// ex05-jokenpo-modular.prg
// Jokenpo (pedra, papel, tesoura) modular

PROCEDURE Main()
   LOCAL cJogadaCPU, cJogadaUser, cVencedor
   LOCAL lContinuar := .T.

   DO WHILE lContinuar
      CLS
      ? "=== JOKENPO ==="
      ? "Escolha: PEDRA, PAPEL ou TESOURA"

      cJogadaUser := ValidarJogada( LerEntrada() )

      DO WHILE cJogadaUser == NIL
         ? "Jogada invalida! Digite PEDRA, PAPEL ou TESOURA."
         cJogadaUser := ValidarJogada( LerEntrada() )
      ENDDO

      cJogadaCPU := SortearJogadaCPU()

      ? ""
      ? "Voce jogou: " + cJogadaUser
      ? "CPU jogou : " + cJogadaCPU

      cVencedor := DefinirVencedor( cJogadaUser, cJogadaCPU )

      ? ""
      ? cVencedor

      ? ""
      ? "Jogar novamente? (S/N)"
      lContinuar := ( Upper( LerEntrada() ) == "S" )
   ENDDO

   RETURN

// Sorteia a jogada do computador
FUNCTION SortearJogadaCPU()
   LOCAL aJogadas := { "PEDRA", "PAPEL", "TESOURA" }
   RETURN aJogadas[ hb_RandomInt( 1, 3 ) ]

// Valida a jogada digitada; devolve a jogada em maiusculas ou NIL se invalida
FUNCTION ValidarJogada( cJogada )
   LOCAL cJogadaUpper := Upper( AllTrim( cJogada ) )

   IF cJogadaUpper == "PEDRA" .OR. cJogadaUpper == "PAPEL" .OR. cJogadaUpper == "TESOURA"
      RETURN cJogadaUpper
   ENDIF

   RETURN NIL

// Compara as duas jogadas e devolve o texto do resultado
FUNCTION DefinirVencedor( cJogada1, cJogada2 )
   IF cJogada1 == cJogada2
      RETURN "Empate!"
   ENDIF

   IF ( cJogada1 == "PEDRA"    .AND. cJogada2 == "TESOURA" ) .OR. ;
      ( cJogada1 == "PAPEL"    .AND. cJogada2 == "PEDRA"   ) .OR. ;
      ( cJogada1 == "TESOURA"  .AND. cJogada2 == "PAPEL"   )
      RETURN "Voce venceu!"
   ENDIF

   RETURN "A CPU venceu!"

// Funcao auxiliar de leitura de teclado (linha unica)
FUNCTION LerEntrada()
   LOCAL cVar := Space( 20 )
   @ Row(), Col() SAY "" GET cVar
   READ
   RETURN AllTrim( cVar )
