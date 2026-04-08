# Framework Operacional — COO Squad

## Process Mapping

### Notacao de Fluxo Padrao

```
[GATILHO] → Etapa 1 (Resp) → Etapa 2 (Resp) → [DECISAO] → Etapa 3a / Etapa 3b → [OUTPUT]
```

**Elementos:**
- **GATILHO:** O que inicia o processo (evento, solicitacao, agendamento)
- **Etapa:** Acao com responsavel e ferramenta
- **DECISAO:** Ponto de bifurcacao com criterio explicito
- **OUTPUT:** Entregavel concreto ao final do processo

### Niveis de Criticidade

| Nivel | Definicao | Impacto se Falhar |
|-------|-----------|-------------------|
| CRITICO | Operacao para ou cliente e afetado diretamente | Alto — resolver em <2h |
| IMPORTANTE | Atrasa entrega ou aumenta custo | Medio — resolver em <24h |
| SUPORTE | Processo interno sem impacto direto no cliente | Baixo — resolver em <1 semana |

### Metricas de Processo

**Lead Time**
`Tempo desde solicitacao/gatilho ate entrega do output`
- Inclui tempo de espera entre etapas
- Diferente de tempo de processamento (apenas etapas ativas)

**Tempo de Ciclo**
`Soma dos tempos ativos de todas as etapas`
- Exclui filas e esperas
- Indica eficiencia do processo em si

**Throughput**
`Volume de unidades processadas por periodo`
- Ex: contratos assinados/semana, tickets resolvidos/dia

**Taxa de Retrabalho**
`(Unidades que precisaram de correcao / Total processado) x 100`
- Meta geral: <5%
- Meta processos criticos: <2%

---

## Capacity Planning

### Calculo de Capacidade Disponivel

```
Capacidade Bruta = Headcount x Horas/Semana
Capacidade Util = Capacidade Bruta x % Produtivo
% Produtivo tipico = 70-80% (desconta reunioes, admin, interrupcoes)
```

### Faixas de Utilizacao

| Utilizacao | Status | Interpretacao |
|-----------|--------|--------------|
| <40% | OCIOSO | Subaproveitamento — realocacao ou reducao |
| 40-70% | VERDE | Saudavel — espaco para crescimento |
| 70-85% | AMARELO | Atencao — pouca margem para imprevistos |
| 85-95% | VERMELHO | Gargalo — risco de atraso em qualquer pico |
| >95% | CRITICO | Burnout e falha de qualidade iminentes |

### Calcular Gap de Capacidade

```
Gap = Demanda Prevista - Capacidade Util
Se positivo: contratar ou automatizar
Se negativo: realocacao ou aceitar mais demanda
```

---

## SLA Management

### Estrutura de SLA

| Campo | Descricao |
|-------|-----------|
| Processo | Nome do processo coberto |
| Metrica | O que e medido (tempo, qualidade, disponibilidade) |
| Meta | Valor que constitui cumprimento |
| Alerta | Valor que aciona atencao (antes de violar) |
| Critico | Violacao confirmada — escalar imediatamente |
| Janela | Periodo de medicao (ex: dias uteis, 24/7) |
| Dono | Responsavel pelo SLA |

### SLA Compliance

```
SLA Compliance = (Processos dentro do SLA / Total Processos) x 100
Meta geral: >95%
Meta processos criticos: >99%
```

### Tipos de SLA por Contexto

| Tipo | Contexto | Exemplo |
|------|---------|---------|
| Tempo de resposta | Suporte ao cliente | Responder em <2h |
| Tempo de resolucao | Suporte ao cliente | Resolver em <24h |
| Prazo de entrega | Projetos | Entregar em X dias uteis |
| Disponibilidade | Sistemas/servicos | Uptime >99.5% |
| Qualidade | Entregas | Taxa de retrabalho <5% |

---

## Automation Decision Tree

### Quando Automatizar

**AUTOMATIZAR se ALL TRUE:**
1. Processo ocorre >5x por semana
2. Regras de decisao sao sempre iguais (nao exige julgamento humano)
3. Volume justifica o investimento de build
4. O processo e estavel (nao muda a cada mes)
5. Ferramentas envolvidas tem API ou webhook disponivel

**NAO AUTOMATIZAR se ANY TRUE:**
1. Processo requer julgamento situacional
2. Regras mudam com frequencia
3. Volume baixo (ROI negativo)
4. O processo ainda nao esta documentado e validado
5. Custo de manutencao supera economia

### Selecao de Ferramenta

| Ferramenta | Quando Usar | Pontos Fortes | Limitacoes |
|-----------|-------------|--------------|-----------|
| n8n | Complexidade media/alta, self-hosted, multiplas integracoes | Flexivel, sem limite de execucoes, open source | Curva de aprendizado maior |
| Make (Integromat) | Complexidade media, visual, muitos apps prontos | Interface visual intuitiva, 1000+ integracoes | Custo por operacao |
| Zapier | Simplicidade, integracao rapida entre 2-3 apps | Setup facil, enorme catalogo | Caro para alto volume, pouca logica |

### Calculo de ROI de Automacao

```
Horas economizadas/mes = Tempo manual por ocorrencia x Volume/mes
Economia mensal = Horas economizadas x Custo hora medio
Investimento = Horas de build x Custo hora + Custo ferramenta/mes
Payback (meses) = Investimento / Economia mensal
ROI positivo: Payback < 6 meses para automatizar
```

---

## Quality Operations

### Estrutura de Dashboard Operacional

**Camadas:**
1. **Visao Geral** — Semaforo por area (verde/amarelo/vermelho)
2. **KPIs Primarios** — No maximo 7 por area, com tendencia
3. **SLA Board** — Compliance por processo critico
4. **Alertas Ativos** — O que precisa de atencao agora
5. **Tendencias** — Periodo atual vs anterior

### Hierarquia de Metricas

| Nivel | Tipo | Exemplo | Audiencia |
|-------|------|---------|----------|
| Estrategico | Resultado | Satisfacao cliente, Margem operacional | CEO, COO |
| Tatical | Processo | SLA compliance, Lead time medio | Gestores |
| Operacional | Atividade | Tickets abertos, Tarefas atrasadas | Time operacional |

### NPS Interno — Metodologia

**eNPS (Employee Net Promoter Score)**
```
Pergunta: "De 0 a 10, com que probabilidade recomendaria trabalhar nesta empresa?"
Promotores: 9-10
Neutros: 7-8
Detratores: 0-6
eNPS = % Promotores - % Detratores
Benchmark: >0 aceitavel, >20 bom, >40 excelente
```

**Satisfacao com Processos**
```
Pergunta: "De 1 a 5, como avalia a clareza e eficiencia dos processos do seu time?"
Meta: Media >4.0
Frequencia: Mensal
```
