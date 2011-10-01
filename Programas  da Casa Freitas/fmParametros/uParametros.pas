unit uParametros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, adLabelComboBox, funcsql,
  Buttons, fCtrls;

type
  TfmParametros = class(TForm)
    gdParam: TSoftDBGrid;
    cbParametros: TadLabelComboBox;
    tbParam: TADOTable;
    DataSource1: TDataSource;
    btIncluiXML: TfsBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure carregaListaParametros();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbParametrosChange(Sender: TObject);
    procedure carregaComboParametros();
    procedure btIncluiXMLClick(Sender: TObject);
    procedure gdParamDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmParametros: TfmParametros;

implementation

uses uMain, funcoes;

{$R *.dfm}

procedure TfmParametros.carregaListaParametros;
begin
   tbParam.TableName := 'zcf_paramGerais';
   if (tbParam.Active = true) then
     tbParam.Close();

   if (cbParametros.ItemIndex > 0) then
   begin
      tbParam.Filtered := true;
      tbParam.Filter := 'nm_param = ' + quotedStr(cbParametros.Items[cbParametros.ItemIndex]);
   end
   else
      tbParam.Filtered := false;

   tbParam.Open();

   gdParam.Columns[ tbParam.fieldByName('nm_param').index ].Width := 150;
   gdParam.Columns[ tbParam.fieldByName('uo').index ].Width := 40;
   gdParam.Columns[ tbParam.fieldByName('valor').index ].Width := 300;
   gdParam.Columns[ tbParam.fieldByName('obs').index ].Width := 300;
end;

procedure TfmParametros.FormActivate(Sender: TObject);
begin
   carregaComboParametros();
end;

procedure TfmParametros.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
   action := caFree;
   fmParametros := nil;
   carregaListaParametros();
end;

procedure TfmParametros.cbParametrosChange(Sender: TObject);
begin
   carregaListaParametros()
end;

procedure TfmParametros.carregaComboParametros;
begin
   cbParametros.Items :=  funcsql.getListagem('Select distinct nm_param from zcf_paramGerais order by nm_param', fmMain.Conexao);
end;

procedure TfmParametros.btIncluiXMLClick(Sender: TObject);
var
  str:String;
begin
   str := InputBox('', 'informe o nome do parâmetro', '');
   if (str <> '') then
   begin
      str:= 'insert zcf_paramgerais select ' + quotedStr(str)+', is_uo, '''' , ds_uo from tbuo where tp_estoque in (1, 2)';
      funcsql.execSQL(str, fmMain.Conexao);
   end;
end;

procedure TfmParametros.gdParamDblClick(Sender: TObject);
begin
   if (funcoes.msgTela('','Remove esse parametro ?' , mb_Iconquestion + Mb_Yesno) = mrYes) then
      tbParam.Delete();
end;

end.


