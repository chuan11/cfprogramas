unit uManutencaoCX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRemoveRegTEF, Menus, DB, ADODB, StdCtrls, adLabelEdit,
  adLabelNumericEdit, ComCtrls, fCtrls, TFlatButtonUnit, Grids, DBGrids,
  SoftDBGrid, adLabelComboBox;

type
  TfmManutencaoCX = class(TfmRemRegTEF)
    lbCodCaixa: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbLojasChange(Sender: TObject);
    procedure cbCaixasChange(Sender: TObject);
    procedure carregaOpcoesDeCaixa();
    procedure cbModalidadeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmManutencaoCX: TfmManutencaoCX;

implementation

uses uMain, funcoes, funcSQL, uCF;

{$R *.dfm}

procedure TfmManutencaoCX.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  inherited;
   action := cafree;
   fmManutencaoCX := nil;
end;

procedure TfmManutencaoCX.FormCreate(Sender: TObject);
begin
   carregaCampos(fmManutencaoCX);
   carregaOpcoesDeCaixa();
end;

procedure TfmManutencaoCX.cbLojasChange(Sender: TObject);
begin
   cbCaixas.Items :=  uCF.getDescCaixas( funcoes.getCodUO(cbLojas), false);
   carregaOpcoesDeCaixa();
end;

procedure TfmManutencaoCX.cbCaixasChange(Sender: TObject);
var
   ds:TdataSet;
   cmd:String;
begin
   cmd :=
   'Select statusCaixa from caixas where codLoja=' + funcoes.getCodUO(cbLojas) +
   'and  codCaixa= ' + funcoes.getCodCaixa(cbCaixas);
   ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);

   if (ds.FieldByName('statusCaixa').AsString = 'A') then
      cbModalidade.ItemIndex := 0
   else
      cbModalidade.ItemIndex := 1;
   ds.FieldByName('codCaixa').AsString;
   lbCodCaixa.Caption := 'Caixa: ' + ds.FieldByName('codCaixa').AsString;
   ds.free();
end;

procedure TfmManutencaoCX.carregaOpcoesDeCaixa;
begin
   Label1.Visible := false;
   dt.Visible := false;
   btConsulta.Visible := false;
   groupBox1.Caption := 'Caixas';
   cbModalidade.LabelDefs.Caption := 'Status Caixa';
   cbModalidade.Items.Clear();   
   cbModalidade.Items.Add('Aberto');
   cbModalidade.Items.Add('Fechado');
   cbModalidade.ItemIndex := -1;
end;

procedure TfmManutencaoCX.cbModalidadeChange(Sender: TObject);
var
   cmd:String;
begin
   if (funcoes.msgTela('',
                      'Mudar o status do caixa para ' +
                      cbModalidade.Items[cbModalidade.ItemIndex] +' ?',
                      MB_YESNO + MB_ICONQUESTION ) = mrYes) then
   begin
      cmd :=
      ' update caixas set statusCaixa = ' + quotedStr(copy(cbModalidade.Items[cbModalidade.ItemIndex],01,01)) +
      ' where codLoja=' + funcoes.getCodUO(cbLojas) +
      ' and  codCaixa= ' + funcoes.getCodCaixa(cbCaixas);
      funcSQL.execSQL(cmd, fmMain.Conexao);
      funcoes.msgTela('', 'Status do caixa alterado!', MB_ICONEXCLAMATION + 0);
   end;
end;

end.
