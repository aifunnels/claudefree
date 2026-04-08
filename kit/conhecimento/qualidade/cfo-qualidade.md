# Criterios de Qualidade

# Quality Criteria — CFO Squad

## Criterios de Qualidade por Output

### 1. Diagnostico Financeiro
- [ ] Indicadores calculados com formula explicita
- [ ] Comparacao com benchmark do setor
- [ ] 3 cenarios (pessimista, base, otimista) com probabilidades
- [ ] Top 3 riscos com impacto em R$
- [ ] Top 3 oportunidades com impacto em R$
- [ ] Recomendacoes com prazo e responsavel

### 2. Forecast de Receita
- [ ] Premissas numeradas e explicitas
- [ ] Separacao receita recorrente vs one-time
- [ ] Intervalos de confianca (P10, P50, P90)
- [ ] Analise de sensibilidade por variavel
- [ ] Reconciliacao bottom-up / top-down
- [ ] Granularidade mensal

### 3. Analise de Margens
- [ ] 3 niveis de margem (bruta, operacional, liquida)
- [ ] Decomposicao por produto/servico
- [ ] Decomposicao por cliente (top 10 ou segmentos)
- [ ] Benchmark setorial
- [ ] Oportunidades de otimizacao com impacto

### 4. Fluxo de Caixa Projetado
- [ ] Granularidade semanal (12 semanas)
- [ ] Taxa de inadimplencia aplicada
- [ ] Dias de caixa calculados por semana
- [ ] Calendario de compromissos
- [ ] Gaps identificados com acoes

### 5. Fechamento Mensal
- [ ] Reconciliacao bancaria 100%
- [ ] DRE completo (receita ate lucro liquido)
- [ ] Variancias >5% explicadas com causa raiz
- [ ] Custos por centro de custo
- [ ] Compliance fiscal verificado

### 6. Analise de Custos
- [ ] Classificacao fixo/variavel completa
- [ ] Subclassificacao: essencial/otimizavel/cortavel
- [ ] Top 10 custos identificados
- [ ] Ponto de equilibrio calculado
- [ ] Cenarios de reducao com impacto

### 7. Auditoria de Anomalias
- [ ] Regras de deteccao aplicadas
- [ ] Cross-check entre todos os documentos
- [ ] Scoring de risco por achado
- [ ] Executive summary com top riscos
- [ ] Parecer do auditor

### 8. Mapa de Riscos
- [ ] Riscos categorizados (5 categorias)
- [ ] Scoring (probabilidade x impacto)
- [ ] Mitigacao para altos e medios
- [ ] Early warning indicators
- [ ] Plano de contingencia

### 9. Plano Financeiro 90 Dias
- [ ] 3 meses detalhados com acoes
- [ ] Metas com piso aceitavel
- [ ] Gatilhos de escala e corte
- [ ] Investimentos com payback
- [ ] Riscos da auditoria endereados

### 10. Gestao de Liquidez
- [ ] Ciclo financeiro calculado (PMR, PMP)
- [ ] Reserva de emergencia dimensionada
- [ ] Acoes priorizadas por impacto
- [ ] Alertas por faixa de caixa
- [ ] Estrategia de excedente

## Score de Qualidade

| Score | Veredicto | Acao |
|-------|-----------|------|
| 90-100 | APROVADO | Entrega direta |
| 80-89 | APROVADO | Entrega com notas |
| 60-79 | APROVADO COM RESSALVAS | Entrega + plano de correcao |
| < 60 | REJEITADO | Retorno ao pipeline |

---

# Anti-Patterns

## 1. Diagnostico Superficial
**Problema:** Diagnostico generico sem dados reais, baseado em "achismos".
**Sinais:** Indicadores sem formula ou base de calculo. Cenarios sem probabilidades. Recomendacoes vagas. Sem benchmark.
**Correcao:** Exigir dados reais. Se dados insuficientes, declarar limitacoes explicitamente.

## 2. Forecast sem Premissas
**Problema:** Projecao de receita sem listar as premissas que a sustentam.
**Sinais:** Numeros projetados sem explicar "de onde veio". Extrapolacao linear sem sazonalidade. Sem intervalo de confianca.
**Correcao:** Toda projecao deve listar premissas numeradas. Premissa sem base = projecao invalida.

## 3. Fluxo de Caixa Mensal
**Problema:** Projetar fluxo de caixa com granularidade mensal quando a empresa pode quebrar entre meses.
**Sinais:** Tabela mensal sem detalhe semanal. Sem calendario de vencimentos. Sem taxa de inadimplencia.
**Correcao:** Granularidade semanal obrigatoria. Mapear todos os compromissos com data.

## 4. Prometer Resultados sem Base
**Problema:** Plano com metas ambiciosas sem ancoragem em dados historicos ou benchmark.
**Sinais:** "Dobrar receita em 90 dias" sem historico. Metas sem piso aceitavel. Sem gatilhos de corte.
**Correcao:** Toda meta precisa de base (historico ou benchmark). Incluir piso aceitavel.

## 5. Auditoria Complacente
**Problema:** Auditor que nao questiona, nao cruza dados e "aprova tudo".
**Sinais:** Parecer "limpo" sem evidencia. Sem cross-check entre documentos. Scoring generoso.
**Correcao:** Aplicar TODAS as regras de deteccao. Cruzar numeros entre docs. Ceticismo como padrao.

## 6. Misturar Competencia e Caixa
**Problema:** Confundir receita faturada com receita recebida.
**Sinais:** DRE com valores de extratos bancarios. Fluxo de caixa com valores de notas fiscais.
**Correcao:** DRE = competencia. Fluxo de caixa = caixa. Dois documentos separados.

## 7. Concentracao Ignorada
**Problema:** Ignorar risco de concentracao.
**Sinais:** Top cliente >30% da receita sem alertar. Toda receita de um canal.
**Correcao:** Alertar concentracao >20% em qualquer dimensao. Incluir no mapa de riscos.

## 8. Custos "Outros"
**Problema:** Categoria "outros" engolindo percentual significativo dos custos.
**Sinais:** "Outros" > 10% dos custos totais. Lancamentos sem classificacao.
**Correcao:** Maximo 5% em "outros". Reclassificar ate detalhar.
