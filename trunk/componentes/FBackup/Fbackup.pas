unit Fbackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ZipMstr;

type
  TfrmBackup = class(TForm)
    btnBackup: TBitBtn;
    Animate1: TAnimate;
    CheckBox1: TCheckBox;
    ZipMaster1: TZipMaster;
    procedure btnBackupClick(Sender: TObject);
  private
    procedure procura;
  public
    { Public declarations }
  end;

var
  frmBackup: TfrmBackup;

implementation

uses Math;

{$R *.dfm}

procedure TFrmBackup.Procura;
var
  Procurar : TSearchRec;
  Arquivos: Integer;
begin
  Arquivos := 0;
  Arquivos := Arquivos + faDirectory;
  Arquivos := Arquivos + faArchive;
  Arquivos := Arquivos + faAnyFile;

    if FindFirst(ExtractFilePath(Application.ExeName)+'\*.*', Arquivos, Procurar) = 0 then
    begin
      repeat
        if (Procurar.Attr and Arquivos) = Procurar.Attr then
          If ((Pos('.exe', Procurar.Name)=0) and (Pos('.HLP', Procurar.Name)=0)and
              (Pos('.cnt', Procurar.Name)=0) and (Pos('.dll', Procurar.Name)=0)and
              (Pos('.bin', Procurar.Name)=0)) Then
          Begin
              ZipMaster1.FSpecArgs.Add(ExtractFilePath(Application.ExeName)+'\'+Procurar.Name);
          End;
      until FindNext(Procurar) <> 0;
      FindClose(Procurar);
    end;
end;


procedure TfrmBackup.btnBackupClick(Sender: TObject);
begin
  btnBackup.Enabled:=False;
  Animate1.Active:=True;
  ZipMaster1.ZipFileName:=ExtractFilePath(Application.ExeName)+'Backup'+FormatDateTime('ddmmyyyy', Date)+'.zip';
  ZipMaster1.FSpecArgs.Clear;
  Procura;
  ZipMaster1.Add;
  If CheckBox1.Checked=True Then
    CopyFile(PChar(ExtractFilePath(Application.ExeName)+'Backup'+FormatDateTime('ddmmyyyy', Date)+'.zip'), PChar('A:\Backup'+FormatDateTime('ddmmyyyy', Date)+'.zip'), true);
  If ZipMaster1.SuccessCnt >= 1 then
    MessageDlg('Backup realizado com sucesso!', mtInformation, [mbOk],0)
  Else
    MessageDlg('Erro ao fazer o Backup. Tente novamente!', mtError, [mbOk],0);
  Animate1.Active:=False;
  btnBackup.Enabled:=True;
end;

end.
