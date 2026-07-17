FUNCTION Main()
   LOCAL nA
   LOCAL nB
   ACCEPT "Digite o primeiro numero: " TO nA
   nA := Val(nA)

   ACCEPT "Digite o segundo numero: " TO nB
   nB := Val(nB)

   QOut("Soma       : " + alltrim(Str(nA + nB, 10, 2)))
   QOut("Subtracao  : " + alltrim(Str(nA - nB, 10, 2)))
   QOut("Produto    : " + alltrim(Str(nA * nB, 10, 2)))
   
   IF nB <> 0
    QOut("Divisao    : " + alltrim(Str(nA / nB, 10, 2)))
   ELSE
    QOut("Divisao    : nao e possivel dividir por zero.")
   ENDIF

RETURN NIL