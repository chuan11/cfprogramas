//==============================================================================
// Unit........: ActiveDelphiReg.pas
// Created.....: 08/04/2005
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
// 08/04/2005 - Foi implementado a propriedade About para informar a versão 
//              atual do componente e os créditos dos colaboradores.
//==============================================================================

unit ActiveDelphiReg;

interface

{$I ActiveDelphi.inc}
{$R adComponents.res}

uses Classes, SysUtils, DB, ColnEdit, DBCtrls,
     {$IFDEF LINUX} 
     QForms, QControls, 
     {$ELSE} 
     Forms, Controls,
     {$ENDIF}
     {$IFDEF VERSION5}
     Dsgnintf;
     {$ELSE}
     DesignIntf, DesignEditors;
     {$ENDIF}
     
const

  ADVersion     = 'Version 1.4';
  sPalleteName1 = 'AD - Common Controls';
  sPalleteName2 = 'AD - Data Controls';
  sPalleteName3 = 'AD - N-Tiers';

type

  //-----| Class: TadAboutPropertyEditor

  TadAboutPropertyEditor = class(TPropertyEditor)
    function GetAttributes : TPropertyAttributes ; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;    

  //-----| Class: TadFieldPropertyEditor

  TadFieldPropertyEditor = class(TPropertyEditor)
    function GetAttributes : TPropertyAttributes ; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;    
  
  //-----| Class: TadComponentEditor
  
  TadComponentEditor = class(TComponentEditor)
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): String; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

procedure Register;

implementation

uses adFrmAbout, 
     adBoundLabel,
{$IFNDEF LINUX}
     adLinkedButton,
     adLinkedLabel,
     {$IFNDEF VERSION5}
     adLabelColorBox,
     adLabelValueListEditor,
     {$ENDIF}
     adLabelDBRichEdit,
     adLabelDBDateTimePicker,
{$ENDIF}
     adLabelImageEX,
     adLabelEdit,
     adLabelImage,
     adLabelListBox,
     adLabelMaskEdit,
     adLabelMemo,
     adLabelCheckListBox,
     adLabelComboBox,
     adLabelDBComboBox,
     adLabelDBEdit,
     adLabelDBImage,
     adLabelDBListBox,
     adLabelDBLookupComboBox,
     adLabelDBLookupListBox,
     adLabelDBMemo,
     adLabelDBLookupDialog,
     adLabelDBNumericEdit,
     adLabelDBSpinEdit,
     adLabelNumericEdit,
     adLabelSpinEdit,
     adDBGridEX, 
     adServerConnection,
     adClientConnection;

// -----------------------------------------------------------------------------

procedure ShowAbout(Version : string);
begin
{$IFDEF WITH_ABOUT_INFO}
  frm_About           := Tfrm_About.Create(nil);
  frm_About.FVersion  := Version;
  frm_About.ShowModal;
  FreeAndNil(frm_About);
{$ENDIF}
end;

// -----------------------------------------------------------------------------

procedure Register;  
begin
  //-----| Palette: ActiveDelphi (Common Controls)
  
  RegisterComponents(sPalleteName1, [TadLabelEdit]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelEdit, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelEdit, TadComponentEditor);

  RegisterComponents(sPalleteName1, [TadLabelMemo]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelMemo, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelMemo, TadComponentEditor);

  RegisterComponents(sPalleteName1, [TadLabelListBox]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelListBox, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelListBox, TadComponentEditor);

  RegisterComponents(sPalleteName1, [TadLabelComboBox]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelComboBox, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelComboBox, TadComponentEditor);

  RegisterComponents(sPalleteName1, [TadLabelMaskEdit]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelMaskEdit, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelMaskEdit, TadComponentEditor);

  RegisterComponents(sPalleteName1, [TadLabelImage]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelImage, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelImage, TadComponentEditor);

  RegisterComponents(sPalleteName1, [TadLabelCheckListBox]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelCheckListBox, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelCheckListBox, TadComponentEditor);

  RegisterComponents(sPalleteName1, [TadLabelNumericEdit]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelNumericEdit, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelNumericEdit, TadComponentEditor);

  RegisterComponents(sPalleteName1, [TadLabelSpinEdit]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelSpinEdit, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelSpinEdit, TadComponentEditor);
  
