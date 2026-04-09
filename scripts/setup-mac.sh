#!/bin/bash
# CLAUDEFREE — Setup One-Shot (macOS / Linux)
# curl -fsSL https://raw.githubusercontent.com/aifunnels/claudefree/master/scripts/setup-mac.sh | bash

set -e

ok()   { echo -e "  \033[0;32m[OK]\033[0m $1"; }
fail() { echo -e "  \033[0;31m[ERRO]\033[0m $1"; }
info() { echo -e "  \033[0;33m$1\033[0m"; }
step() { echo -e "\n  \033[0;36m--- $1. $2 ---\033[0m"; }

echo ""
echo -e "  \033[0;97mCLAUDEFREE — Setup Automatico\033[0m"
echo -e "  \033[0;90mOpenClaude + Kit Piloto Automatico + OpenRouter\033[0m"
echo ""

# 1. NODE
step "1" "Node.js"
if command -v node &>/dev/null; then
    NV=$(node --version)
    M=$(echo "$NV" | sed 's/v\([0-9]*\).*/\1/')
    if [ "$M" -ge 20 ]; then ok "Node.js $NV"
    else fail "Node.js $NV antigo. Baixe v20+ em nodejs.org"; exit 1; fi
else
    info "Instalando Node.js..."
    if command -v brew &>/dev/null; then brew install node@22
    elif command -v apt &>/dev/null; then curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && sudo apt install -y nodejs
    elif command -v dnf &>/dev/null; then sudo dnf install -y nodejs
    else fail "Instale Node.js 20+: nodejs.org"; exit 1; fi
    ok "Node.js $(node --version)"
fi

# 2. OPENCLAUDE
step "2" "OpenClaude"
if command -v openclaude &>/dev/null; then ok "OpenClaude $(openclaude --version 2>/dev/null)"
else
    info "Instalando OpenClaude..."
    npm install -g @gitlawb/openclaude
    ok "OpenClaude instalado"
fi

# 3. RIPGREP
step "3" "ripgrep"
if command -v rg &>/dev/null; then ok "ripgrep instalado"
else
    info "Instalando ripgrep..."
    if command -v brew &>/dev/null; then brew install ripgrep
    elif command -v apt &>/dev/null; then sudo apt install -y ripgrep
    elif command -v dnf &>/dev/null; then sudo dnf install -y ripgrep
    else fail "Instale ripgrep manualmente"; exit 1; fi
    ok "ripgrep"
fi

# 4. API KEY
step "4" "OpenRouter API Key"
echo ""
echo -e "  \033[0;97mCrie sua key gratis em: https://openrouter.ai/keys\033[0m"
echo ""
read -p "  Cole a key aqui: " KEY
if [ -z "$KEY" ]; then fail "Sem key. Rode o script de novo quando tiver."; exit 1; fi

info "Testando conexao..."
HTTP=$(curl -s -o /tmp/or-test.json -w "%{http_code}" \
    -X POST "https://openrouter.ai/api/v1/chat/completions" \
    -H "Authorization: Bearer $KEY" \
    -H "Content-Type: application/json" \
    -d '{"model":"openrouter/free","messages":[{"role":"user","content":"OK"}]}' \
    --max-time 30 2>/dev/null)
rm -f /tmp/or-test.json

if [ "$HTTP" = "200" ]; then ok "Key funcionando!"
elif [ "$HTTP" = "402" ]; then fail "Key sem creditos. Acesse openrouter.ai/settings/credits"; exit 1
elif [ "$HTTP" = "401" ]; then fail "Key invalida. Confira em openrouter.ai/keys"; exit 1
else fail "Erro HTTP $HTTP. Verifique sua key."; exit 1; fi

# 5. KIT PA
step "5" "Kit Piloto Automatico"
DESKTOP="$HOME/Desktop"
[ ! -d "$DESKTOP" ] && DESKTOP="$HOME/Área de Trabalho"
[ ! -d "$DESKTOP" ] && DESKTOP="$HOME"
PROJ="$DESKTOP/minha-empresa"

if [ -d "$PROJ" ]; then
    info "Pasta minha-empresa ja existe. Atualizando settings..."
else
    info "Baixando Kit PA..."
    rm -rf /tmp/claudefree-dl
    git clone --depth 1 https://github.com/aifunnels/claudefree.git /tmp/claudefree-dl
    KIT="/tmp/claudefree-dl/kit"

    mkdir -p "$PROJ"
    cp "$KIT/CLAUDE.md" "$PROJ/"
    for d in .claude conhecimento prompts templates nichos docs clientes; do
        cp -r "$KIT/$d" "$PROJ/"
    done
    mkdir -p "$PROJ/config" "$PROJ/output"

    # Antigravity
    mkdir -p "$PROJ/.agent/skills" "$PROJ/.agent/rules" "$PROJ/.agent/workflows"
    cp "$PROJ/.claude/agents/"*.md "$PROJ/.agent/skills/" 2>/dev/null || true
    for sd in "$PROJ/.claude/skills/"*/; do
        sn=$(basename "$sd")
        [ -f "$sd/SKILL.md" ] && cp "$sd/SKILL.md" "$PROJ/.agent/workflows/$sn.md"
    done
    cp "$PROJ/CLAUDE.md" "$PROJ/.agent/rules/main.md"

    rm -rf /tmp/claudefree-dl
    ok "14 agentes + 14 skills + 50 prompts"
fi

# Salvar settings com a key
mkdir -p "$PROJ/.claude"
cat > "$PROJ/.claude/settings.json" << EOF
{
  "env": {
    "CLAUDE_CODE_USE_OPENAI": "1",
    "OPENAI_BASE_URL": "https://openrouter.ai/api/v1",
    "OPENAI_API_KEY": "$KEY",
    "OPENAI_MODEL": "openrouter/free"
  },
  "mcpServers": {}
}
EOF
ok "Key salva em .claude/settings.json"

export CLAUDE_CODE_USE_OPENAI=1
export OPENAI_BASE_URL=https://openrouter.ai/api/v1
export OPENAI_API_KEY="$KEY"
export OPENAI_MODEL=openrouter/free

# PRONTO
echo ""
echo -e "  \033[0;32m========================================\033[0m"
echo -e "    \033[0;32mPRONTO!\033[0m"
echo -e "  \033[0;32m========================================\033[0m"
echo ""
echo -e "  \033[0;36mAbrindo OpenClaude...\033[0m"
echo ""

cd "$PROJ"
openclaude --bare
