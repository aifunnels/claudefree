---
name: buscar-imagem
description: Busca imagens na web ou captura screenshots de sites via Playwright
---

# Buscar Imagem

Obtem assets visuais de multiplas fontes: busca web, screenshots de sites, arquivos do usuario.

## Quando Usar

Use quando precisar de imagens existentes (nao geradas): fotos de referencia, screenshots de concorrentes, assets de marca.

## Modos

### 1. Busca na Web
Use web_search para encontrar imagens por palavra-chave. Avalie resultados e baixe a melhor.

### 2. Screenshot de Site
Use Playwright MCP:
1. `browser_navigate` para a URL
2. `browser_resize` para viewport desejado (1080x1080, 1080x1440, etc.)
3. `browser_take_screenshot` para capturar

### 3. Arquivo do Usuario
Organize arquivos fornecidos pelo usuario na pasta de output com nomes descritivos.

## Regras

- Verifique se o asset ja existe antes de buscar novamente
- Use nomes descritivos: `benchmark-chart.png`, nao `image1.png`
- Timeout maximo: 30s por screenshot
- Dimensoes maximas: 1920x1920px
- Bloqueie URLs file://, localhost e IPs privados
