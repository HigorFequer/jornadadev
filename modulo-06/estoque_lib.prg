// estoque_lib.prg
// Biblioteca com as operacoes de array do controle de estoque
// Cada produto e um item: { codigo, nome, quantidade, preco_unitario }

// Cadastra um novo produto no array (por referencia)
FUNCTION CadastrarProduto( aEstoque, nCodigo, cNome, nQtd, nPreco )
   IF BuscarProduto( aEstoque, nCodigo ) > 0
      ? "Ja existe um produto com esse codigo!"
      RETURN .F.
   ENDIF

   AAdd( aEstoque, { nCodigo, cNome, nQtd, nPreco } )
   ? "Produto cadastrado com sucesso!"

   RETURN .T.

// Lista todos os produtos cadastrados
PROCEDURE ListarProdutos( aEstoque )
   LOCAL nI

   IF Len( aEstoque ) == 0
      ? "Nenhum produto cadastrado."
      RETURN
   ENDIF

   ? "COD  NOME                  QTD    PRECO UNIT."
   ? "----------------------------------------------"
   FOR nI := 1 TO Len( aEstoque )
      ? Str( aEstoque[ nI ][ 1 ], 4 ) + " " + ;
        PadR( aEstoque[ nI ][ 2 ], 20 ) + " " + ;
        Str( aEstoque[ nI ][ 3 ], 5 ) + "  " + ;
        Str( aEstoque[ nI ][ 4 ], 10, 2 )
   NEXT

   RETURN

// Aumenta a quantidade de um produto (entrada de estoque)
FUNCTION EntradaEstoque( aEstoque, nCodigo, nQtd )
   LOCAL nPos := BuscarProduto( aEstoque, nCodigo )

   IF nPos == 0
      ? "Produto nao encontrado!"
      RETURN .F.
   ENDIF

   aEstoque[ nPos ][ 3 ] += nQtd
   ? "Entrada registrada com sucesso!"

   RETURN .T.

// Diminui a quantidade de um produto (saida de estoque), validando saldo
FUNCTION SaidaEstoque( aEstoque, nCodigo, nQtd )
   LOCAL nPos := BuscarProduto( aEstoque, nCodigo )

   IF nPos == 0
      ? "Produto nao encontrado!"
      RETURN .F.
   ENDIF

   IF aEstoque[ nPos ][ 3 ] < nQtd
      ? "Estoque insuficiente! Disponivel: " + Str( aEstoque[ nPos ][ 3 ] )
      RETURN .F.
   ENDIF

   aEstoque[ nPos ][ 3 ] -= nQtd
   ? "Saida registrada com sucesso!"

   RETURN .T.

// Busca um produto pelo codigo; devolve a posicao no array, ou 0 se nao achar
FUNCTION BuscarProduto( aEstoque, nCodigo )
   LOCAL nI

   FOR nI := 1 TO Len( aEstoque )
      IF aEstoque[ nI ][ 1 ] == nCodigo
         RETURN nI
      ENDIF
   NEXT

   RETURN 0

// Exibe o relatorio de valor em estoque (qtd x preco) por produto e o total geral
PROCEDURE RelatorioEstoque( aEstoque )
   LOCAL nI, nValorItem, nTotalGeral := 0

   IF Len( aEstoque ) == 0
      ? "Nenhum produto cadastrado."
      RETURN
   ENDIF

   ? "RELATORIO DE ESTOQUE"
   ? "----------------------------------------------"
   FOR nI := 1 TO Len( aEstoque )
      nValorItem := aEstoque[ nI ][ 3 ] * aEstoque[ nI ][ 4 ]
      ? PadR( aEstoque[ nI ][ 2 ], 20 ) + " - Valor: R$ " + Str( nValorItem, 12, 2 )
      nTotalGeral += nValorItem
   NEXT
   ? "----------------------------------------------"
   ? "TOTAL GERAL EM ESTOQUE: R$ " + Str( nTotalGeral, 12, 2 )

   RETURN
