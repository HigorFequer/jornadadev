#Include "Protheus.ch"

/*/{Protheus.doc} TCCAnaliseISO
Objeto de dominio para avaliar uma ocorrencia de fornecimento segundo a
tolerancia definida no controle ISO 9001 e a validade de seu certificado.

A classe concentra as regras de negocio e reutiliza STTZZLIB, evitando que as
rotinas de interface repitam os calculos de percentual e vencimento.
@since 06/08/2026
/*/
Class TCCAnaliseISO
    Data nQtdOk
    Data nQtdNok
    Data nTolerancia
    Data dValCertificado

    Method New(nQtdOk, nQtdNok, nTolerancia, dValCertificado)
    Method Validar()
    Method PercentualNC()
    Method DentroTolerancia()
    Method CertVencido()
    Method CertVencendo()
    Method SituacaoCertificado()
    Method SituacaoQualidade()
EndClass

/*/{Protheus.doc} New
Inicializa uma analise ISO com os dados da inspecao e do certificado.
/*/
Method New(nQtdOk, nQtdNok, nTolerancia, dValCertificado) Class TCCAnaliseISO
    ::nQtdOk            := nQtdOk
    ::nQtdNok           := nQtdNok
    ::nTolerancia       := nTolerancia
    ::dValCertificado   := dValCertificado
Return Self

/*/{Protheus.doc} Validar
Valida tipos, faixas e a existencia de uma quantidade total inspecionada.
/*/
Method Validar() Class TCCAnaliseISO
    If ValType(::nQtdOk) != "N" .Or. ValType(::nQtdNok) != "N"
        Return .F.
    EndIf

    If ::nQtdOk < 0 .Or. ::nQtdNok < 0 .Or. ;
        (::nQtdOk + ::nQtdNok) <= 0
        Return .F.
    EndIf

    If ValType(::nTolerancia) != "N"
        Return .F.
    EndIf

    If ::nTolerancia < 0 .Or. ::nTolerancia > 100
        Return .F.
    EndIf

    If ValType(::dValCertificado) != "D" .Or. Empty(::dValCertificado)
        Return .F.
    EndIf
Return .T.

/*/{Protheus.doc} PercentualNC
Retorna o percentual nao conforme da inspecao.
/*/
Method PercentualNC() Class TCCAnaliseISO
Return U_PercNaoConforme(::nQtdOk, ::nQtdNok)

/*/{Protheus.doc} DentroTolerancia
Compara o percentual nao conforme com a tolerancia do controle.
/*/
Method DentroTolerancia() Class TCCAnaliseISO
    If !::Validar()
        Return .F.
    EndIf
Return ::PercentualNC() <= ::nTolerancia

/*/{Protheus.doc} CertVencido
Informa se a validade e anterior a data-base do Protheus.
/*/
Method CertVencido() Class TCCAnaliseISO
    If ValType(::dValCertificado) != "D" .Or. Empty(::dValCertificado)
        Return .F.
    EndIf
Return ::dValCertificado < dDataBase

/*/{Protheus.doc} CertVencendo
Delega para a regra unica da biblioteca a janela de 30 dias.
/*/
Method CertVencendo() Class TCCAnaliseISO
Return U_CertificadoVencendo(::dValCertificado)

/*/{Protheus.doc} SituacaoCertificado
Retorna uma descricao simples para telas, relatorios e logs.
/*/
Method SituacaoCertificado() Class TCCAnaliseISO
    If ValType(::dValCertificado) != "D" .Or. Empty(::dValCertificado)
        Return "DATA INVALIDA"
    EndIf

    If ::CertVencido()
        Return "VENCIDO"
    EndIf

    If ::CertVencendo()
        Return "VENCE EM ATE 30 DIAS"
    EndIf
Return "VALIDO"

/*/{Protheus.doc} SituacaoQualidade
Retorna a classificacao da ocorrencia frente a tolerancia configurada.
/*/
Method SituacaoQualidade() Class TCCAnaliseISO
    If !::Validar()
        Return "DADOS INVALIDOS"
    EndIf

    If ::DentroTolerancia()
        Return "DENTRO DA TOLERANCIA"
    EndIf
Return "ACIMA DA TOLERANCIA"

/*/{Protheus.doc} STTISO
Fabrica publica para criar a analise a partir de outras rotinas ADVPL.

@return Object, instancia de TCCAnaliseISO
/*/
User Function STTISO(nQtdOk, nQtdNok, nTolerancia, dValCertificado)
Return TCCAnaliseISO():New(nQtdOk, nQtdNok, nTolerancia, dValCertificado)
