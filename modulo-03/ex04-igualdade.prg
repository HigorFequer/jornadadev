// Exercicio 4 - '=' vs '==' em Harbour
// Modulo 3 - Jornada DEV START
//

// Em Harbour, o operador "=" usado em comparacao de strings faz uma
// comparacao "parcial": se a string do lado direito for MAIS CURTA que a
// da esquerda, ele compara apenas os primeiros N caracteres (N = tamanho
// da string mais curta). Ou seja, "Harbour" = "Harb" da .T., porque os
// 4 primeiros caracteres de "Harbour" sao exatamente "Harb".
//
// Ja o operador "==" faz uma comparacao EXATA: as duas strings precisam
// ter o mesmo tamanho e o mesmo conteudo, caractere a caractere. Por isso
// "Harbour" == "Harb" da .F., pois os tamanhos sao diferentes.
//
// Resumindo: use "==" sempre que quiser ter certeza absoluta de que duas
// strings sao identicas (ex.: comparar senhas, codigos, chaves).

FUNCTION Main()

   LOCAL cCompleta := "Harbour"
   LOCAL cParcial  := "Harb"

   QOut("cCompleta = '" + cCompleta + "'")
   QOut("cParcial  = '" + cParcial  + "'")
   QOut("")

   IF cCompleta = cParcial
      QOut("cCompleta =  cParcial  ->  .T.   (comparacao parcial: compara so os 4 primeiros)")
      // QOut("Harbour" = "Harb")  // compara apenas os 4 primeiros caracteres
      QOut("Harbour" = "Harb")
      QOut("Harbour" = "Harbour")
   ELSE
      QOut("cCompleta =  cParcial  ->  .F.")
   ENDIF

   IF cCompleta == cParcial
      QOut("cCompleta == cParcial  ->  .T.")
   ELSE
      QOut("cCompleta == cParcial  ->  .F.   (comparacao exata: tamanhos diferentes)")
      // QOut("Harbour" == "Harb")  // compara todos os caracteres, mas os tamanhos sao diferentes
      QOut("Harbour" == "Harb")
      QOut("Harbour" == "Harbour")
   ENDIF

RETURN NIL