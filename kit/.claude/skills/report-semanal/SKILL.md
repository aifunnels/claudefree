---
name: report-semanal
description: Gera relatorio semanal de performance de campanhas e conteudo
---

# Report Semanal

Gera relatorio semanal padrao com metricas, insights e recomendacoes.

## Quando Usar

Use toda segunda-feira (ou quando o usuario pedir) para gerar o report da semana.

## Passos

1. Pergunte ao usuario:
   - Qual cliente?
   - Periodo (ex: 31/03 a 06/04)
   - Dados de performance (prints, CSV, ou digitar manualmente)

2. Colete as metricas-chave:
   - CPL (Custo por Lead)
   - CPA (Custo por Aquisicao)
   - ROAS (Return on Ad Spend)
   - CTR (Click-Through Rate)
   - CPM (Custo por Mil Impressoes)
   - Investimento total
   - Leads/Vendas gerados

3. Gere o relatorio no formato abaixo

4. Salve em `output/reports/{cliente}-{data}.md`

## Formato do Output

```markdown
# Report Semanal — {Cliente}

**Periodo:** {data inicio} a {data fim}
**Responsavel:** {nome}

## Resumo Executivo
{2-3 frases: o que aconteceu, resultado principal, tendencia}

## Metricas-Chave

| Metrica | Esta Semana | Semana Anterior | Variacao |
|---------|-------------|-----------------|----------|
| Investimento | R${valor} | R${valor} | {%} |
| Leads | {n} | {n} | {%} |
| CPL | R${valor} | R${valor} | {%} |
| CPA | R${valor} | R${valor} | {%} |
| ROAS | {x} | {x} | {%} |
| CTR | {%} | {%} | {pp} |

## Top 3 Criativos da Semana

1. {criativo}: {metrica destaque}
2. {criativo}: {metrica destaque}
3. {criativo}: {metrica destaque}

## Insights
- {insight 1 — o que os dados mostram}
- {insight 2}
- {insight 3}

## Recomendacoes
- {acao 1 — o que fazer na proxima semana}
- {acao 2}
- {acao 3}

## Proximo Passo
{a acao mais importante para a proxima semana}
```

## Regras

- Sempre comparar com semana anterior (nunca dados isolados)
- Traduzir metricas em impacto no negocio
- Recomendacoes devem ser acoes concretas, nao genericas
- Maximo 1 pagina — se precisar de mais detalhe, anexar
