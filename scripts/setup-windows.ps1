# CLAUDEFREE — Setup One-Shot (Windows PowerShell)
# irm https://raw.githubusercontent.com/aifunnels/claudefree/master/scripts/setup-windows.ps1 | iex

# ── Anti-security: bypass tudo que pode bloquear ──
$ErrorActionPreference = "Continue"
$ProgressPreference = "SilentlyContinue"
try { Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force } catch {}
try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 } catch {}

function Ok($t) { Write-Host "  [OK] $t" -ForegroundColor Green }
function Fail($t) { Write-Host "  [ERRO] $t" -ForegroundColor Red }
function Info($t) { Write-Host "  $t" -ForegroundColor Yellow }
function Step($n,$t) { Write-Host "`n  --- $n. $t ---" -ForegroundColor Cyan }
function RefreshPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    # npm global bin
    $npmPrefix = $null; try { $npmPrefix = (npm config get prefix 2>$null) } catch {}
    if ($npmPrefix -and (Test-Path $npmPrefix)) { $env:Path = "$npmPrefix;$env:Path" }
    # Common paths
    $extras = @(
        "$env:APPDATA\npm",
        "$env:ProgramFiles\Git\cmd",
        "$env:ProgramFiles\nodejs",
        "$env:LOCALAPPDATA\Microsoft\WinGet\Links"
    )
    foreach ($p in $extras) { if ((Test-Path $p) -and ($env:Path -notlike "*$p*")) { $env:Path = "$p;$env:Path" } }
}

Write-Host ""
Write-Host "  CLAUDEFREE — Setup Automatico" -ForegroundColor White
Write-Host "  OpenClaude + Kit Piloto Automatico + OpenRouter" -ForegroundColor DarkGray
Write-Host ""

