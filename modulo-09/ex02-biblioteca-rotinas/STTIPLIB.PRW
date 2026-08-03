#include "protheus.ch"
#include "fileio.ch"

// Retorna o nome do cliente usando a chave completa cliente + loja.
USER FUNCTION NOMECLIENTE(cCodigo, cLoja)
   LOCAL cNome := ""

   IF !Empty(cCodigo)
      cNome := POSICIONE("SA1", 1, xFilial("SA1") + cCodigo + cLoja, "A1_NOME")
   ENDIF
RETURN AllTrim(cNome)

// Reserva no SXE o proximo codigo de contato.
USER FUNCTION PROXCODIGOSZ1()
RETURN GetSXENum("SZ1", "Z1_CODIGO")

// Calcula a proxima sequencia dentro de um mesmo contato.
USER FUNCTION PROXSEQUENSZ2(cContat)
   LOCAL nMax  := 0
   LOCAL aArea := GetArea()

   dbSelectArea("SZ2")
   dbSetOrder(1)

   IF dbSeek(xFilial("SZ2") + cContat)
      WHILE !Eof() .AND. SZ2->Z2_FILIAL == xFilial("SZ2") .AND. ;
            SZ2->Z2_CONTAT == cContat
         nMax := Max(nMax, Val(SZ2->Z2_SEQUEN))
         dbSkip()
      ENDDO
   ENDIF

   RestArea(aArea)
RETURN StrZero(nMax + 1, 3)

// Traduz o codigo de uma interacao.
USER FUNCTION DESCTIPOINTERACAO(cTipo)
   LOCAL cDesc := ""

   DO CASE
   CASE cTipo == "E"
      cDesc := "E-mail"
   CASE cTipo == "L"
      cDesc := "Ligacao"
   CASE cTipo == "R"
      cDesc := "Reuniao"
   CASE cTipo == "V"
      cDesc := "Visita"
   CASE cTipo == "W"
      cDesc := "WhatsApp"
   ENDCASE
RETURN cDesc

// Registra os detalhes tecnicos sem expo-los ao usuario final.
USER FUNCTION GRAVARLOG(cFuncao, oErro)
   LOCAL cArqLog := "\logs\advpl_" + DToS(Date()) + ".log"
   LOCAL cLinha  := ""
   LOCAL nHandle := -1

   cLinha := DToS(Date()) + " " + Time() + " | " + cFuncao + " | "
   cLinha += cNomUsr + " | Empresa: " + cEmpAnt + " Filial: " + cFilAnt

   IF oErro != NIL
      cLinha += " | ERRO: " + oErro:Description
      cLinha += " | Func: " + oErro:ProcName + ":" + cValToChar(oErro:ProcLine)
      cLinha += " | SubSist: " + oErro:SubSystem
      cLinha += " | Oper: " + oErro:Operation
   ENDIF

   nHandle := FOpen(cArqLog, FO_READWRITE + FO_SHARED)
   IF nHandle < 0
      nHandle := FCreate(cArqLog)
   ENDIF

   IF nHandle >= 0
      FSeek(nHandle, 0, FS_END)
      FWrite(nHandle, cLinha + CRLF)
      FClose(nHandle)
   ENDIF
RETURN NIL
