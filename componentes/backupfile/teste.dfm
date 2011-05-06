object Form1: TForm1
  Left = 192
  Top = 103
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FlatGauge1: TFlatGauge
    Left = 312
    Top = 152
    Width = 281
    Height = 25
    AdvColorBorder = 0
    ColorBorder = 8623776
    Progress = 0
  end
  object Button1: TFlatButton
    Left = 320
    Top = 72
    Width = 121
    Height = 49
    TabOrder = 0
    OnClick = Button1Click
  end
  object FileListBox1: TFileListBox
    Left = 32
    Top = 181
    Width = 201
    Height = 129
    ItemHeight = 13
    TabOrder = 1
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 32
    Top = 62
    Width = 201
    Height = 113
    ItemHeight = 16
    TabOrder = 2
    OnChange = DirectoryListBox1Change
  end
  object Drive1: TDriveComboBox
    Left = 32
    Top = 32
    Width = 145
    Height = 19
    TabOrder = 3
    OnChange = Drive1Change
  end
  object Memo1: TFlatMemo
    Left = 248
    Top = 208
    Width = 425
    Height = 89
    ColorFlat = clBtnFace
    ParentColor = True
    TabOrder = 4
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 434
    Width = 688
    Height = 19
    Panels = <>
  end
  object Bk1: TBackupFile
    Version = '1.30'
    BackupMode = bmAll
    RestoreMode = rmAll
    MaxSize = 0
    SetArchiveFlag = True
    OnProgress = Bk1Progress
    RestoreFullPath = False
    SaveFileID = False
    Left = 392
    Top = 24
  end
  object ZipMaster1: TZipMaster
    Verbose = False
    Trace = False
    AddCompLevel = 9
    AddOptions = []
    ExtrOptions = []
    Unattended = False
    MinZipDllVers = 170
    MinUnzDllVers = 170
    VersionInfo = '1.70'
    AddStoreSuffixes = [assGIF, assPNG, assZ, assZIP, assZOO, assARC, assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR, assACE, assCAB, assGZ, assGZIP, assJAR]
    KeepFreeOnDisk1 = 0
    SFXCaption = 'Self-extracting Archive'
    SFXOverWriteMode = OvrConfirm
    SFXPath = 'ZipSFX.bin'
    Left = 248
    Top = 48
  end
end
