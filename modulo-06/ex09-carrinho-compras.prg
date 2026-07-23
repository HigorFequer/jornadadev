// ex09-carrinho-compras.prg
// Mini carrinho de compras - array de itens { nome, preco }

PROCEDURE Main()
   LOCAL aCarrinho := {}
   LOCAL cNome, cPreco, cContinuar
   LOCAL lContinuar := .T.
   LOCAL nI, nTotal := 0

   CLS
   ? "=== MINI CARRINHO DE COMPRAS ==="

   DO WHILE lContinuar
      ? ""
      cNome := Space( 30 )
      ? "Nome do produto: "
      @ Row(), Col() SAY "" GET cNome
      READ

      cPreco := Space( 10 )
      ? "Preco: "
      @ Row(), Col() SAY "" GET cPreco
      READ

      AAdd( aCarrinho, { AllTrim( cNome ), Val( AllTrim( cPreco ) ) } )

      cContinuar := Space( 1 )
      ? "Adicionar outro item? (S/N)"
      @ Row(), Col() SAY "" GET cContinuar
      READ

      lContinuar := ( Upper( AllTrim( cContinuar ) ) == "S" )
   ENDDO

   ? ""
   ? "=== ITENS DO CARRINHO ==="
   FOR nI := 1 TO Len( aCarrinho )
      ? aCarrinho[ nI ][ 1 ] + " - R$ " + Str( aCarrinho[ nI ][ 2 ], 10, 2 )
      nTotal += aCarrinho[ nI ][ 2 ]
   NEXT

   ? ""
   ? "TOTAL: R$ " + Str( nTotal, 10, 2 )

   ? ""
   ? "Pressione qualquer tecla para sair..."
   Inkey( 0 )

   RETURN
