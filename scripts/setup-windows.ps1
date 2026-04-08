# ============================================================
#  CLAUDEFREE — Setup One-Shot (Windows)
#  Instala tudo em um comando: OpenClaude + Ollama + Modelo + Kit PA
# ============================================================

$ErrorActionPreference = "Stop"

function Write-Step($num, $text) {
    Write-Host ""
    Write-Host "  [$num/6] $text" -ForegroundColor Cyan
    Write-Host "  $('-' * 50)" -ForegroundColor DarkGray
}

function Write-Ok($text) {
    Write-Host "    [OK] $text" -ForegroundColor Green
}

function Write-Skip($text) {
    Write-Host "    [SKIP] $text" -ForegroundColor Yellow
}

function Write-Fail($text) {
    Write-Host "    [FAIL] $text" -ForegroundColor Red
}

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

# ── Step 2: OpenClaude ──
Write-Step "2" "Verificando OpenClaude..."

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

# ── Step 3: ripgrep ──
Write-Step "3" "Verificando ripgrep..."

$rgVersion = $null
try { $rgVersion = (rg --version 2>$null | Select-Object -First 1) } catch {}

if ($rgVersion) {
    Write-Ok "ripgrep encontrado"
} else {
    Write-Host "    Instalando ripgrep..." -ForegroundColor Yellow
    winget install BurntSushi.ripgrep.MSVC --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Ok "ripgrep instalado (reabra o terminal se rg nao for encontrado)"
}

# ── Step 4: Ollama ──
Write-Step "4" "Verificando Ollama..."

$ollamaOk = $false
try {
    $ollamaVersion = (ollama --version 2>$null)
    if ($ollamaVersion) { $ollamaOk = $true }
} catch {}

if (-not $ollamaOk) {
    # Check common install path
    $ollamaPath = "$env:LOCALAPPDATA\Programs\Ollama\ollama.exe"
    if (Test-Path $ollamaPath) {
        $ollamaOk = $true
        Write-Ok "Ollama encontrado em $ollamaPath"
    }
}

if ($ollamaOk) {
    Write-Ok "Ollama instalado"
} else {
    Write-Host "    Instalando Ollama (~1.8 GB)..." -ForegroundColor Yellow
    winget install Ollama.Ollama --accept-source-agreements --accept-package-agreements
    Write-Ok "Ollama instalado"
    Write-Host "    Aguardando server iniciar..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
}

# Check if Ollama server is running
$serverOk = $false
try {
    $response = Invoke-RestMethod -Uri "http://localhost:11434/api/tags" -TimeoutSec 5
    $serverOk = $true
} catch {}

if (-not $serverOk) {
    Write-Host "    Iniciando Ollama server..." -ForegroundColor Yellow
    Start-Process -FilePath "ollama" -ArgumentList "serve" -WindowStyle Hidden
    Start-Sleep -Seconds 5
    try {
        $response = Invoke-RestMethod -Uri "http://localhost:11434/api/tags" -TimeoutSec 5
        $serverOk = $true
    } catch {}
}

if ($serverOk) {
    Write-Ok "Ollama server rodando"
} else {
    Write-Fail "Ollama server nao iniciou. Verifique o system tray."
}

# ── Step 5: Modelo ──
Write-Step "5" "Verificando modelo qwen2.5-coder:7b..."

$modelExists = $false
try {
    $models = Invoke-RestMethod -Uri "http://localhost:11434/api/tags" -TimeoutSec 5
    foreach ($m in $models.models) {
        if ($m.name -eq "qwen2.5-coder:7b") { $modelExists = $true }
    }
} catch {}

if ($modelExists) {
    Write-Ok "Modelo qwen2.5-coder:7b encontrado"
} else {
    Write-Host "    Baixando modelo qwen2.5-coder:7b (~4.7 GB)..." -ForegroundColor Yellow
    Write-Host "    Isso pode levar alguns minutos..." -ForegroundColor DarkGray
    ollama pull qwen2.5-coder:7b
    Write-Ok "Modelo baixado"
}

# ── Step 6: Kit PA ──
Write-Step "6" "Configurando Kit Piloto Automatico..."

