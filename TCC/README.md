# TCC - Controle de Não Conformidades de Fornecedores (ISO 9001)

Projeto final da Jornada DEV START - Harbour/ADVPL, desenvolvido para o módulo
de Compras (SIGACOM) do TOTVS Protheus.

**Integrante:** Higor Fequer Lima  
**Data:** agosto de 2026  
**Status:** implementação e documentação concluídas no repositório; compilação,
configuração e evidências no ambiente Protheus ainda devem ser executadas.

## 1. Objetivo

O sistema permite controlar certificados de qualidade de fornecedores e
registrar ocorrências de conformidade ou não conformidade nas entregas de
materiais. A solução relaciona as tabelas customizadas `ZZ1` e `ZZ2` aos
cadastros padrão de fornecedores (`SA2`) e produtos (`SB1`).

O projeto cobre o núcleo mínimo e os itens adicionais da rubrica:

- dicionário completo das tabelas, campos, contextos e índices;
- manutenção das tabelas com `mBrowse`;
- validações de integridade e consistência;
- gatilhos SX7 e consultas padrão SXB;
- filtro de ocorrências pelo controle selecionado;
- legendas para validade do certificado e tolerância de não conformidade;
- tratamento centralizado de erros com `BEGIN SEQUENCE`/`RECOVER` e log;
- biblioteca de funções comuns;
- menu do SIGACOM documentado;
- classe ADVPL aplicada ao domínio;
- bloqueio da exclusão de um controle que possua ocorrências.

## 2. Estrutura do projeto

```text
TCC/
|-- README.md
|-- AUTOAVALIACAO.md
|-- STTZZ1.PRW
|-- STTZZ2.PRW
|-- STTZZLIB.PRW
|-- STTISO.PRW
|-- TCC-Documentacao.docx
|-- Dados-e-Dicionario/
|   |-- README.md
|   |-- SX2-tabelas.csv
|   |-- SX3-campos.csv
|   |-- SIX-indices.csv
|   |-- SX7-gatilhos.csv
|   |-- SXB-consultas.csv
|   `-- SIGACOM-menu.csv
|-- fontes/
|   `-- README.md
`-- evidencias/
    `-- README.md
```

Os arquivos DBF, o projeto do DevStudio e o menu XNU nativo não foram
fabricados. Eles dependem da release, do ambiente e do dicionário físico do
Protheus. O equivalente completo em código e CSV está incluído para avaliação.

## 3. Modelo de dados

### ZZ1 - Controle de Fornecimento

Tabela compartilhada que representa o certificado e os limites de qualidade de
um fornecedor.

| Campo | Tipo | Tam. | Contexto | Finalidade |
|---|---:|---:|---|---|
| `ZZ1_FILIAL` | C | 2 | Real | Filial do registro |
| `ZZ1_CODIGO` | C | 6 | Real | Código do controle |
| `ZZ1_FORNEC` | C | 6 | Real | Código do fornecedor SA2 |
| `ZZ1_LOJAFO` | C | 2 | Real | Loja do fornecedor |
| `ZZ1_NOMEFO` | C | 40 | Virtual | Nome obtido da SA2 |
| `ZZ1_CERTIF` | C | 256 | Real | Dados do certificado |
| `ZZ1_VALCER` | D | 8 | Real | Validade do certificado |
| `ZZ1_TOLERA` | N | 5,2 | Real | Tolerância máxima (%) |
| `ZZ1_TOTOK` | N | 12,2 | Real | Quantidade conforme |
| `ZZ1_TOTNOK` | N | 12,2 | Real | Quantidade não conforme |

Índices:

1. `ZZ1_FILIAL + ZZ1_CODIGO` - chave primária.
2. `ZZ1_FILIAL + ZZ1_FORNEC + ZZ1_LOJAFO` - por fornecedor.
3. `ZZ1_FILIAL + DTOS(ZZ1_VALCER)` - por validade.

### ZZ2 - Ocorrências do Fornecedor

Tabela compartilhada que registra as quantidades e os valores de cada
ocorrência ligada a um controle ZZ1.

