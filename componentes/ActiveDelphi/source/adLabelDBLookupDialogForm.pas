//==============================================================================
// Unit........: adLabelDBLookupDialogForm.pas
// Created.....: 28/04/2005
// Type Unit...: Cross platform
// -----------------------------------------------------------------------------
// Author......: Dennys dos Santos Sobrinho
// E-Mail......: dennys@activedelphi.com.br
// Copyright...: Revista ActiveDelphi
// Distribuição: Licença pública GNU GPL
//               http://lie-br.conectiva.com.br/licenca_gnu.html
// Observação..: Qualquer modificação ou implementação, deverá ser enviada para
//               o autor a fim de atualizar os demais beneficiados.
// .............................................................................
// Histórico
// ---------
// 14/06/2005 - Dennys S. Sobrinho
//              Foi necessário fazer uma implementação para localizar o registro
//              quando a tela for apresentada e já existir um valor associado.  
// 01/06/2005 - Devido a falta da atribuição na propriedade ListSource, estava 
//              ocorrendo um "Access Violation" (BUG) na tela de localização de 
//              registros, quando o usuário informava um valor no campo
//              "Informe (...) :".
// 08/04/2005 - Foi implementado a propriedade About para informar a versão 
//              atual do componente e os créditos dos colaboradores.
//==============================================================================

unit adLabelDBLookupDialogForm;

interface

{$I ActiveDelphi.inc}

uses Classes, SysUtils, DB, DBClient,
{$IFDEF LINUX}
     Qt, QImgList, QControls, QStdCtrls, QButtons, QGrids, QDBGrids,
     QMask, QComCtrls, QExtCtrls, QForms, QGraphics,
{$ELSE}
     Windows, ImgList, Controls, StdCtrls, Buttons, Grids, DBGrids,
     Mask, ComCtrls, ExtCtrls, Forms, Graphics,
{$ENDIF}
     {$IFDEF WITH_ZEOSLIB} // Esta definição escontra-se no arquivo ActiveDelphi.inc
     ZAbstractRODataset,
     {$ENDIF}
     {$IFDEF WITH_BDE} // Esta definição escontra-se no arquivo ActiveDelphi.inc
     DBTables,
     {$ENDIF}     
     {$IFDEF WITH_DBX} // Esta definição escontra-se no arquivo ActiveDelphi.inc
     SqlExpr,
     {$ENDIF}     
     {$IFDEF WITH_IBX} // Esta definição escontra-se no arquivo ActiveDelphi.inc
     IBQuery,
     {$ENDIF}     
     {$IFDEF WITH_ADO} // Esta definição escontra-se no arquivo ActiveDelphi.inc
     ADODB,
     {$ENDIF}     
     {$IFDEF WITH_ADS} // Esta definição escontra-se no arquivo ActiveDelphi.inc
     
     {$ENDIF}     
     adLabelMaskEdit, adLabelComboBox, adLabelDBLookupDialog, 
     adDBGridEX;

{$IFDEF LINUX}
const
  VK_BACK = Key_Backspace;
  VK_TAB  = Key_Tab;   
{$ENDIF}
     
