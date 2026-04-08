---
name: criar-imagem
description: Renderiza HTML/CSS em PNG, JPG ou PDF via Playwright — motor de producao visual
---

# Criar Imagem (HTML para PNG/JPG/PDF)

Renderiza HTML/CSS em imagens ou PDFs prontos para producao via Playwright.

## Quando Usar

Use quando precisar criar imagens ou PDFs a partir de HTML/CSS: posts, carrosseis, infograficos, banners, documentos.

## Regras de Construcao do HTML (CRITICO — ler antes de qualquer export)

### 1. Dimensoes FIXAS e ABSOLUTAS

O HTML DEVE ter dimensoes fixas em pixels que correspondem EXATAMENTE ao viewport de captura. Nunca use %, vh, vw, auto, min-height ou max-height.

```css
/* OBRIGATORIO em todo HTML */
html, body {
  margin: 0;
  padding: 0;
  width: {LARGURA}px;
  height: {ALTURA}px;
  overflow: hidden;
}
```

O container raiz (body ou div principal) DEVE ter as mesmas dimensoes do viewport. Se o viewport e 1080x1920, o body e 1080x1920. Sem excecao.

### 2. Tabela de Dimensoes por Formato

| Formato | Proporcao | Largura | Altura | Viewport Playwright |
|---------|-----------|---------|--------|---------------------|
| Instagram Post | 1:1 | 1080 | 1080 | 1080 x 1080 |
| Instagram Carrossel | 3:4 | 1080 | 1440 | 1080 x 1440 |
| Instagram Story/Reel | 9:16 | 1080 | 1920 | 1080 x 1920 |
| Facebook Post | 1.91:1 | 1200 | 630 | 1200 x 630 |
| LinkedIn Post | 1.91:1 | 1200 | 627 | 1200 x 627 |
| YouTube Thumbnail | 16:9 | 1280 | 720 | 1280 x 720 |
| Twitter/X Post | 16:9 | 1200 | 675 | 1200 x 675 |
| A4 Retrato (PDF) | ~1:1.41 | 794 | 1123 | 794 x 1123 |
| A4 Paisagem (PDF) | ~1.41:1 | 1123 | 794 | 1123 x 794 |
| Custom | qualquer | {W} | {H} | {W} x {H} |

### 3. Regra de Ouro: VIEWPORT = HTML = SCREENSHOT

Esses 3 valores DEVEM ser identicos:
- `width` e `height` no CSS do body
- `browser_resize` no Playwright
- Area capturada pelo `browser_take_screenshot`

Se qualquer um divergir, o export vai cortar ou bugar.

### 4. Checklist Anti-Bug (verificar ANTES de capturar)

- [ ] body tem width e height FIXOS em px (nunca %, auto, vh)
- [ ] body tem margin:0, padding:0, overflow:hidden
- [ ] browser_resize usa EXATAMENTE as mesmas dimensoes do body
- [ ] Nenhum elemento filho ultrapassa as dimensoes do body
- [ ] Nenhum scroll existe (horizontal ou vertical)
- [ ] Nenhuma font externa falhou de carregar (aguardar load)
- [ ] Nenhuma imagem externa falhou de carregar (aguardar load)

## Workflow — Export PNG ou JPG

1. Gere HTML completo e auto-contido (inline CSS, sem dependencias exceto Google Fonts)
2. VERIFIQUE que body tem width/height fixos em px e overflow:hidden
3. Salve o HTML em `output/{nome}.html`
4. Inicie servidor HTTP local:
   ```bash
   python -m http.server 8765 --directory "OUTPUT_DIR" &
   for i in $(seq 1 30); do curl -s http://localhost:8765 > /dev/null 2>&1 && break || sleep 0.1; done
   ```
5. Use Playwright MCP:
   - `browser_navigate` para `http://localhost:8765/{arquivo}.html`
   - `browser_resize` com width e height IDENTICOS ao body do HTML
   - Aguarde fonts e imagens carregarem (browser_wait se necessario)
   - `browser_take_screenshot` para capturar
