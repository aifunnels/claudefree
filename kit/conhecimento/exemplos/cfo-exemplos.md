# Output Examples — CFO Squad

## 1. Diagnostico Financeiro (exemplo parcial)

**Cliente:** TechFlow Agency (agencia de marketing digital, 12 funcionarios)

```markdown
# Diagnostico Financeiro — TechFlow Agency
Data: Abril 2026

## Executive Summary
Empresa com margem bruta saudavel (62%) mas margem liquida apertada (8%) por excesso de custos fixos.
Runway de 4.2 meses — adequado mas sem folga. Principal risco: concentracao em 2 clientes (47% da receita).
Oportunidade principal: otimizar equipe subutilizada (utilizacao em 58%).

## Indicadores-Chave

| Indicador | Valor Atual | Benchmark Agencia | Status |
|-----------|-------------|-------------------|--------|
| Receita mensal | R$180k | - | - |
| Margem bruta | 62% | 50-70% | OK |
| Margem liquida | 8% | 10-25% | ALERTA |
| EBITDA | R$21.6k | - | - |
| Burn rate | -R$14.4k | - | Gerando caixa |
| Runway | 4.2 meses | >6 meses | ALERTA |
| LTV/CAC | 6.2x | >5x | OK |
| Churn mensal | 4.1% | <3% | ALERTA |
| Utilizacao equipe | 58% | >70% | ALERTA |
| Concentracao top 2 | 47% | <40% | ALERTA |
```

---

## 2. Forecast de Receita (exemplo parcial)

```markdown
## Premissas

| # | Premissa | Valor | Base |
|---|----------|-------|------|
| 1 | Churn mensal mantem 4.1% | 4.1% | Media 6 meses |
| 2 | 2 novos clientes/mes | 2 | Media 4 meses |
| 3 | Ticket medio novos: R$8.5k | R$8.5k | Ultimos 6 contratos |
| 4 | Upsell em 15% da base | 15% | Historico |

## Receita Projetada (mensal)

| Mes | Recorrente | One-time | Total | vs Anterior |
|-----|-----------|----------|-------|-------------|
| Abr/26 | R$165k | R$15k | R$180k | - |
| Mai/26 | R$175k | R$12k | R$187k | +3.9% |
| Jun/26 | R$182k | R$10k | R$192k | +2.7% |

## Analise de Sensibilidade

| Variavel | Variacao | Impacto Mensal |
|----------|---------|---------------|
| Ticket medio | +/-10% | +/- R$17k |
| Churn | +/-2pp | +/- R$8k |
| Novos clientes | +/-1/mes | +/- R$8.5k |
```

---

## 3. Fluxo de Caixa (exemplo parcial)

```markdown
## Projecao Semanal

| Semana | Entradas | Saidas | Saldo Final | Dias de Caixa |
|--------|---------|--------|-------------|---------------|
| S1 (01-07/abr) | R$45k | R$62k | R$43.4k | 22 |
| S2 (08-14/abr) | R$38k | R$28k | R$53.4k | 28 |
| S3 (15-21/abr) | R$52k | R$35k | R$70.4k | 37 |
| S4 (22-30/abr) | R$40k | R$85k | R$25.4k | 13 |

## Gaps Identificados

| Periodo | Gap | Causa | Acao Sugerida |
|---------|-----|-------|---------------|
| S4 Abr | Caixa cai para 13 dias | Folha + impostos trimestrais | Antecipar recebivel do Cliente A (R$28k) |
```

---

## 4. Revisao de Qualidade (exemplo parcial)

```markdown
# Revisao de Qualidade — CFO Squad
Score: 84/100
Veredicto: APROVADO

## Checklist de Verificacao

| # | Item | Status | Score |
|---|------|--------|-------|
| 1 | Receita diagnostico = forecast | OK | 10/10 |
| 2 | Saldo caixa consistente | OK | 10/10 |
| 3 | Margem bruta consistente | ALERTA | 7/10 |
| 4 | Premissas rastreadas | OK | 9/10 |
| 5 | Metas ancoradas | OK | 8/10 |

## Inconsistencias Encontradas

| Doc A | Doc B | Metrica | Valor A | Valor B | Delta |
|-------|-------|---------|---------|---------|-------|
| Diagnostico | Analise Margens | Margem bruta | 62% | 63.1% | 1.1pp |

Nota: Divergencia de 1.1pp na margem bruta entre diagnostico e analise de margens.
Causa provavel: diagnostico usa DRE simplificado, analise usa decomposicao por produto.
Impacto: baixo. Recomendacao: padronizar base de calculo.
```
