unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  backup, StdCtrls, ExtCtrls, ComCtrls, FileCtrl;

type
  TForm1 = class(TForm)
    OpenDialog: TOpenDialog;
    Backupfile1: TBackupFile;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FileListBox: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Panel1: TPanel;
    Button3: TButton;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    Edit1: TEdit;
    BtnCancel: TButton;
    SaveDialog: TSaveDialog;
    Button5: TButton;
    Button6: TButton;
    FileListBox1: TFileListBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Edit2: TEdit;
    RadioGroup2: TRadioGroup;
    Label3: TLabel;
    RadioGroup3: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Backupfile1Progress(Sender: TObject; Filename: String;
      Percent: TPercentage; var Continue: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Backupfile1RestoreFile(Sender: TObject; var Filename: String;
      var DoRestore: Boolean);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
   I: Integer;
begin
   if OpenDialog.execute then with FileListbox.items do
   begin
     beginupdate;
     for I := 0 to OpenDialog.files.count-1 do
       if indexof(lowercase(OpenDialog.files[i])) = -1 then
          add(lowercase(OpenDialog.files[i]));
     endupdate;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     if Filelistbox.items.count = 0 then Showmessage('No files added')
     else with SaveDialog do if execute then
     begin
          if uppercase(copy(filename, 1, 1)) = 'A' then
          begin
               Showmessage('Drive A indicates a floppy drive - please a new empty disk');
               BackupFile1.maxSize := 1400000;  //backup to floppy
          end
          else BackupFile1.maxSize := 0;

          backupfile1.backuptitle := Edit1.text;
          backupfile1.backupmode  := TBackupMode(RadioGroup1.itemindex);
          if backupfile1.backup(filelistbox.items, filename)
           then Showmessage('Backup sucessful')
           else Showmessage('Backup failed or aborted');
     end;
end;

procedure TForm1.Backupfile1Progress(Sender: TObject; Filename: String;
  Percent: TPercentage; var Continue: Boolean);
begin
     with Progressbar1 do
     begin
          visible := Percent < 100;
          if visible then position := Percent;
     end;
     if Percent < 100 then Label1.caption := Filename else Label1.caption := '';
end;

procedure TForm1.Button4Click(Sender: TObject);
var
   S: string;
begin
     S := extractFilepath(application.exename)+'*.*';
     if InputQuery('Add files with wildcards', 'Enter path + file mask', S) then FileListBox.items.add(S);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
     filelistbox.items.clear;
end;

procedure TForm1.BtnCancelClick(Sender: TObject);
begin
     if not BackupFile1.busy then close
     else if MessageDlg('Do you want to abort the operation',mtConfirmation, [mbYes,mbNo], 0) = mrYes then Backupfile1.Stop;
end;

procedure TForm1.FileListBox1Click(Sender: TObject);
begin
     Edit2.text := backupfile1.getArchiveTitle(Filelistbox1.filename);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     backupfile1.Restoremode  := TRestoreMode(RadioGroup2.itemindex);
     showmessage('Restore finished, '+inttostr( backupfile1.restore(filelistbox1.filename, '') )+' files restored');
end;

procedure TForm1.Backupfile1RestoreFile(Sender: TObject;
  var Filename: String; var DoRestore: Boolean);
begin
     if Radiogroup3.itemindex = 1 then
       DoRestore := InputQuery('Do you want to restore this file?', 'Enter path + file name to restore to', FileName);
end;

end.
