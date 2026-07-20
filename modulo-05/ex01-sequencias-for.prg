// Exercício 1 — Sequências com FOR/NEXT
// a) Imprime de 1 a 100
// b) Imprime de -50 a 50
// c) Imprime de 80 a 5 em ordem decrescente (STEP -1)

FUNCTION Main()

   LOCAL nI

   QOut("a) Números de 1 a 100:")
   FOR nI := 1 TO 100
      QQOut( Str(nI, 5))
   NEXT
   QOut(" ")

   QOut(" ")
   QOut("b) Números de -50 a 50:")
   FOR nI := -50 TO 50
      QQOut( Str(nI, 5))
   NEXT
   QOut(" ")

   QOut(" ")
   QOut("c) Números de 80 a 5 (decrescente):")
   FOR nI := 80 TO 5 STEP -1
      QQOut( Str(nI, 5))
   NEXT
   QOut(" ")

RETURN NIL
