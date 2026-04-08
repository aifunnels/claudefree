---
name: publicar-instagram
description: Publica carrosseis no Instagram via Graph API
---

# Publicar no Instagram

Publica carrosseis no Instagram Business a partir de imagens locais.

## Quando Usar

Use apos criar imagens (via /criar-imagem ou /gerar-imagem-ia) para publicar diretamente no Instagram.

## Workflow

1. Liste os arquivos JPEG em `output/` ordenados por nome
2. Apresente a lista ao usuario para confirmar ordem
3. Extraia a caption do rascunho de conteudo (max 2200 caracteres)
4. Execute o script de publicacao:
   ```bash
   node --env-file=.env scripts/publish.js \
     --images "img1.jpg,img2.jpg,img3.jpg" \
     --caption "Texto da legenda"
   ```
5. Use `--dry-run` para testar sem publicar de verdade
6. Salve URL e ID do post no output

## Restricoes

- Apenas JPEG, 2-10 imagens por carrossel
- Caption max 2200 caracteres
- Requer conta Instagram Business (nao Personal/Creator)
- Rate limit: 25 posts por 24 horas via API

## Setup (primeira vez)

Configure no `.env`:
```
INSTAGRAM_ACCESS_TOKEN=  # Token de longa duracao (60 dias)
INSTAGRAM_USER_ID=       # ID da conta Business
IMGBB_API_KEY=           # Para upload de imagens
```

### Obter Token
1. developers.facebook.com → seu app → Graph API Explorer
2. Permissoes: instagram_content_publish, instagram_basic, pages_read_engagement
3. Gere token curto → converta para longo (60 dias) via endpoint OAuth
4. Cole no .env

### Obter User ID
1. GET /me/accounts → encontre sua Pagina
2. GET /{page-id}?fields=instagram_business_account
3. Use o id retornado
