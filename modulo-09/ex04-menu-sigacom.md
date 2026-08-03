# Exercício 04 — Menu no SIGACOM

No Configurador, em **Ambiente > Cadastros > Menus**, selecione o menu do módulo **Compras (SIGACOM)** e adicione os itens abaixo ao grupo **Cadastros**:

```text
Cadastros
├── Contatos            → USER FUNCTION STTIP003
└── Interações (todas)  → USER FUNCTION STTIP004B
```

| Item | Tipo | Programa | Objetivo |
|---|---|---|---|
| Contatos | Função Protheus | `STTIP003` | Abre o mBrowse da SZ1 com acesso às interações do contato atual |
| Interações (todas) | Função Protheus | `STTIP004B` | Abre a listagem geral da SZ2, sem filtro por contato |

Depois de gerar o menu, é necessário entrar novamente no SIGACOM para carregar a alteração. O teste esperado é abrir ambos os itens sem erro e confirmar que a primeira rotina trabalha com Contatos e a segunda lista todas as Interações.
