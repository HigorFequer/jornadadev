# Autoavaliação do TCC

Documento de conferência antes da entrega. Marque um item somente depois de
validar o resultado no ambiente correspondente.

## Artefatos verificáveis no repositório

- [x] Estrutura das tabelas ZZ1 e ZZ2 documentada em CSV/texto.
- [x] Campos, tipos, tamanhos, decimais e contextos documentados.
- [x] Índices SIX documentados.
- [x] Fontes `STTZZ1.PRW` e `STTZZ2.PRW` presentes.
- [x] Legendas e filtro da ZZ2 implementados nos fontes.
- [x] Validações de SA2, SB1, ZZ1, datas, tolerância, quantidades e valor.
- [x] Gatilhos SX7 documentados.
- [x] Consultas SXB documentadas.
- [x] `BEGIN SEQUENCE`/`RECOVER`, mensagem amigável e log técnico.
- [x] Biblioteca comum `STTZZLIB.PRW` sem duplicação intencional.
- [x] Menu do SIGACOM documentado.
- [x] README com instalação, funcionamento e roteiro de testes.
- [x] Classe ADVPL aplicada ao domínio como diferencial.
- [x] Exclusão de ZZ1 bloqueada quando existe ZZ2 vinculada.

## Itens que dependem do Protheus/SmartClient

- [ ] Importar ou cadastrar SX2, SX3, SIX, SX7 e SXB no Configurador.
- [ ] Criar fisicamente as tabelas ZZ1 e ZZ2 e seus índices.
- [ ] Compilar os fontes no ambiente/Release utilizados na avaliação.
- [ ] Incluir as rotinas no menu do SIGACOM e atualizar o menu do usuário.
- [ ] Executar os cenários positivos e negativos descritos no README.
- [ ] Gerar os prints reais e adicioná-los em `evidencias/`.
- [ ] Revisar os logs do AppServer e o arquivo de log do TCC.

## Entrega

- [ ] Confirmar o nome dos integrantes no README.
- [ ] Conferir ortografia e dados pessoais antes de publicar.
- [ ] Versionar a pasta TCC quando autorizado.
- [ ] Colar o link público da pasta na atividade e concluir a entrega.
