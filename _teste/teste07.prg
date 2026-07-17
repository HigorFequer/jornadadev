FUNCTION Main ()

    LOCAL nNumero := 50
    LOCAL cTexto := "teste"
    //LOCAL dData := DATE()
    LOCAL dData := DATE()




    QOut("texto:" + cTexto)
    QOut("numero:" + alltrim(str(nNumero)))
    QOut("data:" + DtoC(dData))

RETURN NIL