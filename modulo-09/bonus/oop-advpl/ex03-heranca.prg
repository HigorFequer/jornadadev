CLASS Pessoa
   DATA cNome
   DATA cCPF
   DATA dNasc
   METHOD New(cNome, cCPF, dNasc)
   METHOD Validar()
   METHOD Idade()
ENDCLASS

METHOD New(cNome, cCPF, dNasc) CLASS Pessoa
   ::cNome := cNome
   ::cCPF  := cCPF
   ::dNasc := dNasc
RETURN SELF

METHOD Validar() CLASS Pessoa
RETURN !Empty(::cNome) .AND. !Empty(::dNasc)

METHOD Idade() CLASS Pessoa
   LOCAL nIdade := Year(Date()) - Year(::dNasc)
   IF SToD(StrZero(Year(Date()), 4) + SubStr(DToS(::dNasc), 5, 4)) > Date()
      nIdade--
   ENDIF
RETURN nIdade

CLASS PessoaFisica FROM Pessoa
   DATA cRG
   METHOD New(cNome, cCPF, dNasc, cRG)
   METHOD Validar()
ENDCLASS

METHOD New(cNome, cCPF, dNasc, cRG) CLASS PessoaFisica
   ::Super:New(cNome, cCPF, dNasc)
   ::cRG := cRG
RETURN SELF

METHOD Validar() CLASS PessoaFisica
RETURN ::Super:Validar() .AND. !Empty(::cCPF) .AND. !Empty(::cRG)

CLASS PessoaJuridica FROM Pessoa
   DATA cCNPJ
   DATA cRazaoSocial
   METHOD New(cNome, dNasc, cCNPJ, cRazaoSocial)
   METHOD Validar()
ENDCLASS

METHOD New(cNome, dNasc, cCNPJ, cRazaoSocial) CLASS PessoaJuridica
   ::Super:New(cNome, "", dNasc)
   ::cCNPJ        := cCNPJ
   ::cRazaoSocial := cRazaoSocial
RETURN SELF

METHOD Validar() CLASS PessoaJuridica
RETURN ::Super:Validar() .AND. !Empty(::cCNPJ) .AND. !Empty(::cRazaoSocial)

FUNCTION Main()
   LOCAL oPF := PessoaFisica():New("Maria", "12345678901", CToD("10/05/1990"), "1234567")
   LOCAL oPJ := PessoaJuridica():New("Loja Exemplo", CToD("01/01/2010"), "12345678000199", "Loja Exemplo Ltda")
   QOut("Pessoa fisica valida: " + If(oPF:Validar(), "sim", "nao"))
   QOut("Pessoa juridica valida: " + If(oPJ:Validar(), "sim", "nao"))
RETURN NIL