$kitSource = $PSScriptRoot + "\..\kit"
$targetDir = Get-Location

if (-not (Test-Path $kitSource)) {
    # If running from downloaded script, clone the repo
    Write-Host "    Baixando Kit PA do GitHub..." -ForegroundColor Yellow
    git clone --depth 1 https://github.com/aifunnels/claudefree.git "$env:TEMP\claudefree-tmp"
    $kitSource = "$env:TEMP\claudefree-tmp\kit"
}

# Copy kit structure to current directory
if (Test-Path "$targetDir\CLAUDE.md") {
    Write-Skip "CLAUDE.md ja existe — nao sobrescrever"
} else {
    Copy-Item "$kitSource\CLAUDE.md" "$targetDir\CLAUDE.md"
    Write-Ok "CLAUDE.md criado"
}

# Copy .claude directory
if (-not (Test-Path "$targetDir\.claude")) {
    New-Item -ItemType Directory -Path "$targetDir\.claude" -Force | Out-Null
}

# Agents
if (-not (Test-Path "$targetDir\.claude\agents")) {
    Copy-Item -Recurse "$kitSource\.claude\agents" "$targetDir\.claude\agents"
    Write-Ok "14 agentes instalados"
} else {
    Write-Skip "Pasta .claude\agents ja existe"
}

# Skills
if (-not (Test-Path "$targetDir\.claude\skills")) {
    Copy-Item -Recurse "$kitSource\.claude\skills" "$targetDir\.claude\skills"
    Write-Ok "14 skills instalados"
} else {
    Write-Skip "Pasta .claude\skills ja existe"
}

# Knowledge, prompts, templates, nichos, docs
foreach ($dir in @("conhecimento", "prompts", "templates", "nichos", "docs")) {
    if (-not (Test-Path "$targetDir\$dir")) {
        Copy-Item -Recurse "$kitSource\$dir" "$targetDir\$dir"
        Write-Ok "$dir copiado"
    } else {
        Write-Skip "$dir ja existe"
    }
}

# Create empty directories
foreach ($dir in @("clientes", "config", "output")) {
    if (-not (Test-Path "$targetDir\$dir")) {
        New-Item -ItemType Directory -Path "$targetDir\$dir" -Force | Out-Null
        Write-Ok "Pasta $dir criada"
    }
}

# Copy example clients
if (Test-Path "$kitSource\clientes") {
    Copy-Item -Recurse "$kitSource\clientes\*" "$targetDir\clientes\" -Force 2>$null
}

# ── Create multi-model config ──
$settingsPath = "$targetDir\.claude\settings.json"
if (-not (Test-Path $settingsPath)) {
    $settingsContent = @'
{
  "agentModels": {},
  "agentRouting": {},
  "mcpServers": {}
}
'@
    Set-Content -Path $settingsPath -Value $settingsContent -Encoding UTF8
    Write-Ok "settings.json limpo criado (sem MCPs)"
}

# ── Set environment variables for this session ──
$env:CLAUDE_CODE_USE_OPENAI = "1"
$env:OPENAI_BASE_URL = "http://localhost:11434/v1"
$env:OPENAI_MODEL = "qwen2.5-coder:7b"

# ── Cleanup temp ──
if (Test-Path "$env:TEMP\claudefree-tmp") {
    Remove-Item -Recurse -Force "$env:TEMP\claudefree-tmp" 2>$null
}

# ── Final ──
Write-Host ""
Write-Host "  ================================================" -ForegroundColor Green
Write-Host "    SETUP COMPLETO" -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Para iniciar:" -ForegroundColor White
Write-Host '    $env:CLAUDE_CODE_USE_OPENAI="1"' -ForegroundColor Cyan
Write-Host '    $env:OPENAI_BASE_URL="http://localhost:11434/v1"' -ForegroundColor Cyan
Write-Host '    $env:OPENAI_MODEL="qwen2.5-coder:7b"' -ForegroundColor Cyan
Write-Host "    openclaude --bare" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Dentro do OpenClaude, digite:" -ForegroundColor White
Write-Host "    /setup-empresa" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Seu time de 14 agentes IA esta pronto." -ForegroundColor DarkGray
Write-Host ""
