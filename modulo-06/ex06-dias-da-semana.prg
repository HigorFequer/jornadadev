// ex06-dias-da-semana.prg
// Exibe o nome do dia da semana a partir de um numero de 1 a 7

PROCEDURE Main()
   LOCAL aDias := { "Domingo", "Segunda-feira", "Terca-feira", ;
                     "Quarta-feira", "Quinta-feira", "Sexta-feira", "Sabado" }
   LOCAL cEntrada := Space( 3 )
   LOCAL nNumero

   CLS
   ? "=== DIA DA SEMANA ==="
   ? "Digite um numero de 1 a 7:"
   @ Row(), Col() SAY "" GET cEntrada
   READ

   nNumero := Val( AllTrim( cEntrada ) )

   IF nNumero >= 1 .AND. nNumero <= 7
      ? "O dia correspondente e: " + aDias[ nNumero ]
   ELSE
      ? "Numero fora do intervalo! Digite um valor entre 1 e 7."
   ENDIF

   ? ""
   ? "Pressione qualquer tecla para sair..."
   Inkey( 0 )

   RETURN
