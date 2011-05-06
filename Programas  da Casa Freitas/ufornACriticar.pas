unit ufornACriticar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, funcsql, StdCtrls,
  Buttons, fCtrls, funcoes;

type
  TfmFornACriticar = class(TForm)
    grid: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    fsBitBtn1: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure fsBitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmFornACriticar: TfmFornACriticar;

implementation
uses uMain, uforn ;
{$R *.dfm}

procedure TfmFornACriticar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := cafree;
  fmFornACriticar := nil;
end;

procedure TfmFornACriticar.FormActivate(Sender: TObject);
begin
  tb.TableName := 'zcf_FornCritReq';
  tb.Open;
  grid.Columns[0].Visible := false;
  grid.Columns[0].Width := 50;
  grid.Columns[0].Width := 200;
  funcSQl.OrganizarTabela(tb,  grid.Columns[2]);
  funcSQl.OrganizarTabela(tb,  grid.Columns[2]); 
end;

procedure TfmFornACriticar.fsBitBtn1Click(Sender: TObject);
begin
   Application.CreateForm(TfmForn, fmForn);
   fmForn.ShowModal;
   if fmForn.ModalResult = mrOk then
   begin
       tb.AppendRecord([fmForn.qrCredores.FieldByName('is_cred').asString,
                        fmForn.qrCredores.FieldByName('codigo').asString,
                        fmForn.qrCredores.FieldByName('fornecedor').asString
                       ]
                      );
   end;
end;

procedure TfmFornACriticar.fsBitBtn2Click(Sender: TObject);
begin
   if msgTela('','Remove o fornecedor : ' + tb.fieldbyName('descricao').asString + '.....',mb_yesNo + MB_ICONQUESTION) = mryes then
      tb.Delete;
end;

end.
