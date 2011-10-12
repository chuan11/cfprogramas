unit uResumoCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, adLabelComboBox, fCtrls,
  DB, ADODB, Grids, DBGrids, SoftDBGrid;

type
  TfmResumoCaixa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    cbLojas: TadLabelComboBox;
    ToolButton2: TToolButton;
    dt: TfsDateTimePicker;
    Label1: TLabel;
    grid: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmResumoCaixa: TfmResumoCaixa;

implementation
uses uMain, funcoes, funcSQL, uCF;

{$R *.dfm}

procedure TfmResumoCaixa.FormCreate(Sender: TObject);
begin
   uCF.getListaLojas(cbLojas, false, false, fmMain.getCdPesLogado() );
   dt.Date := now;
end;

end.