type

  {$IFDEF WITH_ZEOSLIB}
  THackZAbstractRODataset = class(TZAbstractRODataset);
  {$ENDIF}
  
  pSearchCondition    = ^TrecSearchCondition;
  TrecSearchCondition = packed record
    oField            : TField;
    sConditional      : string;
    sValue            : string;
    iItemIndex        : longint;
  end;
  

  //-----| Class: Tfrm_LookupDialog

  Tfrm_LookupDialog = class(TForm)
    pnl_FieldOptions: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    pnl_Edit: TPanel;
    pnl_DBGrid: TPanel;
    Panel1: TPanel;
    StandardImages: TImageList;
    bb_Apply: TBitBtn;
    bb_Cancel: TBitBtn;
    grd_Records: TadDBGridEX;
    bb_Locate: TBitBtn;
    pnl_Title: TPanel;
    Panel3: TPanel;
    pnp_RecordCount: TPanel;
    pnl_DisplayHint: TPanel;
    dsr_Local: TDataSource;
    lv_Fields: TListView;
    cb_SearchCondition: TComboBox;
    edt_Search: TMaskEdit;
    lbl_Filter: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure bb_LocateClick(Sender: TObject);
    procedure bb_ApplyClick(Sender: TObject);
    procedure bb_CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsr_LocalDataChange(Sender: TObject; Field: TField);
    procedure grd_RecordsTitleClick(Column: TColumn);
    procedure grd_RecordsDblClick(Sender: TObject);
    procedure edt_SearchChange(Sender: TObject);
    procedure lv_FieldsClick(Sender: TObject);
    procedure cb_SearchConditionChange(Sender: TObject);
    procedure lv_FieldsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FOldOnHint        : TNotifyEvent;
    oFieldSelected    : TField;
    FOldSQL           : TStringList;
    FOldFilter        : string;
    FOldFiltered      : boolean;
    oOldColumnClicked : TColumn;
    sOldOrderBy       : string;
    procedure DisplayHint(Sender : TObject);
    //procedure SetDBColumn(iIndex : longint);
    procedure SetHackSQL(oDataSet : TDataSet; sSQL : string; const bClear : boolean);
    function  GetHackSQL(oDataSet : TDataSet) : TStrings;
  public
    { Public declarations }
    FDBLookupDialog   : TadLabelDBLookupDialog;
    iModalResult      : TModalResult;
    rSearchCondition  : pSearchCondition;
    procedure SetInternalDefs;
  end;

var
  frm_LookupDialog: Tfrm_LookupDialog;

implementation

uses adUtils;

{$IFNDEF LINUX}
  {$R *.dfm}
{$ELSE}
  {$R *.xfm}
{$ENDIF}

// Tfrm_LookupDialog -----------------------------------------------------------

procedure Tfrm_LookupDialog.FormCreate(Sender: TObject);
begin
  ActiveControl       := lv_Fields;
  iModalResult        := mrCancel;
  FOldOnHint          := Application.OnHint;
  Application.OnHint  := DisplayHint;
  FOldSQL             := TStringList.Create;
  FOldFilter          := '';
  FOldFiltered        := False;
  oOldColumnClicked   := nil;
  sOldOrderBy         := '';
  edt_Search.Clear;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.FormClose(Sender: TObject; var Action: TCloseAction);
var
  iColumn : longint;
begin
  if Assigned(dsr_Local.DataSet) then begin
    SetHackSQL(dsr_Local.DataSet, FOldSQL.Text, True);
    if dsr_Local.DataSet.InheritsFrom(TClientDataSet) then begin
      with TClientDataSet(dsr_Local.DataSet) do begin
        Filtered  := False;
        Filter    := FOldFilter;
        Filtered  := FOldFiltered;
      end;
    end;
  end;
  Application.OnHint := FOldOnHint;
  with TadLabelDBLookupDialog(FDBLookupDialog) do begin
    if (csDesigning in ComponentState) and (iModalResult = mrOk) then begin
      DialogDefs.DesignColumnsDefs.Clear;
      for iColumn := 0 to (grd_Records.Columns.Count-1) do
        DialogDefs.DesignColumnsDefs.Add(Format('%s=%d', [grd_Records.Columns[iColumn].FieldName, grd_Records.Columns[iColumn].Width]));
    end;  
    if DialogDefs.AutoCloseListSource and Assigned(ListSource) and Assigned(ListSource.DataSet) then
      ListSource.DataSet.Active := False;
  end;
  if Assigned(FOldSQL) then FreeAndNil(FOldSQL);
  if FDBLookupDialog.DialogDefs.FreeOnCloseDialog then begin
    Release;
    Action    := caFree;
    //Self      := nil;
  end;  
end;