{$IFNDEF LINUX}
  {$IFNDEF VERSION5}
  RegisterComponents(sPalleteName1, [TadLabelValueListEditor]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelValueListEditor, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelValueListEditor, TadComponentEditor);

  RegisterComponents(sPalleteName1, [TadLabelColorBox]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelColorBox, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelColorBox, TadComponentEditor);
  {$ENDIF}
  
  RegisterComponents(sPalleteName1, [TadLinkedLabel]);
  RegisterPropertyEditor(TypeInfo(string), TadLinkedLabel, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLinkedLabel, TadComponentEditor);
  
  RegisterComponents(sPalleteName1, [TadLinkedButton]);
  RegisterPropertyEditor(TypeInfo(string), TadLinkedButton, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLinkedButton, TadComponentEditor);
{$ENDIF}

  RegisterComponents(sPalleteName1, [TadLabelImageEX]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelImageEX, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadLabelImageEX, TadComponentEditor);
  
  //-----| Palette: ActiveDelphi (Data Controls)
  
  RegisterComponents(sPalleteName2, [TadLabelDBEdit]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBEdit, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBEdit, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBEdit, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadLabelDBMemo]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBMemo, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBMemo, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBMemo, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadLabelDBImage]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBImage, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBImage, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBImage, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadLabelDBListBox]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBListBox, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBListBox, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBListBox, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadLabelDBComboBox]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBComboBox, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBComboBox, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBComboBox, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadLabelDBLookupListBox]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBLookupListBox, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBLookupListBox, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBLookupListBox, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadLabelDBLookupComboBox]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBLookupComboBox, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBLookupComboBox, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBLookupComboBox, TadComponentEditor);

{$IFNDEF LINUX}
  RegisterComponents(sPalleteName2, [TadLabelDBRichEdit]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBRichEdit, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBRichEdit, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBRichEdit, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadLabelDBDateTimePicker]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBDateTimePicker, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBDateTimePicker, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBDateTimePicker, TadComponentEditor);
{$ENDIF}  

  RegisterComponents(sPalleteName2, [TadLabelDBLookupDialog]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBLookupDialog, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBLookupDialog, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBLookupDialog, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadLabelDBNumericEdit]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBNumericEdit, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBNumericEdit, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBNumericEdit, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadLabelDBSpinEdit]);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBSpinEdit, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLabelDBSpinEdit, 'DataField', TadFieldPropertyEditor);
  RegisterComponentEditor(TadLabelDBSpinEdit, TadComponentEditor);

  RegisterComponents(sPalleteName2, [TadDBGridEX]);
  RegisterPropertyEditor(TypeInfo(string), TadDBGridEX, 'About', TadAboutPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TadLocateOptions, 'FieldName', TadFieldPropertyEditor);
  RegisterComponentEditor(TadDBGridEX, TadComponentEditor);

  //-----| Palette: ActiveDelphi (N-Tiers)
  
  RegisterComponents(sPalleteName3, [TadServerConnection]);
  RegisterPropertyEditor(TypeInfo(string), TadServerConnection, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadServerConnection, TadComponentEditor);

  RegisterComponents(sPalleteName3, [TadClientConnection]);
  RegisterPropertyEditor(TypeInfo(string), TadClientConnection, 'About', TadAboutPropertyEditor);
  RegisterComponentEditor(TadClientConnection, TadComponentEditor);
  
end;

// TadAboutPropertyEditor ------------------------------------------------------

function TadAboutPropertyEditor.GetAttributes : TPropertyAttributes ;
begin
  Result := [paMultiSelect, paDialog, paReadOnly];
end;

// -----------------------------------------------------------------------------

procedure TadAboutPropertyEditor.GetValues(Proc: TGetStrProc);
begin
  ShowAbout(ADVersion);
end;

// -----------------------------------------------------------------------------

function TadAboutPropertyEditor.GetValue: string;
begin
  Result := ADVersion; //GetStrValue;
end;

// -----------------------------------------------------------------------------

procedure TadAboutPropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

// TadFieldPropertyEditor ------------------------------------------------------

function TadFieldPropertyEditor.GetAttributes : TPropertyAttributes ;
begin
  Result := [paMultiSelect, paValueList, paAutoUpdate];
end;

// -----------------------------------------------------------------------------

procedure TadFieldPropertyEditor.GetValues(Proc: TGetStrProc);
var
  iIndex    : Integer;
  oDataSet  : TDataSet;
  FActive   : boolean;
