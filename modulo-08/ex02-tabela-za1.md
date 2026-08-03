# Exercício 2 — Tabela ZA1 (Pets)

Crie a tabela `ZA1` no Configurador com chave única formada por filial e código.

| Campo | Tipo | Tam. | Título | Observação |
|---|---:|---:|---|---|
| ZA1_FILIAL | C | 2 | Filial | `xFilial("ZA1")` |
| ZA1_CODIGO | C | 6 | Código | Obrigatório |
| ZA1_NOME | C | 30 | Nome | Obrigatório |
| ZA1_TIPO | C | 15 | Tipo | Ex.: cão, gato |
| ZA1_IDADE | N | 3 | Idade | 0 casas decimais |
| ZA1_DTNAS | D | 8 | Nascimento | Data |
| ZA1_CLIENT | C | 6 | Cliente | Código SA1 |
| ZA1_LOJA | C | 2 | Loja | Loja SA1 |
| ZA1_NOMCLI | C | 40 | Nome cliente | Virtual; relação via SA1 |

Índice 1: `ZA1_FILIAL + ZA1_CODIGO`.

Relação sugerida para `ZA1_NOMCLI`:

```advpl
Posicione("SA1", 1, xFilial("SA1") + ZA1->ZA1_CLIENT + ZA1->ZA1_LOJA, "A1_NOME")
```

Os tamanhos de cliente, loja e nome devem ser confirmados no SX3 do ambiente, pois podem variar.

