// Exercicio 1 - Declarando com os prefixos certos
// Modulo 3 - Jornada DEV START

FUNCTION Main()

   LOCAL cNome     := "Higor Fequer"        // c = caractere (texto)
   LOCAL nSalario  := 3500.00              // n = numerico
   LOCAL lAtivo    := .T.                  // l = logico (.T. / .F.)
   LOCAL dAdmissao := STOD("20200715")     // d = data (STOD = string p/ data, formato AAAAMMDD)
   LOCAL cDepto    := "TI"                 // c = caractere

   QOut("Nome: " + cNome)
   QOut("Salario bruto: " + ALLTRIM(Str(nSalario, 10, 2)))
   QOut("Ativo: " + IIf(lAtivo, "Sim", "Nao"))
   QOut("Data admissao: " + DToC(dAdmissao))
   QOut("Departamento: " + cDepto)

RETURN NIL