# Output Examples — CPO Squad

## 1. Diagnostico de Produto (exemplo parcial)

**Cliente:** Flowdesk (SaaS B2B de gestao de tarefas, 2.400 usuarios pagantes)

```markdown
# Diagnostico de Produto — Flowdesk
Data: Abril 2026

## Executive Summary
Produto com ativacao fraca (38% em D1) como principal problema. Retencao D30 em 61% — abaixo do benchmark SaaS B2B (70%+). North Star Metric mal definida: time usa "usuarios cadastrados" em vez de metrica de valor. Oportunidade principal: redesenho do onboarding pode recuperar 15-20% da ativacao.

## North Star Metric

| Metrica | Valor Atual | Target (90 dias) | Gap |
|---------|-------------|-----------------|-----|
| Projetos colaborativos ativos/semana | 420 | 650 | +230 (+55%) |

## Metricas-Chave

| Metrica | Valor Atual | Benchmark SaaS B2B | Status |
|---------|-------------|-------------------|--------|
| Ativacao D1 | 38% | >60% | CRITICO |
| Retencao D30 | 61% | >70% | ALERTA |
| Churn mensal | 2.8% | <1% | CRITICO |
| NPS | 34 | >40 | ALERTA |
| DAU/MAU | 22% | >25% | ALERTA |
| LTV/CAC | 3.2x | >3x | OK |
```

---

## 2. Discovery Research (exemplo parcial)

```markdown
# Discovery Research — Flowdesk
Participantes: 8 entrevistas + analytics de 1.240 usuarios

## Job Principal
"Quando inicio um projeto com meu time, quero garantir que todos sabem o que fazer sem precisar ficar perguntando, para nao perder tempo em reunioes de alinhamento."
- Frequencia: 7 de 8 entrevistados mencionaram variacao deste job
- Intensidade: Alta
- Citacao: "O problema nao e ter as tarefas — e fazer o time realmente olhar para elas."

## Dores Mapeadas

| Dor | Frequencia | Intensidade | Citacao |
|-----|------------|-------------|---------|
| Onboarding confuso no primeiro acesso | 6/8 | Alta | "Nao sabia por onde comecar. Desisti na primeira vez." |
| Notificacoes excessivas | 5/8 | Media | "Viro o celular para baixo quando começa a trabalhar." |
| Sem visao geral do progresso do projeto | 4/8 | Alta | "Preciso entrar em cada tarefa para saber se avancou." |
```

---

## 3. Roadmap de Produto (exemplo parcial)

```markdown
# Roadmap de Produto — Flowdesk
Periodo: Abril a Junho 2026
North Star: Projetos colaborativos ativos/semana | Atual: 420 | Target: 650

## Backlog Priorizado (RICE)

| # | Iniciativa | Reach | Impact | Confidence | Effort | Score RICE |
|---|------------|-------|--------|------------|--------|-----------|
| 1 | Redesenho do onboarding | 2400 | 2 | 80% | 4 | 960 |
| 2 | Dashboard de progresso do projeto | 1800 | 1 | 80% | 3 | 480 |
| 3 | Smart notifications (digest) | 2400 | 0.5 | 50% | 2 | 300 |

## Mes 1 — Ativacao
| Iniciativa | Job | Metrica de Sucesso | Esforco |
|------------|-----|-------------------|---------|
| Redesenho do onboarding | "Quero comecar sem ficar perdido" | Ativacao D1 >55% | 4 sem-pessoa |
```

---

## 4. Revisao de Produto (exemplo parcial)

```markdown
# Revisao do Pacote de Produto — Flowdesk
Score: 82/100
Veredicto: APROVADO

## Checklist de Completude

| Output | Presente | Completo | Score |
|--------|----------|---------|-------|
| diagnostico-produto.md | OK | OK | 9/10 |
| roadmap-produto.md | OK | OK | 8/10 |
| discovery-research.md | OK | OK | 9/10 |
| user-stories.md | OK | ALERTA | 7/10 |
| experiment-plan.md | OK | OK | 8/10 |
| metricas-produto.md | OK | OK | 8/10 |
| ux-audit.md | OK | OK | 9/10 |

## Cross-Check Discovery -> Roadmap

| Item do Roadmap | Origem no Discovery | Status |
|-----------------|---------------------|--------|
| Redesenho do onboarding | 6/8 usuarios reportaram onboarding confuso | OK |
| Dashboard de progresso | 4/8 usuarios com dor de visibilidade | OK |
| Smart notifications | 5/8 com friccao em notificacoes | OK |

## Nota
User stories do mes 2 ainda sem criterios de aceite completos. Recomendacao: detalhar antes de iniciar o mes 2.
```
