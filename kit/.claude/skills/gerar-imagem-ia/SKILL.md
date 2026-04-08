---
name: gerar-imagem-ia
description: Gera imagens via API OpenRouter usando modelos de IA
---

# Gerar Imagem com IA

Gera imagens a partir de prompts de texto via API do OpenRouter.

## Quando Usar

Use quando precisar de imagens geradas por IA (fotos, ilustracoes, arte) que nao podem ser feitas via HTML/CSS.

ANTES de gerar, verifique:
1. Ja existe uma imagem adequada nos assets?
2. Uma busca na web encontraria algo utilizavel?
3. A imagem e realmente necessaria?
4. Gere APENAS 1 imagem por vez para validar conceito.

## Modos

| Modo | Modelo | Custo | Quando |
|------|--------|-------|--------|
| test | sourceful/riverflow-v2-fast | ~R$0.02 | Iteracao, testes |
| production | google/gemini-3.1-flash-image-preview | ~R$0.10 | Imagem final aprovada |

**Padrao: test.** So use production apos aprovacao do layout.

## Uso

```bash
python3 scripts/generate.py \
  --prompt "Descricao detalhada da imagem" \
  --output "output/nome-imagem.jpg" \
  --mode test
```

Com imagem de referencia (logo, mascote):
```bash
python3 scripts/generate.py \
  --prompt "Banner com logo da empresa" \
  --output "output/banner.jpg" \
  --reference "assets/logo.png" \
  --mode production
```

## Dicas de Prompt

- Seja especifico: composicao, iluminacao, estilo, humor
- Especifique orientacao: "portrait 3:4", "landscape 16:9"
- Para fotografia: "hyper realistic, 4K quality"
- Evite pedir texto nas imagens (IA nao renderiza texto bem)

## Requisitos

- Variavel `OPENROUTER_API_KEY` configurada no `.env`
