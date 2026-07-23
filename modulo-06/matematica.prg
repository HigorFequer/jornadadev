// matematica.prg
// Biblioteca de funcoes matematicas reutilizaveis

// Calcula o fatorial de N (N!)
FUNCTION FatorialN( nN )
   LOCAL nResultado := 1
   LOCAL nI

   IF nN < 0
      RETURN NIL   // fatorial nao definido para negativos
   ENDIF

   FOR nI := 2 TO nN
      nResultado *= nI
   NEXT

   RETURN nResultado

// Retorna .T. se N e um numero primo
FUNCTION EhPrimo( nN )
   LOCAL nI

   IF nN < 2
      RETURN .F.
   ENDIF

   FOR nI := 2 TO Int( Sqrt( nN ) )
      IF nN % nI == 0
         RETURN .F.
      ENDIF
   NEXT

   RETURN .T.

// Maximo divisor comum (algoritmo de Euclides)
FUNCTION MDC( nA, nB )
   LOCAL nResto

   DO WHILE nB != 0
      nResto := nA % nB
      nA := nB
      nB := nResto
   ENDDO

   RETURN nA

// Minimo multiplo comum (usa o MDC)
FUNCTION MMC( nA, nB )
   RETURN ( nA * nB ) / MDC( nA, nB )
