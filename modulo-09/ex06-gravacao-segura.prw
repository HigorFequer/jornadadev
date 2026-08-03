#include "protheus.ch"
#include "fileio.ch"

// Exercicio 06 - Gravacao segura de Contatos (SZ1)
// A funcao valida os dados, protege a alteracao com lock e garante
// que a transacao seja confirmada somente quando toda a operacao termina.
USER FUNCTION STTIP003SALVAR()
   LOCAL lOk       := .T.
   LOCAL lLock     := .F.
   LOCAL lTransacao := .F.
   LOCAL oErro

   BeginTran()
   lTransacao := .T.

   BEGIN SEQUENCE
      IF Empty(M->Z1_CLIENTE)
         MsgAlert("Cliente e obrigatorio!", "Atencao")
         lOk := .F.
         Break()
      ENDIF

      IF Empty(M->Z1_ASSUNTO)
         MsgAlert("Assunto e obrigatorio!", "Atencao")
         lOk := .F.
         Break()
      ENDIF

      dbSelectArea("SZ1")

      IF INCLUI
         lLock := RecLock("SZ1", .T.)
      ELSE
         lLock := RecLock("SZ1", .F.)
      ENDIF

      IF !lLock
         MsgAlert("Nao foi possivel bloquear o registro para gravacao.", "Atencao")
         lOk := .F.
         Break()
      ENDIF

      SZ1->Z1_CODIGO  := M->Z1_CODIGO
      SZ1->Z1_CLIENTE := M->Z1_CLIENTE
      SZ1->Z1_LOJACLI := M->Z1_LOJACLI
      SZ1->Z1_ASSUNTO := M->Z1_ASSUNTO
      SZ1->Z1_DATA    := M->Z1_DATA
      SZ1->Z1_HORA    := M->Z1_HORA

      MsUnLock()
      lLock := .F.

   RECOVER WITH oErro
      lOk := .F.

      IF lLock
         MsUnLock()
         lLock := .F.
      ENDIF

      IF lTransacao
         RollBackTran()
         lTransacao := .F.
      ENDIF

      MsgStop("Nao foi possivel salvar o contato. Nenhum dado foi gravado.", "Erro")
      U_GRAVARLOG("STTIP003SALVAR", oErro)
   END SEQUENCE

   IF lOk
      CommitTran()
      lTransacao := .F.
   ELSEIF lTransacao
      // Break() atende validacoes esperadas sem criar um objeto de erro.
      RollBackTran()
      lTransacao := .F.
   ENDIF
RETURN lOk
