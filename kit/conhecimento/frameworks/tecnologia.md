# Framework Tecnico — CTO Squad

## Metricas DORA

As metricas DORA (DevOps Research and Assessment) medem a performance de entrega de software.

| Metrica | Elite | Alta | Media | Baixa |
|---------|-------|------|-------|-------|
| Deployment Frequency | Multiplos/dia | 1x/semana | 1x/mes | <1x/6 meses |
| Lead Time for Changes | <1 hora | 1 dia | 1 semana | 1 mes |
| MTTR | <1 hora | <1 dia | <1 semana | >1 semana |
| Change Failure Rate | <5% | 10% | 15% | >30% |

**Como calcular:**
- Deployment Frequency: numero de deploys em producao / periodo
- Lead Time: timestamp do primeiro commit ate o deploy em producao
- MTTR: timestamp do incidente ate restauracao do servico
- Change Failure Rate: deploys que causaram incidente / total de deploys

---

## 12-Factor App

Principios para aplicacoes cloud-native:

| # | Fator | Descricao |
|---|-------|-----------|
| I | Codebase | Um repositorio, multiplos deploys |
| II | Dependencies | Declarar e isolar dependencias explicitamente |
| III | Config | Configuracoes em variaveis de ambiente |
| IV | Backing Services | Tratar servicos externos como recursos |
| V | Build, Release, Run | Separar rigorosamente as etapas |
| VI | Processes | Executar como processos stateless |
| VII | Port Binding | Exportar servicos via port binding |
| VIII | Concurrency | Escalar via modelo de processo |
| IX | Disposability | Startup rapido e shutdown gracioso |
| X | Dev/Prod Parity | Dev, staging e prod o mais similares possivel |
| XI | Logs | Tratar logs como streams de eventos |
| XII | Admin Processes | Executar tarefas admin como processos pontuais |

---

## SOLID Principles

| Principio | Definicao | Violacao Comum |
|-----------|-----------|---------------|
| Single Responsibility | Uma classe = uma razao para mudar | God class com 500+ linhas |
| Open/Closed | Aberto para extensao, fechado para modificacao | Switch/case sem polimorfismo |
| Liskov Substitution | Subclasses podem substituir superclasses | Override que quebra contrato |
| Interface Segregation | Interfaces especificas em vez de gerais | Interface com 20 metodos |
| Dependency Inversion | Depender de abstracoes, nao implementacoes | `new ConcreteService()` no construtor |

---

## Clean Architecture

### Camadas
```
Entities (regras de negocio)
  ↑
Use Cases (logica de aplicacao)
  ↑
Interface Adapters (controllers, presenters, gateways)
  ↑
Frameworks & Drivers (DB, Web, UI)
```

### Regra de Dependencia
- Dependencias apontam SEMPRE para dentro (em direcao ao dominio)
- Camadas externas conhecem internas, nunca o contrario
- Dominio nao conhece nada sobre banco de dados, HTTP, etc.

---

## Security Best Practices

### OWASP Top 10 (2021)
- **A01 Broken Access Control:** Verificar autorizacao em todo endpoint
- **A02 Cryptographic Failures:** TLS 1.2+, hashing bcrypt/argon2, nao MD5/SHA1
- **A03 Injection:** Parameterized queries, validacao de input, ORM
- **A04 Insecure Design:** Threat modeling, security requirements no design
- **A05 Security Misconfiguration:** Headers, permissoes, default credentials
- **A06 Vulnerable Components:** SCA, atualizar dependencias, CVE monitoring
- **A07 Auth Failures:** MFA, rate limiting, session management, JWT seguro
- **A08 Data Integrity Failures:** Verificar integridade de serialization
- **A09 Logging Failures:** Logar eventos de seguranca, nao dados sensiveis
- **A10 SSRF:** Validar e restringir requests para recursos externos

### Headers de Seguranca Essenciais
```
Strict-Transport-Security: max-age=31536000; includeSubDomains
Content-Security-Policy: default-src 'self'
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Referrer-Policy: no-referrer
Permissions-Policy: geolocation=(), microphone=()
```

---

## Observabilidade (SLI/SLO/SLA)

### Definicoes
- **SLI (Service Level Indicator):** Metrica que mede o servico (ex: latencia P99)
- **SLO (Service Level Objective):** Meta interna para o SLI (ex: latencia P99 < 500ms em 99.9% do tempo)
- **SLA (Service Level Agreement):** Compromisso externo com usuario/cliente (sempre mais conservador que o SLO)

### Error Budget
`Error Budget = 100% - SLO`
- Se SLO = 99.9% disponibilidade → budget = 0.1% = ~43 minutos/mes
- Enquanto ha error budget: pode fazer deploys agressivos
- Quando budget esgota: congelar deploys, focar em confiabilidade

### Tres Pilares da Observabilidade
1. **Logs:** Registro de eventos discretos com contexto (structured logging)
2. **Metricas:** Dados numericos agregados ao longo do tempo
3. **Traces:** Rastreamento de requests distribuidos entre servicos

---

## ADR (Architecture Decision Record)

Template padrao:
```markdown
# ADR-{numero}: {titulo}

**Status:** Proposto | Aceito | Deprecated | Superseded

**Contexto:**
{Por que esta decisao precisa ser tomada agora?}

**Decisao:**
{O que foi decidido}

**Alternativas Consideradas:**
- **Opcao A:** {descricao} — Pros: {lista} / Contras: {lista}
- **Opcao B:** {descricao} — Pros: {lista} / Contras: {lista}

**Consequencias:**
{O que muda com esta decisao? O que fica mais facil? O que fica mais dificil?}

**Metricas de Sucesso:**
{Como saberemos em 6 meses que foi a decisao certa?}
```

---

## Disaster Recovery

### RTO vs RPO
- **RTO (Recovery Time Objective):** Tempo maximo aceitavel de indisponibilidade
- **RPO (Recovery Point Objective):** Quantidade maxima aceitavel de perda de dados (medida em tempo)

### Estrategias de Backup por Criticidade
| Criticidade | RPO | Estrategia |
|------------|-----|-----------|
| Critico | <1 hora | Replicacao em tempo real + backup horario |
| Alto | <24 horas | Backup diario + retencao 30 dias |
| Medio | <72 horas | Backup diario + retencao 7 dias |
| Baixo | <1 semana | Backup semanal |
