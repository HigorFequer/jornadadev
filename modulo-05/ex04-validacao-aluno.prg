// Exercício 4 — Validação completa (loops de consistência)
// Lê nome, disciplina e 2 notas de um aluno, validando cada campo
// com um loop que só avança quando o valor for válido.
//
// Nome       -> não pode ser vazio
// Disciplina -> exatamente 3 letras maiúsculas (ex.: MAT, POR)
// Notas      -> cada uma entre 0 e 10

FUNCTION Main()

   LOCAL cNome
   LOCAL cDisc
   LOCAL nNota1
   LOCAL nNota2
   LOCAL nMedia

   // --- Validação do nome ---
   WHILE .T.
      ACCEPT "Nome do aluno: " TO cNome
      IF Len( Trim( cNome ) ) > 0
         EXIT
      ENDIF
      QOut("Nome inválido. O nome não pode ser vazio.")
   ENDDO

   // --- Validação da disciplina ---
   WHILE .T.
      ACCEPT "Disciplina (3 letras maiúsculas, ex.: MAT): " TO cDisc
      IF Len( cDisc ) == 3 .AND. cDisc == Upper( cDisc )
         EXIT
      ENDIF
      QOut("Disciplina inválida. Digite exatamente 3 letras maiúsculas.")
   ENDDO

   // --- Validação da nota 1 ---
   WHILE .T.
      ACCEPT "Nota 1 (0 a 10): " TO nNota1
      nNota1 := Val( nNota1 )
      IF nNota1 >= 0 .AND. nNota1 <= 10
         EXIT
      ENDIF
      QOut("Nota inválida. Digite um valor entre 0 e 10.")
   ENDDO

   // --- Validação da nota 2 ---
   WHILE .T.
      ACCEPT "Nota 2 (0 a 10): " TO nNota2
      nNota2 := Val( nNota2 )
      IF nNota2 >= 0 .AND. nNota2 <= 10
         EXIT
      ENDIF
      QOut("Nota inválida. Digite um valor entre 0 e 10.")
   ENDDO

   nMedia := ( nNota1 + nNota2 ) / 2

   QOut(" ")
   QOut("----- Dados do aluno -----")
   QOut("Nome      : " + Trim( cNome ))
   QOut("Disciplina: " + cDisc)
   QOut("Nota 1    : " + Str( nNota1, 5, 2 ))
   QOut("Nota 2    : " + Str( nNota2, 5, 2 ))
   QOut("Média     : " + Str( nMedia, 5, 2 ))
   QOut(" ")

RETURN NIL