// -----------------------------------------------------------------------------
{
procedure Tfrm_LookupDialog.SetDBColumn(iIndex : longint);
begin
  if (grd_Records.Columns.Count > 0) then
    oFieldSelected := grd_Records.Columns[iIndex].Field;
end;
}
// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.SetInternalDefs;
var
  iFieldIndex     : longint;
  sValue          : string;
  oField          : TField;
  oListItem       : TListItem;
  sFirstMacro     : string;
  bDataSetActive  : boolean;
begin
  grd_Records.Columns.Clear;
  if Assigned(FDBLookupDialog.ListSource) then
    dsr_Local.DataSet := FDBLookupDialog.ListSource.DataSet
  else  
    dsr_Local.DataSet := nil;
  if Assigned(dsr_Local.DataSet) then begin
    bDataSetActive := dsr_Local.DataSet.Active;
    FOldSQL.AddStrings(GetHackSQL(dsr_Local.DataSet){.SQL});
    if not bDataSetActive then
      dsr_Local.DataSet.Active := True;
    if (FDBLookupDialog.DialogDefs.DesignColumnsDefs.Count > 0) then begin
      for iFieldIndex := 0 to (FDBLookupDialog.DialogDefs.DesignColumnsDefs.Count-1) do begin
        oField := dsr_Local.DataSet.FindField(FDBLookupDialog.DialogDefs.DesignColumnsDefs.Names[iFieldIndex]);
        if Assigned(oField) and oField.Visible then begin
          with grd_Records.Columns.Add do begin
            FieldName     := oField.FieldName;
            Title.Caption := oField.DisplayLabel;
            Width         := StrToInt(FDBLookupDialog.DialogDefs.DesignColumnsDefs.Values[FieldName]);
            //SetDBColumn(Index);
          end;  
        end;
      end;
    end else begin
      for iFieldIndex := 0 to (dsr_Local.DataSet.FieldCount-1) do begin
        if dsr_Local.DataSet.Fields[iFieldIndex].Visible then begin
          with grd_Records.Columns.Add do begin
            FieldName     := dsr_Local.DataSet.Fields[iFieldIndex].FieldName;
            Title.Caption := dsr_Local.DataSet.Fields[iFieldIndex].DisplayLabel;
            //SetDBColumn(Index);
          end;  
        end;
      end;
    end;
    if FDBLookupDialog.DialogDefs.AutoOpenListSource then
      dsr_Local.DataSet.Active := True
    else
      dsr_Local.DataSet.Active := bDataSetActive;          
  end;
  if (csDesigning in FDBLookupDialog.ComponentState) then
    grd_Records.Options := grd_Records.Options + [dgColumnResize];
  
  //SetDBColumn(0);
  
  pnl_Title.Caption             := FDBLookupDialog.DialogDefs.Translations.CaptionTitleOptions;
  lv_Fields.Hint                := FDBLookupDialog.DialogDefs.Translations.HintOptions;
  cb_SearchCondition.Hint       := lv_Fields.Hint;
  lbl_Filter.Caption            := FDBLookupDialog.DialogDefs.Translations.CaptionEditSearch;
  edt_Search.Hint               := FDBLookupDialog.DialogDefs.Translations.HintEditSearch;
  grd_Records.Hint              := FDBLookupDialog.DialogDefs.Translations.HintGridRecords;
  bb_Locate.Caption             := FDBLookupDialog.DialogDefs.Translations.CaptionBtnLocate;
  bb_Locate.Hint                := FDBLookupDialog.DialogDefs.Translations.HintBtnLocate;
  bb_Apply.Caption              := FDBLookupDialog.DialogDefs.Translations.CaptionBtnApply;
  bb_Apply.Hint                 := FDBLookupDialog.DialogDefs.Translations.HintBtnApply;
  bb_Cancel.Caption             := FDBLookupDialog.DialogDefs.Translations.CaptionBtnCancel;
  bb_Cancel.Hint                := FDBLookupDialog.DialogDefs.Translations.HintBtnCancel;
  edt_Search.CharCase           := FDBLookupDialog.DialogDefs.CharCase;
  Self.Caption                  := FDBLookupDialog.DialogDefs.Translations.Title;

  grd_Records.GridDefs.Assign(FDBLookupDialog.DialogDefs.GridDefs);
  
  //cb_SearchCondition.Colors.Assign(FDBLookupDialog.{DialogDefs.}Colors);
  //edt_Search.Colors.Assign(FDBLookupDialog.{DialogDefs.}Colors);
    
  cb_SearchCondition.Items.Clear;
  for iFieldIndex := 0 to (FDBLookupDialog.DialogDefs.Translations.SearchCondition.Count-1) do begin
    sValue := FDBLookupDialog.DialogDefs.Translations.SearchCondition.Strings[iFieldIndex];
    New(rSearchCondition);
    rSearchCondition^.oField        := nil;
    rSearchCondition^.sConditional  := Trim(Copy(sValue, Pos('=', sValue)+1, Length(sValue)));
    rSearchCondition^.iItemIndex    := iFieldIndex;
    rSearchCondition^.sValue        := '';
    if Trim(sFirstMacro) = '' then
      sFirstMacro                   := rSearchCondition^.sConditional;
    cb_SearchCondition.Items.AddObject(Trim(Copy(sValue, 1, Pos('=', sValue)-1)), TObject(rSearchCondition));
  end;  
  
  {$IFDEF LINUX}
  lv_Fields.Items.Clear;
  {$ENDIF}
  {$IFDEF VERSION6_OR_HIGHER}
  lv_Fields.Clear;
  {$ENDIF}
  
  for iFieldIndex := 0 to (grd_Records.Columns.Count-1) do begin
    oListItem                       := lv_Fields.Items.Add;
    oListItem.Caption               := grd_Records.Columns[iFieldIndex].Title.Caption;
    oListItem.ImageIndex            := 0;
    New(rSearchCondition);
    rSearchCondition^.oField        := grd_Records.Columns[iFieldIndex].Field;
    rSearchCondition^.sConditional  := sFirstMacro;
    rSearchCondition^.iItemIndex    := 0;
    rSearchCondition^.sValue        := '';
    oListItem.Data                  := rSearchCondition;
  end;
  
  cb_SearchCondition.ItemIndex      := 0;
  {$IFDEF LINUX}
  lv_Fields.ItemFocused             := lv_Fields.Items[0];
  {$ENDIF}
  {$IFDEF VERSION6_OR_HIGHER}
  lv_Fields.ItemIndex               := 0;
  {$ENDIF}
  grd_RecordsTitleClick(grd_Records.Columns[0]);
  dsr_LocalDataChange(dsr_Local, nil);
  
  // 14/06/2005 - Dennys S. Sobrinho
  //              Foi necessário fazer esta implementação para localizar o
  //              registro quando a tela for apresentada e já existir um
  //              valor associado.  
  if dsr_Local.DataSet.Active then begin
    if Assigned(dsr_Local.DataSet.FindField(FDBLookupDialog.DataField)) then
      dsr_Local.DataSet.Locate(FDBLookupDialog.DataField, FDBLookupDialog.Text, [loCaseInsensitive, loPartialKey]);
  end;
  // Fim da implementação
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := (NewSize > 34);
  //Self.Caption  := IntToStr(NewSize);
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then begin
    if (ActiveControl = lv_Fields) then
      ActiveControl       := edt_Search
    else if (ActiveControl = edt_Search) then
      ActiveControl       := lv_Fields;
    ActiveControl.SetFocus;
  end else if edt_Search.Focused then begin
    New(rSearchCondition);
    rSearchCondition := lv_Fields.Selected.Data;
    if not (rSearchCondition^.oField.DataType in [ftUnknown, ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString]) and
    not (Key in ['0'..'9', '-', '+', ',', '.', Char(VK_BACK), Char(VK_TAB)]) then
      Key := #0;
  end else if grd_Records.Focused and
    not (oFieldSelected.DataType in [ftUnknown, ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString]) and
    not (Key in ['0'..'9', '-', '+', ',', '.', Char(VK_BACK), Char(VK_TAB)]) then
    Key := #0;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.lv_FieldsClick(Sender: TObject);
