---
name: criar-carrossel
description: Cria carrossel completo (copy + design + imagens) para Instagram e LinkedIn
---

# Criar Carrossel

Producao end-to-end de carrossel: da ideia ao arquivo final pronto para publicar.

## Quando Usar

Use quando precisar criar um carrossel completo para Instagram ou LinkedIn.

## Passos

1. Pergunte ao usuario:
   - Qual o tema/assunto do carrossel?
   - Qual cliente? (carregue briefing se existir)
   - Plataforma? (Instagram ou LinkedIn)
   - Quantos slides? (recomendado: 7-10 para IG, 5-8 para LinkedIn)
   - Tem identidade visual definida? (carregue output/identidade-visual.md se existir)

2. Carregue boas praticas da plataforma:
   - Instagram: `conhecimento/boas-praticas/instagram-feed.md`
   - LinkedIn: `conhecimento/boas-praticas/linkedin-post.md`

3. Crie a estrutura do carrossel:
   - Slide 1 (capa): hook forte que gera curiosidade
   - Slides 2-N: conteudo com progressao logica
   - Slide final: CTA claro (seguir, salvar, comentar, link na bio)

4. Para cada slide, escreva:
   - Texto principal
   - Texto de suporte (se aplicavel)
   - Indicacao visual (cor de fundo, icone, imagem)

5. Gere os HTMLs e renderize via /criar-imagem:
   - Um HTML por slide
   - CRITICO: body de cada HTML DEVE ter width e height fixos em px:
     - IG: `width: 1080px; height: 1440px;` (3:4)
     - LinkedIn: `width: 1200px; height: 627px;` (1.91:1)
   - body DEVE ter `margin:0; padding:0; overflow:hidden;`
   - browser_resize DEVE usar EXATAMENTE as mesmas dimensoes do body
   - Mantenha consistencia visual entre slides
   - Verifique o primeiro slide renderizado antes de continuar o batch

6. Apresente as imagens ao usuario para aprovacao

7. Escreva a caption do post (max 2200 caracteres para IG)

8. Pergunte se quer publicar (roteia para /publicar-instagram ou /publicar-social)

## Regras

- Minimo 5 slides, maximo 10
- Capa DEVE ter hook forte — e a peca mais importante
- Ultimo slide DEVE ter CTA
- Consistencia visual: mesma paleta, tipografia e layout em todos os slides
- Nunca incluir contador de slides ("1/7")
- Nomeie arquivos: slide-01.png, slide-02.png, etc.
