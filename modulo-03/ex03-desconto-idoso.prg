// Exercicio 3 - Programa completo com desconto
// Modulo 3 - Jornada DEV START

FUNCTION Main()

   LOCAL cNome, cEntrada
   LOCAL dNasc
   LOCAL nPreco, nIdade, nDesconto, nTotal

   ACCEPT "Nome do cliente: " TO cNome

   ACCEPT "Data de nascimento (AAAAMMDD): " TO cEntrada
   dNasc := STOD(cEntrada)

   ACCEPT "Preco do produto: " TO cEntrada
   nPreco := Val(cEntrada)

   // idade aproximada em anos completos
   nIdade := Int((Date() - dNasc) / 365)

   IF nIdade >= 60
      nDesconto := nPreco * 0.125     // 12,5% de desconto para maiores de 60 anos
   ELSE
      nDesconto := 0
   ENDIF

   nTotal := nPreco - nDesconto

   QOut("")
   QOut("========= Resumo da compra =========")
   QOut("Cliente  : " + cNome)
   QOut("Idade    : " + AllTrim(Str(nIdade, 3) + " anos"))
   QOut("Preco    : " + AllTrim(Str(nPreco, 10, 2)))
   QOut("Desconto : " + AllTrim(Str(nDesconto, 10, 2)))
   QOut("Total    : " + AllTrim(Str(nTotal, 10, 2)))
   QOut("=====================================")

RETURN NIL
