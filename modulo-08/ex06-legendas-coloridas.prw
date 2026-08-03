#include "protheus.ch"

/* Browse de Pets com legenda por idade. */
User Function STTIP006L()
    Local aCores := {;
        {"ZA1->ZA1_IDADE <= 2", "BR_VERDE"},;
        {"ZA1->ZA1_IDADE <= 7", "BR_AMARELO"},;
        {".T.", "BR_VERMELHO"};
    }

    Private cCadastro := "Pets por faixa etária"
    Private aRotina := {;
        {"Pesquisar", "AxPesqui", 0, 1},;
        {"Visualizar", "AxVisual", 0, 2},;
        {"Incluir", "AxInclui", 0, 3},;
        {"Alterar", "AxAltera", 0, 4},;
        {"Excluir", "AxDeleta", 0, 5};
    }

    DbSelectArea("ZA1")
    DbSetOrder(1)
    mBrowse(6, 1, 22, 75, "ZA1",,,,, aCores)
Return Nil

