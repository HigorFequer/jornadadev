// Exercício 3 — Calculadora com DO CASE
// Suporta: +  -  *  /  ^ (potência)  R (raiz quadrada de nA)
// Trata divisão por zero e operação inválida.

FUNCTION Main()

   LOCAL cOp
   LOCAL nA
   LOCAL nB
   LOCAL nResultado
   LOCAL nTecla

   CLS

   QOut("===========================================")
   QOut("Calculadora com DO CASE                  ")
   QOut("Operações suportadas:                  ")
   QOut("Soma(+) Subtração(-) Multiplicação(*)")
   QOut("Divisão(/) Potência(^) Raiz Quadrada(R)")
   QOut("===========================================")

   QOut(" ")
   ACCEPT "Digite o primeiro valor: " TO nA
   ACCEPT "Digite a operação: " TO cOp
   ACCEPT "Digite o segundo valor : " TO nB

   nA := Val(nA)
   nB := Val(nB)
   cOp := Upper(cOp)

   QOut(" ")

   DO CASE
      CASE cOp == "+" 
         nResultado := nA + nB
         QOut("Resultado: " + AllTrim(Str(nResultado, 12, 2)))

      CASE cOp == "-"
         nResultado := nA - nB
         QOut("Resultado: " + AllTrim(Str(nResultado, 12, 2)))

      CASE cOp == "*"
         nResultado := nA * nB
         QOut("Resultado: " + AllTrim(Str(nResultado, 12, 2)))

      CASE cOp == "/"
         IF nA == 0  .OR. nB == 0
            QOut("Não é possível dividir por zero")
         ELSE
            nResultado := nA / nB
            QOut("Resultado: " + AllTrim(Str(nResultado, 12, 2)))
         ENDIF

      CASE cOp == "^"
         nResultado := nA ^ nB
         QOut("Resultado: " + AllTrim(Str(nResultado, 12, 2)))

      CASE cOp == "R"
         IF nA < 0
            QOut("Erro: não é possível calcular raiz quadrada de número negativo.")
         ELSE
            nResultado := Sqrt( nA )
            QOut("Resultado (raiz quadrada): " + AllTrim(Str(nResultado, 12, 4)))
         ENDIF

      OTHERWISE
         QOut("Operação inválida.")

   ENDCASE

   QOut(" ")
   QOut("Pressione 0 para repetir ou qualquer outra tecla para sair...")
   nTecla := Inkey(0)

   IF nTecla == 48 // ASCII para '0'
      Main() // Chama a função novamente para repetir
   ELSE
      QOut("Saindo da calculadora...")
   ENDIF

RETURN NIL