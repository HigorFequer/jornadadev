#include "protheus.ch"

// Exercicio 07a - Impede excluir um contato que ainda possui interacoes.
USER FUNCTION VALEXCSZ1()
   LOCAL lPodeExcluir := .T.
   LOCAL aArea        := GetArea()

   IF ExistCpo("SZ2", xFilial("SZ2") + SZ1->Z1_CODIGO, 1)
      MsgAlert("Contato possui interacoes. Exclua as interacoes primeiro.", "Atencao")
      lPodeExcluir := .F.
   ENDIF

   RestArea(aArea)
RETURN lPodeExcluir

// Exercicio 07b - Executa qualquer bloco com tratamento padronizado.
USER FUNCTION EXECUTARSEGURO(bBloco, cMsgErro)
   LOCAL lOk   := .T.
   LOCAL oErro

   DEFAULT cMsgErro := "Nao foi possivel concluir a operacao."

   IF ValType(bBloco) != "B"
      MsgStop("O parametro informado nao e um bloco de codigo.", "Erro")
      RETURN .F.
   ENDIF

   BEGIN SEQUENCE
      Eval(bBloco)
   RECOVER WITH oErro
      lOk := .F.
      MsgStop(cMsgErro, "Erro")
      U_GRAVARLOG("EXECUTARSEGURO", oErro)
   END SEQUENCE
RETURN lOk
