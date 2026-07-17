Exercício 4 — Refinamento sucessivo
Problema

Um sistema de caixa de supermercado deve registrar os itens de uma compra, calcular o subtotal, aplicar desconto de 5% caso o cliente tenha cartão fidelidade e mostrar o total a pagar.
Nível 1 — Visão geral
1) Registrar itens
2) Calcular subtotal
3) Aplicar desconto (se houver)
4) Mostrar total a pagar

Nível 2 — Detalhamento
- Registrar itens: iniciar compra; para cada item leia código/nome, preço e quantidade; calcule valorItem; some ao subtotal; repetir enquanto houver itens.
- Calcular subtotal: subtotal ← soma dos valorItem.
- Aplicar desconto: se cliente tem cartão então desconto ← subtotal * 0.05 senão desconto ← 0; total ← subtotal - desconto.
- Mostrar total: escreva subtotal, escreva desconto, escreva total.

Pseudocódigo curto
Início
subtotal <- 0
continuar <- "S"
Enquanto continuar = "S" faça
    Leia nomeProduto
    Leia precoProduto
    Leia quantidade
    valorItem <- precoProduto * quantidade
    subtotal <- subtotal + valorItem
    Escreva "Outro item? S/N"
    Leia continuar
FimEnquanto
Escreva "Possui cartão fidelidade? S/N"
Leia possuiCartao
Se possuiCartao = "S" então desconto <- subtotal * 0.05 Senão desconto <- 0
total <- subtotal - desconto
Escreva subtotal, desconto, total
Fim