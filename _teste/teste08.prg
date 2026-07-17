FUNCTION Main()
   LOCAL cNome
   LOCAL nIdade
   LOCAL nValor1
   LOCAL nValor2

   // ACCEPT lê uma string
   ACCEPT "Digite seu nome: " TO cNome

   // INPUT lê um valor (número, string, data, lógico)
   INPUT "Digite sua idade: " TO nIdade

   INPUT "Digite o primeiro valor: " TO nValor1
   INPUT "Digite o segundo valor: " TO nValor2

   Soma := nValor1 + nValor2
   

   QOut("Olá, " + cNome + "!")
   QOut("Você tem " + Alltrim(Str(nIdade)) + " anos.")
   QOut("A soma dos valores é: " + Alltrim(Str(Soma)))
RETURN NIL