// Exercício 1 — Maior, menor ou iguais
// Lê dois valores numéricos e exibe o maior, o menor,
// ou uma mensagem caso os dois sejam iguais.

FUNCTION Main()

   LOCAL nValor1
   LOCAL nValor2

   ACCEPT "Digite o primeiro valor : " TO nValor1
   nValor1 = Val( nValor1 )
   
   ACCEPT "Digite o segundo valor  : " TO nValor2
   nValor2 = Val( nValor2 )

   QOut(" ")
   IF nValor1 == nValor2
      QOut( "Os dois valores são iguais: " + Str( nValor1, 10, 2 ))
   ELSE
      IF nValor1 > nValor2
         QOut( "Maior valor: " + Str( nValor1, 10, 2 ))
         QOut( "Menor valor: " + Str( nValor2, 10, 2 ))
      ELSE
         QOut( "Maior valor: " + Str( nValor2, 10, 2 ))
         QOut( "Menor valor: " + Str( nValor1, 10, 2 ))
      ENDIF
   ENDIF

   QOut(" ")
   QOut("Pressione qualquer tecla para sair...")
   Inkey(0)

   RETURN NIL