begin
  if Assigned(lv_Fields.Selected) and Self.Active then begin
    New(rSearchCondition);
    rSearchCondition              := lv_Fields.Selected.Data;
    edt_Search.Text               := rSearchCondition^.sValue;
    cb_SearchCondition.ItemIndex  := rSearchCondition^.iItemIndex; 
  end;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.bb_LocateClick(Sender: TObject);
var
  bAccept         : boolean;
  sAddSQL         : string;
  iItemIndex      : longint;
  sCommandSelect  : string;
  sCommandWhere   : string;
  sCommandGroupBy : string;
  sCommandHaving  : string;
  sCommandOrderBy : string;
  //............................................................................
  function FormatValue(sValue : string; Field : TField) : string;
  begin
    if (Field.DataType in [ftUnknown, ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftDate, ftTime, ftDateTime]) then
      Result := QuotedStr(sValue)
    else
      Result := sValue;  
  end;
  //............................................................................
begin
  bAccept         := True;
  sAddSQL         := '';
  sCommandSelect  := GetCommandSelect(FOldSQL.Text);
  sCommandWhere   := GetCommandWhere(FOldSQL.Text);
  sCommandGroupBy := GetCommandGroupBy(FOldSQL.Text);
  sCommandHaving  := GetCommandHaving(FOldSQL.Text);
  sCommandOrderBy := GetCommandOrderBy(FOldSQL.Text);
  if dsr_Local.DataSet.InheritsFrom(TClientDataSet) then
    sCommandWhere := ' (1=1)'
  else if (Trim(sCommandWhere) = '') then
    sCommandWhere := ' where (1=1)';
  for iItemIndex := 0 to (lv_Fields.Items.Count-1) do begin
    if (lv_Fields.Items[iItemIndex].ImageIndex = 1) then begin
      New(rSearchCondition);
      rSearchCondition := lv_Fields.Items[iItemIndex].Data;
      if (rSearchCondition^.sConditional = 'macro[being]') then               // Inicie com :
        sAddSQL := sAddSQL + ' and '+rSearchCondition^.oField.FieldName+' like '+QuotedStr(rSearchCondition^.sValue+'%')
      else if (rSearchCondition^.sConditional = 'macro[end]') then            // Termine com :
        sAddSQL := sAddSQL + ' and '+rSearchCondition^.oField.FieldName+' like '+QuotedStr('%'+rSearchCondition^.sValue)
      else if (rSearchCondition^.sConditional = 'macro(contain]') then        // Contenha :
        sAddSQL := sAddSQL + ' and '+rSearchCondition^.oField.FieldName+' like '+QuotedStr('%'+rSearchCondition^.sValue+'%')
      else if (rSearchCondition^.sConditional = 'macro[equal]') then          // Seja igual a :
        sAddSQL := sAddSQL + ' and '+rSearchCondition^.oField.FieldName+' = '+FormatValue(rSearchCondition^.sValue, rSearchCondition^.oField)
      else if (rSearchCondition^.sConditional = 'macro[different]') then      // Seja diferente de :
        sAddSQL := sAddSQL + ' and '+rSearchCondition^.oField.FieldName+' <> '+FormatValue(rSearchCondition^.sValue, rSearchCondition^.oField)
      else if (rSearchCondition^.sConditional = 'macro[larger]') then         // Seja maior que :
        sAddSQL := sAddSQL + ' and '+rSearchCondition^.oField.FieldName+' > '+FormatValue(rSearchCondition^.sValue, rSearchCondition^.oField)
      else if (rSearchCondition^.sConditional = 'macro[smaller]') then        // Seja menor que :
        sAddSQL := sAddSQL + ' and '+rSearchCondition^.oField.FieldName+' < '+FormatValue(rSearchCondition^.sValue, rSearchCondition^.oField)
      else if (rSearchCondition^.sConditional = 'macro[larger_equal]') then   // Seja maior ou igual que :
        sAddSQL := sAddSQL + ' and '+rSearchCondition^.oField.FieldName+' >= '+FormatValue(rSearchCondition^.sValue, rSearchCondition^.oField)
      else if (rSearchCondition^.sConditional = 'macro[smaller_equal]') then  // Seja menor ou igual que :
        sAddSQL := sAddSQL + ' and '+rSearchCondition^.oField.FieldName+' <= '+FormatValue(rSearchCondition^.sValue, rSearchCondition^.oField);
    end;
  end;
  if Assigned(FDBLookupDialog.OnClickBtnLocate) then
    FDBLookupDialog.OnClickBtnLocate(Self, sAddSQL, bAccept);
    
  if bAccept and Assigned(dsr_Local.DataSet) then begin
    dsr_Local.DataSet.Active := False;
    SetHackSQL(dsr_Local.DataSet, sCommandSelect+
                                  sCommandWhere+sAddSQL+
                                  sCommandGroupBy+
                                  sCommandHaving+
                                  sCommandOrderBy, True);
    dsr_Local.DataSet.Active := True;
  end;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.bb_ApplyClick(Sender: TObject);
