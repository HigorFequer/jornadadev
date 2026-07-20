// Exercício 5 — Desafio: plano de saúde
// Calcula o valor mensal do plano conforme a idade,
// somando R$ 90 por dependente.
//
// Até 25 anos       -> R$ 180
// 26 a 40 anos      -> R$ 260
// 41 a 60 anos      -> R$ 380
// Acima de 60 anos  -> R$ 520
// Adicional         -> R$ 90 por dependente

FUNCTION Main()

   LOCAL nIdade
   LOCAL nDependentes
   LOCAL nValorBase
   LOCAL nValorTotal

   ACCEPT "Digite a idade: " TO nIdade
   nIdade := Val( nIdade )

   ACCEPT "Digite o número de dependentes: " TO nDependentes
   nDependentes := Val( nDependentes )

   IF nIdade <= 25
      nValorBase := 180
   ELSEIF nIdade >= 26 .AND. nIdade <= 40
      nValorBase := 260
   ELSEIF nIdade >= 41 .AND. nIdade <= 60
      nValorBase := 380
   ELSE
      nValorBase := 520
   ENDIF

   nValorTotal := nValorBase + (nDependentes * 90)

   QOut(" ")
   QOut("-------------------------------------------")
   QOut("Idade                    : " + AllTrim(Str(nIdade, 5)))
   QOut("Valor base do plano      : " + "R$ " + AllTrim(Str(nValorBase, 10, 2)))
   QOut("Adicional por dependentes: " + AllTrim(Str(nDependentes, 5 )) + " x R$ 90,00")
   QOut("Valor dos dependentes    : " + "R$ " + AllTrim(Str(nDependentes * 90, 10, 2)))
   QOut("-------------------------------------------")
   QOut("Valor mensal total   : " + "R$ " + AllTrim(Str(nValorTotal, 10, 2)))

   QOut(" ")
   QOut("Pressione qualquer tecla para sair...")
   Inkey(0)

   RETURN NIL
