#include "protheus.ch"

USER FUNCTION STTIB004()
   LOCAL cContato := SZ2->Z2_CODIGO
   LOCAL cFiltro  := "Z3_CONTAT == '" + cContato + "'"
   PRIVATE cCadastro := "Interacoes - " + AllTrim(cContato)
   PRIVATE aRotina   := STTIBROT()
   dbSelectArea("SZ3")
   dbSetOrder(1)
   mBrowse(1, 1, 22, 75, "SZ3", , , , , , , , , , , .F., , , cFiltro)
RETURN NIL

USER FUNCTION STTIB004B()
   PRIVATE cCadastro := "Interacoes - Todas"
   PRIVATE aRotina   := STTIBROT()
   dbSelectArea("SZ3")
   dbSetOrder(1)
   mBrowse(1, 1, 22, 75, "SZ3", , , , , , , , , , , .F., , , "")
RETURN NIL

STATIC FUNCTION STTIBROT()
RETURN {{"Pesquisar", "AxPesqui", 0, 1}, {"Visualizar", "AxVisual", 0, 2},;
   {"Incluir", "AxInclui", 0, 3}, {"Alterar", "AxAltera", 0, 4},;
   {"Excluir", "AxDeleta", 0, 5}}
