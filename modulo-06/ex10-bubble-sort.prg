// ex10-bubble-sort.prg
// Implementacao manual do Bubble Sort (sem usar ASORT)

PROCEDURE Main()
   LOCAL aV := { 45, 12, 78, 3, 56, 89, 21, 4, 67, 34 }
   LOCAL nI

   CLS
   ? "=== BUBBLE SORT ==="
   ? ""
   ? "Array original:"
   FOR nI := 1 TO Len( aV )
      ?? Str( aV[ nI ], 6 )
   NEXT

   BubbleSort( aV )

   ? ""
   ? "Array ordenado:"
   FOR nI := 1 TO Len( aV )
      ?? Str( aV[ nI ], 6 )
   NEXT

   ? ""
   ? "Pressione qualquer tecla para sair..."
   Inkey( 0 )

   RETURN

// Ordena o array em ordem crescente, trocando elementos vizinhos fora de ordem
FUNCTION BubbleSort( aVetor )
   LOCAL nI, nJ, nTemp
   LOCAL nTam := Len( aVetor )

   FOR nI := 1 TO nTam - 1
      FOR nJ := 1 TO nTam - nI
         IF aVetor[ nJ ] > aVetor[ nJ + 1 ]
            nTemp := aVetor[ nJ ]
            aVetor[ nJ ] := aVetor[ nJ + 1 ]
            aVetor[ nJ + 1 ] := nTemp
         ENDIF
      NEXT
   NEXT

   RETURN aVetor
