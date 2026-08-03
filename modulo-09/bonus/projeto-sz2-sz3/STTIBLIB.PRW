#include "protheus.ch"
#include "fileio.ch"

USER FUNCTION PROXCODIGOSZ2()
RETURN GetSXENum("SZ2", "Z2_CODIGO")

USER FUNCTION PROXSEQUENSZ3(cContato)
   LOCAL nMax := 0
   LOCAL aArea := GetArea()
   dbSelectArea("SZ3")
   dbSetOrder(1)
   IF dbSeek(xFilial("SZ3") + cContato)
      WHILE !Eof() .AND. SZ3->Z3_CONTAT == cContato
         nMax := Max(nMax, Val(SZ3->Z3_SEQUEN))
         dbSkip()
      ENDDO
   ENDIF
   RestArea(aArea)
RETURN StrZero(nMax + 1, 3)

USER FUNCTION GRAVARLOGB(cFuncao, oErro)
   LOCAL cArquivo := "\logs\advpl_bonus_" + DToS(Date()) + ".log"
   LOCAL cLinha := DToS(Date()) + " " + Time() + " | " + cFuncao
   LOCAL nHandle
   IF oErro != NIL
      cLinha += " | " + oErro:Description + " | " + oErro:ProcName
   ENDIF
   nHandle := FOpen(cArquivo, FO_READWRITE + FO_SHARED)
   IF nHandle < 0
      nHandle := FCreate(cArquivo)
   ENDIF
   IF nHandle >= 0
      FSeek(nHandle, 0, FS_END)
      FWrite(nHandle, cLinha + CRLF)
      FClose(nHandle)
   ENDIF
RETURN NIL

USER FUNCTION VALEXCSZ2()
   IF ExistCpo("SZ3", xFilial("SZ3") + SZ2->Z2_CODIGO, 1)
      MsgAlert("Contato possui interacoes.", "Atencao")
      RETURN .F.
   ENDIF
RETURN .T.
