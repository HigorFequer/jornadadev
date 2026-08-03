// Exercicio 05 - Primeiro contato com tratamento de erros

FUNCTION Main()
   LOCAL nA   := 10
   LOCAL nB   := 0
   LOCAL nRes := 0
   LOCAL oErro

   BEGIN SEQUENCE
      // Erro provocado de proposito para exercitar o RECOVER.
      nRes := nA / nB
      QOut("Resultado: " + Str(nRes))
   RECOVER WITH oErro
      QOut("Erro capturado: " + oErro:Description)
   END SEQUENCE

   QOut("O programa continua de pe!")
RETURN NIL
