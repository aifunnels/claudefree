# Output Examples — COO Squad

## 1. Diagnostico Operacional (exemplo parcial)

**Cliente:** Polypus Agency (agencia de marketing digital, 8 funcionarios)

```markdown
# Diagnostico Operacional — Polypus Agency
Data: Abril 2026

## Executive Summary
Agencia com 5 processos criticos identificados, sendo 3 sem SLA formal definido.
Principal gargalo: onboarding de novos clientes consome 40h/mes do COO (20% da capacidade).
Utilizacao media do time: 84% — no limite. Nenhum processo critico tem backup documentado.
Oportunidade imediata: automatizar relatorio semanal de performance (6h/semana economizadas).

## Mapa de Processos Atual

| Area | Processo | SLA Atual | SLA Formal? | Tempo Ciclo | Volume/Mes |
|------|---------|-----------|-------------|-------------|-----------|
| Comercial | Proposta comercial | 3 dias | Nao | 4h | 8 |
| Entrega | Onboarding cliente | 15 dias | Nao | 40h | 2 |
| Entrega | Relatorio mensal | D+3 util | Sim | 6h | 12 |
| Suporte | Atendimento ad hoc | 24h | Nao | 30min | 35 |
| Administrativo | Fechamento financeiro | D+5 util | Sim | 8h | 1 |

## Gargalos Identificados

| # | Gargalo | Processo Afetado | Impacto | Frequencia |
|---|---------|-----------------|---------|-----------|
| 1 | COO executa onboarding inteiro | Onboarding cliente | 40h/mes COO | 2x/mes |
| 2 | Relatorio manual em planilha | Relatorio mensal | 6h/ciclo, atraso recorrente | 12x/mes |
| 3 | Proposta sem template — recriada do zero | Proposta comercial | 2h extras/proposta | 8x/mes |
```

---

## 2. Mapa de Processos (exemplo parcial)

```markdown
## PROCESSO: Relatorio Mensal de Performance

**ID:** P-003
**Criticidade:** IMPORTANTE
**Gatilho:** D+1 util de cada mes
**Output:** Relatorio PDF enviado ao cliente por email
**Volume:** 12 clientes/mes

### Fluxo

[GATILHO: D+1 util do mes]
  |
Etapa 1: Extrair dados do Meta Ads — Resp: Analista — Ferramenta: Meta Business Suite — Tempo: 45min
  |
Etapa 2: Extrair dados do Google Analytics — Resp: Analista — Ferramenta: GA4 — Tempo: 30min
  |
Etapa 3: Consolidar na planilha de relatorio — Resp: Analista — Ferramenta: Google Sheets — Tempo: 60min
  |
Etapa 4: Montar PDF com comentarios — Resp: Analista — Ferramenta: Canva / Google Slides — Tempo: 90min
  | [DECISAO: COO revisa?]
  +-- Cliente Premium (>R$5k/mes) -> Etapa 5a: Revisao COO (30min)
  +-- Cliente Standard -> Etapa 5b: Auto-aprovado
  |
Etapa 6: Enviar por email — Resp: Analista — Ferramenta: Gmail — Tempo: 10min
  |
[OUTPUT: Relatorio entregue ao cliente]

### Pontos de Falha

| Etapa | Falha Frequente | Causa | Impacto |
|-------|----------------|-------|---------|
| Etapa 3 | Dados de um cliente nao aparecem | API Meta retornou erro | Atraso de 1-2 dias |
| Etapa 4 | Template desatualizado | Sem controle de versao do template | Retrabalho de 60min |
```

---

## 3. Plano de Automacao (exemplo parcial)

```markdown
## AUTOMACAO-01: Extracao e Consolidacao de Dados de Performance

**Processo Origem:** P-003 — Relatorio Mensal
**Ferramenta Recomendada:** n8n
**Justificativa:** Multiplas APIs (Meta, GA4, Sheets), logica condicional, self-hosted para controle

**Trigger:** Agendamento D+1 util de cada mes, 7h00
**Acoes:**
1. Buscar dados Meta Ads via API — para cada cliente ativo
2. Buscar dados GA4 via API — para cada cliente ativo
3. Consolidar em aba especifica do Google Sheets por cliente
4. Enviar notificacao Slack: "Dados extraidos — iniciar montagem do relatorio"

**Tratamento de Erro:**
- Se API Meta falhar: tentar 3x com intervalo de 10min
- Se GA4 falhar: marcar cliente como "dados pendentes" e continuar outros
- Fallback manual: notificar analista via Slack com lista de clientes com erro

**ROI:**
| Metrica | Valor |
|---------|-------|
| Tempo manual atual (extracao) | 75 min/ciclo |
| Volume/mes | 12 ciclos |
| Horas economizadas/mes | 15h |
| Custo hora analista | R$ 40 |
| Economia mensal | R$ 600 |
| Tempo de build | 16h |
| Payback | 1.1 meses |
```

---

## 4. Dashboard Operacional (exemplo parcial)

```markdown
# Dashboard Operacional — Polypus Agency
Data: Abril 2026

## Visao Geral

| Area | Status | Observacao |
|------|--------|-----------|
| Entrega | AMARELO | SLA relatorio: 87% (meta: 95%) |
| Suporte | VERDE | Atendimento: 96% dentro do prazo |
| Capacidade | VERMELHO | Utilizacao media: 88% |
| Satisfacao time | AMARELO | eNPS: +8 (meta: >20) |

## KPIs Primarios

| KPI | Formula | Meta | Alerta | Atual | Tendencia |
|-----|---------|------|--------|-------|----------|
| SLA Relatorio | % entregas no prazo | >95% | <90% | 87% | Estavel |
| Utilizacao equipe | Horas trabalhadas / Capacidade util | 70-80% | >85% | 88% | Subindo |
| Taxa retrabalho | Entregas com correcao / Total | <5% | >8% | 3.2% | Melhora |
| eNPS | % Promotores - % Detratores | >20 | <10 | +8 | Estavel |
```

---

## 5. Revisao Operacional (exemplo parcial)

```markdown
# Revisao Operacional — COO Squad
Score: 82/100
Veredicto: APROVADO

## Checklist de Verificacao

| # | Item | Status | Score | Observacao |
|---|------|--------|-------|-----------|
| 1 | Processos do mapa = processos do SOP | OK | 10/10 | 5 processos criticos com SOP |
| 2 | SLAs do plano aparecem no dashboard | ALERTA | 7/10 | Relatorio mensal: SLA no plano e 24h, dashboard mede 3 dias |
| 3 | Automacoes tem processo mapeado | OK | 10/10 | Todas as 3 automacoes tem P-ID referenciado |
| 4 | Capacidade suporta o plano | ALERTA | 6/10 | M2 tem 3 iniciativas com mesmo responsavel sobrecarregando 95% |

## Inconsistencias Encontradas

| Doc A | Doc B | Item | Valor A | Valor B |
|-------|-------|------|---------|---------|
| Plano 90d | Dashboard | SLA Relatorio | 24h | D+3 uteis |

Recomendacao: alinhar SLA com a equipe e padronizar entre documentos.
```
