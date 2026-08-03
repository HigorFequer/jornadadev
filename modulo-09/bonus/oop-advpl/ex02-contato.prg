CLASS Contato
   DATA cCodigo
   DATA cCliente
   DATA _cAssunto
   DATA dData
   METHOD New(cCodigo, cCliente, cAssunto)
   METHOD Validar()
   ACCESS cAssunto INLINE ::_cAssunto
   ASSIGN cAssunto(cValor) INLINE ::_cAssunto := Left(cValor, 60)
ENDCLASS

METHOD New(cCodigo, cCliente, cAssunto) CLASS Contato
   ::cCodigo  := cCodigo
   ::cCliente := cCliente
   ::cAssunto := cAssunto
   ::dData    := Date()
RETURN SELF

METHOD Validar() CLASS Contato
RETURN !Empty(::cCliente) .AND. !Empty(::cAssunto)

FUNCTION Main()
   LOCAL oContato := Contato():New("000001", "000001", Replicate("A", 70))
   QOut("Valido: " + If(oContato:Validar(), "sim", "nao"))
   QOut("Tamanho do assunto: " + LTrim(Str(Len(oContato:cAssunto))))
RETURN NIL
