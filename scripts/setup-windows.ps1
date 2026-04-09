# CLAUDEFREE — Setup One-Shot (Windows PowerShell)
# irm https://raw.githubusercontent.com/aifunnels/claudefree/master/scripts/setup-windows.ps1 | iex

$ErrorActionPreference = "Continue"

function Ok($t) { Write-Host "  [OK] $t" -ForegroundColor Green }
function Fail($t) { Write-Host "  [ERRO] $t" -ForegroundColor Red }
function Info($t) { Write-Host "  $t" -ForegroundColor Yellow }
function Step($n,$t) { Write-Host "`n  --- $n. $t ---" -ForegroundColor Cyan }
function RefreshPath { $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") }

Write-Host ""
Write-Host "  CLAUDEFREE — Setup Automatico" -ForegroundColor White
Write-Host "  OpenClaude + Kit Piloto Automatico + OpenRouter" -ForegroundColor DarkGray
Write-Host ""

# 1. NODE
Step "1" "Node.js"
$nv = $null; try { $nv = node --version 2>$null } catch {}
if ($nv) {
    $m = [int]($nv -replace 'v(\d+)\..*','$1')
    if ($m -ge 20) { Ok "Node.js $nv" }
    else { Fail "Node.js $nv antigo. Baixe v20+ em nodejs.org"; exit 1 }
} else {
    Info "Instalando Node.js..."
    winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements 2>$null
    RefreshPath
    $nv = $null; try { $nv = node --version 2>$null } catch {}
    if ($nv) { Ok "Node.js $nv instalado" } else { Fail "Instale Node.js manualmente: nodejs.org"; exit 1 }
}

# 2. GIT
Step "2" "Git"
$gv = $null; try { $gv = git --version 2>$null } catch {}
if ($gv) { Ok "Git instalado" }
else {
    Info "Instalando Git..."
    winget install Git.Git --accept-source-agreements --accept-package-agreements 2>$null
    RefreshPath
    Ok "Git instalado"
}

# 3. OPENCLAUDE
Step "3" "OpenClaude"
$ov = $null; try { $ov = openclaude --version 2>$null } catch {}
if ($ov) { Ok "OpenClaude $ov" }
else {
    Info "Instalando OpenClaude..."
    npm install -g @gitlawb/openclaude 2>$null
    RefreshPath
    $ov = $null; try { $ov = openclaude --version 2>$null } catch {}
    if ($ov) { Ok "OpenClaude $ov" } else { Fail "Falha ao instalar OpenClaude"; exit 1 }
}

# 4. RIPGREP
Step "4" "ripgrep"
$rv = $null; try { $rv = rg --version 2>$null } catch {}
if ($rv) { Ok "ripgrep instalado" }
else {
    Info "Instalando ripgrep..."
    winget install BurntSushi.ripgrep.MSVC --accept-source-agreements --accept-package-agreements 2>$null
    RefreshPath
    Ok "ripgrep instalado"
}

# 5. API KEY
Step "5" "OpenRouter API Key"
Write-Host ""
Write-Host "  Crie sua key gratis em: https://openrouter.ai/keys" -ForegroundColor White
Write-Host ""
$key = Read-Host "  Cole a key aqui"
if ([string]::IsNullOrWhiteSpace($key)) { Fail "Sem key. Rode o script de novo quando tiver."; exit 1 }

# Testar key
Info "Testando conexao..."
try {
    $body = '{"model":"openrouter/free","messages":[{"role":"user","content":"OK"}]}'
    $r = Invoke-RestMethod -Uri "https://openrouter.ai/api/v1/chat/completions" -Method POST -Headers @{"Authorization"="Bearer $key";"Content-Type"="application/json"} -Body $body -TimeoutSec 30
    Ok "Key funcionando!"
} catch {
    $code = $_.Exception.Response.StatusCode.value__
    if ($code -eq 402) { Fail "Key sem creditos. Acesse openrouter.ai/settings/credits" }
    elseif ($code -eq 401) { Fail "Key invalida. Confira em openrouter.ai/keys" }
    else { Fail "Erro $code ao testar. Verifique sua key." }
    exit 1
}

# 6. KIT PA
Step "6" "Kit Piloto Automatico"
$desktop = [System.Environment]::GetFolderPath("Desktop")
$proj = Join-Path $desktop "minha-empresa"

if (Test-Path $proj) {
    Info "Pasta minha-empresa ja existe. Atualizando settings..."
} else {
    Info "Baixando Kit PA..."
    $tmp = Join-Path $env:TEMP "claudefree-dl"
    if (Test-Path $tmp) { Remove-Item -Recurse -Force $tmp }
    git clone --depth 1 https://github.com/aifunnels/claudefree.git $tmp 2>$null
    $kit = Join-Path $tmp "kit"

    New-Item -ItemType Directory -Path $proj -Force | Out-Null
    Copy-Item (Join-Path $kit "CLAUDE.md") $proj
    foreach ($d in @(".claude","conhecimento","prompts","templates","nichos","docs","clientes")) {
        Copy-Item -Recurse (Join-Path $kit $d) (Join-Path $proj $d)
    }
    foreach ($d in @("config","output")) {
        New-Item -ItemType Directory -Path (Join-Path $proj $d) -Force | Out-Null
    }

    # Antigravity
    foreach ($d in @(".agent\skills",".agent\rules",".agent\workflows")) {
        New-Item -ItemType Directory -Path (Join-Path $proj $d) -Force | Out-Null
    }
    Copy-Item (Join-Path $proj ".claude\agents\*") (Join-Path $proj ".agent\skills\") -Force
    Get-ChildItem (Join-Path $proj ".claude\skills") -Directory | ForEach-Object {
        $sf = Join-Path $_.FullName "SKILL.md"
        if (Test-Path $sf) { Copy-Item $sf (Join-Path $proj ".agent\workflows\$($_.Name).md") -Force }
    }
    Copy-Item (Join-Path $proj "CLAUDE.md") (Join-Path $proj ".agent\rules\main.md") -Force

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
Ok "Key salva em .claude/settings.json"

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

# Abrir automaticamente
Set-Location $proj
openclaude --bare
