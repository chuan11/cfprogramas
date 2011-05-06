object frmBackup: TfrmBackup
  Left = 357
  Top = 155
  Width = 311
  Height = 177
  BorderIcons = [biSystemMenu]
  Caption = 'Backup'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnBackup: TBitBtn
    Left = 189
    Top = 104
    Width = 99
    Height = 25
    Caption = 'Fazer Backup'
    TabOrder = 0
    OnClick = btnBackupClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
      7700333333337777777733333333008088003333333377F73377333333330088
      88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
      000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
      FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
      99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
      99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
      99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
      93337FFFF7737777733300000033333333337777773333333333}
    NumGlyphs = 2
  end
  object Animate1: TAnimate
    Left = 16
    Top = 32
    Width = 272
    Height = 60
    CommonAVI = aviCopyFiles
    StopFrame = 31
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 104
    Width = 121
    Height = 17
    Caption = 'Guardar em Disquete'
    TabOrder = 2
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
    Left = 144
    Top = 104
  end
end
