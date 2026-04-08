---
name: publicar-social
description: Publica e agenda posts em multiplas redes sociais via Blotato
---

# Publicar em Redes Sociais (Blotato)

Publica e agenda posts no Instagram, LinkedIn, Twitter/X, TikTok, YouTube e mais via Blotato MCP.

## Quando Usar

Use quando precisar publicar o mesmo conteudo em multiplas plataformas simultaneamente, ou agendar posts para datas futuras.

## Workflow

1. `blotato_list_accounts` — liste contas conectadas e IDs
2. Se o post tem imagens/videos: `blotato_upload_media` primeiro
3. `blotato_create_post` — publique ou agende
4. `blotato_get_post_status` — confirme sucesso

## Agendamento

Use formato ISO 8601 para data/hora: `2026-04-15T10:00:00-03:00`

## Requisitos

- Conta Blotato (blotato.com)
- API key configurada no `.env`: `BLOTATO_API_KEY=`
- Contas de redes sociais conectadas no painel Blotato

## Boas Praticas

- Sempre liste contas primeiro para pegar IDs validos
- Apos postar, verifique status ate "published" ou "scheduled"
- Se status "failed", reporte o erro ao usuario
