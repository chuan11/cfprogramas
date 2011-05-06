{$I DFS.INC}

unit DFSToolBarReg;

interface

procedure Register;

implementation

uses
  {$IFDEF DFS_NO_DSGNINTF}
  DesignIntf,
  DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  DFSToolBar, DFSAbout, Classes;

procedure Register;
begin
  RegisterComponents('DFS', [TDFSToolBar]);
  RegisterPropertyEditor(TypeInfo(string), TDFSToolBar, 'Version',
     TDFSVersionProperty);
end;


end.
