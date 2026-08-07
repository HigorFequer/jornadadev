#Include "Protheus.ch"

Static cControleFiltro := ""

/*/{Protheus.doc} STTZZ2
Rotina de manutencao das ocorrencias de fornecedores (ZZ2).
/*/
User Function STTZZ2()
    cControleFiltro := ""
    AbreBrowseZZ2("")
Return Nil

/*/{Protheus.doc} STTZZ2FLT
Abre a ZZ2 exibindo somente as ocorrencias do controle ZZ1 informado.

@param cCodigoZZ1, Character, codigo do controle de fornecimento
/*/
User Function STTZZ2FLT(cCodigoZZ1)
    Local cCodigo := ""

    Default cCodigoZZ1 := ""
    cCodigo := StrTran(AllTrim(cCodigoZZ1), "'", "")

    If Empty(cCodigo)
        MsgAlert("Codigo do controle nao informado.", "Ocorrencias")
        Return Nil
    EndIf

    cControleFiltro := PadR(cCodigo, 6)
    AbreBrowseZZ2("ZZ2->ZZ2_CONFOR == '" + cControleFiltro + "'")
Return Nil

/*/{Protheus.doc} STTZZ2DEF
Inicializador SX3 do campo ZZ2_CONFOR quando a inclusao parte da ZZ1.
/*/
User Function STTZZ2DEF()
Return cControleFiltro

/*/{Protheus.doc} STTZZ2INC
Inclui uma ocorrencia usando a manutencao padrao protegida contra erros.
/*/
User Function STTZZ2INC()
Return ExecutaZZ2("I")

/*/{Protheus.doc} STTZZ2ALT
Altera a ocorrencia selecionada.
/*/
User Function STTZZ2ALT()
Return ExecutaZZ2("A")

/*/{Protheus.doc} STTZZ2DEL
Exclui a ocorrencia selecionada.
/*/
User Function STTZZ2DEL()
Return ExecutaZZ2("E")

/*/{Protheus.doc} STTZZ2CTL
Validacao SX3: o controle de fornecimento deve existir na ZZ1.
/*/
User Function STTZZ2CTL()
    Local aArea   := GetArea()
    Local lValido := .F.
    Local cChave  := ""

    If Empty(M->ZZ2_CONFOR)
        MsgAlert("Informe o codigo do controle de fornecimento.", ;
            "Validacao do controle")
        RestArea(aArea)
        Return .F.
    EndIf

    cChave  := xFilial("ZZ1") + M->ZZ2_CONFOR
    lValido := ExistCpo("ZZ1", cChave, 1)

    If !lValido
        MsgAlert("Controle de fornecimento nao encontrado na ZZ1.", ;
            "Validacao do controle")
    EndIf

    RestArea(aArea)
Return lValido

/*/{Protheus.doc} STTZZ2PRO
Validacao SX3: o produto deve existir na SB1.
/*/
User Function STTZZ2PRO()
    Local aArea   := GetArea()
    Local lValido := .F.
    Local cChave  := ""

    If Empty(M->ZZ2_CODPRO)
        MsgAlert("Informe o produto.", "Validacao do produto")
        RestArea(aArea)
        Return .F.
    EndIf

    cChave  := xFilial("SB1") + M->ZZ2_CODPRO
    lValido := ExistCpo("SB1", cChave, 1)

    If !lValido
        MsgAlert("Produto nao encontrado no cadastro SB1.", "Validacao do produto")
    EndIf

    RestArea(aArea)
Return lValido

/*/{Protheus.doc} STTZZ2DAT
Validacao SX3: a data da ocorrencia nao pode ser futura.
/*/
User Function STTZZ2DAT()
    Local lValido := !Empty(M->ZZ2_DATA) .And. M->ZZ2_DATA <= dDataBase

    If !lValido
        MsgAlert("A data da ocorrencia nao pode ser futura.", "Data invalida")
    EndIf
Return lValido

