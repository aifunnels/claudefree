# Criterios de Qualidade

# Quality Criteria — CTO Squad

## Criterios de Qualidade por Output

### 1. Diagnostico Tecnico
- [ ] Stack mapeada com versoes
- [ ] Metricas DORA calculadas com nivel de performance
- [ ] Score por area (arquitetura, codigo, seguranca, testes, CI/CD, monitoramento)
- [ ] Top 3 dividas tecnicas com impacto e esforco
- [ ] Recomendacoes priorizadas com esforco

### 2. Plano de Arquitetura
- [ ] ADR por cada decisao irreversivel
- [ ] Alternativas documentadas com pros e contras
- [ ] Plano em 3 fases com esforco estimado
- [ ] Metricas de sucesso por ADR
- [ ] Riscos de implementacao mapeados

### 3. Avaliacao de Divida Tecnica
- [ ] Score de qualidade de codigo com todas as metricas
- [ ] Inventario completo com tipo e severidade
- [ ] Esforco de resolucao por item
- [ ] Plano de quitacao em 3 horizontes
- [ ] Prioridade clara por item

### 4. Auditoria de Seguranca
- [ ] OWASP Top 10 verificado
- [ ] CVSS score por vulnerabilidade
- [ ] SCA realizado com CVEs
- [ ] Secrets scan realizado
- [ ] Remediacao acionavel
- [ ] Compliance avaliado

### 5. Pipeline CI/CD
- [ ] Etapas documentadas
- [ ] Quality gates bloqueantes
- [ ] Security scans integrados
- [ ] Estrategia de deploy por ambiente
- [ ] Rollback documentado
- [ ] Metricas do pipeline

### 6. Padroes de Code Review
- [ ] Categorias com severidade
- [ ] Checklist por categoria
- [ ] Exemplos bons e ruins
- [ ] Criterios de aprovacao claros
- [ ] Contexto da stack

### 7. Plano de Monitoramento
- [ ] SLI/SLO/SLA por servico critico
- [ ] Tres pilares (logs, metricas, traces)
- [ ] Alertas por severidade
- [ ] Runbooks para incidentes
- [ ] On-call definido

### 8. Disaster Recovery
- [ ] RTO e RPO por componente critico
- [ ] Estrategia de backup
- [ ] Procedimentos para cenarios criticos
- [ ] Plano de teste periodico
- [ ] Responsaveis definidos

## Score de Qualidade

| Score | Veredicto | Acao |
|-------|-----------|------|
| 90-100 | APROVADO | Entrega direta |
| 80-89 | APROVADO | Entrega com notas |
| 60-79 | APROVADO COM RESSALVAS | Entrega + plano de correcao |
| < 60 | REJEITADO | Retorno ao pipeline |

---

# Anti-Patterns

## 1. Diagnostico Tecnico Superficial
**Problema:** Diagnostico que lista tecnologias sem avaliar qualidade ou riscos.
**Correcao:** Cada afirmacao precisa de dado. Sem evidencia, declarar limitacao.

## 2. Complexidade Prematura
**Problema:** Arquitetura distribuida para problema que monolito resolve.
**Correcao:** Monolito modular como padrao. Complexidade exige problema real documentado.

## 3. Tech Debt Invisivel
**Problema:** Divida tecnica nao documentada nem priorizada.
**Correcao:** Todo tech debt critico no backlog. Reservar 20% da capacidade para quitacao.

## 4. Seguranca como Afterthought
**Problema:** Seguranca tratada como etapa final.
**Correcao:** Seguranca no pipeline desde o primeiro commit. OWASP Top 10 no design.

## 5. Pipeline sem Quality Gates
**Problema:** CI que executa mas nao bloqueia problemas.
**Correcao:** Cada etapa com criterio de aprovacao bloqueante. Coverage enforced.

## 6. Monitoramento sem Runbook
**Problema:** Alertas sem procedimento de resposta.
**Correcao:** Todo alerta critico com runbook testado. Passos especificos, escalacao definida.

## 7. Deploy sem Rollback
**Problema:** Deploy sem capacidade de reverter rapidamente.
**Correcao:** Plano de rollback testado. Target: <5 minutos. Migracoes backwards compatible.