| Campo | Tipo | Tam. | Contexto | Finalidade |
|---|---:|---:|---|---|
| `ZZ2_FILIAL` | C | 2 | Real | Filial do registro |
| `ZZ2_CONFOR` | C | 6 | Real | Controle relacionado na ZZ1 |
| `ZZ2_FORNEC` | C | 6 | Real | Fornecedor herdado da ZZ1 |
| `ZZ2_LOJAFO` | C | 2 | Real | Loja herdada da ZZ1 |
| `ZZ2_NOMEFO` | C | 40 | Virtual | Nome obtido da SA2 |
| `ZZ2_DATA` | D | 8 | Real | Data da ocorrência |
| `ZZ2_HORA` | C | 5 | Real | Hora da ocorrência |
| `ZZ2_CODPRO` | C | 15 | Real | Produto SB1 |
| `ZZ2_QTDOK` | N | 12 | Real | Quantidade conforme |
| `ZZ2_QTDNOK` | N | 12 | Real | Quantidade não conforme |
| `ZZ2_VLRUNI` | N | 12,2 | Real | Valor unitário |
| `ZZ2_TOTOK` | N | 12,2 | Virtual | Valor conforme calculado |
| `ZZ2_TOTNOK` | N | 12,2 | Virtual | Valor não conforme calculado |

Índices:

1. `ZZ2_FILIAL + ZZ2_CONFOR + DTOS(ZZ2_DATA) + ZZ2_HORA` - chave primária.
2. `ZZ2_FILIAL + ZZ2_FORNEC + ZZ2_LOJAFO + DTOS(ZZ2_DATA)` - por fornecedor e data.
3. `ZZ2_FILIAL + DTOS(ZZ2_DATA)` - por data.

As definições completas para SX2, SX3 e SIX estão em
[`Dados-e-Dicionario`](Dados-e-Dicionario/README.md).

## 4. Rotinas

### STTZZ1.PRW

Mantém a tabela ZZ1 com pesquisa, visualização, inclusão, alteração e exclusão.
O botão **Ocorrências** abre `STTZZ2FLT()` com apenas os registros vinculados ao
controle selecionado.

Legenda do certificado:

- vermelho: `ZZ1_VALCER < dDataBase`;
- amarelo: validade até 30 dias;
- verde: validade superior a 30 dias.

A exclusão consulta a ZZ2 e é recusada quando existe vínculo, preservando a
integridade referencial lógica.

### STTZZ2.PRW

Mantém a tabela ZZ2 em modo geral ou filtrado por ZZ1. A legenda fica vermelha
quando o percentual de não conformidade supera `ZZ1_TOLERA`; caso contrário,
fica verde.

O percentual é calculado pela biblioteca:

```text
% não conforme = QTDNOK / (QTDOK + QTDNOK) * 100
```

Quando a quantidade total é zero, a função retorna zero e evita divisão por
zero.

### STTZZLIB.PRW

Centraliza consultas e cálculos usados por mais de uma rotina, incluindo:

- `NomeFornecedor(cFornec, cLoja)`;
- `NomeProduto(cCodPro)`;
- `PercNaoConforme(nOk, nNok)`;
- `CertificadoVencendo(dValCer)`;
- `GravarLogTCC(cFuncao, oErro)`;
- busca da tolerância e verificação de vínculo ZZ1/ZZ2.

### STTISO.PRW

Implementa uma classe ADVPL pequena para representar a avaliação de qualidade
de um fornecimento. Ela encapsula o cálculo do percentual e a comparação com a
tolerância, demonstrando POO sem duplicar a regra da biblioteca.

## 5. Validações

### ZZ1

- fornecedor e loja precisam formar uma chave existente na SA2;
- na inclusão, a validade do certificado não pode ser anterior à data-base;
- tolerância aceita valores de 0 a 100, inclusive;
- fornecedor, loja e validade são obrigatórios no dicionário.

### ZZ2

- controle informado precisa existir na ZZ1;
- produto precisa existir na SB1;
- data não pode ser futura;
- quantidades não podem ser negativas e a soma deve ser maior que zero;
- valor unitário não pode ser negativo.

As validações referencialmente importantes usam `ExistCpo()` e preservam a área
de trabalho atual com `GetArea()`/`RestArea()`.

## 6. Campos virtuais e gatilhos

Campos virtuais:

- `ZZ1_NOMEFO` e `ZZ2_NOMEFO`: nome recuperado da SA2 por `POSICIONE()`;
- `ZZ2_TOTOK`: `ZZ2_QTDOK * ZZ2_VLRUNI`;
- `ZZ2_TOTNOK`: `ZZ2_QTDNOK * ZZ2_VLRUNI`.

Gatilhos da ZZ2, disparados a partir de `ZZ2_CONFOR`, recuperam da ZZ1 o
fornecedor e a loja e depois resolvem o nome. Na inclusão, data e hora recebem
`dDataBase` e `Time()`. Todas as regras e a ordem de execução constam em
`Dados-e-Dicionario/SX7-gatilhos.csv`.

## 7. Consultas F3 e menu

Foram documentadas consultas SXB para:

- controle ZZ1: código, fornecedor e validade;
- fornecedor SA2: código, loja e nome;
- produto SB1: código, descrição e unidade de medida.

No SIGACOM, a hierarquia esperada é:

