#include "protheus.ch"

/* Abre os Pets nascidos no mês informado e oferece Histórico. */
User Function STTIP008()
    Local nMes := Val(FwInputBox("Mês de nascimento (1 a 12)", StrZero(Month(Date()), 2)))
    Local cFiltro := ""

    If nMes < 1 .Or. nMes > 12
        MsgStop("Informe um mês entre 1 e 12.", "Mês inválido")
        Return Nil
    EndIf

    cFiltro := "Month(ZA1_DTNAS) == " + AllTrim(Str(nMes))
    Private cCadastro := "Pets por mês de nascimento"
    Private aRotina := {;
        {"Pesquisar", "AxPesqui", 0, 1},;
        {"Visualizar", "AxVisual", 0, 2},;
        {"Incluir", "AxInclui", 0, 3},;
        {"Alterar", "AxAltera", 0, 4},;
        {"Excluir", "AxDeleta", 0, 5},;
        {"Histórico", "U_ZA1HIST", 0, 6};
    }

    DbSelectArea("ZA1")
    DbSetOrder(1)
    mBrowse(6, 1, 22, 75, "ZA1",,,,,, cFiltro)
Return Nil

User Function ZA1HIST()
    If ZA1->(Eof())
        Return Nil
    EndIf
    MsgInfo("Pet: " + AllTrim(ZA1->ZA1_NOME) + CRLF + ;
        "Idade: " + AllTrim(Str(ZA1->ZA1_IDADE)) + CRLF + ;
        "Nascimento: " + DToC(ZA1->ZA1_DTNAS), "Histórico do Pet")
Return Nil

