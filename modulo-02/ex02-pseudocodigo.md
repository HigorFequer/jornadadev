
# Exercício 2 — Pseudocódigo
Escreva em pseudocódigo um algoritmo para cada item:
- a. Calcular a área de um retângulo (base × altura)
- b. Verificar se um número é par ou ímpar
- c. Encontrar o maior entre três números

Dica: use as palavras Leia, Escreva, Se ... Senão e o operador `<-` para atribuir.

---
### a) Área do retângulo
Início
Leia base
Leia altura
area <- base * altura
Escreva area
Fim

### b) Par ou ímpar
Início
Leia n
Se n % 2 == 0 então
    Escreva "par"
Senão
    Escreva "ímpar"
Fim

### c) Maior entre três
Início
Leia a, b, c
maior <- a
Se b > maior então maior <- b
Se c > maior então maior <- c
Escreva maior
Fim