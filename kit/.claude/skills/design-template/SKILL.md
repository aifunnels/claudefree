---
name: design-template
description: Seleciona e personaliza templates visuais HTML para producao de conteudo
---

# Design de Template Visual

Selecao, personalizacao e aprovacao de templates visuais para producao de conteudo.

## Quando Usar

Use quando precisar definir a identidade visual de um tipo de conteudo (carrossel, post, story) antes de produzir em escala.

## Workflow

### 1. Entender o Contexto
Leia `config/empresa.md` para entender: segmento, nicho, tom do negocio.

### 2. Gerar 3 Variacoes
Crie 3 templates HTML completos e auto-contidos, cada um com estilo visual diferente:
- Template A: estilo limpo e moderno
- Template B: estilo bold e chamativo
- Template C: estilo elegante e sofisticado

Adapte cores, tipografia e conteudo ao segmento do usuario.

### 3. Renderizar como Imagem
Use a skill /criar-imagem para renderizar cada template HTML como PNG.

### 4. Apresentar ao Usuario
Mostre os 3 templates com links clicaveis para os arquivos PNG.
Pergunte qual prefere ou se quer ajustes.

### 5. Iterar
Gere novas versoes com base no feedback ate aprovacao.

### 6. Salvar Template Aprovado
Salve em `output/template-referencia.html` e crie `output/identidade-visual.md` com:
- Paleta de cores (max 5 cores)
- Tipografia (fontes, pesos, tamanhos)
- Layout (grid, espacamento)
- Regras de composicao

## Regras de Design (OBRIGATORIO)

- Dimensoes FIXAS em pixels (nunca auto/%)
- Instagram Carrossel: 1080x1440px
- Instagram Post: 1080x1080px
- Maximo 5 cores por sistema de design
- Contraste WCAG AA minimo 4.5:1 para texto
- CSS Grid ou Flexbox apenas (sem position: absolute para conteudo principal)
- HTML auto-contido (inline CSS, so Google Fonts como recurso externo)
- Nunca incluir contadores de slide ("1/7") — Instagram tem navegacao nativa
- Tamanhos minimos de fonte: Hero 58px, Heading 43px, Body 34px, Caption 24px
