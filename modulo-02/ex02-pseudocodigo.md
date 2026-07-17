FUnCTION MAIN()
    Local nValor := 800
    Local nDesconto := 0
    Local nTotal := 0

    if nValor > 100
        nDesconto := nValor * 0.10
    ENDIF

    nTotal := nValor - nDesconto

    QOut("O valor com desconto ‚ de: R$" + str(nDesconto))

RETURN NIL