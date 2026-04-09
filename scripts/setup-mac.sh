#!/bin/bash
# ============================================================
#  CLAUDEFREE — Setup One-Shot (macOS / Linux)
#  UMA LINHA: instala OpenClaude + Kit PA + configura OpenRouter
#
#  Uso:
#    curl -fsSL https://raw.githubusercontent.com/aifunnels/claudefree/master/scripts/setup-mac.sh | bash
# ============================================================

set -e

C='\033[0;36m'; G='\033[0;32m'; Y='\033[0;33m'; R='\033[0;31m'; D='\033[0;90m'; W='\033[0;97m'; N='\033[0m'

step() { echo -e "\n  ${C}[$1/5] $2${N}\n  ${D}$(printf '%0.s-' {1..50})${N}"; }
ok()   { echo -e "    ${G}[OK]${N} $1"; }
skip() { echo -e "    ${Y}[SKIP]${N} $1"; }
fail() { echo -e "    ${R}[FAIL]${N} $1"; }

echo ""
echo -e "  ${W}================================================${N}"
echo -e "    ${W}CLAUDEFREE — Setup Automatico${N}"
echo -e "    ${D}OpenClaude + Kit Piloto Automatico + OpenRouter${N}"
echo -e "  ${W}================================================${N}"
echo ""

# ── Step 1: Node.js ──
step "1" "Node.js..."

if command -v node &>/dev/null; then
    NODE_V=$(node --version)
    MAJOR=$(echo "$NODE_V" | sed 's/v\([0-9]*\).*/\1/')
    if [ "$MAJOR" -ge 20 ]; then
        ok "Node.js $NODE_V"
    else
        fail "Node.js $NODE_V muito antigo (precisa v20+). Baixe em nodejs.org"
        exit 1
    fi
else
    echo -e "    ${Y}Instalando Node.js...${N}"
    if command -v brew &>/dev/null; then
        brew install node@22
    elif command -v apt &>/dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
        sudo apt install -y nodejs
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y nodejs
    else
        fail "Instale Node.js 20+: nodejs.org"
        exit 1
    fi
    ok "Node.js $(node --version)"
fi

# ── Step 2: OpenClaude + ripgrep ──
step "2" "OpenClaude + dependencias..."

if command -v openclaude &>/dev/null; then
    ok "OpenClaude $(openclaude --version 2>/dev/null)"
else
    echo -e "    ${Y}Instalando OpenClaude...${N}"
    npm install -g @gitlawb/openclaude
    ok "OpenClaude instalado"
fi

if command -v rg &>/dev/null; then
    ok "ripgrep"
else
    echo -e "    ${Y}Instalando ripgrep...${N}"
    if command -v brew &>/dev/null; then brew install ripgrep
    elif command -v apt &>/dev/null; then sudo apt install -y ripgrep
    elif command -v dnf &>/dev/null; then sudo dnf install -y ripgrep
    else fail "Instale ripgrep manualmente"; exit 1; fi
    ok "ripgrep"
fi

# ── Step 3: Kit PA na Area de Trabalho ──
step "3" "Kit Piloto Automatico..."

PROJECT_NAME="minha-empresa"
DESKTOP="$HOME/Desktop"
[ ! -d "$DESKTOP" ] && DESKTOP="$HOME/Área de Trabalho"
[ ! -d "$DESKTOP" ] && DESKTOP="$HOME"
PROJECT_DIR="$DESKTOP/$PROJECT_NAME"

