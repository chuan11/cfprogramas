unit uListaItensPorNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ADODB,
  TFlatButtonUnit, StdCtrls, adLabelEdit, adLabelComboBox,
  Dialogs, funcoes, funcsql, Buttons, Grids, DBGrids, SoftDBGrid, DB,
  fCtrls, ScktComp;

type
  TfmListaItensNota = class(TForm)
    cbLoja: TadLabelComboBox;
    edSerie: TadLabelEdit;
    edNNota: TadLabelEdit;
    btPesq: TFlatButton;
    grid: TSoftDBGrid;
    qrNota: TADOQuery;
    DataSource1: TDataSource;
    btOk: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    procedure btPesqClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure getprecosDeUmaNota();
    procedure getIsNota();
    procedure btOkClick(Sender: TObject);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListaItensNota: TfmListaItensNota;
  gravaDadosSocket:boolean;
implementation

uses uMain, Uprecoswell, uCF, Math;

{$R *.dfm}


procedure TfmListaItensNota.getprecosDeUmaNota;
var
   qr:TadoQuery;
begin
{   cmd := ' select cd_ref, dbo.z_cf_funObterPrecoProduto_cf('+ funcsql.getCodPreco(cbPreco)  +'  , is_ref, '+ getCodUo(cbLoja)+' ,0) as preco from crefe with(nolock) where ' +
          ' is_ref in  (select is_ref from dmovi (noLock)where is_nota in ' +
          ' ( select is_nota from dnota where is_estoque =  ' + funcSQL.getCodUo(cbLoja) + '   and sr_docf = ' + quotedStr(edSerie.text) + ' and '
          + ' nr_docf = ' + edNNota.Text    + '  ) )  ';
   funcsql.getQuery( fmMain.Conexao, qr, cmd);
   tecla:= VK_RETURN;
   if qr.IsEmpty = false then
   begin
      qr.First;
      while qr.Eof = false do
      begin
         fmLancaPrecos.edPcNovo.Text := qr.fieldByName('cd_ref').asString;
         fmLancaPrecos.edPcNovo.OnKeyDown(nil, tecla , []);
         fmLancaPrecos.edPcNovo.Text := qr.fieldByName('preco').asString;
         fmLancaPrecos.edPcNovo.OnKeyDown(nil, tecla , []);
         qr.Next();
      end;
   end
   else
      msgTela('','Nao achei essa nota.',MB_ICONERROR + MB_OK);

}  fmListaItensNota.Close();
end;

procedure TfmListaItensNota.FormCreate(Sender: TObject);
begin
   fmMain.getListaLojas(cbLoja, false, false, '');
//   cbPreco.Items := funcSql.getListaPrecos( fmMain.Conexao, false, false, false, fmMain.getGrupoLogado());
end;

procedure TfmListaItensNota.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//   fmListaItensNota := NIL;
//   Action := CaFree;
end;

procedure TfmListaItensNota.getIsNota;
var
   i:integer;
begin
   qrNota := ucf.getDadosNota('', funcoes.getCodUO(cbLoja), edSerie.Text, edNNota.Text );

   DataSource1.DataSet := qrNota;
   for i:=0 to grid.Columns.Count -1 do
   grid.Columns[i].Visible := false;


   grid.Columns[qrNota.FieldByname('Serie').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Tipo').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Situacao').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Num').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Num').Index].Width := 50;
   grid.Columns[qrNota.FieldByname('Emissor/Destino').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Emissor/Destino').Index].Width := 150;
   grid.Columns[qrNota.FieldByname('Loja').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Valor').Index].Visible := true;
end;

procedure TfmListaItensNota.btPesqClick(Sender: TObject);
var
   erro:String;
begin
   erro := '';
   if (edSerie.Text = '') or (edNNota.text  = '') then
      erro := erro + ' - Preencha serie e numero da nota.'  +#13;
   if (erro <> '') then
   begin
      erro := '   Corrija antes esses erros     ' +#13 + erro;
      msgTela('',erro,MB_ICONERROR + mb_ok);
   end
   else
      getIsNota();
   edSerie.SetFocus();   
end;

procedure TfmListaItensNota.btOkClick(Sender: TObject);
begin
  if (qrNota.IsEmpty = false) then
  begin
    fmListaItensNota.Caption := qrNota.FieldByname('is_nota').asString;
    btOk.ModalResult := mrOk;
    fmListaItensNota.ModalResult := mrOk
  end
  else
    fmListaItensNota.ModalResult := mrCancel;
end;

procedure TfmListaItensNota.fsBitBtn2Click(Sender: TObject);
begin
//    fmListaItensNota.ModalResult := mrCancel;
end;

procedure TfmListaItensNota.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
//   showMessage(intToStr(modalREsult));
   if (ModalResult = 2 ) then
   begin
      CanClose := false;

      if (edSerie.Text = '') then
        edSerie.setFocus()
      else if (edNNota.Text = '') then
        edNNota.setFocus()
      else
         btPesqClick(nil);
   end;
end;

end.
