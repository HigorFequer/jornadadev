#Include "Protheus.ch"
#Include "FileIO.ch"

/*/{Protheus.doc} NomeFornecedor
Retorna o nome do fornecedor cadastrado na SA2.

@param cFornec, Character, codigo do fornecedor
@param cLoja,   Character, loja do fornecedor
@return Character, nome do fornecedor ou vazio quando nao localizado
@since 06/08/2026
/*/
User Function NomeFornecedor(cFornec, cLoja)
    Local aArea   := GetArea()
    Local cCodigo := PadCampo(cFornec, "A2_COD", 6)
    Local cLojaSA2 := PadCampo(cLoja, "A2_LOJA", 2)
    Local uNome   := ""
    Local cNome   := ""
    Local oErro   := Nil
    Local bErroAnterior := ErrorBlock({|oFalha| Break(oFalha)})

    BEGIN SEQUENCE
        If !Empty(AllTrim(cCodigo)) .And. !Empty(AllTrim(cLojaSA2))
            uNome := Posicione("SA2", 1, ;
                xFilial("SA2") + cCodigo + cLojaSA2, "A2_NOME")

            If ValType(uNome) == "C"
                cNome := AllTrim(uNome)
            EndIf
        EndIf
    RECOVER USING oErro
        U_GravarLogTCC("NomeFornecedor", oErro)
    END SEQUENCE

    ErrorBlock(bErroAnterior)
    RestArea(aArea)
Return cNome

/*/{Protheus.doc} NomeProduto
Retorna a descricao do produto cadastrado na SB1.

@param cCodPro, Character, codigo do produto
@return Character, descricao do produto ou vazio quando nao localizado
/*/
User Function NomeProduto(cCodPro)
    Local aArea   := GetArea()
    Local cCodigo := PadCampo(cCodPro, "B1_COD", 15)
    Local uNome   := ""
    Local cNome   := ""
    Local oErro   := Nil
    Local bErroAnterior := ErrorBlock({|oFalha| Break(oFalha)})

    BEGIN SEQUENCE
        If !Empty(AllTrim(cCodigo))
            uNome := Posicione("SB1", 1, ;
                xFilial("SB1") + cCodigo, "B1_DESC")

            If ValType(uNome) == "C"
                cNome := AllTrim(uNome)
            EndIf
        EndIf
    RECOVER USING oErro
        U_GravarLogTCC("NomeProduto", oErro)
    END SEQUENCE

    ErrorBlock(bErroAnterior)
    RestArea(aArea)
Return cNome

/*/{Protheus.doc} PercNaoConforme
Calcula o percentual de itens nao conformes sobre o total inspecionado.
Valores negativos ou parametros de outro tipo sao tratados como zero.

@param nOk,  Numeric, quantidade conforme
@param nNok, Numeric, quantidade nao conforme
@return Numeric, percentual entre 0 e 100 com duas casas decimais
/*/
User Function PercNaoConforme(nOk, nNok)
    Local nConforme    := 0
    Local nNaoConforme := 0
    Local nTotal       := 0

    If ValType(nOk) == "N"
        nConforme := Max(0, nOk)
    EndIf

    If ValType(nNok) == "N"
        nNaoConforme := Max(0, nNok)
    EndIf

    nTotal := nConforme + nNaoConforme

    If nTotal <= 0
        Return 0
    EndIf
Return Round((nNaoConforme / nTotal) * 100, 2)

/*/{Protheus.doc} CertificadoVencendo
Informa se um certificado valido vence entre a data-base e os proximos
30 dias. Certificados ja vencidos nao sao classificados como "vencendo".

@param dValCer, Date, validade do certificado
@return Logical, verdadeiro quando estiver na janela de vencimento
/*/
User Function CertificadoVencendo(dValCer)
    If ValType(dValCer) != "D" .Or. Empty(dValCer)
        Return .F.
    EndIf
Return dValCer >= dDataBase .And. dValCer <= (dDataBase + 30)

