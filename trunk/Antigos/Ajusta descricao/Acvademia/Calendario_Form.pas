unit Calendario_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Grids, Calendar, Spin, ExtCtrls;

type
  TfrmCalendario = class(TForm)
    Calendario: TCalendar;
    cmbMes: TComboBox;
    Label1: TLabel;
    edAno: TEdit;
    Label2: TLabel;
    SpinButton1: TSpinButton;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edAnoKeyPress(Sender: TObject; var Key: Char);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure cmbMesClick(Sender: TObject);
    procedure edAnoExit(Sender: TObject);
    procedure cmbMesKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCalendario: TfrmCalendario;
  Mes, Ano: Word;

implementation

{$R *.DFM}

procedure TfrmCalendario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
frmCalendario := Nil;
end;

procedure TfrmCalendario.FormCreate(Sender: TObject);
begin
Calendario.CalendarDate := Trunc(Now);
Mes := Calendario.Month;
Ano := Calendario.Year;
edAno.Text := IntToStr(Ano);
cmbMes.ItemIndex := mes - 1;
end;

procedure TfrmCalendario.edAnoKeyPress(Sender: TObject; var Key: Char);
begin
if not(Key in['0'..'9',#8]) then
 Key := #0;
end;

procedure TfrmCalendario.SpinButton1DownClick(Sender: TObject);
begin
Ano := Ano - 1;
edAno.Text := IntToStr(Ano);
Calendario.Year := Ano;
end;

procedure TfrmCalendario.SpinButton1UpClick(Sender: TObject);
begin
Ano := Ano + 1;
edAno.Text := IntToStr(Ano);
Calendario.Year := Ano;
end;

procedure TfrmCalendario.cmbMesClick(Sender: TObject);
begin
Calendario.Month := cmbMes.ItemIndex + 1;
end;

procedure TfrmCalendario.edAnoExit(Sender: TObject);
begin
Ano := StrToInt(edAno.Text);
Calendario.Year := Ano;
end;

procedure TfrmCalendario.cmbMesKeyPress(Sender: TObject; var Key: Char);
begin
Key := #0;
end;

end.
