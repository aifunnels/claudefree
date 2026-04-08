# Kit Piloto Automatico

Assistente IA para prestadores de servico digital (gestores de trafego, social media, designers, videomakers).

## Inicializacao

SE `config/empresa.md` NAO existir:
- Execute /setup-empresa para configurar o perfil do negocio antes de qualquer outra acao.

SE `config/empresa.md` existir:
- Carregue `config/empresa.md` para contexto do negocio.
- Use o agente @cos (Chief of Staff) para rotear qualquer pedido.

## Regras

- Idioma: pt-BR em todas as interacoes
- NUNCA carregar arquivos de `conhecimento/` a menos que o agente solicite explicitamente
- NUNCA expor tokens, senhas ou credenciais
- Dados de clientes sao CONFIDENCIAIS
- Commits em ingles (conventional commits)

## Estrutura

- `config/empresa.md` — perfil do negocio (criado por /setup-empresa)
- `clientes/` — briefings por cliente
- `conhecimento/` — frameworks, boas praticas, KPIs (carregar sob demanda)
- `prompts/` — 50 prompts validados (5 categorias)
- `templates/` — templates por segmento (5 segmentos)
- `nichos/` — contexto especifico por nicho (advocacia, b2b, clinicas)
- `docs/` — FAQ, glossario, troubleshooting