/*/{Protheus.doc} ToleranciaControle
Busca na ZZ1 a tolerancia do controle informado, preservando a area atual.

@param cCodigoZZ1, Character, codigo do controle de fornecimento
@return Numeric, tolerancia cadastrada ou zero quando nao localizada
/*/
User Function ToleranciaControle(cCodigoZZ1)
    Local aArea   := GetArea()
    Local cCodigo := PadCampo(cCodigoZZ1, "ZZ1_CODIGO", 6)
    Local uValor  := 0
    Local nValor  := 0
    Local oErro   := Nil
    Local bErroAnterior := ErrorBlock({|oFalha| Break(oFalha)})

    BEGIN SEQUENCE
        If !Empty(AllTrim(cCodigo))
            uValor := Posicione("ZZ1", 1, ;
                xFilial("ZZ1") + cCodigo, "ZZ1_TOLERA")

            If ValType(uValor) == "N"
                nValor := Max(0, Min(100, uValor))
            EndIf
        EndIf
    RECOVER USING oErro
        U_GravarLogTCC("ToleranciaControle", oErro)
    END SEQUENCE

    ErrorBlock(bErroAnterior)
    RestArea(aArea)
Return nValor

/*/{Protheus.doc} ControleTemOcorrencia
Verifica a existencia de uma ZZ2 vinculada ao controle ZZ1. A busca usa o
prefixo do indice 1 da ZZ2 (filial + controle) e preserva a area corrente.

@param cCodigoZZ1, Character, codigo do controle de fornecimento
@return Logical, verdadeiro quando existir ao menos uma ocorrencia
/*/
User Function ControleTemOcorrencia(cCodigoZZ1)
    Local aArea   := GetArea()
    Local cCodigo := PadCampo(cCodigoZZ1, "ZZ1_CODIGO", 6)
    Local lExiste := .F.
    Local oErro   := Nil
    Local bErroAnterior := ErrorBlock({|oFalha| Break(oFalha)})

    BEGIN SEQUENCE
        If !Empty(AllTrim(cCodigo))
            lExiste := ExistCpo("ZZ2", xFilial("ZZ2") + cCodigo, 1)
        EndIf
    RECOVER USING oErro
        // Falha fechada: se nao foi possivel consultar a ZZ2, a exclusao da
        // ZZ1 deve permanecer bloqueada para preservar a integridade.
        lExiste := .T.
        U_GravarLogTCC("ControleTemOcorrencia", oErro)
        MsgStop("Nao foi possivel verificar as ocorrencias vinculadas." + CRLF + ;
            "A exclusao foi bloqueada por seguranca.", "Validacao de integridade")
    END SEQUENCE

    ErrorBlock(bErroAnterior)
    RestArea(aArea)
Return lExiste

/*/{Protheus.doc} TextoErro
Converte um erro capturado por RECOVER em texto tecnico para o arquivo de log.

@param oErro, Variant, objeto de erro, texto ou outro valor recuperado
@return Character, descricao segura para registro tecnico
/*/
User Function TextoErro(oErro)
    Local cTexto      := ""
    Local cDescricao  := ""
    Local cOperacao   := ""
    Local oFalhaTexto := Nil
    Local bErroAnterior := ErrorBlock({|oFalha| Break(oFalha)})

    Do Case
    Case ValType(oErro) == "O"
        // Description e Operation pertencem a ErrorClass. A leitura ainda e
        // protegida para aceitar objetos recebidos de integracoes legadas.
        BEGIN SEQUENCE
            cDescricao := AllTrim(cValToChar(oErro:Description))
            cOperacao  := AllTrim(cValToChar(oErro:Operation))
        RECOVER USING oFalhaTexto
            cDescricao := "Objeto de erro sem propriedades compativeis"
            cOperacao  := ""
        END SEQUENCE

        cTexto := If(Empty(cDescricao), "Erro ADVPL sem descricao", cDescricao)

        If !Empty(cOperacao)
            cTexto += " | Operacao: " + cOperacao
        EndIf

    Case ValType(oErro) == "C"
        cTexto := AllTrim(oErro)

    Case ValType(oErro) == "U"
        cTexto := "Erro nao informado"

    Otherwise
        cTexto := AllTrim(cValToChar(oErro))
    EndCase

    ErrorBlock(bErroAnterior)

    If Empty(cTexto)
        cTexto := "Erro sem detalhes tecnicos"
    EndIf
