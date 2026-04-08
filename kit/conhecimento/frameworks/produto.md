# Framework de Produto — CPO Squad

## North Star Metric

A North Star Metric (NSM) e a unica metrica que melhor captura o valor central entregue ao usuario E conecta-se diretamente ao crescimento do negocio.

### Como escolher a NSM
- Deve refletir o valor que o usuario recebe (nao o negocio)
- Deve ser influenciavel pelo time de produto
- Deve ser um leading indicator de receita
- Exemplos por modelo:
  - SaaS B2B: "Usuarios ativos por semana que completaram X tarefas"
  - Marketplace: "Transacoes concluidas com sucesso por mes"
  - Consumer: "Dias com sessao ativa por mes por usuario"
  - PLG: "Usuarios que atingiram o aha moment em D7"

### Decomposicao da NSM
`NSM = Amplitude x Frequencia x Profundidade`
- Amplitude: quantos usuarios
- Frequencia: com qual regularidade
- Profundidade: com qual intensidade de uso

---

## Jobs-to-be-Done (JTBD)

Framework para entender por que usuarios "contratam" um produto.

### Job Story Template
"Quando [situacao/contexto], quero [motivacao/acao], para [resultado esperado/beneficio]."

### Tipos de Jobs
- **Functional:** A tarefa pratica a realizar
- **Emotional:** Como o usuario quer se sentir
- **Social:** Como o usuario quer ser percebido

### Entrevista JTBD — Roteiro Base
1. "Me conta sobre a ultima vez que voce usou [produto] para fazer [tarefa]."
2. "O que voce estava tentando fazer quando decidiu usar [produto]?"
3. "Quais outras coisas voce tentou antes? Por que nao funcionaram?"
4. "Como voce sabia que tinha terminado a tarefa com sucesso?"
5. "O que mudou na sua vida depois de conseguir resolver isso?"

---

## RICE Prioritization

Score = (Reach x Impact x Confidence) / Effort

### Componentes
| Campo | Definicao | Exemplos |
|-------|-----------|---------|
| Reach | Usuarios impactados em 1 trimestre | Numero absoluto |
| Impact | Efeito na metrica principal | 0.25 / 0.5 / 1 / 2 / 3 |
| Confidence | Confianca na estimativa | 10% / 50% / 80% / 100% |
| Effort | Esforco total em semanas-pessoa | 0.5 / 1 / 2 / 4 / 8... |

### Interpretacao do Score
- Score > 50: alta prioridade
- Score 20-50: media prioridade
- Score < 20: baixa prioridade ou descartar

---

## Funil de Produto (AARRR)

| Etapa | Pergunta | Metricas Comuns |
|-------|----------|----------------|
| Aquisicao | Como os usuarios chegam? | CAC, taxa de conversao de landing page |
| Ativacao | Tiveram a primeira experiencia de valor? | % ativacao D1, tempo ate aha moment |
| Retencao | Os usuarios voltam? | Retencao D7, D30, D90, churn |
| Receita | Os usuarios pagam? | MRR, ARPU, LTV, LTV/CAC |
| Indicacao | Os usuarios indicam outros? | NPS, referral rate, virality coefficient |

### Aha Moment
O momento em que o usuario percebe o valor do produto pela primeira vez.
- Deve ser definido por comportamento (nao por tempo)
- Exemplos: "Criou primeiro projeto com colaborador", "Completou 3 tarefas em sequencia"

---

## Product-Led Growth (PLG)

Modelo onde o produto e o principal canal de aquisicao, conversao e expansao.

### Principios PLG
1. **Time-to-value minimo:** Usuario chega ao valor em minutos, nao dias
2. **Freemium como funil:** Tier gratuito como top of funnel
3. **Viral loops:** Uso do produto gera convites e indicacoes naturais
4. **Expansao por uso:** Receita cresce com o uso (usage-based pricing)
5. **Self-serve:** Usuario converte sem contato com sales

### Metricas PLG
- **Product Qualified Lead (PQL):** Usuario que atingiu threshold de uso (candidato a conversao)
- **Time to value (TTV):** Tempo entre cadastro e aha moment
- **Expansion MRR:** Receita de upsell/cross-sell de usuarios existentes

---

## Heuristicas de Nielsen (UX)

| # | Heuristica | Descricao |
|---|------------|-----------|
| H1 | Visibilidade do status | Sistema sempre informa o que esta acontecendo |
| H2 | Correspondencia com mundo real | Linguagem familiar, ordem natural |
| H3 | Controle do usuario | Saida de emergencia, desfazer/refazer |
| H4 | Consistencia e padroes | Mesmas palavras, situacoes e acoes sempre iguais |
| H5 | Prevencao de erros | Eliminar condicoes de erro antes que ocorram |
| H6 | Reconhecimento em vez de lembranca | Minimizar carga de memoria do usuario |
| H7 | Flexibilidade e eficiencia | Atalhos para usuarios experientes |
| H8 | Estetica minimalista | Sem informacao irrelevante |
| H9 | Ajuda a recuperar erros | Mensagens de erro claras com sugestao de solucao |
| H10 | Ajuda e documentacao | Facil de buscar e orientada a tarefas |

---

## User Stories e Criterios de Aceite

### Template User Story
"Como [tipo de usuario], quero [acao/capacidade], para [beneficio/resultado]."

### Template BDD (Given/When/Then)
```
Given [contexto inicial / precondição]
When [acao do usuario]
Then [resultado esperado / comportamento do sistema]
```

### Tamanho de Story
- **P (Pequena):** 1-2 dias de desenvolvimento
- **M (Media):** 3-5 dias
- **G (Grande):** 1-2 semanas — considerar quebrar
- **GG (Muito Grande):** >2 semanas — deve ser quebrada em stories menores

---

## Experimentacao e A/B Testing

### Calculo de Tamanho de Amostra
Usar calculadora estatistica com:
- Baseline conversion rate: {valor atual da metrica}
- Minimum Detectable Effect (MDE): minimo lift que importa (ex: 5%)
- Significancia: 95% (p < 0.05)
- Poder estatistico: 80%

### Regras de Ouro
1. Uma variavel por experimento
2. Nao olhar resultados antes do prazo (peeking problem)
3. Nao parar cedo por resultado positivo
4. Documentar resultado mesmo se negativo
5. Checar metricas de guardrail apos resultado
