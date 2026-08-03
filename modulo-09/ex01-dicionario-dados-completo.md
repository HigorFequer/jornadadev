# Exercício 01 — Dicionário de dados completo

Este documento registra a configuração que deve ser feita no Configurador. Os campos marcados como **Virtual** são calculados em tempo de execução e não ocupam espaço físico na tabela.

## SX2 — tabelas

| Prefixo | Nome | Modo |
|---|---|---|
| SZ1 | Contatos | Compartilhado (`C`) |
| SZ2 | Interações | Compartilhado (`C`) |

## SX3 — campos da SZ1 (Contatos)

| Ordem | Campo | Título | Tipo | Tamanho | Decimais | Contexto |
|---:|---|---|:---:|---:|---:|---|
| 1 | Z1_FILIAL | Filial | C | 2 | 0 | Real |
| 2 | Z1_CODIGO | Código | C | 6 | 0 | Real |
| 3 | Z1_CLIENTE | Cliente | C | 6 | 0 | Real |
| 4 | Z1_LOJACLI | Loja Cliente | C | 2 | 0 | Real |
| 5 | Z1_NOME | Nome Cliente | C | 40 | 0 | Virtual |
| 6 | Z1_ASSUNTO | Assunto | C | 60 | 0 | Real |
| 7 | Z1_DATA | Data | D | 8 | 0 | Real |
| 8 | Z1_HORA | Hora | C | 5 | 0 | Real |

Relação do campo virtual `Z1_NOME`:

```advpl
POSICIONE("SA1", 1, xFilial("SA1") + M->Z1_CLIENTE + M->Z1_LOJACLI, "A1_NOME")
```

## SX3 — campos da SZ2 (Interações)

| Ordem | Campo | Título | Tipo | Tamanho | Decimais | Contexto |
|---:|---|---|:---:|---:|---:|---|
| 1 | Z2_FILIAL | Filial | C | 2 | 0 | Real |
| 2 | Z2_CONTAT | Contato | C | 6 | 0 | Real |
| 3 | Z2_SEQUEN | Sequência | C | 3 | 0 | Real |
| 4 | Z2_TIPO | Tipo | C | 1 | 0 | Real |
| 5 | Z2_DESCRI | Descrição | C | 100 | 0 | Real |
| 6 | Z2_DATA | Data | D | 8 | 0 | Real |
| 7 | Z2_HORA | Hora | C | 5 | 0 | Real |
| 8 | Z2_USUAR | Usuário | C | 20 | 0 | Real |
| 9 | Z2_CODIGO | Cód. Contato | C | 6 | 0 | Virtual |
| 10 | Z2_ASSUNT | Assunto Cont. | C | 60 | 0 | Virtual |

## SIX — índices

### SZ1

| Ordem | Expressão | Descrição |
|---:|---|---|
| 1 | `Z1_FILIAL + Z1_CODIGO` | Chave primária |
| 2 | `Z1_FILIAL + Z1_CLIENTE + Z1_LOJACLI` | Por cliente |
| 3 | `Z1_FILIAL + DTOS(Z1_DATA)` | Por data |

### SZ2

| Ordem | Expressão | Descrição |
|---:|---|---|
| 1 | `Z2_FILIAL + Z2_CONTAT + Z2_SEQUEN` | Chave primária |
| 2 | `Z2_FILIAL + DTOS(Z2_DATA)` | Por data |

## SX5 — domínio Z2

| Chave | Descrição |
|:---:|---|
| E | E-mail |
| L | Ligação |
| R | Reunião |
| V | Visita |
| W | WhatsApp |

Para validar no ambiente, devem ser capturados prints das duas entradas no SX2, das estruturas SX3, dos índices SIX e do domínio SX5. Esses prints complementam esta descrição, mas não substituem os dados escritos acima.
