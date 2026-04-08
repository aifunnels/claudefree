# Criterios de Qualidade

# Quality Criteria — COO Squad

## Criterios de Qualidade por Output

### 1. Diagnostico Operacional
- [ ] Todos os processos criticos identificados e listados
- [ ] Gargalos com impacto quantificado (tempo ou custo estimado)
- [ ] Utilizacao da equipe calculada ou estimada por funcao
- [ ] SLAs mapeados — onde existem e onde estao faltando
- [ ] Top 3 riscos operacionais com impacto e probabilidade
- [ ] Recomendacoes priorizadas com prazo e responsavel

### 2. Plano Operacional 90 Dias
- [ ] Iniciativas priorizadas por impacto / esforco
- [ ] Cronograma mes a mes com responsavel por etapa
- [ ] Metas mensuraveis com baseline do diagnostico
- [ ] Riscos do plano identificados com mitigacao
- [ ] Indicadores de acompanhamento definidos
- [ ] Maximo 7 iniciativas simultaneas

### 3. Mapa de Processos
- [ ] Todos os processos criticos com fluxo completo
- [ ] Responsavel definido por etapa
- [ ] Lead time calculado por processo
- [ ] Pontos de falha identificados com frequencia
- [ ] Excecoes e casos de borda documentados
- [ ] Tempos reais medidos

### 4. SOPs
- [ ] Todos os processos criticos com SOP
- [ ] Cada passo com criterio de saida explicito
- [ ] Excecoes e erros comuns documentados
- [ ] Versao e data em todo SOP
- [ ] Novo funcionario consegue executar sem ajuda adicional
- [ ] Responsavel de revisao e periodicidade definidos

### 5. Plano de Automacao
- [ ] Criterio de automatizabilidade aplicado
- [ ] ROI calculado com horas reais
- [ ] Especificacao tecnica com trigger, acoes e condicoes
- [ ] Tratamento de erro para cada automacao
- [ ] Stack tecnica justificada
- [ ] Cronograma de implementacao com responsavel

### 6. Dashboard Operacional
- [ ] Maximo 7 KPIs primarios por area
- [ ] Formula explicita para cada indicador
- [ ] Meta, alerta e critico definidos
- [ ] NPS interno incluido
- [ ] Dono atribuido para cada metrica
- [ ] Alertas configurados para desvios

### 7. Gestao de Capacidade
- [ ] Utilizacao calculada para cada funcao
- [ ] Projecao 90 dias incluindo automacoes
- [ ] Gargalos com acao recomendada
- [ ] Recomendacoes contratar / realocar / automatizar
- [ ] Capacidade vs demanda verificada

### 8. Checklist de Entrega
- [ ] Todos os tipos de entrega critica com checklist
- [ ] Responsavel por item
- [ ] Criterio de qualidade por etapa
- [ ] Instrucao de fallback
- [ ] SLA indicado
- [ ] Comunicacao ao cliente incluida

### 9. Revisao Operacional (Gate Final)
- [ ] Todos os 10 itens verificados
- [ ] Cross-check entre mapa, SOPs e dashboard
- [ ] Score justificado com evidencia
- [ ] Instrucoes de correcao para rejeicoes
- [ ] Zero inconsistencias aceitas

## Score de Qualidade

| Score | Veredicto | Acao |
|-------|-----------|------|
| 90-100 | APROVADO | Entrega direta |
| 80-89 | APROVADO | Entrega com notas |
| 60-79 | APROVADO COM RESSALVAS | Entrega + plano de correcao |
| < 60 | REJEITADO | Retorno ao pipeline |

---

# Anti-Patterns

## 1. Automatizar Antes de Documentar
**Problema:** Criar automacao de processo que nunca foi documentado.
**Correcao:** SOP antes de qualquer workflow. Se nao e claro em papel, nao sera em automacao.

## 2. SLA sem Medicao
**Problema:** Definir SLA sem sistema de medicao.
**Correcao:** SLA so existe se for medido. Confirmar fonte de dados, quem mede, frequencia.

## 3. Diagnostico sem Dados de Volume
**Problema:** Mapa de processos sem frequencia ou volume.
**Correcao:** Todo processo precisa de estimativa de volume. Se desconhecido, coletar por 2 semanas.

## 4. Plano de 90 Dias Sem Capacidade Verificada
**Problema:** Plano ambicioso que ignora capacidade real.
**Correcao:** Calcular capacidade por funcao antes de montar cronograma.

## 5. SOPs Descartados pelo Time
**Problema:** SOPs criados mas nunca usados.
**Correcao:** SOP ideal: 1-2 paginas. Revisar a cada 3 meses. Armazenar onde o processo acontece.

## 6. Dashboard com Excesso de Metricas
**Problema:** Dashboard com 30+ indicadores que ninguem olha.
**Correcao:** Maximo 7 KPIs primarios. Cada metrica com meta, alerta e dono.

## 7. Utilizacao 100% Como Meta
**Problema:** Time "ocupado ao maximo" como meta.
**Correcao:** Utilizacao ideal e 70-80%. Acima de 85% por 2+ semanas = alarme.

## 8. Processo Critico sem Backup
**Problema:** Processo essencial dependente de uma unica pessoa.
**Correcao:** SOP + 2 pessoas treinadas + plano de contingencia.

## 9. Automacao sem Monitoramento
**Problema:** Workflow que falha silenciosamente.
**Correcao:** Alerta de falha + log acessivel + responsavel de monitoramento.
