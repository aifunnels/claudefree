# ============================================================
#  CLAUDEFREE — Setup One-Shot (Windows)
#  UMA LINHA instala tudo: OpenClaude + Ollama + Modelo + Kit PA
#
#  Uso:
#    irm https://raw.githubusercontent.com/aifunnels/claudefree/master/scripts/setup-windows.ps1 | iex
# ============================================================

$ErrorActionPreference = "Stop"

function Write-Step($num, $text) {
    Write-Host ""
    Write-Host "  [$num/7] $text" -ForegroundColor Cyan
    Write-Host "  $('-' * 50)" -ForegroundColor DarkGray
}

function Write-Ok($text) { Write-Host "    [OK] $text" -ForegroundColor Green }
function Write-Skip($text) { Write-Host "    [SKIP] $text" -ForegroundColor Yellow }
function Write-Fail($text) { Write-Host "    [FAIL] $text" -ForegroundColor Red }

# ── Header ──
Write-Host ""
Write-Host "  ================================================" -ForegroundColor White
Write-Host "    CLAUDEFREE — Setup Automatico" -ForegroundColor White
Write-Host "    OpenClaude + Ollama + Kit Piloto Automatico" -ForegroundColor DarkGray
Write-Host "  ================================================" -ForegroundColor White
Write-Host ""
Write-Host "  IMPORTANTE: Execute este script no PowerShell" -ForegroundColor Yellow
Write-Host "  NAO use Git Bash (causa travamento)" -ForegroundColor Yellow
Write-Host ""

# ── Step 1: Node.js ──
Write-Step "1" "Verificando Node.js..."

$nodeVersion = $null
try { $nodeVersion = (node --version 2>$null) } catch {}

if ($nodeVersion) {
    $major = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')
    if ($major -ge 20) {
        Write-Ok "Node.js $nodeVersion encontrado"
    } else {
        Write-Fail "Node.js $nodeVersion muito antigo (precisa v20+)"
        Write-Host "    Baixe em: https://nodejs.org/" -ForegroundColor Yellow
        exit 1
    }
} else {
    Write-Host "    Node.js nao encontrado. Instalando via winget..." -ForegroundColor Yellow
    winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    try {
        $nodeVersion = (node --version 2>$null)
        Write-Ok "Node.js $nodeVersion instalado"
    } catch {
        Write-Fail "Falha ao instalar Node.js. Instale manualmente: https://nodejs.org/"
        exit 1
    }
}

# ── Step 2: Git ──
Write-Step "2" "Verificando Git..."

$gitOk = $false
try { git --version 2>$null | Out-Null; $gitOk = $true } catch {}

if ($gitOk) {
    Write-Ok "Git encontrado"
} else {
    Write-Host "    Instalando Git..." -ForegroundColor Yellow
    winget install Git.Git --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Ok "Git instalado"
}

# ── Step 3: OpenClaude + ripgrep ──
Write-Step "3" "Verificando OpenClaude + ripgrep..."

$ocVersion = $null
try { $ocVersion = (openclaude --version 2>$null) } catch {}

if ($ocVersion) {
    Write-Ok "OpenClaude $ocVersion encontrado"
} else {
    Write-Host "    Instalando OpenClaude..." -ForegroundColor Yellow
    npm install -g @gitlawb/openclaude
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    try {
        $ocVersion = (openclaude --version 2>$null)
        Write-Ok "OpenClaude $ocVersion instalado"
    } catch {
        Write-Fail "Falha ao instalar OpenClaude"
        exit 1
    }
}

# ripgrep
$rgVersion = $null
try { $rgVersion = (rg --version 2>$null | Select-Object -First 1) } catch {}

if ($rgVersion) {
    Write-Ok "ripgrep encontrado"
} else {
    Write-Host "    Instalando ripgrep..." -ForegroundColor Yellow
    winget install BurntSushi.ripgrep.MSVC --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Ok "ripgrep instalado"
}

# ── Step 4: Ollama ──
Write-Step "4" "Verificando Ollama..."

$ollamaOk = $false
try { $ollamaVersion = (ollama --version 2>$null); if ($ollamaVersion) { $ollamaOk = $true } } catch {}
if (-not $ollamaOk) {
    $ollamaPath = "$env:LOCALAPPDATA\Programs\Ollama\ollama.exe"
    if (Test-Path $ollamaPath) { $ollamaOk = $true }
}

if ($ollamaOk) {
    Write-Ok "Ollama instalado"
} else {
    Write-Host "    Instalando Ollama (~1.8 GB)..." -ForegroundColor Yellow
    winget install Ollama.Ollama --accept-source-agreements --accept-package-agreements
    Write-Ok "Ollama instalado"
    Start-Sleep -Seconds 10
}

# Server check
$serverOk = $false
try { Invoke-RestMethod -Uri "http://localhost:11434/api/tags" -TimeoutSec 5 | Out-Null; $serverOk = $true } catch {}
if (-not $serverOk) {
    Write-Host "    Iniciando Ollama server..." -ForegroundColor Yellow
    Start-Process -FilePath "ollama" -ArgumentList "serve" -WindowStyle Hidden
    Start-Sleep -Seconds 5
    try { Invoke-RestMethod -Uri "http://localhost:11434/api/tags" -TimeoutSec 5 | Out-Null; $serverOk = $true } catch {}
}
if ($serverOk) { Write-Ok "Ollama server rodando" } else { Write-Fail "Ollama server nao iniciou. Verifique o system tray." }

# ── Step 5: Modelo ──
Write-Step "5" "Verificando modelo qwen2.5-coder:7b..."

$modelExists = $false
try {
    $models = Invoke-RestMethod -Uri "http://localhost:11434/api/tags" -TimeoutSec 5
    foreach ($m in $models.models) { if ($m.name -eq "qwen2.5-coder:7b") { $modelExists = $true } }
} catch {}

