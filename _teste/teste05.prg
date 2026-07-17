#include _TESTE05 "Teste05"
FUNCTION Main()

    /*
    LOCAL
    PRIVATE
    PUBLIC
    STATIC
    */
    QOut(_TESTE05)
    PUBLIC nNumero := 50
    Operacoes()
RETURN NIL

FUNCTION Operacoes()
    //PRIVATE nNumero := 10
    
    Soma()
    Substrai()
RETURN NIL


FUNCTION Soma()
    //LOCAL nNumero := 20
    QOut(nNumero)
    QOut("Função Soma")
RETURN NIL

FUNCTION Substrai()
    //LOCAL nNumero := 30
    QOut(nNumero)
    QOut("Função Subtrai")
RETURN NIL