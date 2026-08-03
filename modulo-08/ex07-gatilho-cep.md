# Exercício 7 — Gatilho de CEP

## a. Campo, contra-domínio e regra

O campo é a origem que dispara o gatilho. O contra-domínio é o campo que recebe o resultado. A regra é a expressão ADVPL avaliada para produzir esse resultado.

## b. Por que `M->A1_CEP`?

`M->` lê o valor que está na tela, ainda não gravado. `SA1->A1_CEP` poderia retornar o valor antigo do registro no banco.

## c. Problemas de manter CEPs no fonte

O código precisaria ser recompilado a cada mudança e a lista ficaria rapidamente desatualizada e incompleta. Em produção, os dados poderiam ficar numa tabela do dicionário consultada com `Posicione()` ou vir de um serviço externo de CEP via HTTP, com tratamento de indisponibilidade.

## d. Preencher `A1_COD_MUN`

Eu incluiria o código do município na fonte de dados, faria `U_STCEP()` aceitar um retorno como `CODMUN` e criaria outro gatilho de `A1_CEP` para `A1_COD_MUN`, com uma nova sequência.

## Gatilhos SX7

| Origem | Seq. | Contra-domínio | Regra |
|---|---:|---|---|
| A1_CEP | 001 | A1_BAIRRO | `U_STCEP(M->A1_CEP,"BAIRRO")` |
| A1_CEP | 002 | A1_MUN | `U_STCEP(M->A1_CEP,"CIDADE")` |
| A1_CEP | 003 | A1_EST | `U_STCEP(M->A1_CEP,"UF")` |

Tipo: Primário. Posiciona: Não.

