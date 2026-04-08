# CHEAT SHEET — Claude Code para Agencias

## Termos Essenciais


| Termo         | O Que E                            | Analogia                                 |
| ------------- | ---------------------------------- | ---------------------------------------- |
| **CLAUDE.md** | Arquivo de instrucoes do projeto   | Manual do funcionario                    |
| **Agente**    | Assistente especializado numa area | Funcionario com cargo definido           |
| **Skill**     | Comando reutilizavel (/nome)       | SOP que qualquer um segue igual          |
| **MCP**       | Conexao com ferramentas externas   | Tomada USB — pluga Drive, ClickUp, Slack |
| **Hook**      | Automacao em momentos especificos  | Alarme que dispara antes/depois de acoes |
| **Plan Mode** | Modo somente-leitura pra analisar  | Reuniao de planejamento                  |
| **Contexto**  | Info disponivel na conversa        | Memoria de trabalho do Claude            |


---

## Estrutura de Pastas

```
minha-agencia/
├── CLAUDE.md                  ← Cerebro do projeto (OBRIGATORIO)
├── .claude/
│   ├── agents/                ← Agentes especializados
│   │   ├── copy-agent.md
│   │   └── traffic-agent.md
│   ├── skills/                ← Skills (SOPs executaveis)
│   │   └── briefing-cliente/
│   │       └── SKILL.md
│   └── settings.json          ← Configuracoes e MCPs
├── clientes/                  ← Pasta por cliente
│   └── nome-do-cliente/
│       └── briefing.md
└── templates/                 ← Templates reutilizaveis
```

---

## Atalhos de Teclado


| Atalho           | O Que Faz                    |
| ---------------- | ---------------------------- |
| `Shift+Tab`      | Alterna modo de permissao    |
| `Esc`            | Interrompe o Claude          |
| `Esc` duas vezes | Volta ao checkpoint anterior |
| `/clear`         | Limpa a conversa             |
| `/help`          | Mostra ajuda                 |
| `/nome-da-skill` | Executa uma skill            |


---

## Comandos Essenciais


| Comando           | O Que Faz                |
| ----------------- | ------------------------ |
| `claude`          | Inicia sessao interativa |
| `claude "tarefa"` | Executa tarefa unica     |
| `claude -c`       | Continua ultima sessao   |
| `/init`           | Cria/edita CLAUDE.md     |
| `/clear`          | Limpa contexto           |


---

## Modos de Permissao (Shift+Tab)

1. **Padrao** — Pede permissao pra tudo
2. **Auto-aceitar edits** — Edita sem perguntar, pede permissao pra comandos
3. **Plan Mode** — So le, nao edita nada (pra planejar)

---

## 5 Regras de Ouro

1. **CLAUDE.md primeiro** — Sem ele, o Claude nao sabe nada do seu negocio
2. **Seja especifico** — "Escreva 5 headlines pra SaaS B2B" > "Escreva headlines"
3. **Explore antes de agir** — "O que esse projeto faz?" antes de "Mude X"
4. **Atualize sempre** — Depois de cada sessao, atualize o CLAUDE.md
5. **Use /clear entre tarefas** — Nao misture contextos diferentes

---

## Repositorios Uteis


| Repo                        | O Que Tem                           | Link                                            |
| --------------------------- | ----------------------------------- | ----------------------------------------------- |
| awesome-claude-code         | Lista curada de tudo                | github.com/hesreallyhim/awesome-claude-code     |
| awesome-claude-code-toolkit | 135 agentes, 35 skills, 42 comandos | github.com/rohitg00/awesome-claude-code-toolkit |
| anthropics/skills           | Skills oficiais da Anthropic        | github.com/anthropics/skills                    |
| claude-skills (192+)        | Maior biblioteca de skills          | github.com/alirezarezvani/claude-skills         |
| awesome-mcp-servers         | 7000+ servidores MCP                | github.com/TensorBlock/awesome-mcp-servers      |
| claude-code-templates       | Templates de configuracao           | github.com/davila7/claude-code-templates        |
| claude-howto                | Guia visual pra iniciantes          | github.com/luongnv89/claude-howto               |


---

## Proximos 30 Dias

- **Hoje:** Instalar Claude Code + criar CLAUDE.md
- **Semana 1:** Criar 3-5 agentes pra sua operacao
- **Semana 2:** Criar skills pros processos que mais repete
- **Semana 3:** Configurar 1-2 MCPs (Google Drive, ClickUp)
- **Semana 4:** Treinar o time a usar

