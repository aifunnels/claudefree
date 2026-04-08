---
name: setup-empresa
description: Configura o perfil do negocio na primeira vez — cria config/empresa.md
---

# Setup da Empresa

Wizard de primeira vez. Coleta informacoes sobre o negocio e cria o perfil em `config/empresa.md`.

## Quando Usar

- Automaticamente na primeira interacao (quando config/empresa.md nao existe)
- Quando o usuario pedir para reconfigurar o perfil

## Passos

1. Cumprimente o usuario e explique que vai configurar o perfil do negocio em 6 perguntas rapidas.

2. Faca as perguntas UMA POR VEZ (espere a resposta antes da proxima):

   **Pergunta 1:** Qual o nome da sua empresa ou marca?

   **Pergunta 2:** Qual seu segmento principal?
   - Gestor de trafego
   - Social media
   - Designer
   - Videomaker
   - Agencia full service
   - Outro (especifique)

   **Pergunta 3:** Quantos clientes voce atende atualmente?

   **Pergunta 4:** Qual sua faixa de faturamento mensal?
   - Ate R$5k
   - R$5k a R$10k
   - R$10k a R$25k
   - Acima de R$25k

   **Pergunta 5:** Quais ferramentas voce usa no dia a dia?
   (Meta Ads, Google Ads, Canva, Figma, ClickUp, n8n, Make, HubSpot, RD Station, etc.)

   **Pergunta 6:** Voce tem um nicho principal?
   - Advocacia
   - B2B / SaaS
   - Clinicas / Saude
   - Geral (varios nichos)
   - Outro (especifique)

3. Com as respostas, crie o arquivo `config/empresa.md` no formato abaixo.

4. Confirme o perfil com o usuario e pergunte se quer ajustar algo.

5. Apos confirmar, sugira 3 proximos passos personalizados baseado no perfil:
   - Se gestor de trafego: "Crie um briefing de campanha com /briefing-cliente"
   - Se social media: "Peca ao @cmo um calendario editorial"
   - Se designer: "Use /criar-imagem para produzir um criativo"
   - Se videomaker: "Veja templates de roteiro em templates/videomaker/"
   - Se agencia: "Cadastre seu primeiro cliente com /briefing-cliente"
   - Se nicho especifico: "Carregue o contexto do seu nicho: nichos/{nicho}/contexto.md"

## Formato do Output

```markdown
# Perfil — {Nome da Empresa}

**Configurado em:** {data atual}

## Negocio
- **Nome:** {nome}
- **Segmento:** {segmento}
- **Clientes ativos:** {quantidade}
- **Faturamento:** {faixa}
- **Nicho principal:** {nicho}

## Ferramentas
- {lista de ferramentas, uma por linha}

## Contexto Adicional
{qualquer informacao extra relevante fornecida pelo usuario}
```

## Regras

- Nao pular nenhuma pergunta — se o usuario nao souber, marcar como "A definir"
- Nao inventar informacoes — apenas registrar o que o usuario fornecer
- Manter o arquivo abaixo de 500 bytes sempre que possivel
- O arquivo DEVE ser salvo em config/empresa.md (caminho exato)
