#!/bin/bash
# ============================================================
#  CLAUDEFREE — Setup One-Shot (macOS / Linux)
#  Instala tudo em um comando: OpenClaude + Ollama + Modelo + Kit PA
# ============================================================

set -e

# Colors
C='\033[0;36m'    # Cyan
G='\033[0;32m'    # Green
Y='\033[0;33m'    # Yellow
R='\033[0;31m'    # Red
D='\033[0;90m'    # Dim
W='\033[0;97m'    # White
N='\033[0m'       # Reset

step() { echo -e "\n  ${C}[$1/6] $2${N}\n  ${D}$(printf '%0.s-' {1..50})${N}"; }
ok()   { echo -e "    ${G}[OK]${N} $1"; }
skip() { echo -e "    ${Y}[SKIP]${N} $1"; }
fail() { echo -e "    ${R}[FAIL]${N} $1"; }

# ── Header ──
echo ""
echo -e "  ${W}================================================${N}"
echo -e "    ${W}CLAUDEFREE — Setup Automatico${N}"
echo -e "    ${D}OpenClaude + Ollama + Kit Piloto Automatico${N}"
echo -e "  ${W}================================================${N}"
echo ""

# ── Step 1: Node.js ──
step "1" "Verificando Node.js..."

if command -v node &>/dev/null; then
    NODE_V=$(node --version)
    MAJOR=$(echo "$NODE_V" | sed 's/v\([0-9]*\).*/\1/')
    if [ "$MAJOR" -ge 20 ]; then
        ok "Node.js $NODE_V encontrado"
    else
        fail "Node.js $NODE_V muito antigo (precisa v20+)"
        echo "    Baixe em: https://nodejs.org/"
        exit 1
    fi
else
    echo -e "    ${Y}Node.js nao encontrado. Instalando...${N}"
    if command -v brew &>/dev/null; then
        brew install node@22
    elif command -v apt &>/dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
        sudo apt install -y nodejs
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y nodejs
    else
        fail "Instale Node.js 20+ manualmente: https://nodejs.org/"
        exit 1
    fi
    ok "Node.js $(node --version) instalado"
fi

# ── Step 2: OpenClaude ──
step "2" "Verificando OpenClaude..."

if command -v openclaude &>/dev/null; then
    ok "OpenClaude $(openclaude --version) encontrado"
else
    echo -e "    ${Y}Instalando OpenClaude...${N}"
    npm install -g @gitlawb/openclaude
    ok "OpenClaude $(openclaude --version) instalado"
fi

# ── Step 3: ripgrep ──
step "3" "Verificando ripgrep..."

if command -v rg &>/dev/null; then
    ok "ripgrep encontrado"
else
    echo -e "    ${Y}Instalando ripgrep...${N}"
    if command -v brew &>/dev/null; then
        brew install ripgrep
    elif command -v apt &>/dev/null; then
        sudo apt install -y ripgrep
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y ripgrep
    else
        fail "Instale ripgrep manualmente: https://github.com/BurntSushi/ripgrep"
        exit 1
    fi
    ok "ripgrep instalado"
fi

# ── Step 4: Ollama ──
step "4" "Verificando Ollama..."

if command -v ollama &>/dev/null; then
    ok "Ollama $(ollama --version 2>&1 | head -1) encontrado"
else
    echo -e "    ${Y}Instalando Ollama...${N}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ollama
    else
        curl -fsSL https://ollama.com/install.sh | sh
    fi
    ok "Ollama instalado"
fi

# Check server
if curl -s http://localhost:11434/api/tags &>/dev/null; then
    ok "Ollama server rodando"
else
    echo -e "    ${Y}Iniciando Ollama server...${N}"
    ollama serve &>/dev/null &
    sleep 5
    if curl -s http://localhost:11434/api/tags &>/dev/null; then
        ok "Ollama server iniciado"
    else
        fail "Ollama server nao iniciou. Rode 'ollama serve' manualmente."
    fi
fi

