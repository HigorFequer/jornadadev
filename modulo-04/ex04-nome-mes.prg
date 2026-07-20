// Exercício 4 — Número do mês → nome do mês
// Lê um número de 1 a 12 e exibe o nome do mês correspondente.
// Fora do intervalo 1–12, exibe "Mês inválido".

FUNCTION Main()

   LOCAL nMes
   LOCAL cNomeMes
   LOCAL aMeses

   aMeses := { "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", ;
      "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" }

   ACCEPT "Digite o número do mês (1 a 12): " TO nMes
   nMes := Val(nMes)

   // Forma compacta (curto): array com os 12 nomes, indexado pelo próprio número do mês.
   // IF nMes >= 1 .AND. nMes <= 12
   //    cNomeMes := aMeses[ nMes ]
   //    QOut("Mês: " + cNomeMes)
   // ELSE
   //    QOut("Mês inválido")
   // ENDIF

   // Alternativa usando a DICA DO CASE:
   DO CASE
      CASE nMes == 1
         cNomeMes := "Janeiro"
      CASE nMes == 2
         cNomeMes := "Fevereiro"
      CASE nMes == 3
         cNomeMes := "Março"
      CASE nMes == 4
         cNomeMes := "Abril"
      CASE nMes == 5
         cNomeMes := "Maio"
      CASE nMes == 6
         cNomeMes := "Junho"
      CASE nMes == 7
         cNomeMes := "Julho"
      CASE nMes == 8
         cNomeMes := "Agosto"
      CASE nMes == 9
         cNomeMes := "Setembro"
      CASE nMes == 10
         cNomeMes := "Outubro"
      CASE nMes == 11
         cNomeMes := "Novembro"
      CASE nMes == 12
         cNomeMes := "Dezembro"
         OTHERWISE
         cNomeMes := "Mês inválido"
   ENDCASE

   QOut(" ")
   QOut("O mês é: " + cNomeMes)
   QOut(" ")
   QOut("Pressione qualquer tecla para sair...")
   Inkey( 0 )

RETURN NIL

