# ============================================================
#  CLAUDEFREE — Setup One-Shot (Windows)
#  UMA LINHA: instala OpenClaude + Kit PA + configura OpenRouter
#
#  Uso (PowerShell):
#    irm https://raw.githubusercontent.com/aifunnels/claudefree/master/scripts/setup-windows.ps1 | iex
# ============================================================

$ErrorActionPreference = "Stop"

function Write-Step($num, $text) {
    Write-Host ""
    Write-Host "  [$num/5] $text" -ForegroundColor Cyan
    Write-Host "  $('-' * 50)" -ForegroundColor DarkGray
}
function Write-Ok($text) { Write-Host "    [OK] $text" -ForegroundColor Green }
function Write-Skip($text) { Write-Host "    [SKIP] $text" -ForegroundColor Yellow }
function Write-Fail($text) { Write-Host "    [FAIL] $text" -ForegroundColor Red }

# ── Header ──
Write-Host ""
Write-Host "  ================================================" -ForegroundColor White
Write-Host "    CLAUDEFREE — Setup Automatico" -ForegroundColor White
Write-Host "    OpenClaude + Kit Piloto Automatico + OpenRouter" -ForegroundColor DarkGray
Write-Host "  ================================================" -ForegroundColor White
Write-Host ""
Write-Host "  Use PowerShell (NAO Git Bash)" -ForegroundColor Yellow
Write-Host ""

# ── Step 1: Node.js ──
Write-Step "1" "Node.js..."

$nodeVersion = $null
try { $nodeVersion = (node --version 2>$null) } catch {}

if ($nodeVersion) {
    $major = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')
    if ($major -ge 20) {
        Write-Ok "Node.js $nodeVersion"
    } else {
        Write-Fail "Node.js $nodeVersion muito antigo (precisa v20+). Baixe em nodejs.org"
        exit 1
    }
} else {
    Write-Host "    Instalando Node.js..." -ForegroundColor Yellow
    winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    try { $nodeVersion = (node --version 2>$null); Write-Ok "Node.js $nodeVersion" }
    catch { Write-Fail "Instale Node.js manualmente: nodejs.org"; exit 1 }
}

# ── Step 2: OpenClaude + ripgrep + Git ──
Write-Step "2" "OpenClaude + dependencias..."

# Git
$gitOk = $false
try { git --version 2>$null | Out-Null; $gitOk = $true } catch {}
if (-not $gitOk) {
    Write-Host "    Instalando Git..." -ForegroundColor Yellow
    winget install Git.Git --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}
Write-Ok "Git"

# OpenClaude
$ocVersion = $null
try { $ocVersion = (openclaude --version 2>$null) } catch {}
if ($ocVersion) {
    Write-Ok "OpenClaude $ocVersion"
} else {
    Write-Host "    Instalando OpenClaude..." -ForegroundColor Yellow
    npm install -g @gitlawb/openclaude
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    try { $ocVersion = (openclaude --version 2>$null); Write-Ok "OpenClaude $ocVersion" }
    catch { Write-Fail "Falha ao instalar OpenClaude"; exit 1 }
}

# ripgrep
try { rg --version 2>$null | Out-Null; Write-Ok "ripgrep" } catch {
    Write-Host "    Instalando ripgrep..." -ForegroundColor Yellow
    winget install BurntSushi.ripgrep.MSVC --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Ok "ripgrep"
}

# ── Step 3: Kit PA na Area de Trabalho ──
Write-Step "3" "Kit Piloto Automatico..."

$projectName = "minha-empresa"
$desktopPath = [System.Environment]::GetFolderPath("Desktop")
$projectDir = Join-Path $desktopPath $projectName

if (Test-Path $projectDir) {
    Write-Skip "Pasta $projectName ja existe na Area de Trabalho"
} else {
    Write-Host "    Baixando Kit PA..." -ForegroundColor Yellow
    git clone --depth 1 https://github.com/aifunnels/claudefree.git "$env:TEMP\claudefree-dl"
    $kitSource = "$env:TEMP\claudefree-dl\kit"

    New-Item -ItemType Directory -Path $projectDir -Force | Out-Null
    Copy-Item "$kitSource\CLAUDE.md" "$projectDir\CLAUDE.md"
    Copy-Item -Recurse "$kitSource\.claude" "$projectDir\.claude"
    Copy-Item -Recurse "$kitSource\conhecimento" "$projectDir\conhecimento"
    Copy-Item -Recurse "$kitSource\prompts" "$projectDir\prompts"
    Copy-Item -Recurse "$kitSource\templates" "$projectDir\templates"
    Copy-Item -Recurse "$kitSource\nichos" "$projectDir\nichos"
    Copy-Item -Recurse "$kitSource\docs" "$projectDir\docs"
    Copy-Item -Recurse "$kitSource\clientes" "$projectDir\clientes"
    foreach ($dir in @("config", "output")) {
        New-Item -ItemType Directory -Path "$projectDir\$dir" -Force | Out-Null
    }

    # Antigravity .agent/
    New-Item -ItemType Directory -Path "$projectDir\.agent\skills" -Force | Out-Null
    New-Item -ItemType Directory -Path "$projectDir\.agent\rules" -Force | Out-Null
    New-Item -ItemType Directory -Path "$projectDir\.agent\workflows" -Force | Out-Null
    Copy-Item -Recurse "$projectDir\.claude\agents\*" "$projectDir\.agent\skills\" -Force
    Get-ChildItem "$projectDir\.claude\skills" -Directory | ForEach-Object {
        $sf = Join-Path $_.FullName "SKILL.md"
        if (Test-Path $sf) { Copy-Item $sf "$projectDir\.agent\workflows\$($_.Name).md" -Force }
    }
    Copy-Item "$projectDir\CLAUDE.md" "$projectDir\.agent\rules\main.md" -Force

    Remove-Item -Recurse -Force "$env:TEMP\claudefree-dl" 2>$null
    Write-Ok "14 agentes + 14 skills + 50 prompts + 3 nichos"
    Write-Ok "VSCode / Cursor / Antigravity"
}

