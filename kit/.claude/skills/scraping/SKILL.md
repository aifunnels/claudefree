---
name: scraping
description: Web scraping e extracao de dados via Apify (redes sociais, sites, buscadores)
---

# Web Scraping (Apify)

Extrai dados de websites, redes sociais e buscadores usando Actors da Apify.

## Quando Usar

Use para: extrair dados de concorrentes, coletar posts de redes sociais, scraping de reviews, pesquisa de mercado automatizada.

## Capacidades

- Scrapers prontos (Actors) para Instagram, YouTube, Twitter, TikTok, Google, Amazon
- Web scraper generico para qualquer site
- Exportacao de dados em JSON

## Workflow

1. Identifique o Actor adequado (ex: instagram-scraper, google-search-scraper)
2. Configure os parametros de entrada (URLs, limites, filtros)
3. Execute o Actor via MCP Apify
4. Colete e processe os resultados

## Boas Praticas

- Comece com o Actor mais simples que atenda a necessidade
- Use `maxItems` para limitar resultados e evitar custos excessivos
- Verifique pricing do Actor antes de executar
- Extraia apenas os campos necessarios dos resultados

## Requisitos

- Conta Apify (apify.com)
- Token no `.env`: `APIFY_TOKEN=`
