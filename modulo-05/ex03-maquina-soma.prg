// Exercício 3 — Máquina de soma
// Lê valores até que 0 seja digitado.
// Ao final, mostra a soma total e a quantidade de valores somados
// (sem contar o 0 final).

FUNCTION Main()

   LOCAL nValor
   LOCAL nTotal
   LOCAL nQtd

   nTotal := 0
   nQtd   := 0

   QOut("===================================================================")
   QOut("                     Máquina de soma")
   QOut("Digite os valores para somar (digite 0 para somar todos os valores)")
   QOut("===================================================================")
   QOut(" ")

   WHILE .T.

      ACCEPT "Digite o valor: " TO nValor
      nValor := Val(nValor)

      IF nValor == 0
         EXIT
      ENDIF

      nTotal += nValor
      nQtd++

   ENDDO

   QOut(" ")
   QOut("Soma total       : " + AllTrim(Str( nTotal, 12, 2)))
   QOut("Quantidade somada: " + AllTrim(Str( nQtd, 5)))

   RETURN NIL
