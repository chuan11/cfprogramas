unit TUtility;

interface

uses DbiTypes;

{ TUtility (TUVerifyTable) Session Options }
const
  TU_Append_Errors = 1;
  TU_No_Secondary  = 2;
  TU_No_Warnings   = 4;
  TU_Header_Only   = 8;
  TU_Dialog_Hide   = 16;
  TU_No_Lock       = 32;

{ TUtility type definitions }
type
  hTUses  = word;
  phTUses = ^hTUses;
  { Verify Callback processes }
  TUVerifyProcess = (TUVerifyHeader, TUVerifyIndex, TUVerifyData, TUVerifySXHeader,
                     TUVerifySXIndex, TUVerifySXData, TUVerifySXIntegrity,
                     TUVerifyTableName);
  { Call back info for Verify Callback function }
  TUVerifyCallBack = record
    PercentDone: word;
    TableName: DBIPath;
    Process: TUVerifyProcess;
    CurrentIndex: word;
    TotalIndex: word;
  end;

{ TUtility functions }
function TUInit(hTUSession: phTUses): DBIResult;
function TUVerifyTable(hTUSession: hTUses; pszTableName, pszDriverType,
                       pszErrTableName, pszPassword: PChar; iOptions: integer;
                       var piErrorLevel: word): DBIResult;
function TURebuildTable(hTUSession: hTUses; pszTableName, pszDriverType,
                        pszBackupTableName, pszKeyviolName, pszProblemTableName:
                        PChar; pCrDesc: pCRTblDesc): DBIResult;
function TUGetCRTblDescCount(hTUSession: hTUses; pszTableName: PChar; var
                             iFldCount,iIdxCount, iSecRecCount, iValChkCount,
                             iRintCount, iOptParams, iOptDataLen: word):
                             DBIResult;
function TUFillCRTblDesc(hTUSession: hTUses; pCrDesc: pCRTblDesc;
                         pszTableName, pszPassword: PChar): DBIResult;
function TUFillCURProps(hTUSession: hTUses; pszTableName: PChar; tblProps:
                        pCURProps): DBIResult;
function TUExit(hTUSession: hTUses): DBIResult;
function TUGetErrorString(iErrorcode: DBIResult; pszError: PChar): DBIResult;

implementation

function TUInit;              external 'TUTILITY' index 2;
function TUVerifyTable;       external 'TUTILITY' index 3;
function TURebuildTable;      external 'TUTILITY' index 4;
function TUGetCRTblDescCount; external 'TUTILITY' index 5;
function TUFillCRTblDesc;     external 'TUTILITY' index 6;
function TUFillCURProps;      external 'TUTILITY' index 7;
function TUExit;              external 'TUTILITY' index 8;
function TUGetErrorString;    external 'TUTILITY' index 9;

end.
