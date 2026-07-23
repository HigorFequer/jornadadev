// ex03-calculadora-refatorada.prg
// Calculadora refatorada em funcoes pequenas

PROCEDURE Main()
   LOCAL nA, nB, cOp, uResultado
   LOCAL lContinuar := .T.

   DO WHILE lContinuar
      CLS
      ? "=== CALCULADORA ==="
      nA  := LerNumero( "Digite o primeiro numero: " )
      nB  := LerNumero( "Digite o segundo numero: " )
      cOp := LerOperacao()

      uResultado := Calcular( nA, nB, cOp )

      MostrarResultado( nA, nB, cOp, uResultado )

      ? ""
      ? "Deseja calcular novamente? (S/N)"
      lContinuar := ( Upper( ReadInput() ) == "S" )
   ENDDO

   ? "Encerrando a calculadora..."

   RETURN

// Le e valida um numero digitado pelo usuario
FUNCTION LerNumero( cMsg )
   LOCAL cTexto

   ? cMsg
   cTexto := ReadInput()

   RETURN Val( cTexto )

// Le a operacao desejada (+, -, *, /)
FUNCTION LerOperacao()
   LOCAL cOp

   ? "Escolha a operacao (+, -, *, /): "
   cOp := ReadInput()

   RETURN AllTrim( cOp )

// Calcula o resultado; devolve .F. se houver divisao por zero
FUNCTION Calcular( nA, nB, cOp )
   LOCAL uResultado

   DO CASE
      CASE cOp == "+"
         uResultado := nA + nB
      CASE cOp == "-"
         uResultado := nA - nB
      CASE cOp == "*"
         uResultado := nA * nB
      CASE cOp == "/"
         IF nB == 0
            uResultado := .F.
         ELSE
            uResultado := nA / nB
         ENDIF
      OTHERWISE
         uResultado := NIL
   ENDCASE

   RETURN uResultado

// Exibe o resultado formatado (ou o erro de divisao por zero)
PROCEDURE MostrarResultado( nA, nB, cOp, uResultado )
   ? ""
   IF uResultado == NIL
      ? "Operacao invalida: " + cOp
   ELSEIF ValType( uResultado ) == "L" .AND. uResultado == .F.
      ? "Erro: divisao por zero nao e permitida."
   ELSE
      ? Str( nA ) + " " + cOp + " " + Str( nB ) + " = " + Str( uResultado )
   ENDIF
   RETURN

// Funcao auxiliar simples de leitura de teclado (linha unica)
FUNCTION ReadInput()
   LOCAL cVar := Space( 30 )
   @ Row(), Col() SAY "" GET cVar
   READ
   RETURN AllTrim( cVar )
