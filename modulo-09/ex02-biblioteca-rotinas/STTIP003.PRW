#include "protheus.ch"

// Cadastro de Contatos (SZ1) com legendas e navegacao para Interacoes.
USER FUNCTION STTIP003()
   LOCAL cFiltro := ""
   LOCAL aColors := {}
   PRIVATE cCadastro := "Contatos"
   PRIVATE aRotina   := {;
      {"Pesquisar",  "AxPesqui",   0, 1},;
      {"Visualizar", "AxVisual",   0, 2},;
      {"Incluir",    "AxInclui",   0, 3},;
      {"Alterar",    "AxAltera",   0, 4},;
      {"Excluir",    "AxDeleta",   0, 5},;
      {"Interacoes", "U_STTIP004", 0, 6};
   }

   aColors := {;
      {"SZ1->Z1_DATA >= dDataBase - 7",  "BR_GREEN"},;
      {"SZ1->Z1_DATA >= dDataBase - 30", "BR_YELLOW"},;
      {".T.",                            "BR_RED"};
   }

   dbSelectArea("SZ1")
   dbSetOrder(1)
   dbSeek(xFilial("SZ1"))

   mBrowse(1, 1, 22, 75, "SZ1", , , , , , aColors, , , , , .F., , , cFiltro)
RETURN NIL
