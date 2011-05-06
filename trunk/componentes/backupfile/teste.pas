unit teste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, backup, FileCtrl, StdCtrls, TFlatGaugeUnit,
  TFlatMemoUnit, ComCtrls, ZipMstr;

type
  TForm1 = class(TForm)
    Bk1: TBackupFile;
    Button1: TFlatButton;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    Drive1: TDriveComboBox;
    FlatGauge1: TFlatGauge;
    Memo1: TFlatMemo;
    StatusBar1: TStatusBar;
    ZipMaster1: TZipMaster;
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure Drive1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Bk1Progress(Sender: TObject; Filename: String;
      Percent: TPercentage; var Continue: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DirectoryListBox1Change(Sender: TObject);
var
   i:integer;
begin
   memo1.Clear;
   filelistbox1.Directory := DirectoryListBox1.Directory;

   for i:=0 to filelistbox1.Count-1 do
   begin
      memo1.Lines.Add( DirectoryListBox1.Directory +'\'+   filelistbox1.Items[i] );
   end;

end;

procedure TForm1.Drive1Change(Sender: TObject);
begin
   DirectoryListBox1.Drive := Drive1.Drive;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   arq:Tstringlist;//TStrings;
   i:integer;
begin
   memo1.Clear;
   arq :=Tstringlist.Create;
   for i:=0 to filelistbox1.Count-1 do
   begin
      memo1.Lines.Add( DirectoryListBox1.Directory +'\'+   filelistbox1.Items[i] );
      arq.Add( DirectoryListBox1.Directory +'\'+   filelistbox1.Items[i]);
   end;
      bk1.backup(arq, 'c:\Backup.bkp');




end;

procedure TForm1.Bk1Progress(Sender: TObject; Filename: String; Percent: TPercentage; var Continue: Boolean);
begin
   statusbar1.SimpleTExt := Filename;
   flatgauge1.Progress := percent
end;

end.
