# Exercício 03 — Gatilhos, campos virtuais e validações

## Campos virtuais no SX3

No `X3_RELACAO` de `Z2_CODIGO`:

```advpl
POSICIONE("SZ1", 1, xFilial("SZ1") + M->Z2_CONTAT, "Z1_CODIGO")
```

No `X3_RELACAO` de `Z2_ASSUNT`:

```advpl
POSICIONE("SZ1", 1, xFilial("SZ1") + M->Z2_CONTAT, "Z1_ASSUNTO")
```

Os dois campos têm contexto **Virtual**, portanto exibem dados do contato sem duplicá-los fisicamente na SZ2.

## Gatilhos no SX7

| Campo destino | Regra | Fase | Resultado |
|---|---|---:|---|
| Z2_DATA | `dDataBase` | 1 | Preenche a data na inclusão |
| Z2_HORA | `IF(INCLUI, Time(), SZ2->Z2_HORA)` | 3 | Preenche na inclusão e preserva na alteração |
| Z2_USUAR | `cNomUsr` | 1 | Registra o usuário logado na inclusão |

## Validação cruzada

No `X3_VALID` de `Z2_CONTAT`:

```advpl
ExistCpo("SZ1", xFilial("SZ1") + M->Z2_CONTAT, 1)
```

A validação impede uma interação órfã: o código digitado precisa existir na ordem 1 da SZ1. No teste, data, hora e usuário devem aparecer automaticamente e um código de contato inexistente deve ser recusado.
