# Exercício 5 - A1_FILIAL e xFilial()

## a. Por que existe o campo A1_FILIAL?

O campo **A1_FILIAL** serve para identificar a qual filial cada registro pertence. Isso ajuda a manter os dados organizados quando a empresa possui mais de uma filial. Por esse motivo, esse campo existe em todas as tabelas do Protheus, inclusive nas tabelas personalizadas.

## b. O que a função xFilial() tem a ver com isso?

A função **xFilial()** retorna automaticamente a filial que está sendo utilizada no momento. Assim, o sistema grava as informações na filial correta. Se a filial fosse informada manualmente, poderiam acontecer erros e os dados seriam gravados na filial errada.
