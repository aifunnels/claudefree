# KPI Reference — Benchmarks Tecnicos

## Metricas DORA por Performance

| Metrica | Elite | Alta | Media | Baixa |
|---------|-------|------|-------|-------|
| Deployment Frequency | Multiplos/dia | 1x/semana | 1x/mes | <1x/6 meses |
| Lead Time for Changes | <1 hora | 1 dia | 1 semana | 1 mes |
| MTTR | <1 hora | <1 dia | <1 semana | >1 semana |
| Change Failure Rate | <5% | 10% | 15% | >30% |

## Qualidade de Codigo

| KPI | Saudavel | Alerta | Critico |
|-----|----------|--------|---------|
| Cobertura de testes | >80% | 60-80% | <60% |
| Complexidade ciclomatica media | <5 | 5-10 | >10 |
| Duplicacao de codigo | <3% | 3-10% | >10% |
| Dividas tecnicas criticas | 0 | 1-3 | >3 |
| Dependencias com CVE critico | 0 | 0 (alerta imediato) | >0 |

## Performance de Aplicacao

| KPI | Saudavel | Alerta | Critico |
|-----|----------|--------|---------|
| Latencia API P95 | <200ms | 200-500ms | >500ms |
| Latencia API P99 | <500ms | 500ms-1s | >1s |
| Taxa de erro 5xx | <0.1% | 0.1-1% | >1% |
| Disponibilidade | >99.9% | 99-99.9% | <99% |
| Tempo de resposta DB P95 | <50ms | 50-200ms | >200ms |

## Pipeline CI/CD

| KPI | Saudavel | Alerta | Critico |
|-----|----------|--------|---------|
| Tempo de CI (build+test) | <10 min | 10-20 min | >20 min |
| Taxa de sucesso do CI | >95% | 90-95% | <90% |
| Tempo de deploy staging | <5 min | 5-15 min | >15 min |
| Tempo de rollback | <5 min | 5-15 min | >15 min |
| Cobertura de security scan | 100% | 80-100% | <80% |

## Seguranca

| KPI | Saudavel | Alerta | Critico |
|-----|----------|--------|---------|
| Vulnerabilidades Criticas abertas | 0 | 0 (fechar em 24h) | >0 |
| Vulnerabilidades Altas abertas | 0 | <3 | >3 |
| Dependencias desatualizadas (>1 ano) | 0 | 1-5 | >5 |
| Secrets no repositorio | 0 | 0 (emergencia) | >0 |
| Dias sem patch de seguranca | <7 | 7-30 | >30 |

## Infraestrutura

| KPI | Saudavel | Alerta | Critico |
|-----|----------|--------|---------|
| CPU usage medio | <60% | 60-80% | >80% |
| Memory usage medio | <70% | 70-85% | >85% |
| Disk usage | <70% | 70-85% | >85% |
| DB connections (% do pool) | <60% | 60-80% | >80% |
| Dias de caixa de infra (runway) | Indefinido | Contrato vence <30 dias | Servico a cortar |
