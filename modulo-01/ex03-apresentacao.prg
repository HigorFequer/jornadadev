FUNCTION Main()

    LOCAL cNome := "Higor Fequer Lima"
    LOCAL cCidade := "São Paulo"
    LOCAL cCurso := "Harbour/ADVPL"

    QOut("===========================")
    QOut("  FICHA DE APRESENTAÇÃO    ")
    QOut("===========================")
    QOut(hb_StrFormat("Nome     : %s", cNome))
    QOut(hb_StrFormat("Cidade   : %s", cCidade))
    QOut(hb_StrFormat("Curso    : %s", cCurso))
    QOut("===========================")

RETURN NIL