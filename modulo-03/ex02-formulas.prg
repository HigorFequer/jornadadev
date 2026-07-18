// Exercicio 2 - Calculando com formulas
// Modulo 3 - Jornada DEV START

#define PI 3.14159

FUNCTION Main()

   LOCAL cEntrada
   LOCAL nRaio, nAreaCirculo
   LOCAL nCatA, nCatB, nHipotenusa
   LOCAL nPeso, nAltura, nIMC

   // a) Area do circulo = PI * r^2
   ACCEPT "Informe o raio do circulo: " TO cEntrada
   nRaio := Val(cEntrada)
   nAreaCirculo := PI * nRaio ^ 2
   QOut("Area do circulo .....: " + Str(nAreaCirculo, 10, 2))

   QOut("")

   // b) Hipotenusa = raiz(a^2 + b^2)
   ACCEPT "Informe o cateto A .......: " TO cEntrada
   nCatA := Val(cEntrada)
   ACCEPT "Informe o cateto B .......: " TO cEntrada
   nCatB := Val(cEntrada)
   nHipotenusa := Sqrt(nCatA ^ 2 + nCatB ^ 2)
   QOut("Hipotenusa ..........: " + Str(nHipotenusa, 10, 2))

   QOut("")

   // c) IMC = peso / altura^2
   ACCEPT "Informe o peso (kg) ......: " TO cEntrada
   nPeso := Val(cEntrada)
   ACCEPT "Informe a altura (m) .....: " TO cEntrada
   nAltura := Val(cEntrada)
   nIMC := nPeso / (nAltura ^ 2)
   QOut("IMC .................: " + Str(nIMC, 10, 2))

RETURN NIL
