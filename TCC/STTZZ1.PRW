#Include "Protheus.ch"

/*/{Protheus.doc} STTZZ1
Rotina de manutencao do Controle de Fornecimento (ZZ1).

Exibe a situacao do certificado por cores e permite abrir somente as
ocorrencias relacionadas ao controle selecionado.

@type  User Function
@since 06/08/2026
/*/
User Function STTZZ1()
    Local aArea   := GetArea()
    Local aColors := {;
        {"ZZ1->ZZ1_VALCER < dDataBase",      "BR_VERMELHO"},;
        {"ZZ1->ZZ1_VALCER <= dDataBase + 30", "BR_AMARELO"},;
        {".T.",                               "BR_VERDE"};
    }

    Private cCadastro := "Controle ISO 9001 - Fornecimentos"
    Private aRotina   := {;
        {"Pesquisar",   "AxPesqui",     0, 1},;
        {"Visualizar",  "AxVisual",     0, 2},;
        {"Incluir",     "U_STTZZ1INC",  0, 3},;
        {"Alterar",     "U_STTZZ1ALT",  0, 4},;
        {"Excluir",     "U_STTZZ1DEL",  0, 5},;
        {"Ocorrencias", "U_STTZZ1OCO",  0, 6};
    }

    DbSelectArea("ZZ1")
    DbSetOrder(1)

    // Ordem das regras: vencido, vence em ate 30 dias e certificado regular.
    mBrowse(1, 1, 22, 75, "ZZ1", , , , , , aColors, , , , , .F., , , "")

    RestArea(aArea)
Return Nil

/*/{Protheus.doc} STTZZ1INC
Inclui um controle ZZ1 usando a manutencao padrao protegida contra erros.
/*/
User Function STTZZ1INC()
Return ExecutaZZ1("I")

/*/{Protheus.doc} STTZZ1ALT
Altera o controle ZZ1 selecionado.
/*/
User Function STTZZ1ALT()
Return ExecutaZZ1("A")

/*/{Protheus.doc} STTZZ1DEL
Exclui um controle apenas quando nao existem ocorrencias ZZ2 vinculadas.
/*/
User Function STTZZ1DEL()
    Local cCodigo := ""

    If ZZ1->(Eof())
        MsgInfo("Selecione um controle de fornecimento.", "Controle ISO 9001")
        Return .F.
    EndIf

    cCodigo := ZZ1->ZZ1_CODIGO

    If U_ControleTemOcorrencia(cCodigo)
        MsgAlert("Este controle possui ocorrencias vinculadas na ZZ2." + CRLF + ;
            "Exclua as ocorrencias antes de excluir o controle.", ;
            "Exclusao nao permitida")
        Return .F.
    EndIf
Return ExecutaZZ1("E")

/*/{Protheus.doc} STTZZ1OCO
Abre a rotina ZZ2 filtrada pelo codigo do controle selecionado.
/*/
User Function STTZZ1OCO()
    If ZZ1->(Eof())
        MsgInfo("Selecione um controle de fornecimento.", "Controle ISO 9001")
        Return Nil
    EndIf

    U_STTZZ2FLT(ZZ1->ZZ1_CODIGO)
Return Nil

/*/{Protheus.doc} STTZZ1FOR
Validacao SX3: o fornecedor e a loja devem existir na SA2.
/*/
User Function STTZZ1FOR()
    Local aArea   := GetArea()
    Local lValido := .F.
    Local cChave  := ""

    If Empty(M->ZZ1_FORNEC) .Or. Empty(M->ZZ1_LOJAFO)
        MsgAlert("Informe o fornecedor e a loja.", "Validacao do fornecedor")
        RestArea(aArea)
        Return .F.
    EndIf

    cChave  := xFilial("SA2") + M->ZZ1_FORNEC + M->ZZ1_LOJAFO
    lValido := ExistCpo("SA2", cChave, 1)

    If !lValido
        MsgAlert("Fornecedor/loja nao encontrado no cadastro SA2.", ;
            "Validacao do fornecedor")
    EndIf

    RestArea(aArea)
Return lValido

/*/{Protheus.doc} STTZZ1CER
Validacao SX3: na inclusao, a validade nao pode ser anterior a data-base.
/*/
User Function STTZZ1CER()
    Local lValido := !Empty(M->ZZ1_VALCER)

    If lValido .And. INCLUI
        lValido := M->ZZ1_VALCER >= dDataBase
    EndIf

    If !lValido
        MsgAlert("A validade do certificado deve ser igual ou posterior a data atual.", ;
            "Validade invalida")
    EndIf
Return lValido

/*/{Protheus.doc} STTZZ1TOL
Validacao SX3: a tolerancia deve estar entre zero e cem por cento.
/*/
User Function STTZZ1TOL()
    Local lValido := M->ZZ1_TOLERA >= 0 .And. M->ZZ1_TOLERA <= 100

    If !lValido
        MsgAlert("A tolerancia deve estar entre 0 e 100.", "Tolerancia invalida")
    EndIf
Return lValido

/*/{Protheus.doc} ExecutaZZ1
Centraliza o tratamento de erros das operacoes padrao da mBrowse.

AxInclui, AxAltera e AxDeleta cuidam da transacao de persistencia. Por isso,
esta funcao nao abre uma transacao externa ao formulario interativo.
/*/
Static Function ExecutaZZ1(cAcao)
    Local lSucesso      := .T.
    Local oErro         := Nil
    Local bErroAnterior := ErrorBlock({|oFalha| Break(oFalha)})
    Local cFuncao       := "STTZZ1/" + cAcao

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
            MsgStop("Operacao de manutencao desconhecida.", "Controle ISO 9001")
        EndCase
    RECOVER USING oErro
        lSucesso := .F.
        U_GravarLogTCC(cFuncao, oErro)
        MsgStop("Nao foi possivel concluir a operacao no controle de fornecimento." + ;
            CRLF + "Nenhum dado deve ser considerado confirmado.", ;
            "Erro na gravacao")
    END SEQUENCE

    ErrorBlock(bErroAnterior)
Return lSucesso
