#include "protheus.ch"

User Function STCEP(cCEP, cRetorno)
    Local aTabela := aTabCEP()
    Local cLimpo := ""
    Local cRet := ""
    Local nPos := 0

    Default cCEP := ""
    Default cRetorno := "BAIRRO"
    cLimpo := StrTran(StrTran(AllTrim(cCEP), "-", ""), ".", "")
    nPos := aScan(aTabela, {|aLinha| aLinha[1] == cLimpo})

    If nPos > 0
        Do Case
        Case Upper(AllTrim(cRetorno)) == "BAIRRO"
            cRet := aTabela[nPos][2]
        Case Upper(AllTrim(cRetorno)) == "CIDADE"
            cRet := aTabela[nPos][3]
        Case Upper(AllTrim(cRetorno)) == "UF"
            cRet := aTabela[nPos][4]
        EndCase
    EndIf
Return cRet

User Function STCEPTESTE()
    Local cCEP := "18035-000"
    MsgInfo("CEP informado: " + cCEP + CRLF + ;
        "Bairro: " + U_STCEP(cCEP, "BAIRRO") + CRLF + ;
        "Cidade: " + U_STCEP(cCEP, "CIDADE") + CRLF + ;
        "UF: " + U_STCEP(cCEP, "UF"), "Consulta de CEP")
Return Nil

Static Function aTabCEP()
Return {;
    {"18035000", "Centro", "Sorocaba", "SP"},;
    {"18040000", "Vila Hortencia", "Sorocaba", "SP"},;
    {"18045000", "Jardim Paulista", "Sorocaba", "SP"},;
    {"18110000", "Centro", "Votorantim", "SP"},;
    {"01001000", "Se", "Sao Paulo", "SP"},;
    {"01310100", "Bela Vista", "Sao Paulo", "SP"},;
    {"11010000", "Centro", "Santos", "SP"};
}