var
  iFieldIndex : longint;  
  oField      : TField;
  bAccept     : boolean;
begin
  bAccept := True;
  if Assigned(FDBLookupDialog.OnClickBtnApply) then
    FDBLookupDialog.OnClickBtnApply(Self, bAccept);
  if bAccept then begin
    if Assigned(dsr_Local.DataSet) and {Assigned(FDBLookupDialog.DataSource) and
      Assigned(FDBLookupDialog.DataSource.DataSet) and}
      not (csDesigning in FDBLookupDialog.ComponentState) then begin
      for iFieldIndex := 0 to (dsr_Local.DataSet.FieldCount-1) do begin
        oField := FDBLookupDialog.DataSource.DataSet.FindField(dsr_Local.DataSet.Fields[iFieldIndex].FieldName);
        if Assigned(oField) then begin
          if not (FDBLookupDialog.DataSource.State in [dsEdit, dsInsert]) then
            FDBLookupDialog.DataSource.DataSet.Edit;
          oField.AsString := dsr_Local.DataSet.Fields[iFieldIndex].AsString;
        end;
      end;
    end;
    iModalResult := mrOk;
    Self.Close;
  end;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.bb_CancelClick(Sender: TObject);
var
  bAccept : boolean;
begin
  bAccept := True;
  if bAccept then begin
    if Assigned(FDBLookupDialog.OnClickBtnCancel) then
      FDBLookupDialog.OnClickBtnCancel(Self, bAccept);
    iModalResult := mrCancel;
    Self.Close;
  end;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.DisplayHint(Sender : TObject);