/*/{Protheus.doc} STTZZ2QTD
Validacao SX3: quantidades nao negativas e ao menos uma unidade informada.
/*/
User Function STTZZ2QTD()
    Local lValido := M->ZZ2_QTDOK >= 0 .And. M->ZZ2_QTDNOK >= 0 .And. ;
        (M->ZZ2_QTDOK + M->ZZ2_QTDNOK) > 0

    If !lValido
        MsgAlert("Informe quantidades nao negativas e pelo menos uma unidade.", ;
            "Quantidades invalidas")
    EndIf
Return lValido

/*/{Protheus.doc} STTZZ2VLR
Validacao SX3: o valor unitario nao pode ser negativo.
/*/
User Function STTZZ2VLR()
    Local lValido := M->ZZ2_VLRUNI >= 0

    If !lValido
        MsgAlert("O valor unitario nao pode ser negativo.", "Valor invalido")
    EndIf
Return lValido

/*/{Protheus.doc} STTZZ2FORA
Regra de legenda: retorna verdadeiro quando o percentual nao conforme supera
a tolerancia cadastrada no controle ZZ1 relacionado.
/*/
User Function STTZZ2FORA()
    Local nPercentual := 0
    Local nTolerancia := 0

    If ZZ2->(Eof())
        Return .F.
    EndIf

    nPercentual := U_PercNaoConforme(ZZ2->ZZ2_QTDOK, ZZ2->ZZ2_QTDNOK)
    nTolerancia := U_ToleranciaControle(ZZ2->ZZ2_CONFOR)
Return nPercentual > nTolerancia

/*/{Protheus.doc} AbreBrowseZZ2
Prepara a mBrowse geral ou filtrada da ZZ2.
/*/
Static Function AbreBrowseZZ2(cFiltro)
    Local aArea   := GetArea()
    Local aColors := {;
        {"U_STTZZ2FORA()", "BR_VERMELHO"},;
        {".T.",             "BR_VERDE"};
    }

    Private cCadastro := If(Empty(cControleFiltro), ;
        "Ocorrencias de Fornecedores", ;
        "Ocorrencias do controle " + AllTrim(cControleFiltro))
    Private aRotina   := {;
        {"Pesquisar",  "AxPesqui",    0, 1},;
        {"Visualizar", "AxVisual",    0, 2},;
        {"Incluir",    "U_STTZZ2INC", 0, 3},;
        {"Alterar",    "U_STTZZ2ALT", 0, 4},;
        {"Excluir",    "U_STTZZ2DEL", 0, 5};
    }

    DbSelectArea("ZZ2")
    DbSetOrder(1)
    mBrowse(1, 1, 22, 75, "ZZ2", , , , , , aColors, , , , , .F., , , cFiltro)

    RestArea(aArea)
Return Nil

/*/{Protheus.doc} ExecutaZZ2
Centraliza o tratamento de erros das operacoes padrao da mBrowse.

As funcoes Ax* administram a transacao de persistencia do formulario. Evita-se
abrir uma transacao externa durante toda a interacao com o usuario.
/*/
Static Function ExecutaZZ2(cAcao)
    Local lSucesso      := .T.
    Local oErro         := Nil
    Local bErroAnterior := ErrorBlock({|oFalha| Break(oFalha)})
    Local cFuncao       := "STTZZ2/" + cAcao

    BEGIN SEQUENCE
        Do Case
        Case cAcao == "I"
            AxInclui()
        Case cAcao == "A"
            AxAltera()
        Case cAcao == "E"
            AxDeleta()
        Otherwise
            lSucesso := .F.
            MsgStop("Operacao de manutencao desconhecida.", "Ocorrencias")
        EndCase
    RECOVER USING oErro
        lSucesso := .F.
        U_GravarLogTCC(cFuncao, oErro)
        MsgStop("Nao foi possivel concluir a operacao na ocorrencia." + CRLF + ;
            "Nenhum dado deve ser considerado confirmado.", "Erro na gravacao")
    END SEQUENCE

    ErrorBlock(bErroAnterior)
Return lSucesso
