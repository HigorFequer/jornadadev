REQUEST HB_CODEPAGE_PT850
REQUEST HB_LANG_PT

FUNCTION Main()
    //O comando LOCAL cria variáveis para guardar textos
    LOCAL cNome   := "Higor Fequer Lima"
    LOCAL cCidade := "São Paulo"
    LOCAL cFrase  := "Pronta para aprender ADVPL!"

    //Comandos executáveis de configuração
    hb_cdpSelect( "PT850" )
    hb_langSelect( "PT" )
    
    //Estou fazendo duas formas diferentes de mostrar o conteúdo das variáveis na tela
    QOut("Higor Fequer Lima - São Paulo - Pronto para aprender ADVPL!")

    QOut("Nome   : " + cNome)
    QOut("Cidade : " + cCidade)
    QOut(cFrase)     // Mostra o conteúdo completo da variável cFrase na tela
RETURN NIL