begin
  pnl_DisplayHint.Caption := Application.Hint;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.dsr_LocalDataChange(Sender: TObject; Field: TField);
var
  sRecordCount : string;
begin
  if Assigned(dsr_Local.DataSet) and dsr_Local.DataSet.Active then
    sRecordCount          := FormatFloat(',0', dsr_Local.DataSet.RecordCount)
  else
    sRecordCount          := '0';  
  pnp_RecordCount.Caption := Format(FDBLookupDialog.DialogDefs.Translations.CaptionRecordCount, [sRecordCount]);
  if not (csDesigning in FDBLookupDialog.ComponentState) then
    bb_Apply.Enabled      := (sRecordCount <> '0')
  else
    bb_Apply.Enabled      := True;
  bb_Locate.Enabled       := Assigned(dsr_Local.DataSet){ and dsr_Local.DataSet.Active};
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.grd_RecordsTitleClick(Column: TColumn);
var
  bAccept         : boolean;
  sCommandSelect  : string;
  sCommandWhere   : string;
  sCommandGroupBy : string;
  sCommandHaving  : string;
  sCommandOrderBy : string;
begin
  bAccept := True;
  if Assigned(FDBLookupDialog.OnDBGridTitleClick) then
    FDBLookupDialog.OnDBGridTitleClick(Column, bAccept);
  if bAccept then begin
    oFieldSelected := Column.Field;
    //SetDBColumn(Column.Index);
    grd_Records.GridDefs.LocateOptions.FieldName := Column.FieldName;
  end;
  bAccept := True;
  if Assigned(FDBLookupDialog.OnSortByTitle) then
    FDBLookupDialog.OnSortByTitle(sCommandOrderBy, bAccept);
  sCommandSelect  := GetCommandSelect(FOldSQL.Text);
  sCommandWhere   := GetCommandWhere(FOldSQL.Text);
  sCommandGroupBy := GetCommandGroupBy(FOldSQL.Text);
  sCommandHaving  := GetCommandHaving(FOldSQL.Text);
  if (oOldColumnClicked <> Column) then begin
    oOldColumnClicked := Column;
    sCommandOrderBy   := GetCommandOrderBy(FOldSQL.Text);
    if (sCommandOrderBy = '') then
      sCommandOrderBy := ' order by ';
  end else
    sCommandOrderBy   := sOldOrderBy;
  if (PosExact(Column.FieldName, sCommandOrderBy) <= 0) then
    sCommandOrderBy   := sCommandOrderBy + #32 + Column.FieldName + ' asc '
  else begin
    if PosExact('asc', sCommandOrderBy) > 0 then
      sCommandOrderBy := StringReplace(sCommandOrderBy, ' asc', ' desc', [rfReplaceAll, rfIgnoreCase])
    else if PosExact('desc', sCommandOrderBy) > 0 then
      sCommandOrderBy := StringReplace(sCommandOrderBy, ' desc', ' asc', [rfReplaceAll, rfIgnoreCase]);
  end;  
  if bAccept and Assigned(dsr_Local.DataSet) then begin
    sOldOrderBy := sCommandOrderBy;
    dsr_Local.DataSet.Active := False;
    SetHackSQL(dsr_Local.DataSet, sCommandSelect+
                                  sCommandWhere+
                                  sCommandGroupBy+
                                  sCommandHaving+
                                  sCommandOrderBy, True);
    dsr_Local.DataSet.Active := True;
  end;    
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.grd_RecordsDblClick(Sender: TObject);
begin
  if Assigned(dsr_Local.DataSet) and bb_Apply.Enabled then
    bb_Apply.Click;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.edt_SearchChange(Sender: TObject);
