unit unMovDiario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, fCtrls, ToolWin, StdCtrls, DB, ADODB, Grids, DBGrids,
  SoftDBGrid, ImgList;

type
  TfmMovDiario = class(TForm)
    ToolBar1: TToolBar;
    tbtNova: TToolButton;
    GroupBox2: TGroupBox;
    SoftDBGrid1: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    tbItem: TStringField;
    tbvalor: TBCDField;
    tbtAbrir: TToolButton;
    ImageList1: TImageList;
    tbSalvar: TToolButton;
    ToolButton2: TToolButton;
    tbConfere: TToolButton;
    tbseq: TAutoIncField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMovDiario: TfmMovDiario;
  isAlterado:Boolean;
implementation

{$R *.dfm}
uses uMain;

procedure TfmMovDiario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmMovDiario := nil;
end;

end.
