// principal.prg
// Mini controle de estoque - integrador: funcoes + array de registros + loop
// Compilar junto com a biblioteca: hbmk2 principal.prg estoque_lib.prg

PROCEDURE Main()
   LOCAL aEstoque := {}
   LOCAL nOpcao := -1

   SET PROCEDURE TO estoque_lib.prg

   DO WHILE nOpcao != 0
      nOpcao := ExibirMenu()

      DO CASE
         CASE nOpcao == 1
            OpcaoCadastrar( aEstoque )
         CASE nOpcao == 2
            CLS
            ListarProdutos( aEstoque )
            Pausar()
         CASE nOpcao == 3
            OpcaoEntrada( aEstoque )
         CASE nOpcao == 4
            OpcaoSaida( aEstoque )
         CASE nOpcao == 5
            OpcaoBuscar( aEstoque )
         CASE nOpcao == 6
            CLS
            RelatorioEstoque( aEstoque )
            Pausar()
         CASE nOpcao == 0
            ? "Encerrando o sistema..."
         OTHERWISE
            ? "Opcao invalida!"
            Pausar()
      ENDCASE
   ENDDO

   RETURN

// Exibe o menu e devolve a opcao numerica escolhida
FUNCTION ExibirMenu()
   LOCAL cOpcao := Space( 2 )

   CLS
   ? "=== CONTROLE DE ESTOQUE ==="
   ? "1 - Cadastrar produto"
   ? "2 - Listar produtos"
   ? "3 - Entrada de estoque"
   ? "4 - Saida de estoque"
   ? "5 - Buscar produto por codigo"
   ? "6 - Relatorio de valor em estoque"
   ? "0 - Sair"
   ? ""
   ? "Escolha uma opcao: "
   @ Row(), Col() SAY "" GET cOpcao
   READ

   RETURN Val( AllTrim( cOpcao ) )

// Coleta os dados e chama CadastrarProduto
PROCEDURE OpcaoCadastrar( aEstoque )
   LOCAL cCodigo := Space( 6 )
   LOCAL cNome := Space( 30 )
   LOCAL cQtd := Space( 6 )
   LOCAL cPreco := Space( 10 )

   CLS
   ? "=== CADASTRAR PRODUTO ==="
   ? "Codigo: "
   @ Row(), Col() SAY "" GET cCodigo
   READ
   ? "Nome: "
   @ Row(), Col() SAY "" GET cNome
   READ
   ? "Quantidade inicial: "
   @ Row(), Col() SAY "" GET cQtd
   READ
   ? "Preco unitario: "
   @ Row(), Col() SAY "" GET cPreco
   READ

   CadastrarProduto( aEstoque, Val( AllTrim( cCodigo ) ), AllTrim( cNome ), ;
                      Val( AllTrim( cQtd ) ), Val( AllTrim( cPreco ) ) )
   Pausar()

   RETURN

// Coleta codigo e quantidade e chama EntradaEstoque
PROCEDURE OpcaoEntrada( aEstoque )
   LOCAL cCodigo := Space( 6 )
   LOCAL cQtd := Space( 6 )

   CLS
   ? "=== ENTRADA DE ESTOQUE ==="
   ? "Codigo do produto: "
   @ Row(), Col() SAY "" GET cCodigo
   READ
   ? "Quantidade a entrar: "
   @ Row(), Col() SAY "" GET cQtd
   READ

   EntradaEstoque( aEstoque, Val( AllTrim( cCodigo ) ), Val( AllTrim( cQtd ) ) )
   Pausar()

   RETURN

// Coleta codigo e quantidade e chama SaidaEstoque
PROCEDURE OpcaoSaida( aEstoque )
   LOCAL cCodigo := Space( 6 )
   LOCAL cQtd := Space( 6 )

   CLS
   ? "=== SAIDA DE ESTOQUE ==="
   ? "Codigo do produto: "
   @ Row(), Col() SAY "" GET cCodigo
   READ
   ? "Quantidade a sair: "
   @ Row(), Col() SAY "" GET cQtd
   READ

   SaidaEstoque( aEstoque, Val( AllTrim( cCodigo ) ), Val( AllTrim( cQtd ) ) )
   Pausar()

   RETURN

// Coleta o codigo e exibe a posicao/dados do produto encontrado
PROCEDURE OpcaoBuscar( aEstoque )
   LOCAL cCodigo := Space( 6 )
   LOCAL nPos

   CLS
   ? "=== BUSCAR PRODUTO ==="
   ? "Codigo do produto: "
   @ Row(), Col() SAY "" GET cCodigo
   READ

   nPos := BuscarProduto( aEstoque, Val( AllTrim( cCodigo ) ) )

   IF nPos == 0
      ? "Produto nao encontrado."
   ELSE
      ? "Encontrado na posicao " + Str( nPos ) + " do array:"
      ? "Nome : " + aEstoque[ nPos ][ 2 ]
      ? "Qtd  : " + Str( aEstoque[ nPos ][ 3 ] )
      ? "Preco: " + Str( aEstoque[ nPos ][ 4 ], 10, 2 )
   ENDIF

   Pausar()

   RETURN

// Pausa a execucao ate o usuario pressionar uma tecla
PROCEDURE Pausar()
   ? ""
   ? "Pressione qualquer tecla para continuar..."
   Inkey( 0 )
   RETURN
