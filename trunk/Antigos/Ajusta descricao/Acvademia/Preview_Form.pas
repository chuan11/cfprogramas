unit Preview_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, QRPrntr;

type
  TfrmPreview = class(TForm)
    QRPreview1: TQRPreview;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    lblSimbolo: TLabel;
    sbPrimeiro: TSpeedButton;
    sbAnterior: TSpeedButton;
    sbProximo: TSpeedButton;
    sbUltima: TSpeedButton;
    Edit1: TEdit;
    Label1: TLabel;
    sbSetup: TSpeedButton;
    sbImprime: TSpeedButton;
    sbFecha: TSpeedButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure sbPrimeiroClick(Sender: TObject);
    procedure sbAnteriorClick(Sender: TObject);
    procedure sbProximoClick(Sender: TObject);
    procedure sbUltimaClick(Sender: TObject);
    procedure QRPreview1PageAvailable(Sender: TObject; PageNum: Integer);
    procedure Edit1Change(Sender: TObject);
    procedure sbSetupClick(Sender: TObject);
    procedure sbImprimeClick(Sender: TObject);
    procedure sbFechaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ChecaPaginas;
  end;

var
  frmPreview: TfrmPreview;

implementation

{$R *.DFM}

procedure TfrmPreview.ChecaPaginas;
begin
 Edit1.Text := IntToStr(QrPreview1.PageNumber);
 label1.Caption := 'de '+ IntToStr(QrPreview1.QrPrinter.PageCount);
 sbPrimeiro.Enabled := (qrPreview1.PageNumber > 1);
 sbAnterior.Enabled := (qrPreview1.PageNumber > 1);
 sbProximo.Enabled := (qrPreview1.PageNumber <
 qrPreview1.QRPrinter.PageCount);
 sbUltima.Enabled := (qrPreview1.PageNumber <
 qrPreview1.QRPrinter.PageCount);
end; 
procedure TfrmPreview.ComboBox1Change(Sender: TObject);
begin
  try
    qrPreview1.Zoom := StrToInt(ComboBox1.Text)
   except
  End;
end;

procedure TfrmPreview.sbPrimeiroClick(Sender: TObject);
begin
QrPreview1.PageNumber := 1;
ChecaPaginas;
end;

procedure TfrmPreview.sbAnteriorClick(Sender: TObject);
begin
QrPreview1.PageNumber := QrPreview1.PageNumber-1;
ChecaPaginas;
end;

procedure TfrmPreview.sbProximoClick(Sender: TObject);
begin
QrPreview1.PageNumber := QrPreview1.PageNumber+1;
ChecaPaginas;
end;

procedure TfrmPreview.sbUltimaClick(Sender: TObject);
begin
QrPreview1.PageNumber := QrPreview1.QRPrinter.PageCount;
ChecaPaginas;
end;

procedure TfrmPreview.QRPreview1PageAvailable(Sender: TObject;
  PageNum: Integer);
begin
  ChecaPaginas;
end;

procedure TfrmPreview.Edit1Change(Sender: TObject);
begin
 try
   qrPreview1.PageNumber := StrToInt(Edit1.Text);
  except
 End; // Try
end;

procedure TfrmPreview.sbSetupClick(Sender: TObject);
begin
QrPreview1.QRPrinter.PrintSetup;
end;

procedure TfrmPreview.sbImprimeClick(Sender: TObject);
begin
QrPreview1.QRPrinter.Print;
end;

procedure TfrmPreview.sbFechaClick(Sender: TObject);
begin
Close;
end;

procedure TfrmPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
frmPreview := Nil;
end;

end.
