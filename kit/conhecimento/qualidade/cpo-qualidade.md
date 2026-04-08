# Criterios de Qualidade

# Quality Criteria — CPO Squad

## Criterios de Qualidade por Output

### 1. Diagnostico de Produto
- [ ] North Star Metric definida com baseline e target
- [ ] Funil numerado com taxas de conversao por etapa
- [ ] Benchmarks da vertical incluidos
- [ ] Top 3 problemas com evidencia
- [ ] Top 3 oportunidades com impacto estimado
- [ ] Recomendacoes com prazo e responsavel

### 2. Discovery Research
- [ ] Minimo 5 entrevistas com usuarios reais
- [ ] Jobs-to-be-Done documentados com citacao e frequencia
- [ ] Triangulacao quanti/quali presente
- [ ] Insights classificados por frequencia e intensidade
- [ ] Hipoteses priorizadas
- [ ] Segmentacao por perfil

### 3. User Stories
- [ ] Formato "Como... quero... para..."
- [ ] Minimo 2 criterios de aceite BDD por story
- [ ] Valor e complexidade estimados
- [ ] Origem rastreada ao insight de discovery
- [ ] Stories atomicas
- [ ] Backlog priorizado

### 4. UX Audit
- [ ] 4+ fluxos auditados
- [ ] Problemas com severidade classificada
- [ ] Heuristica de Nielsen referenciada
- [ ] Quick wins identificados
- [ ] Score por heuristica
- [ ] Impacto estimado por problema critico

### 5. Metricas de Produto
- [ ] North Star Metric com formula e decomposicao
- [ ] Funil AARRR completo
- [ ] Dashboard com 3 cadencias
- [ ] Alertas de regressao
- [ ] Metricas de vaidade eliminadas

### 6. Plano de Experimentos
- [ ] Hipotese estruturada por experimento
- [ ] Metrica primaria e guardrail definidas
- [ ] Tamanho de amostra calculado
- [ ] Criterio de parada e escala
- [ ] Conexao com NSM
- [ ] Sequenciamento por prioridade

### 7. Roadmap de Produto
- [ ] Score RICE calculado
- [ ] Job-to-be-Done por iniciativa
- [ ] Metrica de sucesso mensuravel
- [ ] Distribuicao realista de esforco
- [ ] Dependencias mapeadas
- [ ] Conexao com NSM

## Score de Qualidade

| Score | Veredicto | Acao |
|-------|-----------|------|
| 90-100 | APROVADO | Entrega direta |
| 80-89 | APROVADO | Entrega com notas |
| 60-79 | APROVADO COM RESSALVAS | Entrega + plano de correcao |
| < 60 | REJEITADO | Retorno ao pipeline |

---

# Anti-Patterns

## 1. Roadmap de Features sem Metricas
**Problema:** Roadmap listando features sem metrica de sucesso.
**Correcao:** Cada item precisa de job-to-be-done, metrica de sucesso e score RICE.

## 2. Discovery sem Evidencia
**Problema:** Insights baseados em opiniao do time, nao em dados.
**Correcao:** Todo insight precisa de citacao direta OU dado comportamental. Triangular quali/quanti.

## 3. Metricas de Vaidade no Dashboard
**Problema:** Dashboard com numeros que crescem mas nao refletem valor real.
**Correcao:** Focar em metricas de outcome, nao de output. NSM como metrica #1.

## 4. Experimento sem Hipotese
**Problema:** Rodar mudancas sem hipotese estruturada.
**Correcao:** Hipotese obrigatoria. Uma variavel por experimento. Criterio de parada antes de comecar.

## 5. Priorizacao por Pedido de Stakeholder
**Problema:** Roadmap determinado por quem grita mais alto.
**Correcao:** Todo pedido passa pelo RICE. Usar discovery para validar.

## 6. UX como Opiniao
**Problema:** Decisoes de UX sem dados de usabilidade.
**Correcao:** UX avaliada por criterio objetivo: taxa de conclusao, dropoff, heuristicas.

## 7. North Star Metric Errada
**Problema:** NSM que favorece o negocio em vez de capturar valor ao usuario.
**Correcao:** NSM responde "O que e sucesso para o USUARIO?" Uma NSM. Decomponivel.