# ── Step 5: Modelo ──
step "5" "Verificando modelo qwen2.5-coder:7b..."

if curl -s http://localhost:11434/api/tags | grep -q "qwen2.5-coder:7b"; then
    ok "Modelo qwen2.5-coder:7b encontrado"
else
    echo -e "    ${Y}Baixando modelo qwen2.5-coder:7b (~4.7 GB)...${N}"
    echo -e "    ${D}Isso pode levar alguns minutos...${N}"
    ollama pull qwen2.5-coder:7b
    ok "Modelo baixado"
fi

# ── Step 6: Kit PA ──
step "6" "Configurando Kit Piloto Automatico..."

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KIT_SOURCE="$SCRIPT_DIR/../kit"
TARGET_DIR="$(pwd)"

if [ ! -d "$KIT_SOURCE" ]; then
    echo -e "    ${Y}Baixando Kit PA do GitHub...${N}"
    git clone --depth 1 https://github.com/aifunnels/claudefree.git /tmp/claudefree-tmp
    KIT_SOURCE="/tmp/claudefree-tmp/kit"
fi

# CLAUDE.md
if [ -f "$TARGET_DIR/CLAUDE.md" ]; then
    skip "CLAUDE.md ja existe"
else
    cp "$KIT_SOURCE/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
    ok "CLAUDE.md criado"
fi

# .claude directory
mkdir -p "$TARGET_DIR/.claude"

# Agents
if [ ! -d "$TARGET_DIR/.claude/agents" ]; then
    cp -r "$KIT_SOURCE/.claude/agents" "$TARGET_DIR/.claude/agents"
    ok "14 agentes instalados"
else
    skip "Pasta .claude/agents ja existe"
fi

# Skills
if [ ! -d "$TARGET_DIR/.claude/skills" ]; then
    cp -r "$KIT_SOURCE/.claude/skills" "$TARGET_DIR/.claude/skills"
    ok "17 skills instalados"
else
    skip "Pasta .claude/skills ja existe"
fi

# Knowledge, prompts, templates, nichos, docs
for dir in conhecimento prompts templates nichos docs; do
    if [ ! -d "$TARGET_DIR/$dir" ]; then
        cp -r "$KIT_SOURCE/$dir" "$TARGET_DIR/$dir"
        ok "$dir copiado"
    else
        skip "$dir ja existe"
    fi
done

# Empty directories
for dir in clientes config output; do
    mkdir -p "$TARGET_DIR/$dir"
done

# Example clients
if [ -d "$KIT_SOURCE/clientes" ]; then
    cp -r "$KIT_SOURCE/clientes/"* "$TARGET_DIR/clientes/" 2>/dev/null || true
fi

# Clean settings (no MCPs)
SETTINGS="$TARGET_DIR/.claude/settings.json"
if [ ! -f "$SETTINGS" ]; then
    cat > "$SETTINGS" << 'SETTINGS_EOF'
{
  "agentModels": {},
  "agentRouting": {},
  "mcpServers": {}
}
SETTINGS_EOF
    ok "settings.json limpo criado"
fi

# Cleanup
rm -rf /tmp/claudefree-tmp 2>/dev/null || true

# ── Final ──
echo ""
echo -e "  ${G}================================================${N}"
echo -e "    ${G}SETUP COMPLETO${N}"
echo -e "  ${G}================================================${N}"
echo ""
echo -e "  ${W}Para iniciar:${N}"
echo -e "    ${C}export CLAUDE_CODE_USE_OPENAI=1${N}"
echo -e "    ${C}export OPENAI_BASE_URL=http://localhost:11434/v1${N}"
echo -e "    ${C}export OPENAI_MODEL=qwen2.5-coder:7b${N}"
echo -e "    ${C}openclaude --bare${N}"
echo ""
echo -e "  ${W}Dentro do OpenClaude, digite:${N}"
echo -e "    ${Y}/setup-empresa${N}"
echo ""
echo -e "  ${D}Seu time de 14 agentes IA esta pronto.${N}"
echo ""
