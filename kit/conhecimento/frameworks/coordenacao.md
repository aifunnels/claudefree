# Coordination Framework — CoS Squad

## Squad Routing

### Como Determinar Qual Squad Atender uma Demanda

| Tipo de Demanda | Squad Responsavel | Como Identificar |
|----------------|-------------------|-----------------|
| Analise financeira, forecast, caixa | CFO Squad | Envolve numeros financeiros, P&L, budget |
| Campanhas de marketing, conteudo, copy | CMO Squad | Envolve marketing, audiencia, comunicacao |
| Onboarding de cliente novo | Onboarding Squad | Novo cliente entrando no ecossistema |
| Coordenacao entre squads | CoS Squad | Decisoes que afetam 2+ squads |
| Reuniao de lideranca | CoS Squad | Alinhamento estrategico, decisoes cruzadas |

### Criterios de Roteamento

1. **Impacto em 1 squad apenas** → Rotear para o squad especifico
2. **Impacto em 2+ squads** → Envolver CoS para coordenar
3. **Decisao estrategica** → CoS como facilitadora + squad(s) como executores
4. **Blocker cruzado** → CoS medeia, squads desbloqueiam com suporte da CoS

---

## Handoff Protocol

### O Que Constitui um Bom Handoff

Um handoff completo entre squads ou entre sessoes deve conter:

1. **Estado atual** — onde o trabalho esta agora
2. **O que foi feito** — resumo do trabalho concluido
3. **Decisoes tomadas** — com raciocinio (nao so o resultado)
4. **Itens em aberto** — o que ainda precisa ser feito
5. **Blockers ativos** — o que esta impedindo progresso
6. **Proximo passo** — a acao imediata para continuar
7. **Contexto de restauracao** — o minimo necessario para retomar sem perguntas

### Qualidade de Handoff

| Nivel | Descricao |
|-------|-----------|
| Excelente | Outra pessoa pode continuar em < 5 min sem perguntas |
| Bom | Outra pessoa pode continuar com 1-2 perguntas de esclarecimento |
| Adequado | Outra pessoa precisa de 15-30 min para entender o contexto |
| Ruim | Sem handoff ou handoff incompleto — contexto perdido |

---

## Meeting Templates

### Reuniao de Alinhamento de Squads (30-45 min)

**Objetivo:** Resolver blockers cruzados e alinhar dependencias entre squads

```
Pauta padrao:
[5 min] Check-in rapido — cada squad em 1 linha
[15 min] Blockers cruzados — top 2-3
[10 min] Decisoes necessarias
[5 min] Action items e responsaveis
[5 min] Buffer
```

### Reuniao de Revisao de Ciclo (60-90 min)

**Objetivo:** Revisar o ciclo encerrado e planejar o proximo

```
Pauta padrao:
[10 min] Report consolidado — leitura previa obrigatoria
[15 min] Retrospectiva — Start/Stop/Continue
[20 min] Priorizacao do proximo ciclo
[15 min] Resolucao de pendencias
[10 min] Comprometimentos e action items
[10 min] Buffer
```

### Reuniao de Decisao (30 min)

**Objetivo:** Tomar uma decisao especifica que requer multiplas perspectivas

```
Pauta padrao:
[5 min] Contexto da decisao (pre-leitura obrigatoria)
[5 min] Opcoes na mesa
[15 min] Discussao e deliberacao
[5 min] Decisao + action items
```

---

## Priority Frameworks

### Matriz de Eisenhower

```
                URGENTE          NAO URGENTE
IMPORTANTE  | FAZER AGORA   | AGENDAR        |
            | (Quadrante I) | (Quadrante II) |
NAO         | DELEGAR       | ELIMINAR       |
IMPORTANTE  | (Quad. III)   | (Quadrante IV) |
```

**Regra do CoS Squad:** O foco e o Quadrante II (importante, nao urgente). Incendios no Quadrante I sao sintoma de falta de planejamento no Quadrante II.

### MoSCoW

| Categoria | Definicao | Criterio |
|-----------|-----------|---------|
| **Must Have** | Sem isso o ciclo falha | Blocker direto para objetivo principal |
| **Should Have** | Alta prioridade mas ha margem | Pode esperar 1-2 semanas sem dano critico |
| **Could Have** | Valor real mas baixa urgencia | Pode esperar ate 1 mes |
| **Won't Have** | Fora de escopo deliberado | Nao neste ciclo — reavaliar no proximo |

### Criterio de Desempate

Quando dois itens parecem igualmente prioritarios:

1. **Impacto:** Qual tem maior impacto se feito? Qual tem maior impacto se NAO feito?
2. **Dependencias:** Qual desbloqueia mais outros itens?
3. **Esforco:** Qual e mais viavel com os recursos atuais?
4. **Reversibilidade:** Qual e mais facil de desfazer se errado?

---

## Coordination KPIs

### Como Medir a Saude da Coordenacao

| KPI | Definicao | Formula |
|-----|-----------|---------|
| Taxa de Entrega | % de itens planejados entregues no ciclo | Entregues / Planejados x 100 |
| Qualidade de Handoff | % de handoffs classificados como "Bom" ou "Excelente" | Bons / Total x 100 |
| Ciclo de Decisao | Tempo medio entre "decisao necessaria" e "decisao tomada" | Media em dias |
| Squads sem Blocker | % de squads sem blocker ativo no final do ciclo | Squads OK / Total x 100 |
| Recorrencia de Problemas | % de problemas que aparecem em 2+ ciclos | Recorrentes / Total x 100 |

### Benchmarks Alvo

| KPI | Alvo | Alerta | Critico |
|-----|------|--------|---------|
| Taxa de Entrega | >80% | 60-80% | <60% |
| Qualidade de Handoff | >85% bom+ | 70-85% | <70% |
| Ciclo de Decisao | <2 dias | 2-5 dias | >5 dias |
| Squads sem Blocker | >70% | 50-70% | <50% |
| Recorrencia de Problemas | <20% | 20-40% | >40% |

---

## Retrospectiva

### Estrutura Start/Stop/Continue

**Start:** Praticas que nao existem hoje mas deveriam existir
- Evidencia: problema que ocorreu que seria evitado com esta pratica
- Responsavel: quem vai implementar
- Como medir: como saber que esta funcionando

**Stop:** Praticas que existem mas estao gerando dano ou desperdicio
- Evidencia: impacto negativo observado no ciclo
- Alternativa: o que fazer em vez disso
- Responsavel: quem vai descontinuar

**Continue:** Praticas que estao funcionando e devem ser mantidas
- Evidencia: impacto positivo observado
- Por que nao e obvio: muitas boas praticas sao descontinuadas inadvertidamente

### Criterio de Honestidade

Uma retrospectiva e honesta quando:
- O numero de Stops e comparavel ao numero de Continues
- Problemas recorrentes sao nomeados como sistemicos, nao como casos isolados
- Os comprometimentos sao especificos e mensuraveis, nao genericos
