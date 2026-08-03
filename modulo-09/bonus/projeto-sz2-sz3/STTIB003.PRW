#include "protheus.ch"

USER FUNCTION STTIB003()
   LOCAL aColors := {;
      {"SZ2->Z2_DATA >= dDataBase - 7",  "BR_GREEN"},;
      {"SZ2->Z2_DATA >= dDataBase - 30", "BR_YELLOW"},;
      {".T.",                            "BR_RED"};
   }
   PRIVATE cCadastro := "Contatos - Bonus"
   PRIVATE aRotina := {;
      {"Pesquisar", "AxPesqui", 0, 1}, {"Visualizar", "AxVisual", 0, 2},;
      {"Incluir", "AxInclui", 0, 3}, {"Alterar", "AxAltera", 0, 4},;
      {"Excluir", "AxDeleta", 0, 5}, {"Interacoes", "U_STTIB004", 0, 6};
   }
   dbSelectArea("SZ2")
   dbSetOrder(1)
   mBrowse(1, 1, 22, 75, "SZ2", , , , , , aColors, , , , , .F., , , "")
RETURN NIL

USER FUNCTION STTIB003SALVAR()
   LOCAL lOk := .T.
   LOCAL oErro

   BeginTran()
   BEGIN SEQUENCE
      IF Empty(M->Z2_CLIENTE) .OR. Empty(M->Z2_ASSUNTO)
         lOk := .F.
         Break()
      ENDIF
      dbSelectArea("SZ2")
      IF !RecLock("SZ2", INCLUI)
         lOk := .F.
         Break()
      ENDIF
      SZ2->Z2_CODIGO  := M->Z2_CODIGO
      SZ2->Z2_CLIENTE := M->Z2_CLIENTE
      SZ2->Z2_ASSUNTO := M->Z2_ASSUNTO
      MsUnLock()
   RECOVER WITH oErro
      lOk := .F.
      RollBackTran()
      MsgStop("Nao foi possivel salvar o contato.", "Erro")
      U_GRAVARLOGB("STTIB003SALVAR", oErro)
      RETURN lOk
   END SEQUENCE
   IF lOk
      CommitTran()
   ELSE
      RollBackTran()
   ENDIF
RETURN lOk
