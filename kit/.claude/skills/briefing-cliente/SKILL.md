---
name: briefing-cliente
description: Coleta informacoes e gera briefing padronizado para novo cliente
---

# Briefing de Novo Cliente

Coleta informacoes estruturadas sobre um novo cliente e gera o briefing padrao.

## Passos

1. Pergunte as informacoes basicas:
   - Nome do cliente (e nome fantasia se diferente)
   - Nicho/segmento de mercado
   - Produto ou servico principal
   - Site e redes sociais

2. Pergunte sobre o publico-alvo:
   - Quem e o cliente ideal? (cargo, idade, localizacao)
   - Principal dor que o produto resolve
   - O que o publico ja tentou antes

3. Pergunte sobre objetivos:
   - Objetivo principal (leads, vendas, awareness)
   - Meta numerica se tiver
   - Prazo para resultados

4. Pergunte sobre concorrencia:
   - 2-3 concorrentes diretos
   - Diferencial do cliente vs concorrentes

5. Pergunte sobre orcamento:
   - Budget mensal para midia paga
   - Ferramentas ja usadas
   - Historico de marketing digital

6. Gere o briefing e salve em `clientes/{nome-em-kebab-case}/briefing.md`

7. Confirme com o usuario se quer ajustar algo

## Formato do Output

```markdown
# Briefing — {Nome do Cliente}

**Data:** {data atual}

## 1. Visao Geral
- **Nome:** {nome}
- **Nicho:** {segmento}
- **Produto/Servico:** {descricao}
- **Site:** {url}
- **Redes:** {links}

## 2. Publico-Alvo
- **Perfil:** {descricao do ICP}
- **Dor principal:** {problema que resolve}
- **Tentativas anteriores:** {o que ja tentaram}

## 3. Objetivos
- **Objetivo principal:** {leads/vendas/awareness}
- **Meta numerica:** {se tiver}
- **Prazo:** {expectativa}

## 4. Concorrencia
| Concorrente | Link | Diferencial |
|-------------|------|-------------|
| {nome} | {url} | {o que fazem bem} |

**Nosso diferencial:** {o que diferencia este cliente}

## 5. Orcamento e Recursos
- **Budget mensal midia:** R${valor}
- **Ferramentas:** {lista}
- **Historico:** {experiencia anterior}

## 6. Notas
{observacoes relevantes}
```

## Regras
- Nao pular secoes — se nao souber, marcar "A definir"
- Nao inventar informacoes
- Manter tom profissional e objetivo
