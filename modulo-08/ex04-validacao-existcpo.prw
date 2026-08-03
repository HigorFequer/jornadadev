#include "protheus.ch"

/* Validação de cliente/loja para uso no X3_VALID da ZA1. */
User Function ZA1CliVal()
    Local cCliente := M->ZA1_CLIENT
    Local cLoja := M->ZA1_LOJA

    If Empty(cCliente) .Or. Empty(cLoja)
        Help(" ", 1, "CLIENTE",, "Informe cliente e loja.", 1, 0)
        Return .F.
    EndIf

    If !ExistCpo("SA1", cCliente + cLoja)
        Help(" ", 1, "CLIENTE",, "Cliente/loja não encontrado.", 1, 0)
        Return .F.
    EndIf
Return .T.

