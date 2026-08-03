# Exercício 1 — AxCadastro x mBrowse

## a. Quando usar cada um?

`AxCadastro()` é indicado para um CRUD simples cuja tabela e campos já estejam configurados no dicionário. `mBrowse()` é mais adequado quando a tela precisa de filtros, legendas, cores ou ações personalizadas.

## b. Recursos controlados pelo mBrowse

1. Legendas e cores por condição (`aColors`).
2. Filtro inicial (`cFiltro`).
3. Menu de operações personalizado (`aRotina`).

## c. Por que `.T.` fica por último em `aColors`?

As condições são avaliadas na ordem. Como `.T.` sempre é verdadeiro, ele funciona como regra padrão; se viesse primeiro, impediria que as demais regras fossem usadas.

## d. Campo virtual x gatilho

O campo virtual calcula o valor quando ele é consultado e não o grava fisicamente. O gatilho SX7 reage à alteração do campo de origem e transfere o resultado da regra ao contra-domínio, que pode ser gravado no registro.

