#include "protheus.ch"

// Lista somente as interacoes vinculadas ao contato selecionado na SZ1.
USER FUNCTION STTIP004()
   LOCAL cCodigSZ1 := SZ1->Z1_CODIGO
   LOCAL cFiltro   := "Z2_CONTAT == '" + cCodigSZ1 + "'"
   PRIVATE cCadastro := "Interacoes - Contato " + AllTrim(cCodigSZ1)
   PRIVATE aRotina   := STTIPROT()

   dbSelectArea("SZ2")
   dbSetOrder(1)
   dbSeek(xFilial("SZ2") + cCodigSZ1)

   mBrowse(1, 1, 22, 75, "SZ2", , , , , , , , , , , .F., , , cFiltro)
RETURN NIL

// Listagem geral usada pelo menu do SIGACOM.
USER FUNCTION STTIP004B()
   PRIVATE cCadastro := "Interacoes - Todas"
   PRIVATE aRotina   := STTIPROT()

   dbSelectArea("SZ2")
   dbSetOrder(1)
   dbSeek(xFilial("SZ2"))

   mBrowse(1, 1, 22, 75, "SZ2", , , , , , , , , , , .F., , , "")
RETURN NIL

STATIC FUNCTION STTIPROT()
   LOCAL aOpcoes := {;
      {"Pesquisar",  "AxPesqui", 0, 1},;
      {"Visualizar", "AxVisual", 0, 2},;
      {"Incluir",    "AxInclui", 0, 3},;
      {"Alterar",    "AxAltera", 0, 4},;
      {"Excluir",    "AxDeleta", 0, 5};
   }
RETURN aOpcoes
