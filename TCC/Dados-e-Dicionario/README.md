# Dicionario de dados - Controle de Nao Conformidades ISO 9001

Esta pasta documenta, em texto aberto, a configuracao solicitada para o TCC. Os CSV usam ponto e virgula como separador e codificacao UTF-8. Eles permitem que o avaliador leia o dicionario sem depender de arquivos DBF binarios.

## Arquivos

- `SX2-tabelas.csv`: aliases ZZ1 e ZZ2, descricoes, compartilhamento e chaves logicas.
- `SX3-campos.csv`: campos, tipos, tamanhos, decimais, contexto real/virtual, validacoes, consultas F3 e formulas.
- `SIX-indices.csv`: tres indices de cada tabela, na ordem pedida no enunciado.
- `SX7-gatilhos.csv`: preenchimento automatico do fornecedor e da data/hora.
- `SXB-consultas.csv`: consultas de controle ZZ1, fornecedor SA2 e produto SB1.
- `SIGACOM-menu.csv`: hierarquia do menu de Compras e programas chamados.

Nao foram criados DBFs de exemplo nem um arquivo `.xnu` artificial. Os DBFs e o menu nativo devem ser produzidos pelo Protheus/Configurador no ambiente real. Os nomes `ZZ1990` e `ZZ2990` em SX2 sao referencias aos nomes apresentados no material; o sufixo fisico pode variar conforme o ambiente.

## Ordem sugerida de configuracao

1. Faca backup do dicionario e use inicialmente um ambiente de homologacao.
2. No Configurador (SIGACFG), crie as tabelas logicas ZZ1 e ZZ2 conforme `SX2-tabelas.csv`, ambas com acesso **Compartilhado**.
3. Cadastre os campos de `SX3-campos.csv`. Marque como virtuais somente `ZZ1_NOMEFO`, `ZZ2_NOMEFO`, `ZZ2_TOTOK` e `ZZ2_TOTNOK`; os demais sao reais.
4. Crie os indices de `SIX-indices.csv`, preservando exatamente a ordem e as expressoes.
5. Associe as validacoes de usuario e as consultas F3 indicadas no SX3.
6. Configure os gatilhos de `SX7-gatilhos.csv` na fase 3 e mantenha a sequencia da ZZ2. Os gatilhos que copiam fornecedor e loja precisam executar antes do gatilho que resolve o nome. Na ZZ1, o segundo gatilho recalcula o nome depois que a loja e informada.
7. Configure as consultas de `SXB-consultas.csv`. Se SA2 e SB1 ja tiverem consultas padrao equivalentes no ambiente, confira os campos e reutilize-as; a consulta da ZZ1 deve retornar `ZZ1_CODIGO`.
8. Acrescente ao SIGACOM as duas entradas descritas em `SIGACOM-menu.csv`, dentro de `Cadastros > Controle ISO 9001`.
9. Atualize/crie as estruturas fisicas pelo procedimento oficial da versao do Protheus e valide tudo em homologacao antes de transportar para producao.

## Regras de integridade documentadas

### ZZ1

- `ZZ1_FORNEC` e `ZZ1_LOJAFO` devem formar uma chave existente na SA2.
- Na inclusao, `ZZ1_VALCER` nao aceita data anterior a `dDataBase`.
- `ZZ1_TOLERA` aceita valores de 0 a 100, inclusive.
- `ZZ1_NOMEFO` e virtual e consulta `A2_NOME` por `POSICIONE()`.

### ZZ2

- `ZZ2_CONFOR` deve existir na ZZ1 pelo indice 1.
- `ZZ2_CODPRO` deve existir na SB1 pelo indice 1.
- `ZZ2_DATA` nao aceita data futura.
- Ao selecionar `ZZ2_CONFOR`, os gatilhos recuperam fornecedor, loja e nome.
- Na inclusao, data e hora recebem `dDataBase` e `Time()`.
- `ZZ2_TOTOK` e `ZZ2_TOTNOK` sao virtuais e calculados pela quantidade multiplicada pelo valor unitario.

## Conferencias no ambiente Protheus

Depois da configuracao, valide manualmente:

- inclusao, alteracao, consulta e exclusao logica nas duas tabelas;
- rejeicao de fornecedor, controle e produto inexistentes;
- limites 0 e 100 para a tolerancia e rejeicao de valores fora da faixa;
- rejeicao de validade passada na ZZ1 e de data futura na ZZ2;
- retorno correto das tres consultas F3;
- preenchimento dos gatilhos, inclusive a ordem fornecedor/loja/nome;
- abertura das rotinas `STTZZ1` e `STTZZ2` pelo menu do SIGACOM.

As expressoes foram transcritas do enunciado do TCC. Dependendo da release e do idioma do ambiente, os rotulos das telas do Configurador podem mudar, mas os aliases, campos e regras logicas permanecem os mesmos.