begin
  if edt_Search.Focused and Self.Active then begin
    New(rSearchCondition);
    rSearchCondition          := lv_Fields.Selected.Data;
    rSearchCondition^.sValue  := edt_Search.Text;
    lv_Fields.Selected.Data   := rSearchCondition;
    if (Trim(edt_Search.Text) <> '') then
      lv_Fields.Selected.ImageIndex := 1
    else
      lv_Fields.Selected.ImageIndex := 0;
  end;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.cb_SearchConditionChange(Sender: TObject);
var
  sMacro : string;
begin
  if Self.Active then begin
    New(rSearchCondition);
    rSearchCondition                := pSearchCondition(cb_SearchCondition.Items.Objects[cb_SearchCondition.ItemIndex]);
    sMacro                          := rSearchCondition^.sConditional;
    rSearchCondition                := lv_Fields.Selected.Data;
    rSearchCondition^.iItemIndex    := cb_SearchCondition.ItemIndex;
    rSearchCondition^.sConditional  := sMacro;
    lv_Fields.Selected.Data         := rSearchCondition;
  end;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.lv_FieldsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if Assigned(FDBLookupDialog) and Assigned(lbl_Filter) then
    lbl_Filter.Caption  := Format(FDBLookupDialog.DialogDefs.Translations.CaptionEditSearch, [Item.Caption]);
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.SetHackSQL(oDataSet : TDataSet; sSQL : string; const bClear : boolean);
begin
  sSQL := Trim(sSQL);
  if oDataSet.InheritsFrom(TClientDataSet) then begin
    with TClientDataSet(oDataSet) do begin
      if (sSQL <> '') then begin
        sSQL := StringReplace(sSQL, '(1=1) and', '', []);
        if (Trim(CommandText) <> '') then
          CommandText := sSQL
        else begin
          Filtered  := False;
          try
            if (Pos('order by', sSQL) > 0) then begin
              sSQL            := StringReplace(sSQL, 'order by', '', []);
              sSQL            := StringReplace(sSQL, ' asc'    , '', []);
              sSQL            := StringReplace(sSQL, ' desc'   , '', []);
              IndexFieldNames := sSQL;
            end else begin
              Filter    := sSQL;
              Filtered  := True;
            end;
          except
            Filter    := FOldFilter;
            Filtered  := FOldFiltered;
          end;
        end;  
      end;
    end;
  end;
  {$IFDEF WITH_ZEOSLIB}
  if oDataSet.InheritsFrom(TZAbstractRODataset) then begin
    with THackZAbstractRODataset(oDataSet) do begin
      if bClear then
        SQL.Clear;
      if (sSQL <> '') then
        SQL.Text := sSQL;
    end;
  end;  
  {$ENDIF} 
  {$IFDEF WITH_BDE}
  if oDataSet.InheritsFrom(TQuery) then begin
    with TQuery(oDataSet) do begin
      if bClear then
        SQL.Clear;
      if (sSQL <> '') then
        SQL.Text := sSQL;
    end;
  end;  
  {$ENDIF} 
  {$IFDEF WITH_DBX}
  if oDataSet.InheritsFrom(TSQLQuery) then begin
    with TSQLQuery(oDataSet) do begin
      if bClear then
        SQL.Clear;
      if (sSQL <> '') then
        SQL.Text := sSQL;
    end;
  end;  
  {$ENDIF} 
  {$IFDEF WITH_IBX}
  if oDataSet.InheritsFrom(TIBQuery) then begin
    with TIBQuery(oDataSet) do begin
      if bClear then
        SQL.Clear;
      if (sSQL <> '') then
        SQL.Text := sSQL;
    end;
  end;  
  {$ENDIF} 
  {$IFDEF WITH_ADO}
  if oDataSet.InheritsFrom(TADOQuery) then begin
    with TADOQuery(oDataSet) do begin
      if bClear then
        SQL.Clear;
      if (sSQL <> '') then
        SQL.Text := sSQL;
    end;
  end;  
  {$ENDIF} 
  {$IFDEF WITH_ADS}

  {$ENDIF} 