if [ -d "$PROJECT_DIR" ]; then
    skip "Pasta $PROJECT_NAME ja existe"
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

    # Antigravity .agent/
    mkdir -p "$PROJECT_DIR/.agent/skills" "$PROJECT_DIR/.agent/rules" "$PROJECT_DIR/.agent/workflows"
    cp "$PROJECT_DIR/.claude/agents/"*.md "$PROJECT_DIR/.agent/skills/" 2>/dev/null || true
    for sd in "$PROJECT_DIR/.claude/skills/"*/; do
        sn=$(basename "$sd")
        [ -f "$sd/SKILL.md" ] && cp "$sd/SKILL.md" "$PROJECT_DIR/.agent/workflows/$sn.md"
    done
    cp "$PROJECT_DIR/CLAUDE.md" "$PROJECT_DIR/.agent/rules/main.md"

    rm -rf /tmp/claudefree-dl
    ok "14 agentes + 14 skills + 50 prompts + 3 nichos"
    ok "VSCode / Cursor / Antigravity"
fi

# ── Step 4: OpenRouter API Key ──
step "4" "Configurando OpenRouter..."

echo ""
echo -e "    ${W}Crie sua key GRATIS em: https://openrouter.ai/keys${N}"
echo -e "    ${D}(10 dolares de credito gratis no primeiro cadastro)${N}"
echo ""

read -p "    Cole sua OpenRouter API key aqui: " OR_KEY

if [ -z "$OR_KEY" ]; then
    fail "Nenhuma key inserida. Configure manualmente:"
    echo -e "    ${D}export CLAUDE_CODE_USE_OPENAI=1${N}"
    echo -e "    ${D}export OPENAI_BASE_URL=https://openrouter.ai/api/v1${N}"
    echo -e "    ${D}export OPENAI_API_KEY=sua-key${N}"
    echo -e "    ${D}export OPENAI_MODEL=openrouter/free${N}"
else
    export CLAUDE_CODE_USE_OPENAI=1
    export OPENAI_BASE_URL=https://openrouter.ai/api/v1
    export OPENAI_API_KEY="$OR_KEY"
    export OPENAI_MODEL=openrouter/free

    cat > "$PROJECT_DIR/.claude/settings.json" << SETTINGS_EOF
{
  "env": {
    "CLAUDE_CODE_USE_OPENAI": "1",
    "OPENAI_BASE_URL": "https://openrouter.ai/api/v1",
    "OPENAI_API_KEY": "$OR_KEY",
    "OPENAI_MODEL": "openrouter/free"
  },
  "agentModels": {},
  "agentRouting": {},
  "mcpServers": {}
}
SETTINGS_EOF

    ok "OpenRouter configurado (Free Router — escolhe o melhor modelo gratis automaticamente)"
    ok "Key salva em .claude/settings.json"
fi

# ── Step 5: Testar conexao ──
step "5" "Testando conexao..."

if [ -n "$OR_KEY" ]; then
    RESPONSE=$(curl -s -w "%{http_code}" -o /tmp/or-test.json \
        -X POST "https://openrouter.ai/api/v1/chat/completions" \
        -H "Authorization: Bearer $OR_KEY" \
        -H "Content-Type: application/json" \
        -d '{"model":"openrouter/free","messages":[{"role":"user","content":"Responda apenas: OK"}],"max_tokens":5}' \
        --max-time 15 2>/dev/null)

    if [ "$RESPONSE" = "200" ]; then
        ok "Conexao com OpenRouter funcionando!"
    else
        fail "Erro na conexao (HTTP $RESPONSE). Verifique sua API key."
    fi
    rm -f /tmp/or-test.json
else
    skip "Sem key — teste pulado"
fi

# ── Final ──
echo ""
echo -e "  ${G}================================================${N}"
echo -e "    ${G}PRONTO!${N}"
echo -e "  ${G}================================================${N}"
echo ""
echo -e "  ${W}Agora faca:${N}"
echo ""
echo -e "    ${C}cd \"$PROJECT_DIR\"${N}"
echo -e "    ${C}openclaude --bare${N}"
echo ""
echo -e "  ${W}Dentro do OpenClaude:${N}"
echo -e "    ${Y}/setup-empresa${N}"
echo ""
echo -e "  ${D}14 agentes IA prontos. Boa sorte.${N}"
echo ""