begin
  oDataSet  := nil;
  FActive   := False;
  if (GetComponent(0) is TadLocateOptions) then begin
    with TadLocateOptions(GetComponent(0)) do begin
      if Owner.InheritsFrom(TadDBGridEX) and Assigned(TadDBGridEX(Owner).DataSource) then 
        oDataSet := TadDBGridEX(Owner).DataSource.DataSet
      else if Owner.InheritsFrom(TadLabelDBLookupDialog) and Assigned(TadLabelDBLookupDialog(Owner).ListSource) then 
        oDataSet := TadLabelDBLookupDialog(Owner).ListSource.DataSet
    end;
  end else if (GetComponent(0) is TadLabelDBEdit) and Assigned(TadLabelDBEdit(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBEdit(GetComponent(0)).DataSource.DataSet
  else if (GetComponent(0) is TadLabelDBMemo) and Assigned(TadLabelDBMemo(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBMemo(GetComponent(0)).DataSource.DataSet
  else if (GetComponent(0) is TadLabelDBImage) and Assigned(TadLabelDBImage(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBImage(GetComponent(0)).DataSource.DataSet
  else if (GetComponent(0) is TadLabelDBListBox) and Assigned(TadLabelDBListBox(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBListBox(GetComponent(0)).DataSource.DataSet
  else if (GetComponent(0) is TadLabelDBComboBox) and Assigned(TadLabelDBComboBox(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBComboBox(GetComponent(0)).DataSource.DataSet
  else if (GetComponent(0) is TadLabelDBLookupListBox) and Assigned(TadLabelDBLookupListBox(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBLookupListBox(GetComponent(0)).DataSource.DataSet
  else if (GetComponent(0) is TadLabelDBLookupComboBox) and Assigned(TadLabelDBLookupComboBox(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBLookupComboBox(GetComponent(0)).DataSource.DataSet
{$IFNDEF LINUX}
  else if (GetComponent(0) is TadLabelDBRichEdit) and Assigned(TadLabelDBRichEdit(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBRichEdit(GetComponent(0)).DataSource.DataSet
  else if (GetComponent(0) is TadLabelDBDateTimePicker) and Assigned(TadLabelDBDateTimePicker(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBDateTimePicker(GetComponent(0)).DataSource.DataSet
{$ENDIF}  
  else if (GetComponent(0) is TadLabelDBLookupDialog) and Assigned(TadLabelDBLookupDialog(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBLookupDialog(GetComponent(0)).DataSource.DataSet
  else if (GetComponent(0) is TadLabelDBNumericEdit) and Assigned(TadLabelDBNumericEdit(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBNumericEdit(GetComponent(0)).DataSource.DataSet
  else if (GetComponent(0) is TadLabelDBSpinEdit) and Assigned(TadLabelDBSpinEdit(GetComponent(0)).DataSource) then 
    oDataSet := TadLabelDBSpinEdit(GetComponent(0)).DataSource.DataSet;
  if Assigned(oDataSet) then begin
    with oDataSet do begin
      try
        DisableControls;
        Screen.Cursor := crSQLWait;
        FActive       := Active;
        if not Active then
          Active      := True;
        for iIndex    := 0 to Fields.Count - 1 do 
          Proc(Fields[iIndex].FieldName);
      finally
        Active        := FActive;
        Screen.Cursor := crDefault;
        EnableControls;
      end;
    end;
  end;
end;

// -----------------------------------------------------------------------------

function TadFieldPropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

// -----------------------------------------------------------------------------

procedure TadFieldPropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
  if (GetComponent(0) is TadLabelDBEdit) and (Value <> '') then 
    TadLabelDBEdit(GetComponent(0)).LabelDefs.Caption := TadLabelDBEdit(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else if (GetComponent(0) is TadLabelDBMemo) and (Value <> '')  then 
    TadLabelDBMemo(GetComponent(0)).LabelDefs.Caption := TadLabelDBMemo(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else if (GetComponent(0) is TadLabelDBImage) and (Value <> '')  then 
    TadLabelDBImage(GetComponent(0)).LabelDefs.Caption := TadLabelDBImage(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else if (GetComponent(0) is TadLabelDBListBox) and (Value <> '')  then 
    TadLabelDBListBox(GetComponent(0)).LabelDefs.Caption := TadLabelDBListBox(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else if (GetComponent(0) is TadLabelDBComboBox) and (Value <> '')  then 
    TadLabelDBComboBox(GetComponent(0)).LabelDefs.Caption := TadLabelDBComboBox(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else if (GetComponent(0) is TadLabelDBLookupListBox) and (Value <> '')  then 
    TadLabelDBLookupListBox(GetComponent(0)).LabelDefs.Caption := TadLabelDBLookupListBox(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else if (GetComponent(0) is TadLabelDBLookupComboBox) and (Value <> '')  then 
    TadLabelDBLookupComboBox(GetComponent(0)).LabelDefs.Caption := TadLabelDBLookupComboBox(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
{$IFNDEF LINUX}
  else if (GetComponent(0) is TadLabelDBRichEdit) and (Value <> '')  then 
    TadLabelDBRichEdit(GetComponent(0)).LabelDefs.Caption := TadLabelDBRichEdit(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else if (GetComponent(0) is TadLabelDBDateTimePicker) and (Value <> '')  then 
    TadLabelDBDateTimePicker(GetComponent(0)).LabelDefs.Caption := TadLabelDBDateTimePicker(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
{$ENDIF}  
  else if (GetComponent(0) is TadLabelDBLookupDialog) and (Value <> '')  then 
    TadLabelDBLookupDialog(GetComponent(0)).LabelDefs.Caption := TadLabelDBLookupDialog(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else if (GetComponent(0) is TadLabelDBNumericEdit) and (Value <> '')  then 
    TadLabelDBNumericEdit(GetComponent(0)).LabelDefs.Caption := TadLabelDBNumericEdit(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else if (GetComponent(0) is TadLabelDBSpinEdit) and (Value <> '')  then 
    TadLabelDBSpinEdit(GetComponent(0)).LabelDefs.Caption := TadLabelDBSpinEdit(GetComponent(0)).DataSource.DataSet.FindField(Value).DisplayLabel
  else
    ;
end;

// TadComponentEditor ----------------------------------------------------------

function TadComponentEditor.GetVerbCount : integer;
{$IFDEF VERSION5}
var
  GetComponent : TComponent;
{$ENDIF}  
begin
  // Modificações feita em 01/05/2005 por Dennys S. Sobrinho,
  // possibilitando assim, visualizar a tela de pesquisa
  // durante o design do projeto.
  {$IFDEF VERSION5}
  GetComponent := Component;
  {$ENDIF}
  if (GetComponent is TadLabelDBLookupDialog) or (GetComponent is TadDBGridEX) then
    Result := 2
  else
    Result := 1;
  // Final das modificações
end;

// -----------------------------------------------------------------------------

function TadComponentEditor.GetVerb(Index : integer) : string;
{$IFDEF VERSION5}
var
  GetComponent : TComponent;
{$ENDIF}  
begin
  // Modificação feita em 01/05/2005 por Dennys S. Sobrinho,
  // possibilitando assim, visualizar a tela de pesquisa
  // durante o design do projeto.
  {$IFDEF VERSION5}
  GetComponent := Component;
  {$ENDIF}
  if (GetComponent is TadLabelDBLookupDialog) then begin
    case Index of
      0: Result := 'Preview...';
      1: Result := 'About: '+ADVersion; //'Version...';
    else  
      Result := inherited GetVerb(Index{ -1});
    end;
  end else if (GetComponent is TadDBGridEX) then begin
    case Index of
      0: Result := 'Columns Editor...';
      1: Result := 'About: '+ADVersion; //'Version...';      
    else  
      Result := inherited GetVerb(Index{ -1});
    end;
  end else if (Index = 0) then
    Result := 'About: '+ADVersion
  else  
    Result := inherited GetVerb(Index{ -1});
  // Final das modificações
end;

// -----------------------------------------------------------------------------

procedure TadComponentEditor.ExecuteVerb(Index : integer);
{$IFDEF VERSION5}
var
  GetComponent : TComponent;
{$ENDIF}  
begin
  // Modificações feita em 01/05/2005 por Dennys S. Sobrinho,
  // possibilitando assim, visualizar a tela de pesquisa
  // durante o design do projeto.
  {$IFDEF VERSION5}
  GetComponent := Component;
  {$ENDIF}
  if (GetComponent is TadLabelDBLookupDialog) then begin
    case Index of
      0: TadLabelDBLookupDialog(GetComponent).ShowDialog;
      1: ShowAbout(ADVersion);
    end;
  end else if (GetComponent is TadDBGridEX) then begin
    case Index of
      0: ShowCollectionEditor(Designer, GetComponent, TadDBGridEX(GetComponent).Columns, 'Columns');
      1: ShowAbout(ADVersion);
    else  
      inherited ExecuteVerb(Index);
    end;
  end else if (Index = 0) then
    ShowAbout(ADVersion)
  else
    inherited ExecuteVerb(Index);
  // Final das modificações
end;

//------------------------------------------------------------------------------

end.
