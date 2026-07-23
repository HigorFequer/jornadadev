// ex02-relogio-modular.prg
// Relogio digital modular - exibe HH:MM:SS por ~30 segundos

PROCEDURE Main()
   LOCAL nI

   CLS
   FOR nI := 1 TO 30
      ExibirHora( FormatarHora( ObterHora() ) )
      Inkey( 1 )      // espera ~1 segundo entre atualizacoes
   NEXT

   ? ""
   ? "Fim do relogio. Pressione qualquer tecla para sair..."
   Inkey( 0 )

   RETURN

// Retorna a hora atual em segundos decorridos desde a meia-noite
FUNCTION ObterHora()
   RETURN Seconds()

// Recebe os segundos e devolve a string formatada HH:MM:SS
FUNCTION FormatarHora( nSegundos )
   LOCAL nH, nM, nS

   nH := Int( nSegundos / 3600 )
   nM := Int( ( nSegundos % 3600 ) / 60 )
   nS := Int( nSegundos % 60 )

   RETURN StrZero( nH, 2 ) + ":" + StrZero( nM, 2 ) + ":" + StrZero( nS, 2 )

// Exibe a hora formatada na tela
PROCEDURE ExibirHora( cHora )
   CLS
   ? "=== RELOGIO DIGITAL ==="
   ? "Hora atual: " + cHora
   RETURN
