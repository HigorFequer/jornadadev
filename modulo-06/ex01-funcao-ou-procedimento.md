# Exercício 1 — Função ou procedimento?

| Comando       | Classificação | Justificativa                                                                 |
|---------------|---------------|--------------------------------------------------------------------------------|
| `Str()`       | Função        | Recebe um número e **devolve** a representação em string, para ser usada em outra expressão. |
| `QOut()`      | Procedimento  | Apenas **exibe** o texto na tela; não devolve nenhum valor utilizável.        |
| `Date()`      | Função        | **Retorna** a data atual como um valor do tipo Data, que pode ser armazenado ou comparado. |
| `Len()`       | Função        | **Retorna** um número (tamanho da string ou array), usado em expressões e condições. |
| `Upper()`     | Função        | Recebe uma string e **retorna** outra string (em maiúsculas); não executa uma ação, produz um valor. |
| `ClearScreen()` | Procedimento | Apenas **executa uma ação** (limpar a tela); não há valor de retorno a ser usado. |

**Resumo da regra:** se o comando é usado do lado direito de uma atribuição
(`x := Comando(...)`) ou dentro de uma expressão/condição, ele é uma **função**.
Se ele só é chamado "sozinho" para produzir um efeito (mostrar algo, limpar
algo, mover o cursor), ele é um **procedimento**.
