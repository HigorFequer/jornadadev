# Exercício 2 - A tabela ZA1 (Pets)

## a. Estrutura da tabela ZA1

  Campo        Tipo       Tamanho
  ------------ ---------- ---------
  ZA1_FILIAL   Caracter   2
  ZA1_NOME     Caracter   40
  ZA1_RACA     Caracter   40
  ZA1_DTNASC   Data       8

## b. Que índice faria sentido para a ZA1?

Eu criaria um índice utilizando o campo **ZA1_NOME**, porque normalmente é a primeira informação usada para procurar um pet. Com esse índice, a busca fica mais rápida e não precisa verificar todos os registros da tabela.

## c. Por que o prefixo da tabela é Z?

O prefixo **Z** identifica que a tabela é uma customização do cliente e
não faz parte das tabelas padrão do Protheus. Essa convenção evita
conflitos com futuras atualizações do sistema.

## d. Explique por que os campos começam com ZA1_?

Os campos utilizam o prefixo **ZA1_** para indicar a qual tabela
pertencem. Isso facilita a organização do dicionário de dados, evita
conflitos entre nomes de campos e mantém um padrão utilizado pelo
Protheus.
