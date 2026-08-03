#include "protheus.ch"

/* Cadastro padrão de Pets da tabela ZA1. */
User Function STTIP002()
    Local cAlias := "ZA1"
    Local cTitulo := "Cadastro de Pets"

    DbSelectArea(cAlias)
    DbSetOrder(1)
    AxCadastro(cAlias, cTitulo)
Return Nil

