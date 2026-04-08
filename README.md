# ClaudeFree

**14 agentes IA + 14 skills + 50 prompts.** Uma agencia inteira rodando local, gratis.

OpenClaude + Ollama + Kit Piloto Automatico v29.9.

## Setup em 1 comando

### Windows (PowerShell)

```powershell
git clone https://github.com/aifunnels/claudefree.git
cd claudefree
powershell -ExecutionPolicy Bypass -File scripts/setup-windows.ps1
```

### macOS / Linux

```bash
git clone https://github.com/aifunnels/claudefree.git
cd claudefree
chmod +x scripts/setup-mac.sh && ./scripts/setup-mac.sh
```

## O que instala

| Componente | O que faz |
|------------|-----------|
| OpenClaude | CLI de coding-agent (clone do Claude Code) |
| Ollama | LLM local (qwen2.5-coder:7b) |
| ripgrep | Busca de arquivos (dependencia) |
| Kit PA v29.9 | 14 agentes + 14 skills + 50 prompts + 3 nichos |

## Iniciar

```powershell
# Windows
$env:CLAUDE_CODE_USE_OPENAI="1"
$env:OPENAI_BASE_URL="http://localhost:11434/v1"
$env:OPENAI_MODEL="qwen2.5-coder:7b"
openclaude --bare
```

```bash
# macOS / Linux
export CLAUDE_CODE_USE_OPENAI=1
export OPENAI_BASE_URL=http://localhost:11434/v1
export OPENAI_MODEL=qwen2.5-coder:7b
openclaude --bare
```

Dentro do OpenClaude: `/setup-empresa`

## Agentes

| Agente | Papel |
|--------|-------|
| @cos | Router — classifica e despacha |
| @ceo | Estrategia, OKRs, roadmap |
| @cfo | Financeiro, fluxo de caixa, pricing |
| @cmo | Marketing, canais, calendario editorial |
| @cso | Vendas, pipeline, prospeccao |
| @coo | Processos, SOPs, automacao |
| @cpo | Produto, discovery, UX |
| @cto | Tecnologia, seguranca, infra |
| @chro | Pessoas, cultura, recrutamento |
| @copy | Copywriting, headlines, emails, ads |
| @traffic | Trafego pago, Meta Ads, Google Ads |
| @carrossel | Carrosseis Instagram/LinkedIn |
| @revisor | Revisao de qualidade (score 0-100) |
| @onboarding | Integracao de novos clientes |

## Multi-Model Routing

3 modos de operacao:

| Modo | Router | Agentes | Custo |
|------|--------|---------|-------|
| Local | Ollama 3b | Ollama 7b | R$0 |
| Hibrido | Ollama 3b | GPT-4o-mini + Ollama 7b | ~R$5/mes |
| Performance | Ollama 3b | GPT-4o + DeepSeek | ~R$30/mes |

Config em `kit/.claude/multi-model.example.json`

## Estrutura

```
seu-projeto/
├── CLAUDE.md                    <- cerebro do projeto
├── .claude/
│   ├── agents/                  <- 14 agentes
│   ├── skills/                  <- 14 skills (/comandos)
│   └── settings.json            <- config limpa
├── clientes/                    <- briefings por cliente
├── conhecimento/                <- frameworks, boas praticas, KPIs
├── prompts/                     <- 50 prompts validados
├── templates/                   <- templates por segmento
├── nichos/                      <- advocacia, B2B, clinicas
├── config/                      <- perfil do negocio
├── docs/                        <- guias e FAQ
└── output/                      <- arquivos gerados
```

## Guia Visual

Abra `index.html` no navegador para o guia completo de instalacao.

## Licenca

MIT
