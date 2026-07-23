// principal.prg
// Testa as funcoes da biblioteca matematica.prg
// Compilar os dois arquivos juntos: hbmk2 principal.prg matematica.prg

PROCEDURE Main()

   SET PROCEDURE TO matematica.prg

   CLS
   ? "=== TESTE DA BIBLIOTECA MATEMATICA ==="
   ? ""
   ? "FatorialN(5)  = " + Str( FatorialN( 5 ) )     // esperado: 120
   ? "EhPrimo(7)    = " + IIf( EhPrimo( 7 ), "Sim", "Nao" )   // esperado: Sim
   ? "EhPrimo(10)   = " + IIf( EhPrimo( 10 ), "Sim", "Nao" )  // esperado: Nao
   ? "MDC(24, 36)   = " + Str( MDC( 24, 36 ) )      // esperado: 12
   ? "MMC(4, 6)     = " + Str( MMC( 4, 6 ) )        // esperado: 12

   ? ""
   ? "Pressione qualquer tecla para sair..."
   Inkey( 0 )

   RETURN
