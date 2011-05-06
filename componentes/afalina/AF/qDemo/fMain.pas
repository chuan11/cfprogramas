unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ImgList, fCtrls, fDBCtrls, DBCtrls, DBGrids,
  ComCtrls, Buttons, Grids, CheckLst, Mask;

type
  TfrmMain = class(TForm)
    fmMain: TfsManager;
    tvMain: TfsTreeView;
    sp: TSplitter;
    panClient: TPanel;
    ilMain: TImageList;
    pcMain: TPageControl;
    tsManager: TTabSheet;
    tsEdits: TTabSheet;
    tsMemos: TTabSheet;
    tsGrids: TTabSheet;
    tsDBGrids: TTabSheet;
    tsOtherDB: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    fsLabel2: TfsLabel;
    fsLabel3: TfsLabel;
    fsLabel4: TfsLabel;
    fsEdit1: TfsEdit;
    fsEdit3: TfsEdit;
    fsComboEdit1: TfsComboEdit;
    fsLabel6: TfsLabel;
    fsComboEdit2: TfsComboEdit;
    Panel4: TPanel;
    fsLabel7: TfsLabel;
    fsLabel5: TfsLabel;
    Panel5: TPanel;
    fsLabel8: TfsLabel;
    fsLabel9: TfsLabel;
    lblLink: TfsLabel;
    Panel6: TPanel;
    fsLabel17: TfsLabel;
    fsLabel18: TfsLabel;
    fsMaskEdit1: TfsMaskEdit;
    fsComboBox1: TfsComboBox;
    gbEdits: TGroupBox;
    fsLabel19: TfsLabel;
    cbStandard: TfsCheckBox;
    cbFlat: TfsCheckBox;
    cbCorel: TfsCheckBox;
    cbLotus: TfsCheckBox;
    cbOffice: TfsCheckBox;
    Panel7: TPanel;
    Panel8: TPanel;
    fsLabel20: TfsLabel;
    Panel9: TPanel;
    Panel10: TPanel;
    fsLabel1: TfsLabel;
    Panel11: TPanel;
    fsLabel11: TfsLabel;
    fsMemo1: TfsMemo;
    fsLabel22: TfsLabel;
    Panel12: TPanel;
    fsCheckListBox1: TfsCheckListBox;
    fsLabel23: TfsLabel;
    Panel13: TPanel;
    fsLabel24: TfsLabel;
    fsLabel25: TfsLabel;
    fsListBox1: TfsListBox;
    TabSheet1: TTabSheet;
    Panel14: TPanel;
    fsLabel13: TfsLabel;
    Panel15: TPanel;
    fsLabel12: TfsLabel;
    Panel16: TPanel;
    fsLabel14: TfsLabel;
    Panel17: TPanel;
    fsLabel15: TfsLabel;
    dgMain: TfsDrawGrid;
    Panel18: TPanel;
    Panel19: TPanel;
    sgMain: TfsStringGrid;
    Splitter1: TSplitter;
    Panel20: TPanel;
    fsLabel30: TfsLabel;
    Panel21: TPanel;
    fsLabel29: TfsLabel;
    fsLabel31: TfsLabel;
    Panel24: TPanel;
    Panel22: TPanel;
    fsBitBtn1: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    Panel25: TPanel;
    dbgCustomer: TfsDBGrid;
    Panel26: TPanel;
    fsLabel32: TfsLabel;
    Splitter2: TSplitter;
    fsLabel33: TfsLabel;
    Panel27: TPanel;
    fsLabel34: TfsLabel;
    dbgOrders: TfsDBGrid;
    Panel28: TPanel;
    fsDBGrid1: TfsDBGrid;
    Panel29: TPanel;
    fsLabel35: TfsLabel;
    fsDBEdit1: TfsDBEdit;
    Panel30: TPanel;
    fsLabel36: TfsLabel;
    fsDBEdit2: TfsDBEdit;
    Panel31: TPanel;
    fsLabel37: TfsLabel;
    Panel32: TPanel;
    fsDBText1: TfsDBText;
    fsLabel38: TfsLabel;
    Panel33: TPanel;
    fsLabel39: TfsLabel;
    fsLabel40: TfsLabel;
    fsDBEdit5: TfsDBEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    fsLabel41: TfsLabel;
    Panel34: TPanel;
    fsLabel42: TfsLabel;
    Panel35: TPanel;
    fsLabel43: TfsLabel;
    Panel36: TPanel;
    fsLabel44: TfsLabel;
    fsDBEdit7: TfsDBEdit;
    Panel37: TPanel;
    gbStyles: TGroupBox;
    rbStandard: TfsRadioButton;
    rbFlat: TfsRadioButton;
    fsLabel45: TfsLabel;
    Panel38: TPanel;
    fsLabel47: TfsLabel;
    fsLabel48: TfsLabel;
    fsDBEdit8: TfsDBEdit;
    fsDBEdit9: TfsDBEdit;
    Panel39: TPanel;
    fsLabel49: TfsLabel;
    fsLabel50: TfsLabel;
    fsDBEdit11: TfsDBEdit;
    fsDBDateTimePicker1: TfsDBDateTimePicker;
    fsDBComboEdit1: TfsDBComboEdit;
    dbcState: TfsDBComboBox;
    dbcCountry: TfsDBComboBox;
    Panel41: TPanel;
    fsSpeedButton7: TfsSpeedButton;
    fsSpeedButton8: TfsSpeedButton;
    fsSpeedButton9: TfsSpeedButton;
    fsSpeedButton10: TfsSpeedButton;
    lblBevel: TfsLabel;
    fsLabel60: TfsLabel;
    fsSpeedButton11: TfsSpeedButton;
    fsLabel54: TfsLabel;
    fsSpeedButton12: TfsSpeedButton;
    fsSpeedButton13: TfsSpeedButton;
    fsSpeedButton14: TfsSpeedButton;
    Bevel3: TBevel;
    fsLabel62: TfsLabel;
    GroupBox1: TGroupBox;
    rbStandard2: TfsRadioButton;
    rbFlat2: TfsRadioButton;
    rbCorel2: TfsRadioButton;
    rbLous2: TfsRadioButton;
    rbOffice2: TfsRadioButton;
    fsLabel27: TfsLabel;
    lvMain: TfsListView;
    fsSpeedButton1: TfsSpeedButton;
    fsLabel51: TfsLabel;
    fsLabel52: TfsLabel;
    fsLabel46: TfsLabel;
    fsLabel53: TfsLabel;
    fsLabel55: TfsLabel;
    fsLabel56: TfsLabel;
    fsDBText2: TfsDBText;
    fsLabel57: TfsLabel;
    fsLabel58: TfsLabel;
    fsLabel59: TfsLabel;
    fsLabel61: TfsLabel;
    Panel23: TPanel;
    fsLabel64: TfsLabel;
    fsLabel21: TfsLabel;
    DateOne: TfsDateTimePicker;
    DateTwo: TfsDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure tvMainChange(Sender: TObject; Node: TTreeNode);
    procedure ChangeStyle(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblLinkClick(Sender: TObject);
  private
    { Private declarations }
    FPageControlWndProc: TWndMethod;
    procedure PageControlWndProc(var Message: TMessage);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses fDM, CommCtrl, ShellAPI;

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: integer;
begin
  FPageControlWndProc := pcMain.WindowProc;
  pcMain.WindowProc := PageControlWndProc;
  for i := 0 to pcMain.PageCount - 1 do
    pcMain.Pages[i].TabVisible := false;
  tvMain.FullExpand;
  tvMain.Selected := tvMain.Items[0];
  DateOne.Date := Date;
  DateTwo.Date := Date;

  sgMain.Cells[0, 0] := '...';
  for i := 1 to sgMain.ColCount - 1 do sgMain.Cells[i, 0] := 'Column ' + IntToStr(i);
  for i := 1 to sgMain.RowCount - 1 do sgMain.Cells[0, i] := 'Row ' + IntToStr(i);

  with DM do
    try
      tblCustomer.Open;
      tblCustomer.First;
      while not tblCustomer.Eof do begin
        if dbcCountry.Items.IndexOf(tblCustomerCountry.AsString) = -1 then
          dbcCountry.Items.Add(tblCustomerCountry.AsString);

        if (dbcState.Items.IndexOf(tblCustomerState.AsString) = -1) and
           (tblCustomerState.AsString <> '') then
          dbcState.Items.Add(tblCustomerState.AsString);
        tblCustomer.Next;
      end;
      tblCustomer.First;
      tblOrders.Open;
    except
      MessageDlg('An error occurred while attempting access to alias DBDEMOS', mtError, [mbOK], 0);
    end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with DM do begin
    if tblOrders.Active then tblOrders.Close;
    if tblCustomer.Active then tblCustomer.Close;
  end;
end;

procedure TfrmMain.tvMainChange(Sender: TObject; Node: TTreeNode);
begin
  case Node.AbsoluteIndex of
  { FlatManager }
    0: pcMain.ActivePage := pcMain.Pages[Node.AbsoluteIndex];
  { Edits, Lists & Memos, Grids, Buttons & Other }
    2, 3, 4, 5:
       pcMain.ActivePage := pcMain.Pages[Node.AbsoluteIndex - 1];
  { DBGrids, OtherDBControls  }
    7, 8:
       pcMain.ActivePage := pcMain.Pages[Node.AbsoluteIndex - 2];
  end;
end;

procedure TfrmMain.ChangeStyle(Sender: TObject);
begin
  fmMain.GlobalStyle := TFlatStyle((Sender as TControl).Tag);
  if Sender is TRadioButton then
    case (Sender as TControl).Tag of
      0: begin
           cbFlat.Checked := false;
           cbStandard.Checked := true;
           rbStandard2.Checked := true;
         end;
      1: begin
           cbFlat.Checked := true;
           cbStandard.Checked := false;
           rbFlat2.Checked := true;
         end;
    end;
end;

procedure TfrmMain.PageControlWndProc(var Message: TMessage);
var
  ARect: TRect;
  DC: HDC;
  BtnFaceBrush: HBRUSH;
  Handle: HWND;
begin
  FPageControlWndProc(Message);
  if Message.Msg = WM_PAINT then begin
    Handle := pcMain.Handle;
    DC := GetWindowDC(Handle);
    BtnFaceBrush := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
    try
      GetWindowRect(Handle, ARect);
      OffsetRect(ARect, -ARect.Left, -ARect.Top);
      FrameRect(DC, ARect, BtnFaceBrush);
      InflateRect(ARect, -1, -1);
      FrameRect(DC, ARect, BtnFaceBrush);
      InflateRect(ARect, -1, -1);
      FrameRect(DC, ARect, BtnFaceBrush);
      InflateRect(ARect, -1, -1);
      FrameRect(DC, ARect, BtnFaceBrush);
    finally
      DeleteObject(BtnFaceBrush);
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TfrmMain.lblLinkClick(Sender: TObject);
var
  s: array [0..255] of char;
begin
  StrPCopy(s, (Sender as TLabel).Caption);
  ShellExecute(Handle, 'open', s, nil, nil, SW_SHOW);
end;

end.

