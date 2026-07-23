// ex08-sistema-notas.prg
// Sistema de notas com array multidimensional
// Cada linha do array: { nome, n1, n2, n3, n4 }

PROCEDURE Main()
   LOCAL aAlunos := {}
   LOCAL nN, nI, nJ
   LOCAL cEntrada, cNome
   LOCAL aLinha, nMedia

   CLS
   ? "=== SISTEMA DE NOTAS ==="
   ? "Quantos alunos serao cadastrados? "
   cEntrada := Space( 3 )
   @ Row(), Col() SAY "" GET cEntrada
   READ
   nN := Val( AllTrim( cEntrada ) )

   FOR nI := 1 TO nN
      ? ""
      ? "--- Aluno " + Str( nI, 2 ) + " ---"
      cNome := Space( 30 )
      ? "Nome: "
      @ Row(), Col() SAY "" GET cNome
      READ

      aLinha := { AllTrim( cNome ) }

      FOR nJ := 1 TO 4
         cEntrada := Space( 10 )
         ? "Nota " + Str( nJ, 1 ) + ": "
         @ Row(), Col() SAY "" GET cEntrada
         READ
         AAdd( aLinha, Val( AllTrim( cEntrada ) ) )
      NEXT

      AAdd( aAlunos, aLinha )
   NEXT

   ? ""
   ? "=== RESULTADO ==="
   ? ""
   ? "APROVADOS (media >= 7):"
   FOR nI := 1 TO Len( aAlunos )
      nMedia := CalcularMedia( aAlunos[ nI ] )
      IF nMedia >= 7
         ? "  " + aAlunos[ nI ][ 1 ] + " - Media: " + Str( nMedia, 6, 2 )
      ENDIF
   NEXT

   ? ""
   ? "REPROVADOS (media < 7):"
   FOR nI := 1 TO Len( aAlunos )
      nMedia := CalcularMedia( aAlunos[ nI ] )
      IF nMedia < 7
         ? "  " + aAlunos[ nI ][ 1 ] + " - Media: " + Str( nMedia, 6, 2 )
      ENDIF
   NEXT

   ? ""
   ? "Pressione qualquer tecla para sair..."
   Inkey( 0 )

   RETURN

// Calcula a media das 4 notas de um aluno (posicoes 2 a 5 da linha)
FUNCTION CalcularMedia( aLinha )
   LOCAL nSoma := 0, nJ

   FOR nJ := 2 TO 5
      nSoma += aLinha[ nJ ]
   NEXT

   RETURN nSoma / 4
