// Exercício 6 — Desafio: jogo "Adivinhe o número"
// O programa sorteia um número entre 1 e 100.
// O usuário tem 7 tentativas.
// A cada palpite errado, informa se o número secreto é maior ou menor.
// Ao acertar ou esgotar as tentativas, mostra o resultado e revela o número.

FUNCTION Main()

   LOCAL nSecreto
   LOCAL nI
   LOCAL nPalpite
   LOCAL lAcertou
   LOCAL nTecla

   nSecreto := HB_RandomInt(1, 100)
   lAcertou := .F.

   QOut("Adivinhe o número entre 1 e 100! Você tem 7 tentativas.")
   QOut(" ")

   FOR nI := 1 TO 7

      ACCEPT "Tentativa " + Str(nI, 2) + " - digite seu palpite: " TO nPalpite
      nPalpite := Val(nPalpite)

      IF nPalpite == nSecreto
         lAcertou := .T.
         EXIT
      ELSEIF nPalpite < nSecreto
         QOut("O número secreto é MAIOR que " + Str(nPalpite, 5))
      ELSE
         QOut("O número secreto é MENOR que " + Str(nPalpite, 5))
      ENDIF

      QOut(" ")

   NEXT

   QOut(" ")
   IF lAcertou
      QOut("Parabéns! Você acertou o número " + Str( nSecreto, 5 ) + "!")
   ELSE
      QOut("Suas tentativas acabaram. O número secreto era: " + Str(nSecreto, 5))
      QOut("            Tente novamente na próxima vez!")
      QOut("--- Não vale tentar adivinhar o número secreto olhando o código fonte! ---")
      QOut(" ")
   ENDIF

   QOut("Pressione 0 para repetir ou qualquer outra tecla para sair...")
   nTecla := Inkey(0)

   IF nTecla == 48 // ASCII para '0'

      QOut(" ")
      QOut("============================================================")
      QOut("      Reiniciando o jogo...")
      QOut("      Boa sorte na próxima tentativa!")
      QOut("============================================================")
      QOut(" ")
      Main() // Chama a função novamente para repetir

   ELSE
      QOut("Saindo da aplicação. Até a próxima!")
   ENDIF

   RETURN NIL
