#!/bin/bash
# ============================================================
#  CLAUDEFREE — Setup One-Shot (macOS / Linux)
#  UMA LINHA instala tudo: OpenClaude + Ollama + Modelo + Kit PA
#
#  Uso:
#    curl -fsSL https://raw.githubusercontent.com/aifunnels/claudefree/master/scripts/setup-mac.sh | bash
# ============================================================

set -e

C='\033[0;36m'; G='\033[0;32m'; Y='\033[0;33m'; R='\033[0;31m'; D='\033[0;90m'; W='\033[0;97m'; N='\033[0m'

step() { echo -e "\n  ${C}[$1/7] $2${N}\n  ${D}$(printf '%0.s-' {1..50})${N}"; }
ok()   { echo -e "    ${G}[OK]${N} $1"; }
skip() { echo -e "    ${Y}[SKIP]${N} $1"; }
fail() { echo -e "    ${R}[FAIL]${N} $1"; }

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
    ok "OpenClaude instalado"
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
        fail "Instale ripgrep manualmente"
        exit 1
    fi
    ok "ripgrep instalado"
fi

# ── Step 4: Ollama ──
step "4" "Verificando Ollama..."

if command -v ollama &>/dev/null; then
    ok "Ollama encontrado"
else
    echo -e "    ${Y}Instalando Ollama...${N}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ollama
    else
        curl -fsSL https://ollama.com/install.sh | sh
    fi
    ok "Ollama instalado"
fi

if curl -s http://localhost:11434/api/tags &>/dev/null; then
    ok "Ollama server rodando"
else
    echo -e "    ${Y}Iniciando Ollama server...${N}"
    ollama serve &>/dev/null &
    sleep 5
    if curl -s http://localhost:11434/api/tags &>/dev/null; then
        ok "Ollama server iniciado"
    else
        fail "Rode 'ollama serve' manualmente"
    fi
fi

# ── Step 5: Modelo ──
step "5" "Verificando modelo qwen2.5-coder:7b..."

if curl -s http://localhost:11434/api/tags | grep -q "qwen2.5-coder:7b"; then
    ok "Modelo encontrado"
else
    echo -e "    ${Y}Baixando modelo (~4.7 GB)...${N}"
    ollama pull qwen2.5-coder:7b
    ok "Modelo baixado"
fi

# ── Step 6: Criar projeto na Area de Trabalho ──
step "6" "Criando projeto com Kit Piloto Automatico..."

PROJECT_NAME="minha-empresa"
DESKTOP="$HOME/Desktop"
# Fallback pra Linux que pode nao ter ~/Desktop
[ ! -d "$DESKTOP" ] && DESKTOP="$HOME/Área de Trabalho"
[ ! -d "$DESKTOP" ] && DESKTOP="$HOME"

PROJECT_DIR="$DESKTOP/$PROJECT_NAME"

if [ -d "$PROJECT_DIR" ]; then
    skip "Pasta $PROJECT_NAME ja existe na Area de Trabalho"
else
    echo -e "    ${Y}Baixando Kit PA...${N}"
    git clone --depth 1 https://github.com/aifunnels/claudefree.git /tmp/claudefree-dl
    KIT="/tmp/claudefree-dl/kit"

    mkdir -p "$PROJECT_DIR"
    cp "$KIT/CLAUDE.md" "$PROJECT_DIR/"
    cp -r "$KIT/.claude" "$PROJECT_DIR/"
    cp -r "$KIT/conhecimento" "$PROJECT_DIR/"
    cp -r "$KIT/prompts" "$PROJECT_DIR/"
    cp -r "$KIT/templates" "$PROJECT_DIR/"
    cp -r "$KIT/nichos" "$PROJECT_DIR/"
    cp -r "$KIT/docs" "$PROJECT_DIR/"
    cp -r "$KIT/clientes" "$PROJECT_DIR/"
    mkdir -p "$PROJECT_DIR/config" "$PROJECT_DIR/output"

    cat > "$PROJECT_DIR/.claude/settings.json" << 'EOF'
{
  "agentModels": {},
  "agentRouting": {},
  "mcpServers": {}
}
EOF

    # ── Antigravity support (.agent/ convention) ──
    mkdir -p "$PROJECT_DIR/.agent/skills"
    mkdir -p "$PROJECT_DIR/.agent/rules"
    mkdir -p "$PROJECT_DIR/.agent/workflows"

    # Agents -> .agent/skills/
    cp "$PROJECT_DIR/.claude/agents/"*.md "$PROJECT_DIR/.agent/skills/" 2>/dev/null || true

    # Skills -> .agent/workflows/
    for skill_dir in "$PROJECT_DIR/.claude/skills/"*/; do
        skill_name=$(basename "$skill_dir")
        if [ -f "$skill_dir/SKILL.md" ]; then
            cp "$skill_dir/SKILL.md" "$PROJECT_DIR/.agent/workflows/$skill_name.md"
        fi
    done

    # CLAUDE.md -> .agent/rules/
    cp "$PROJECT_DIR/CLAUDE.md" "$PROJECT_DIR/.agent/rules/main.md"

    ok "Antigravity (.agent/) configurado"

    rm -rf /tmp/claudefree-dl
    ok "Projeto criado na Area de Trabalho: $PROJECT_DIR"
    ok "14 agentes + 14 skills + 50 prompts + 3 nichos"
    ok "Compativel com: VSCode, Cursor, Antigravity"
fi

# ── Step 7: Provider ──
step "7" "Escolha seu provider..."

echo ""
echo -e "    ${W}[1] Ollama local (gratis, ja instalado)${N}"
echo -e "    ${W}[2] OpenRouter (1 key = 200+ modelos)${N}"
echo -e "    ${D}[3] Configurar depois${N}"
echo ""

read -p "    Escolha (1/2/3): " choice

case "$choice" in
    2)
        read -p "    Cole sua OpenRouter API key: " or_key
        export CLAUDE_CODE_USE_OPENAI=1
        export OPENAI_BASE_URL=https://openrouter.ai/api/v1
        export OPENAI_API_KEY="$or_key"
        export OPENAI_MODEL=deepseek/deepseek-chat-v3-0324
        ok "OpenRouter configurado"
        ;;
    *)
        export CLAUDE_CODE_USE_OPENAI=1
        export OPENAI_BASE_URL=http://localhost:11434/v1
        export OPENAI_MODEL=qwen2.5-coder:7b
        ok "Ollama local configurado"
        ;;
esac

# ── Final ──
echo ""
echo -e "  ${G}================================================${N}"
echo -e "    ${G}SETUP COMPLETO${N}"
echo -e "  ${G}================================================${N}"
echo ""
echo -e "  ${W}Proximos passos:${N}"
echo -e "    ${C}cd $PROJECT_DIR${N}"
echo -e "    ${C}openclaude --bare${N}"
echo ""
echo -e "  ${W}Dentro do OpenClaude:${N}"
echo -e "    ${Y}/setup-empresa${N}"
echo ""
echo -e "  ${D}Seu time de 14 agentes IA esta pronto.${N}"
echo ""
