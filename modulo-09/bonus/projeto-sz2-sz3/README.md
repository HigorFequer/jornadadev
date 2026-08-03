# Projeto bônus independente — SZ2/SZ3

Esta segunda implementação replica o relacionamento 1:N sem colidir com o projeto principal: `SZ2` representa Contatos e `SZ3`, Interações.

- Chave SZ2: `Z2_FILIAL + Z2_CODIGO`.
- Chave SZ3: `Z3_FILIAL + Z3_CONTAT + Z3_SEQUEN`.
- `Z3_CONTAT` valida a existência na SZ2 com `ExistCpo("SZ2", xFilial("SZ2") + M->Z3_CONTAT, 1)`.
- Os campos virtuais da SZ3 usam `POSICIONE` para trazer código e assunto da SZ2.
- Os gatilhos de data, hora e usuário seguem `dDataBase`, `IF(INCLUI, Time(), SZ3->Z3_HORA)` e `cNomUsr`.
- O menu do SIGACOM aponta para `STTIB003` e `STTIB004B`.

Os fontes abaixo incluem a biblioteca, os browses filtrado/geral e a gravação segura com transação, lock, rollback e log.