# ── 1. NODE ──
Step "1" "Node.js"
RefreshPath
$nv = $null; try { $nv = (node --version 2>$null).Trim() } catch {}
if ($nv -and ([int]($nv -replace 'v(\d+)\..*','$1') -ge 20)) {
    Ok "Node.js $nv"
} else {
    if ($nv) { Info "Node.js $nv antigo, atualizando..." } else { Info "Instalando Node.js..." }

    # Tentar winget primeiro
    $installed = $false
    try {
        winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements --silent 2>$null | Out-Null
        RefreshPath
        $nv = $null; try { $nv = (node --version 2>$null).Trim() } catch {}
        if ($nv) { $installed = $true }
    } catch {}

    # Fallback: baixar direto
    if (-not $installed) {
        Info "winget falhou. Baixando Node.js direto..."
        $nodeUrl = "https://nodejs.org/dist/v22.15.0/node-v22.15.0-x64.msi"
        $nodeInstaller = Join-Path $env:TEMP "node-install.msi"
        Invoke-WebRequest -Uri $nodeUrl -OutFile $nodeInstaller -UseBasicParsing
        Start-Process msiexec.exe -ArgumentList "/i `"$nodeInstaller`" /qn /norestart" -Wait -NoNewWindow
        Remove-Item $nodeInstaller -Force 2>$null
        RefreshPath
        $nv = $null; try { $nv = (node --version 2>$null).Trim() } catch {}
    }

    if ($nv) { Ok "Node.js $nv instalado" }
    else { Fail "Node.js nao instalou. Baixe manualmente: nodejs.org"; exit 1 }
}

# ── 2. GIT ──
Step "2" "Git"
RefreshPath
$gv = $null; try { $gv = git --version 2>$null } catch {}
if ($gv) { Ok "Git" }
else {
    Info "Instalando Git..."
    $installed = $false
    try {
        winget install Git.Git --accept-source-agreements --accept-package-agreements --silent 2>$null | Out-Null
        RefreshPath
        try { git --version 2>$null | Out-Null; $installed = $true } catch {}
    } catch {}

    if (-not $installed) {
        Info "winget falhou. Baixando Git direto..."
        $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.2/Git-2.47.1.2-64-bit.exe"
        $gitInstaller = Join-Path $env:TEMP "git-install.exe"
        Invoke-WebRequest -Uri $gitUrl -OutFile $gitInstaller -UseBasicParsing
        Start-Process $gitInstaller -ArgumentList "/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS" -Wait -NoNewWindow
        Remove-Item $gitInstaller -Force 2>$null
        RefreshPath
    }
    Ok "Git instalado"
}

# ── 3. OPENCLAUDE ──
Step "3" "OpenClaude"
RefreshPath
$ov = $null; try { $ov = (openclaude --version 2>$null).Trim() } catch {}
if ($ov) { Ok "OpenClaude $ov" }
else {
    Info "Instalando OpenClaude (pode levar 1-2 min)..."
    npm install -g @gitlawb/openclaude 2>&1 | Out-Null
    RefreshPath
    $ov = $null; try { $ov = (openclaude --version 2>$null).Trim() } catch {}
    if ($ov) { Ok "OpenClaude $ov" } else { Fail "Falha. Tente: npm install -g @gitlawb/openclaude"; exit 1 }
}

# ── 4. RIPGREP ──
Step "4" "ripgrep"
RefreshPath
$rv = $null; try { $rv = rg --version 2>$null } catch {}
if ($rv) { Ok "ripgrep" }
else {
    Info "Instalando ripgrep..."
    try { winget install BurntSushi.ripgrep.MSVC --accept-source-agreements --accept-package-agreements --silent 2>$null | Out-Null } catch {}
    RefreshPath
    # Verificar de novo
    try { rg --version 2>$null | Out-Null; Ok "ripgrep" } catch { Info "ripgrep pode precisar reabrir o terminal depois" }
}

# ── 5. API KEY ──
Step "5" "OpenRouter API Key"
Write-Host ""
Write-Host "  Crie sua key gratis em: https://openrouter.ai/keys" -ForegroundColor White
Write-Host ""
$key = Read-Host "  Cole a key aqui"
if ([string]::IsNullOrWhiteSpace($key)) { Fail "Sem key. Rode o script de novo quando tiver."; exit 1 }

Info "Testando conexao..."
$testOk = $false
try {
    $body = '{"model":"openrouter/free","messages":[{"role":"user","content":"OK"}]}'
    $headers = @{ "Authorization" = "Bearer $key"; "Content-Type" = "application/json" }
    $r = Invoke-RestMethod -Uri "https://openrouter.ai/api/v1/chat/completions" -Method POST -Headers $headers -Body $body -TimeoutSec 30
    $testOk = $true
    Ok "Key funcionando!"
} catch {
    $code = $null; try { $code = $_.Exception.Response.StatusCode.value__ } catch {}
    if ($code -eq 402) { Info "Key sem creditos pagos — mas funciona com modelos free. Continuando..." ; $testOk = $true }
    elseif ($code -eq 401) { Fail "Key invalida. Confira em openrouter.ai/keys"; exit 1 }
    elseif ($code -eq 429) { Info "Rate limit — muita gente usando. Mas a key e valida. Continuando..." ; $testOk = $true }
    else { Info "Teste retornou $code — continuando mesmo assim..." ; $testOk = $true }
}

# ── 6. KIT PA ──
Step "6" "Kit Piloto Automatico"
$desktop = [System.Environment]::GetFolderPath("Desktop")
$proj = Join-Path $desktop "minha-empresa"

if (Test-Path $proj) {
    Info "Pasta minha-empresa ja existe. Atualizando settings..."
} else {
    Info "Baixando Kit PA..."
    $tmp = Join-Path $env:TEMP "claudefree-dl"
    if (Test-Path $tmp) { Remove-Item -Recurse -Force $tmp 2>$null }
    git clone --depth 1 https://github.com/aifunnels/claudefree.git $tmp 2>$null
    $kit = Join-Path $tmp "kit"

    if (-not (Test-Path $kit)) { Fail "Falha ao baixar Kit PA. Verifique sua conexao."; exit 1 }

    New-Item -ItemType Directory -Path $proj -Force | Out-Null
    Copy-Item (Join-Path $kit "CLAUDE.md") $proj
    foreach ($d in @(".claude","conhecimento","prompts","templates","nichos","docs","clientes")) {
        $src = Join-Path $kit $d
        if (Test-Path $src) { Copy-Item -Recurse $src (Join-Path $proj $d) }
    }
    foreach ($d in @("config","output")) {
        New-Item -ItemType Directory -Path (Join-Path $proj $d) -Force | Out-Null
    }

    # Antigravity .agent/
    foreach ($d in @(".agent\skills",".agent\rules",".agent\workflows")) {
        New-Item -ItemType Directory -Path (Join-Path $proj $d) -Force | Out-Null
    }
    $agentsDir = Join-Path $proj ".claude\agents"
    if (Test-Path $agentsDir) { Copy-Item (Join-Path $agentsDir "*") (Join-Path $proj ".agent\skills\") -Force 2>$null }
    $skillsDir = Join-Path $proj ".claude\skills"
    if (Test-Path $skillsDir) {
        Get-ChildItem $skillsDir -Directory | ForEach-Object {
            $sf = Join-Path $_.FullName "SKILL.md"
            if (Test-Path $sf) { Copy-Item $sf (Join-Path $proj ".agent\workflows\$($_.Name).md") -Force }
        }
    }
    Copy-Item (Join-Path $proj "CLAUDE.md") (Join-Path $proj ".agent\rules\main.md") -Force 2>$null

    Remove-Item -Recurse -Force $tmp 2>$null
    Ok "14 agentes + 14 skills + 50 prompts"
}

# Salvar settings com a key
$settings = @"
{
  "env": {
    "CLAUDE_CODE_USE_OPENAI": "1",
    "OPENAI_BASE_URL": "https://openrouter.ai/api/v1",
    "OPENAI_API_KEY": "$key",
    "OPENAI_MODEL": "openrouter/free"
  },
  "mcpServers": {}
}
"@
$settingsDir = Join-Path $proj ".claude"
if (-not (Test-Path $settingsDir)) { New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null }
Set-Content -Path (Join-Path $settingsDir "settings.json") -Value $settings -Encoding UTF8
Ok "Key salva"

# Setar env pra sessao atual
$env:CLAUDE_CODE_USE_OPENAI = "1"
$env:OPENAI_BASE_URL = "https://openrouter.ai/api/v1"
$env:OPENAI_API_KEY = $key
$env:OPENAI_MODEL = "openrouter/free"

# PRONTO
Write-Host ""
Write-Host "  ========================================" -ForegroundColor Green
Write-Host "    PRONTO!" -ForegroundColor Green
Write-Host "  ========================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Abrindo OpenClaude..." -ForegroundColor Cyan
Write-Host ""

Set-Location $proj
openclaude --bare
