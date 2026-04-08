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

## Providers — Escolha o seu

| Provider | Vantagem | Como usar |
|----------|----------|-----------|
| **Ollama (local)** | Gratis, 100% local, sem API key | Ja vem configurado |
| **OpenRouter** | 1 conta = 200+ modelos (GPT-4o, Claude, Gemini, DeepSeek) | Crie key em openrouter.ai/keys |
| **OpenAI direto** | Se ja tem key OpenAI | Coloque a key no config |
| **DeepSeek direto** | Mais barato que OpenAI | Coloque a key no config |

> **Recomendacao:** Use **OpenRouter** como hub unico. Uma conta, uma key, acesso a todos os modelos. Ou **Ollama** se quer custo zero.

## Multi-Model Routing

6 modos de operacao:

| Modo | Router | Agentes | Custo |
|------|--------|---------|-------|
| Local | Ollama 3b | Ollama 7b | R$0 |
| OpenRouter | Ollama 3b | Gemini Flash + DeepSeek + GPT-4o-mini | ~R$5/mes |
| Hibrido | Ollama 3b | GPT-4o-mini (OpenRouter) + Ollama 7b | ~R$3/mes |
| Performance | Ollama 3b | GPT-4o + Claude Sonnet + DeepSeek | ~R$30/mes |
| Direto OpenAI | Ollama 3b | GPT-4o-mini | ~R$10/mes |
| Direto DeepSeek | Ollama 3b | DeepSeek Chat v3 | ~R$2/mes |

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
