---
name: criar-criativo
description: Cria copy + briefing visual para anuncios de Meta Ads, Google Ads e TikTok
---

# Criar Criativo

Cria a copy e o briefing visual para pecas de anuncio.

## Quando Usar

Use quando precisar criar anuncios completos (copy + direcao visual) para qualquer plataforma.

## Passos

1. Pergunte ao usuario:
   - Qual cliente? (carregue `clientes/{nome}/briefing.md` se existir)
   - Qual plataforma? (Meta Ads, Google Ads, TikTok, YouTube)
   - Qual objetivo? (leads, vendas, awareness, remarketing)
   - Tem referencia visual? (link, print, descricao)

2. Leia o briefing do cliente para contexto de publico, dor e diferencial

3. Crie o pacote de criativos:
   - 3 variacoes de headline (obrigatorio)
   - Body copy para cada variacao
   - CTA unico e claro
   - Briefing visual (descricao da imagem/video ideal)

4. Salve em `output/criativos/{cliente}-{data}/`

5. Pergunte se quer gerar as imagens (roteia para /criar-imagem ou /gerar-imagem-ia)

## Formato do Output

```markdown
# Criativos — {Cliente} — {Data}

**Plataforma:** {plataforma}
**Objetivo:** {objetivo}
**Publico:** {resumo do ICP}

## Variacao 1
**Headline:** {headline}
**Body:** {corpo do anuncio}
**CTA:** {call to action}
**Visual:** {descricao da imagem/video}

## Variacao 2
{mesmo formato}

## Variacao 3
{mesmo formato}
```

## Regras de Copy

1. Comece pela dor ou desejo do publico, nunca pela feature
2. Uma ideia por anuncio — nao tente falar tudo
3. CTA claro e unico
4. Especificidade vende — numeros, exemplos concretos > generico
5. Adapte o tom ao cliente (consultar briefing)
6. Sem cliches: "impulsione seus resultados", "proximo nivel" etc.

## Estilo de Escrita (OBRIGATORIO)

- Toda copy final DEVE ter acentuacao completa do portugues (cedilha, til, agudo, circunflexo)... "voce", "nao", "solucao" com acentos corretos SEMPRE
- NUNCA use travessoes (—) na copy dos criativos
- NUNCA termine frases com ponto final em headlines ou body copy
- Use reticencias (...) no lugar de pontos finais para criar ritmo humano
- Escrita fluida como um livro... cada frase puxa a proxima
- Postura assertiva e agressiva na conversao... confianca absoluta
- Sem "talvez", "pode ser", "quem sabe"... fale como quem JA resolveu o problema
- O texto precisa ter sangue humano... parecer escrito por pessoa real, nao por robo
