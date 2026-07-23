// ex07-estatisticas-numeros.prg
// Le 10 numeros, ordena e exibe soma, media, maior e menor

PROCEDURE Main()
   LOCAL aV := Array( 10 )
   LOCAL nI, nSoma := 0, nMedia
   LOCAL cEntrada

   CLS
   ? "=== ESTATISTICAS DE 10 NUMEROS ==="

   FOR nI := 1 TO 10
      cEntrada := Space( 10 )
      ? "Digite o numero " + Str( nI, 2 ) + ": "
      @ Row(), Col() SAY "" GET cEntrada
      READ
      aV[ nI ] := Val( AllTrim( cEntrada ) )
   NEXT

   ASort( aV )

   ? ""
   ? "Numeros em ordem crescente:"
   FOR nI := 1 TO Len( aV )
      ?? Str( aV[ nI ], 8 )
   NEXT

   FOR nI := 1 TO Len( aV )
      nSoma += aV[ nI ]
   NEXT
   nMedia := nSoma / Len( aV )

   ? ""
   ? "Soma  : " + Str( nSoma )
   ? "Media : " + Str( nMedia, 10, 2 )
   ? "Maior : " + Str( aV[ Len( aV ) ] )
   ? "Menor : " + Str( aV[ 1 ] )

   ? ""
   ? "Pressione qualquer tecla para sair..."
   Inkey( 0 )

   RETURN