Return cTexto

/*/{Protheus.doc} GravarLogTCC
Grava uma linha de log no servidor sem expor detalhes tecnicos ao usuario.
Caso a pasta padrao de logs nao esteja disponivel, tenta gravar na raiz do
StartPath e, se ainda falhar, envia a linha ao console do AppServer.

@param cFuncao, Character, rotina em que ocorreu a falha
@param oErro,   Variant, erro capturado pelo RECOVER
@return Logical, verdadeiro quando a linha foi persistida em arquivo
/*/
User Function GravarLogTCC(cFuncao, oErro)
    Local cRotina     := "FUNCAO NAO INFORMADA"
    Local cNomeArq    := "tcc_iso_" + DToS(Date()) + ".log"
    Local cArquivo    := "\logs\" + cNomeArq
    Local cAlternativo := "\" + cNomeArq
    Local cLinha      := ""
    Local nHandle     := -1
    Local lGravou     := .F.

    If ValType(cFuncao) == "C"
        If !Empty(AllTrim(cFuncao))
            cRotina := AllTrim(cFuncao)
        EndIf
    EndIf

    cLinha := DToS(Date()) + " " + Time() + " | " + cRotina + " | " + ;
        U_TextoErro(oErro)

    nHandle := FOpen(cArquivo, FO_READWRITE + FO_SHARED)
    If nHandle < 0
        nHandle := FCreate(cArquivo)
    EndIf

    If nHandle < 0
        cArquivo := cAlternativo
        nHandle := FOpen(cArquivo, FO_READWRITE + FO_SHARED)
        If nHandle < 0
            nHandle := FCreate(cArquivo)
        EndIf
    EndIf

    If nHandle >= 0
        FSeek(nHandle, 0, FS_END)
        lGravou := FWrite(nHandle, cLinha + CRLF) > 0
        FClose(nHandle)
    Else
        ConOut("TCC ISO | Falha ao gravar log | " + cLinha)
    EndIf
Return lGravou

/*/{Protheus.doc} PadCampo
Normaliza uma chave conforme o tamanho definido no SX3. O tamanho informado
como alternativa corresponde ao layout oficial do TCC e so e usado quando o
dicionario ainda nao estiver carregado.
/*/
Static Function PadCampo(uValor, cCampo, nAlternativo)
    Local aTamanho  := {}
    Local cValor    := ""
    Local nTamanho  := nAlternativo
    Local oFalhaSX3 := Nil
    Local bErroAnterior := ErrorBlock({|oFalha| Break(oFalha)})

    // Permite usar a biblioteca durante a implantacao, antes da importacao
    // completa do dicionario. Nesse caso prevalece o layout oficial do TCC.
    BEGIN SEQUENCE
        aTamanho := TamSX3(cCampo)
    RECOVER USING oFalhaSX3
        aTamanho := {}
    END SEQUENCE

    ErrorBlock(bErroAnterior)

    If ValType(uValor) == "C"
        cValor := AllTrim(uValor)
    ElseIf ValType(uValor) != "U"
        cValor := AllTrim(cValToChar(uValor))
    EndIf

    If ValType(aTamanho) == "A"
        If Len(aTamanho) >= 1
            If ValType(aTamanho[1]) == "N"
                If aTamanho[1] > 0
                    nTamanho := aTamanho[1]
                EndIf
            EndIf
        EndIf
    EndIf
Return PadR(Left(cValor, nTamanho), nTamanho)
