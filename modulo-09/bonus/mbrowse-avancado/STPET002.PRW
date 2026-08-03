#include "protheus.ch"

USER FUNCTION STPET002()
   LOCAL cFiltro := "ZA1->ZA1_ESPECIE == 'C'"
   LOCAL aColors := {;
      {"ZA1->ZA1_NASC >= dDataBase - 365",       "BR_GREEN"},;
      {"ZA1->ZA1_NASC >= dDataBase - (365 * 8)", "BR_YELLOW"},;
      {".T.",                                    "BR_BLUE"};
   }
   PRIVATE cCadastro := "Pets (somente caes)"
   PRIVATE aRotina   := {;
      {"Pesquisar",  "AxPesqui",      0, 1},;
      {"Visualizar", "AxVisual",      0, 2},;
      {"Incluir",    "AxInclui",      0, 3},;
      {"Alterar",    "AxAltera",      0, 4},;
      {"Excluir",    "AxDeleta",      0, 5},;
      {"Ver todos",  "U_STPET002ALL", 0, 6};
   }
   PRIVATE aColunas := {;
      {"ZA1_COD",     "Codigo",      6},;
      {"ZA1_NOME",    "Nome do Pet", 30},;
      {"ZA1_ESPECIE", "Especie",      1},;
      {"ZA1_NOMCLI",  "Cliente",     40};
   }

   dbSelectArea("ZA1")
   dbSetOrder(1)
   mBrowse(1, 1, 22, 75, "ZA1", aColunas, , , , , aColors, , , , , .F., , , cFiltro)
RETURN NIL

USER FUNCTION STPET002ALL()
   PRIVATE cCadastro := "Pets (todos)"
   PRIVATE aRotina   := {;
      {"Pesquisar",  "AxPesqui", 0, 1},;
      {"Visualizar", "AxVisual", 0, 2},;
      {"Incluir",    "AxInclui", 0, 3},;
      {"Alterar",    "AxAltera", 0, 4},;
      {"Excluir",    "AxDeleta", 0, 5};
   }

   dbSelectArea("ZA1")
   dbSetOrder(1)
   mBrowse(1, 1, 22, 75, "ZA1", , , , , , , , , , , .F., , , "")
RETURN NIL
