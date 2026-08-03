# Configuração complementar da ZA1

- `ZA1_NOMCLI`: campo Virtual, tipo C, tamanho 40.
- `X3_RELACAO`: `POSICIONE("SA1", 1, xFilial("SA1") + M->ZA1_CLIENT + M->ZA1_LOJA, "A1_NOME")`.
- `X3_VALID` de `ZA1_CLIENT`: `ExistCpo("SA1", xFilial("SA1") + M->ZA1_CLIENT + M->ZA1_LOJA, 1)`.
- `X3_F3` de `ZA1_CLIENT`: consulta padrão de clientes do ambiente, normalmente `SA1010`.

O fonte `STPET002.PRW` demonstra mBrowse, colunas customizadas, legendas por idade, filtro inicial de cães e botão para reabrir a tabela sem filtro.
