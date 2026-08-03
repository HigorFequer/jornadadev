#include "protheus.ch"

/* Browse personalizado da ZA1. */
User Function STTIP006()
    Private cCadastro := "Cadastro de Pets"
    Private aRotina := {;
        {"Pesquisar", "AxPesqui", 0, 1},;
        {"Visualizar", "AxVisual", 0, 2},;
        {"Incluir", "AxInclui", 0, 3},;
        {"Alterar", "AxAltera", 0, 4},;
        {"Excluir", "AxDeleta", 0, 5};
    }

    DbSelectArea("ZA1")
    DbSetOrder(1)
    mBrowse(6, 1, 22, 75, "ZA1")
Return Nil
