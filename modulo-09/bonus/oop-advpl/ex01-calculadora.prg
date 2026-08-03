CLASS Calculadora
   DATA nAcumulador
   METHOD New()
   METHOD Somar(nValor)
   METHOD Subtrair(nValor)
   METHOD Resultado()
ENDCLASS

METHOD New() CLASS Calculadora
   ::nAcumulador := 0
RETURN SELF

METHOD Somar(nValor) CLASS Calculadora
   ::nAcumulador += nValor
RETURN SELF

METHOD Subtrair(nValor) CLASS Calculadora
   ::nAcumulador -= nValor
RETURN SELF

METHOD Resultado() CLASS Calculadora
RETURN ::nAcumulador

FUNCTION Main()
   LOCAL oCalc := Calculadora():New()
   oCalc:Somar(10):Somar(5):Subtrair(3)
   QOut("Resultado: " + LTrim(Str(oCalc:Resultado())))
RETURN NIL
