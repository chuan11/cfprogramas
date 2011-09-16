program ProgramasCasaFreitas;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uLogin in 'fmLogin\uLogin.pas',
  ufornACriticar in 'FmFornecACriticar\ufornACriticar.pas' {fmFornACriticar},
  uTabela in 'fmTabela\uTabela.pas' {fmTabela},
  UpcoAlteradoPorPeriodo in 'fmPrecosAlteradosPorPeriodo\UpcoAlteradoPorPeriodo.pas' {fmPrecosAlterados},
  uOsDeposito in 'fmOsDeposito\uOsDeposito.pas' {fmOsDeposito},
  uAvarias in 'fmAvarias\uAvarias.pas' {fmCadAvarias},
  fmAbrirAvarias in 'fmAvarias\fmAbrirAvarias.pas' {fmAbrirAvaria},
  uCriaAvaria in 'fmAvarias\uCriaAvaria.pas' {fmCriarAvaria},
  uAprovaAvaria in 'fmAvarias\uAprovaAvaria.pas' {fmAprovaAv},
  uEmail in '..\Funcoes\uEmail.pas',
  uPropostaLoja in 'fmPropostas\uPropostaLoja.pas' {fmProposta},
  uNovaProposta in 'fmPropostas\uNovaProposta.pas' {fmNovaProposta},
  uDestinoEmail in '..\Funcoes\uDestinoEmail.pas' {fmDestEmail},
  uRelNotaTransf in 'fmRelNotasTransf\uRelNotaTransf.pas' {fmRelNotaTransf},
  uMapa in 'fmMapaSeparacao\uMapa.pas' {fmMapa},
  uCriaMapa in 'fmMapaSeparacao\uCriaMapa.pas' {fmCriarMapa},
  Uprecoswell in 'fmPrecos\Uprecoswell.pas' {fmLancaPrecos},
  uReajuste in 'fmPrecos\uReajuste.pas' {fmReajuste},
  uDescPedido in 'fmDescontoPedido\uDescPedido.pas' {fmDescPed},
  uAnaliseVenda in 'fmAnaliseVenda\uAnaliseVenda.pas' {fmFaturamento},
  uListaMapa in 'fmAnaliseVenda\uListaMapa.pas' {fmListaMapa},
  uEtiquetas in 'fmEtiquetas\uEtiquetas.pas' {fmEtiquetas},
  uPallet in 'fmEtiquetas\uPallet.pas' {Pallet},
  unNotasTransfrencia in 'fmRelNotasTransferidas\unNotasTransfrencia.pas' {fmNotasTransf},
  uPrecosCusto in 'fmPrecoCusto\uPrecosCusto.pas' {fmPrecoCustos},
  uetqNotas in 'fmPrecoCusto\uetqNotas.pas' {fmEtq},
  uREsumoEstoque in 'fmResumoEstoque\uREsumoEstoque.pas' {fmResEstoque},
  uDetEntrada in 'fmDetalhesEntrada\uDetEntrada.pas' {fmDetEntrada},
  uTotalSaidas in 'fmTotalSaidas\uTotalSaidas.pas' {fmTotalSaidas},
  uenviaEmail in 'fmEmail\uenviaEmail.pas' {fmEnviaEmail},
  uAlteraFinanceira in 'fmAlteraFinanceira\uAlteraFinanceira.pas' {fmAlteraFiananceira},
  uListaItensPorNota in 'fmPrecos\fmListaItensNotas\uListaItensPorNota.pas' {fmListaItensNota},
  uDetalhesNotas in 'fmDetalhesNotas\uDetalhesNotas.pas' {fmDetalhesNota},
  uRelatorioComissao in 'fmRelatorioComissao\uRelatorioComissao.pas' {fmRelatorioComissao},
  uComporEstoque in 'fmComporEstoque\uComporEstoque.pas' {fmComporEstoque},
  unClientes in 'fmEtiquetasClientes\unClientes.pas' {fmetqClientes},
  uAjustaNota in 'fmAjustaNota\uAjustaNota.pas' {fmAjustaNota},
  uAnaliseEstoque in 'fmAnaliseEstoque\uAnaliseEstoque.pas' {fmAnaliseEstoque},
  uConReqProd in 'fmConREqProd\uConReqProd.pas' {fmConReqProduto},
  uCalcEN in 'fmCalcExnota\uCalcEN.pas' {fmCalcExNota},
  uGetNotas in 'fmGetNotas\uGetNotas.pas',
  uRelGeral in 'fmRelatorioGeral\uRelGeral.pas' {fmRelGeral},
  unMovDiario in 'fmMovDiario\unMovDiario.pas' {fmMovDiario},
  uAbreMovDiario in 'fmMovDiario\uAbreMovDiario.pas' {fmDialogMov},
  UAlteraForPedido in 'fmAlterafornecedorPedido\UAlteraForPedido.pas' {fmAlteraPedForn},
  uClassificaProd in 'fmClassificaProd\uClassificaProd.pas' {fmClassificaProd},
  uCompFornecedor in 'fmCompFornecedor\uCompFornecedor.pas' {fmCompFornecedor},
  system,
  sysUtils,
  windows,
  uCadFornecedor in 'uCadFornecedor\uCadFornecedor.pas' {Form1},
  uListaFornecedores in 'FmFornecACriticar\uListaFornecedores.pas' {fmListaFornecedores},
  uParametros in 'fmParametros\uParametros.pas' {fmParametros},
  funcoes,
  uRemoveRegTEF in 'fmRemoveRegTEF\uRemoveRegTEF.pas' {fmRemRegTEF},
  uCadastrarNCM in 'fmCadastrarNCM\uCadastrarNCM.pas' {fmCadastraNCM},
  uAjustaSPED in 'fmAjustaSPED\uAjustaSPED.pas' {fmAjustaSPED},
  uCustoPorPedido in 'fmListaPrecosCustoPorNota\uCustoPorPedido.pas' {fmCustoPorPedido},
  uObterSaldoFiscal in 'fmObterSaldoFiscal\uObterSaldoFiscal.pas' {fmObterSaldoFiscal},
  uAjusteModPag in 'fmAjusteModPag\uAjusteModPag.pas' {fmAjusteModPag},
  uAlteraModalidadePagto in 'fmRemoveRegTEF\uAlteraModalidadePagto.pas' {fmAlteraModPagto},
  uSelecionaUo in 'fmSelecionaUo\uSelecionaUo.pas' {fmSelecionaUo},
  uGeraEstoque in 'fmGeraEstoque\uGeraEstoque.pas' {fmGeraEstoque},
  uRelInventario in 'fmRelInventario\uRelInventario.pas' {fmRelInventario},
  uSelCat in 'fmCategorias\uSelCat.pas' {fmSelCat},
  uTotalEntSai in 'fmGeraEstoque\fmTotalEntSai\uTotalEntSai.pas' {fmTotalEntSai},
  uDetalhesCRUC in 'fmGeraEstoque\fmDetalhesCRUC\uDetalhesCRUC.pas' {fmDetalhesCRUC},
  uPedidosFornecedor in 'fmGeraEstoque\fmPedidosFornecedor\uPedidosFornecedor.pas' {fmPedidosFornecedor},
  uExportaTable in 'fmGeraEstoque\fmExportacao\uExportaTable.pas' {fmExportaTable},
  umColetor in 'fmColetor\umColetor.pas' {fmColetor},
  uResumoECF in 'fmResumoECF\uResumoECF.pas' {fmResumoECF},
  uRRANA in 'fmRRANA\uRRANA.pas' {fmRelGeral1},
  uListaNotaWMS in 'WMS\uListaNotaWMS.pas' {fmRecebeNota},
  uInternaNota in 'WMS\uInternaNota.pas' {fmInternaNota},
  uCEP in 'fmCEP\uCEP.pas' {fmCep},
  fmMudaSerieNota in 'fmMudaSerieNota\fmMudaSerieNota.pas' {fmAjustaSerie},
  uBuscaCidade in 'fmBuscaCidade\uBuscaCidade.pas' {fmBuscaDiversas},
  uCadImagem in 'fmCadImagem\uCadImagem.pas' {fmCadastro},
  uManutencaoCX in 'fmManutencaoCx\uManutencaoCX.pas' {fmManutencaoCX};

{$R *.res}

begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe') ) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end
   else begin
      Application.Initialize;
      Application.Title := 'Programas Loja';
      Application.CreateForm(TfmMain, fmMain);
  Application.Run;
  end;
end.