6. VERIFIQUE a imagem: leia o screenshot e confirme que nao cortou
7. Encerre o servidor: `pkill -f "http.server 8765" 2>/dev/null || true`

## Workflow — Export PDF

Para PDFs, use Chrome headless em vez de Playwright screenshot:

1. Gere HTML com as regras acima
2. Adicione no CSS do HTML:
   ```css
   @page {
     size: {LARGURA}px {ALTURA}px;
     margin: 0;
   }
   @media print {
     html, body {
       width: {LARGURA}px;
       height: {ALTURA}px;
       -webkit-print-color-adjust: exact !important;
       print-color-adjust: exact !important;
     }
   }
   ```
3. Salve o HTML
4. Execute:
   ```bash
   "/c/Program Files/Google/Chrome/Application/chrome.exe" \
     --headless --disable-gpu --no-sandbox \
     --print-to-pdf="output/{nome}.pdf" \
     --print-to-pdf-no-header \
     --no-pdf-header-footer \
     --run-all-compositor-stages-before-draw \
     --virtual-time-budget=5000 \
     "file:///CAMINHO_ABSOLUTO/{nome}.html"
   ```
5. VERIFIQUE o PDF: leia o arquivo e confirme que nao cortou

### PDF Multi-pagina (documentos longos)

Se o conteudo e maior que 1 pagina:
- Use `@page { size: A4; margin: 40px; }` em vez de dimensoes custom
- NAO defina height fixo no body (deixe o conteudo fluir)
- Use `page-break-before: always` para forcar quebras de pagina
- Use `page-break-inside: avoid` em cards e tabelas
- O Chrome headless gera multiplas paginas automaticamente

### PDF Pagina Unica (poster, certificado, infografico)

Se o conteudo e exatamente 1 pagina:
- Use `@page { size: {W}px {H}px; margin: 0; }`
- Defina body com width/height fixos identicos
- overflow: hidden no body
- Mesma logica de PNG/JPG mas output em PDF

## Regras de Tipografia (OBRIGATORIO)

| Elemento | Tamanho Minimo (Instagram) |
|----------|---------------------------|
| Hero/Titulo | 58px |
| Heading | 43px |
| Body | 34px |
| Caption | 24px |
| Minimo absoluto | 20px |

- Font-weight: 500+ para body e acima
- WCAG AA contraste minimo 4.5:1

## Problemas Comuns e Solucao

| Problema | Causa | Solucao |
|----------|-------|---------|
| Imagem cortada na parte inferior | body height menor que o conteudo | Ajustar height do body OU reduzir conteudo |
| Imagem cortada na lateral | body width menor que viewport | Garantir body width = viewport width |
| Borda branca ao redor | body nao tem margin:0 | Adicionar `html, body { margin:0; padding:0 }` |
| Fundo branco no PDF | Falta print-color-adjust | Adicionar `-webkit-print-color-adjust: exact` |
| Font nao carregou | Google Font lento | Adicionar `browser_wait` de 2s apos navigate |
| Scroll aparecendo | Conteudo excede viewport | overflow:hidden + reduzir conteudo |
| Proporcao errada | resize e body divergem | Conferir que VIEWPORT = BODY = mesmas dimensoes |
| PDF com margem | Falta @page margin:0 | Adicionar `@page { margin: 0 }` no CSS |
| PDF cortou conteudo | height fixo menor que conteudo | Para multi-pagina: remover height fixo do body |

## Batch (Carrosseis/Multi-slide)

1. Gere um HTML por slide (mesmas dimensoes em todos)
2. Inicie servidor HTTP UMA vez
3. Renderize cada slide sequencialmente (navigate → resize → screenshot)
4. Encerre servidor UMA vez apos todos
5. Nomeie: slide-01.png, slide-02.png, slide-03.png
