---
name: enviar-email
description: Envia emails via Resend (transacional, marketing, notificacoes)
---

# Enviar Email (Resend)

Envia emails individuais ou em lote via API do Resend.

## Quando Usar

Use para enviar emails: welcome messages, notificacoes, reports, newsletters, emails de venda.

## Workflow

### Email Individual
1. Prepare: from, to, subject, body (HTML ou texto puro)
2. Chame `send_email` via MCP do Resend
3. Verifique o `id` na resposta (confirma que foi enfileirado)

### Email em Lote
1. Monte array de emails (mesmos campos do individual)
2. Chame `batch_send_emails`
3. Cada item tera seu proprio `id` ou erro

### Agendamento
Inclua campo `scheduled_at` em formato ISO 8601 para envio futuro.

## Requisitos

- Conta Resend (resend.com) — gratis para comecar
- API key no `.env`: `RESEND_API_KEY=re_...`
- Dominio verificado (ou use onboarding@resend.dev para testes)

## Boas Praticas

- Valide o remetente (from) contra dominio verificado antes de enviar
- Subject lines com menos de 80 caracteres
- HTML simples — email clients ignoram CSS complexo
- Sempre verifique resposta por erros