# ── Step 4: OpenRouter API Key ──
Write-Step "4" "Configurando OpenRouter..."

Write-Host ""
Write-Host "    Crie sua key GRATIS em: https://openrouter.ai/keys" -ForegroundColor White
Write-Host "    (10 dolares de credito gratis no primeiro cadastro)" -ForegroundColor DarkGray
Write-Host ""

$orKey = Read-Host "    Cole sua OpenRouter API key aqui"

if ([string]::IsNullOrWhiteSpace($orKey)) {
    Write-Fail "Nenhuma key inserida. Configure manualmente depois."
    Write-Host ""
    Write-Host '    $env:CLAUDE_CODE_USE_OPENAI="1"' -ForegroundColor DarkGray
    Write-Host '    $env:OPENAI_BASE_URL="https://openrouter.ai/api/v1"' -ForegroundColor DarkGray
    Write-Host '    $env:OPENAI_API_KEY="sua-key"' -ForegroundColor DarkGray
    Write-Host '    $env:OPENAI_MODEL="deepseek/deepseek-chat-v3-0324"' -ForegroundColor DarkGray
} else {
    # Set for this session
    $env:CLAUDE_CODE_USE_OPENAI = "1"
    $env:OPENAI_BASE_URL = "https://openrouter.ai/api/v1"
    $env:OPENAI_API_KEY = $orKey
    $env:OPENAI_MODEL = "deepseek/deepseek-chat-v3-0324"

    # Save to settings.json so OpenClaude always picks it up
    $settingsContent = @"
{
  "env": {
    "CLAUDE_CODE_USE_OPENAI": "1",
    "OPENAI_BASE_URL": "https://openrouter.ai/api/v1",
    "OPENAI_API_KEY": "$orKey",
    "OPENAI_MODEL": "deepseek/deepseek-chat-v3-0324"
  },
  "agentModels": {},
  "agentRouting": {},
  "mcpServers": {}
}
"@
    Set-Content -Path "$projectDir\.claude\settings.json" -Value $settingsContent -Encoding UTF8

    Write-Ok "OpenRouter configurado (DeepSeek v3)"
    Write-Ok "Key salva em .claude/settings.json"
}

# ── Step 5: Testar conexao ──
Write-Step "5" "Testando conexao..."

if (-not [string]::IsNullOrWhiteSpace($orKey)) {
    try {
        $testBody = @{
            model = "deepseek/deepseek-chat-v3-0324"
            messages = @(@{ role = "user"; content = "Responda apenas: OK" })
            max_tokens = 5
        } | ConvertTo-Json -Depth 3

        $testResponse = Invoke-RestMethod -Uri "https://openrouter.ai/api/v1/chat/completions" `
            -Method POST `
            -Headers @{ "Authorization" = "Bearer $orKey"; "Content-Type" = "application/json" } `
            -Body $testBody `
            -TimeoutSec 15

        Write-Ok "Conexao com OpenRouter funcionando!"
    } catch {
        Write-Fail "Erro na conexao. Verifique sua API key."
        Write-Host "    Erro: $($_.Exception.Message)" -ForegroundColor DarkGray
    }
} else {
    Write-Skip "Sem key — teste pulado"
}

# ── Final ──
Write-Host ""
Write-Host "  ================================================" -ForegroundColor Green
Write-Host "    PRONTO!" -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Agora faca:" -ForegroundColor White
Write-Host ""
Write-Host "    cd `"$projectDir`"" -ForegroundColor Cyan
Write-Host "    openclaude --bare" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Dentro do OpenClaude:" -ForegroundColor White
Write-Host "    /setup-empresa" -ForegroundColor Yellow
Write-Host ""
Write-Host "  14 agentes IA prontos. Boa sorte." -ForegroundColor DarkGray
Write-Host ""