end;

// -----------------------------------------------------------------------------

function Tfrm_LookupDialog.GetHackSQL(oDataSet : TDataSet) : TStrings;
begin
  Result := TStringList.Create;
  if oDataSet.InheritsFrom(TClientDataSet) then begin
    Result.Add(TClientDataSet(oDataSet).CommandText);
    FOldFilter    := TClientDataSet(oDataSet).Filter;
    FOldFiltered  := TClientDataSet(oDataSet).Filtered;
  end;  
  {$IFDEF WITH_ZEOSLIB}
  if oDataSet.InheritsFrom(TZAbstractRODataset) then
    Result := THackZAbstractRODataset(oDataSet).SQL;
  {$ENDIF} 
  {$IFDEF WITH_BDE}
  if oDataSet.InheritsFrom(TQuery) then
    Result := TQuery(oDataSet).SQL;
  {$ENDIF} 
  {$IFDEF WITH_DBX}
  if oDataSet.InheritsFrom(TSQLQuery) then
    Result := TSQLQuery(oDataSet).SQL;
  {$ENDIF} 
  {$IFDEF WITH_IBX}
  if oDataSet.InheritsFrom(TIBQuery) then
    Result := TIBQuery(oDataSet).SQL;
  {$ENDIF} 
  {$IFDEF WITH_ADO}
  if oDataSet.InheritsFrom(TADOQuery) then
    Result := TADOQuery(oDataSet).SQL;
  {$ENDIF} 
  {$IFDEF WITH_ADS}

  {$ENDIF} 
end;

// -----------------------------------------------------------------------------

procedure Tfrm_LookupDialog.FormShow(Sender: TObject);
begin
  if not dsr_Local.DataSet.IsEmpty then
    grd_Records.SetFocus;
end;

// -----------------------------------------------------------------------------

end.