if ($modelExists) {
    Write-Ok "Modelo qwen2.5-coder:7b encontrado"
} else {
    Write-Host "    Baixando modelo qwen2.5-coder:7b (~4.7 GB)..." -ForegroundColor Yellow
    Write-Host "    Isso pode levar alguns minutos..." -ForegroundColor DarkGray
    ollama pull qwen2.5-coder:7b
    Write-Ok "Modelo baixado"
}

# ── Step 6: Criar projeto + Kit PA ──
Write-Step "6" "Criando projeto com Kit Piloto Automatico..."

$projectName = "minha-agencia"
$desktopPath = [System.Environment]::GetFolderPath("Desktop")
$projectDir = Join-Path $desktopPath $projectName

if (Test-Path $projectDir) {
    Write-Skip "Pasta $projectName ja existe"
} else {
    Write-Host "    Clonando Kit PA..." -ForegroundColor Yellow
    git clone --depth 1 https://github.com/aifunnels/claudefree.git "$env:TEMP\claudefree-dl"

    # Create project directory
    New-Item -ItemType Directory -Path $projectDir -Force | Out-Null

    # Copy kit contents into project root
    $kitSource = "$env:TEMP\claudefree-dl\kit"
    Copy-Item "$kitSource\CLAUDE.md" "$projectDir\CLAUDE.md"
    Copy-Item -Recurse "$kitSource\.claude" "$projectDir\.claude"
    Copy-Item -Recurse "$kitSource\conhecimento" "$projectDir\conhecimento"
    Copy-Item -Recurse "$kitSource\prompts" "$projectDir\prompts"
    Copy-Item -Recurse "$kitSource\templates" "$projectDir\templates"
    Copy-Item -Recurse "$kitSource\nichos" "$projectDir\nichos"
    Copy-Item -Recurse "$kitSource\docs" "$projectDir\docs"
    Copy-Item -Recurse "$kitSource\clientes" "$projectDir\clientes"

    # Create empty dirs
    foreach ($dir in @("config", "output")) {
        New-Item -ItemType Directory -Path "$projectDir\$dir" -Force | Out-Null
    }

    # Clean settings (no MCPs)
    $settingsContent = @'
{
  "agentModels": {},
  "agentRouting": {},
  "mcpServers": {}
}
'@
    Set-Content -Path "$projectDir\.claude\settings.json" -Value $settingsContent -Encoding UTF8

    # ── Antigravity support (.agent/ convention) ──
    New-Item -ItemType Directory -Path "$projectDir\.agent\skills" -Force | Out-Null
    New-Item -ItemType Directory -Path "$projectDir\.agent\rules" -Force | Out-Null
    New-Item -ItemType Directory -Path "$projectDir\.agent\workflows" -Force | Out-Null

    # Agents -> .agent/skills/
    Copy-Item -Recurse "$projectDir\.claude\agents\*" "$projectDir\.agent\skills\" -Force

    # Skills -> .agent/workflows/
    Get-ChildItem "$projectDir\.claude\skills" -Directory | ForEach-Object {
        $skillFile = Join-Path $_.FullName "SKILL.md"
        if (Test-Path $skillFile) {
            Copy-Item $skillFile "$projectDir\.agent\workflows\$($_.Name).md" -Force
        }
    }

    # CLAUDE.md -> .agent/rules/
    Copy-Item "$projectDir\CLAUDE.md" "$projectDir\.agent\rules\main.md" -Force

    Write-Ok "Antigravity (.agent/) configurado"

    # Cleanup
    Remove-Item -Recurse -Force "$env:TEMP\claudefree-dl" 2>$null

    Write-Ok "Projeto criado na Area de Trabalho: $projectDir"
    Write-Ok "14 agentes + 14 skills + 50 prompts + 3 nichos"
    Write-Ok "Compativel com: VSCode, Cursor, Antigravity"
}

# ── Step 7: Configurar provider ──
Write-Step "7" "Escolha seu provider..."

Write-Host ""
Write-Host "    [1] Ollama local (gratis, ja instalado)" -ForegroundColor White
Write-Host "    [2] OpenRouter (1 key = 200+ modelos)" -ForegroundColor White
Write-Host "    [3] Configurar depois" -ForegroundColor DarkGray
Write-Host ""

$choice = Read-Host "    Escolha (1/2/3)"

switch ($choice) {
    "2" {
        $orKey = Read-Host "    Cole sua OpenRouter API key (openrouter.ai/keys)"
        $env:CLAUDE_CODE_USE_OPENAI = "1"
        $env:OPENAI_BASE_URL = "https://openrouter.ai/api/v1"
        $env:OPENAI_API_KEY = $orKey
        $env:OPENAI_MODEL = "deepseek/deepseek-chat-v3-0324"
        Write-Ok "OpenRouter configurado (DeepSeek v3 como padrao)"
    }
    default {
        $env:CLAUDE_CODE_USE_OPENAI = "1"
        $env:OPENAI_BASE_URL = "http://localhost:11434/v1"
        $env:OPENAI_MODEL = "qwen2.5-coder:7b"
        Write-Ok "Ollama local configurado"
    }
}

# ── Final ──
Write-Host ""
Write-Host "  ================================================" -ForegroundColor Green
Write-Host "    SETUP COMPLETO" -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Proximos passos:" -ForegroundColor White
Write-Host "    cd "$desktopPath\$projectName"" -ForegroundColor Cyan
Write-Host "    openclaude --bare" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Dentro do OpenClaude, digite:" -ForegroundColor White
Write-Host "    /setup-empresa" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Seu time de 14 agentes IA esta pronto." -ForegroundColor DarkGray
Write-Host ""
