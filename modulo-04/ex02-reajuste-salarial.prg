// Exercício 2 — Reajuste salarial por faixas
// Lê o salário atual e aplica o percentual de reajuste
// de acordo com a faixa salarial.
//
// Faixas salariais e percentuais de reajuste:
// <R$ 1.000         -> 15%
// R$1.000 a R$2.000 -> 12%
// R$2.000 a R$4.000 -> 8%
// >R$4.000          -> 5%

FUNCTION Main()

   LOCAL nSalario
   LOCAL nPercentual
   LOCAL nNovoSalario

   ACCEPT "Digite o salário atual (Somente o valor, Ex: 1234.56): " TO nSalario
   nSalario := Val(nSalario)

   IF nSalario < 1000
      nPercentual := 0.15
   ELSEIF nSalario >= 1000 .AND. nSalario <= 2000
      nPercentual := 0.12
   ELSEIF nSalario > 2000 .AND. nSalario <= 4000
      nPercentual := 0.08
   ELSE
      nPercentual := 0.05
   ENDIF

   nNovoSalario := nSalario + ( nSalario * nPercentual )

   QOut(" ")
   QOut("Salário atual : " + AllTrim(Str(nSalario, 10, 2)))
   QOut("Reajuste       : " + AllTrim(Str(nPercentual * 100, 5, 2 ) + "%" ))
   QOut("Novo salário  : " + AllTrim(Str(nNovoSalario, 10, 2 )))

   QOut(" ")
   QOut("Pressione qualquer tecla para sair...")
   Inkey(0)

   RETURN NIL
