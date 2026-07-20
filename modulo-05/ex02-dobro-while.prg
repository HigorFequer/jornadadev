// Exercício 2 — Loop indefinido: o dobro
// Lê valores inteiros indefinidamente e exibe o dobro de cada um.
// Para quando o usuário informar um valor zero ou negativo.

FUNCTION Main()

   LOCAL nValor

   QOut("Loop indefinido: o dobro")
   QOut("Digite valores inteiros:")
   QOut("(Digitar valor 0 ou negativo encerrar o programa)")
   QOut(" ")

   WHILE .T.

      ACCEPT "Digite um valor: " TO nValor
      nValor := Val( nValor )

      IF nValor <= 0
         EXIT
      ENDIF

      QOut("O dobro de " + ALLtrim(Str( nValor)) + " é " + ALLtrim(Str(nValor * 2)))

   ENDDO

   QOut(" ")
   QOut("Encerrado.")

   RETURN NIL
