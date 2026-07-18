// Exercicio 5 (Desafio) - Media ponderada
// Modulo 3 - Jornada DEV START
// Pesos: 1, 2, 3, 4  (soma dos pesos = 10)

FUNCTION Main()

   LOCAL cEntrada
   LOCAL nN1, nN2, nN3, nN4
   LOCAL nMedia

   ACCEPT "Nota do 1o bimestre: " TO cEntrada
   nN1 := Val(cEntrada)

   ACCEPT "Nota do 2o bimestre: " TO cEntrada
   nN2 := Val(cEntrada)

   ACCEPT "Nota do 3o bimestre: " TO cEntrada
   nN3 := Val(cEntrada)

   ACCEPT "Nota do 4o bimestre: " TO cEntrada
   nN4 := Val(cEntrada)

   nMedia := (nN1 * 1 + nN2 * 2 + nN3 * 3 + nN4 * 4) / (1 + 2 + 3 + 4)

   QOut("")
   QOut("Media ponderada final: " + AllTrim(Str(nMedia, 10, 2)))

RETURN NIL