```text
Cadastros
`-- Controle ISO 9001
    |-- Controle de Fornecimento (ZZ1) -> STTZZ1
    `-- Ocorrências de Fornecedores (ZZ2) -> STTZZ2
```

## 8. Tratamento de erros

As ações de manutenção executadas pela mBrowse são protegidas por
`BEGIN SEQUENCE`/`RECOVER USING`. Um `ErrorBlock()` converte erros de execução em
objetos recuperáveis. Em falha, o usuário recebe uma mensagem objetiva e a
biblioteca grava o detalhe técnico para diagnóstico.

As rotinas padrão `AxInclui`, `AxAltera` e `AxDeleta` administram a própria
persistência. Não é aberta uma transação externa durante todo o formulário
interativo, evitando manter uma transação ativa enquanto o usuário preenche a
tela. Operações diretas futuras devem usar `RecLock()`/`MsUnlock()` dentro de uma
transação curta e executar rollback em qualquer falha.

## 9. Instalação no Protheus

> Faça backup do dicionário e configure primeiro em homologação. Os nomes das
> telas podem variar conforme a release.

1. No Configurador (SIGACFG), crie as tabelas compartilhadas ZZ1 e ZZ2 conforme
   `SX2-tabelas.csv`.
2. Cadastre os 23 campos de `SX3-campos.csv`, respeitando tipo, tamanho,
   decimais, contexto, validação e fórmula.
3. Crie os seis índices de `SIX-indices.csv` na ordem informada.
4. Configure os gatilhos SX7 e as consultas SXB dos respectivos CSVs.
5. Gere ou atualize as estruturas físicas pelo procedimento oficial da release.
6. Adicione `STTZZLIB.PRW`, `STTISO.PRW`, `STTZZ1.PRW` e `STTZZ2.PRW` a um
   projeto do TDS/DevStudio e compile-os no RPO de homologação.
7. Acrescente as duas entradas descritas em `SIGACOM-menu.csv` ao menu de
   Compras e atualize o menu do usuário.
8. Acesse o SIGACOM e execute `STTZZ1` e `STTZZ2`.

## 10. Roteiro de testes

Antes dos testes, cadastre em homologação pelo menos um fornecedor SA2 e um
produto SB1 próprios para teste.

| Cenário | Resultado esperado |
|---|---|
| Incluir ZZ1 com fornecedor e validade válidos | Registro incluído e nome virtual exibido |
| Informar fornecedor inexistente | Gravação rejeitada com mensagem amigável |
| Informar tolerância -1 ou 101 | Gravação rejeitada |
| Informar validade passada numa inclusão | Gravação rejeitada |
| Abrir Ocorrências a partir da ZZ1 | Browse ZZ2 mostra somente o controle selecionado |
| Incluir ZZ2 com produto válido e data atual | Ocorrência incluída e totais virtuais calculados |
| Informar controle/produto inexistente | Gravação rejeitada |
| Informar data futura ou quantidades inválidas | Gravação rejeitada |
| Percentual de NC maior que a tolerância | Linha da ZZ2 aparece em vermelho |
| Excluir ZZ1 que tenha ZZ2 | Exclusão bloqueada |
| Excluir ZZ1 sem vínculo | Exclusão padrão liberada |

## 11. Evidências

Não foram incluídos prints simulados. Após a execução real, salve as capturas na
pasta `evidencias/` e descreva o cenário e o resultado. O roteiro completo de
capturas está em [`evidencias/README.md`](evidencias/README.md).

## 12. Limitações e compatibilidade

- A compilação final depende das includes, do RPO, da release e do ambiente
  Protheus usados na avaliação.
- O parâmetro `cExprFilTop` usado pela `mBrowse` para filtrar a ZZ2 é suportado
  no cenário relacional com TopConnect/DBAccess esperado para o Protheus. Se o
  teste for feito sobre DBF local puro, valide o comportamento e, se necessário,
  substitua-o por um escopo/`DbSetFilter()` compatível com esse ambiente.
- Expressões de dicionário devem ser revisadas no Configurador após a digitação
  ou importação.
- DBFs e arquivos XNU reais somente devem ser gerados pelo ambiente Protheus.
- O código e os CSVs foram preparados para revisão estática; execução real e
  prints dependem do AppServer, SmartClient e banco configurados.

## 13. Materiais utilizados

- Enunciado do TCC - Controle de Não Conformidades ISO 9001, revisão 2.0.
- Rubrica de validação do TCC, revisão 1.0.
- Conteúdos dos módulos 8 e 9 da Jornada DEV START.

Consulte também [`AUTOAVALIACAO.md`](AUTOAVALIACAO.md) antes da entrega.
