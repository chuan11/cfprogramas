unit ZipMstr;
(* TZipMaster VCL by Chris Vleghert and Eric W. Engler
   e-mail: englere@abraxis.com
   www:    http://www.geocities.com/SiliconValley/Network/2114
 v1.70 by Russell Peters August 2, 2002.

            *)

//{$DEFINE NO_SPAN}
//{$DEFINE NO_SFX}

{$INCLUDE ZipVers.inc}
{$IFDEF VER140}
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

interface

uses
    Forms, WinTypes, WinProcs, SysUtils, Classes, Messages, Dialogs, Controls,
    ZipDLL, UnzDLL, ZCallBck, ZipMsg, ShellApi, Graphics, Buttons, StdCtrls,
    FileCtrl;

const
    ZIPMASTERVERSION: string = '1.70';
    ZIPMASTERBUILD: string = '1.7.0.5';
    Min_ZipDll_Vers: integer = 170;
    Min_UnzDll_Vers: integer = 170;

    {$IFDEF VERD2D3}
type
    LargeInt = Comp;
type
    pLargeInt = ^Comp;
type
    LongWord = Cardinal;
const
    mrNoToAll = mrNo + 1;
    {$ENDIF}
    {$IFDEF VERD4+}
type
    LargeInt = Int64;
type
    pLargeInt = ^Int64;
    {$ENDIF}

    //------------------------------------------------------------------------
type
    ProgressType = (NewFile, ProgressUpdate, EndOfBatch, TotalFiles2Process,
        TotalSize2Process);

    AddOptsEnum = (AddDirNames, AddRecurseDirs, AddMove, AddFreshen, AddUpdate,
        AddZipTime, AddForceDOS, AddHiddenFiles, AddArchiveOnly, AddResetArchive,
		AddEncrypt, AddSeparateDirs, AddVolume, AddFromDate, AddDiskSpan, AddDiskSpanErase);
	AddOpts = set of AddOptsEnum;

    // When changing this enum also change the pointer array in the function AddSuffix,
    // and the initialisation of ZipMaster. Also keep assGIF as first and assEXE as last value.
    AddStoreSuffixEnum = (assGIF, assPNG, assZ, assZIP, assZOO, assARC,
        assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR,
        assACE, assCAB, assGZ, assGZIP, assJAR, assEXE);
    AddStoreExts = set of AddStoreSuffixEnum;

	ExtrOptsEnum = (ExtrDirNames, ExtrOverWrite, ExtrFreshen, ExtrUpdate, ExtrTest);
    ExtrOpts = set of ExtrOptsEnum;

    SFXOptsEnum = (SFXAskCmdLine, SFXAskFiles, SFXAutoRun, SFXHideOverWriteBox, SFXCheckSize, SFXNoSuccessMsg);
    SFXOpts = set of SFXOptsEnum;

    OvrOpts = (OvrConfirm, OvrAlways, OvrNever);

    CodePageOpts = (cpAuto, cpNone, cpOEM);
    CodePageDirection = (cpdOEM2ISO, cpdISO2OEM);

    DeleteOpts = (htdFinal, htdAllowUndo);

    UnZipSkipTypes = (stOnFreshen, stNoOverwrite, stFileExists, stBadPassword, stNoEncryptionDLL,
        stCompressionUnknown, stUnknownZipHost, stZipFileFormatWrong, stGeneralExtractError);

    ZipDiskStatusEnum = (zdsEmpty, zdsHasFiles, zdsPreviousDisk, zdsSameFileName, zdsNotEnoughSpace);
    TZipDiskStatus = set of ZipDiskStatusEnum;
    TZipDiskAction = (zdaOk, zdaErase, zdaReject, zdaCancel);

type
    ZipDirEntry = packed record         // fixed part size = 42
        MadeByVersion: Byte;
        HostVersionNo: Byte;
        Version: Word;
        Flag: Word;
        CompressionMethod: Word;
        DateTime: Integer;              // Time: Word; Date: Word; }
        CRC32: Integer;
        CompressedSize: Integer;
        UncompressedSize: Integer;
        FileNameLength: Word;
        ExtraFieldLength: Word;
        FileCommentLen: Word;
        StartOnDisk: Word;
        IntFileAttrib: Word;
        ExtFileAttrib: LongWord;
        RelOffLocalHdr: LongWord;
        FileName: string;               // variable size
        FileComment: string;            // variable size
        Encrypted: Boolean;
        ExtraData: pChar;               // New v1.6, used in CopyZippedFiles()
    end;
    pZipDirEntry = ^ZipDirEntry;

type
    ZipEndOfCentral = packed record     //Fixed part size : 22 bytes
        HeaderSig: LongWord;            //(4)  hex=06054B50
        ThisDiskNo: Word;               //(2)This disk's number
        CentralDiskNo: Word;            //(2)Disk number central dir start
        CentralEntries: Word;           //(2)Number of central dir entries on this disk
        TotalEntries: Word;             //(2)Number of entries in central dir
        CentralSize: LongWord;          //(4)Size of central directory
        CentralOffSet: LongWord;        //(4)offsett of central dir on 1st disk
        ZipCommentLen: Word;            //(2)
        // not used as part of this record structure:
        // ZipComment
    end;

type
    ZipRenameRec = record
        Source: string;
        Dest: string;
        DateTime: Integer;
    end;
    pZipRenameRec = ^ZipRenameRec;

type
    EZipMaster = class(Exception)
    public
        FDisplayMsg: Boolean;           // We do not always want to see a message after an exception.
        // We also save the Resource ID in case the resource is not linked in the application.
        FResIdent: Integer;

        constructor CreateResDisp(const Ident: Integer; const Display: Boolean);
        constructor CreateResDisk(const Ident: Integer; const DiskNo: Integer);
        constructor CreateResDrive(const Ident: Integer; const Drive: string);
        constructor CreateResFile(const Ident: Integer; const File1, File2: string);
    end;

    TPasswordButton = (pwbOk, pwbCancel, pwbCancelAll, pwbAbort);
    TPasswordButtons = set of TPasswordButton;

    TProgressEvent = procedure(Sender: TObject; ProgrType: ProgressType; Filename: string; FileSize: Integer) of object;
    TMessageEvent = procedure(Sender: TObject; ErrCode: Integer; Message: string) of object;
    TSetNewNameEvent = procedure(Sender: TObject; var OldFileName: string; var IsChanged: Boolean) of object;
    TNewNameEvent = procedure(Sender: TObject; SeqNo: Integer; ZipEntry: ZipDirEntry) of object;
    TPasswordErrorEvent = procedure(Sender: TObject; IsZipAction: Boolean; var NewPassword: string; ForFile: string; var RepeatCount: LongWord; var Action: TPasswordButton) of object;
    TCRC32ErrorEvent = procedure(Sender: TObject; ForFile: string; FoundCRC, ExpectedCRC: LongWord; var DoExtract: Boolean) of object;
    TExtractOverwriteEvent = procedure(Sender: TObject; ForFile: string; IsOlder: Boolean; var DoOverwrite: Boolean; DirIndex: Integer) of object;
    TExtractSkippedEvent = procedure(Sender: TObject; ForFile: string; SkipType: UnZipSkipTypes; ExtError: Integer) of object;
    TCopyZipOverwriteEvent = procedure(Sender: TObject; ForFile: string; var DoOverwrite: Boolean) of object;
    TGetNextDiskEvent = procedure(Sender: TObject; DiskSeqNo, DiskTotal: Integer; Drive: string; var AbortAction: Boolean) of object;
    TStatusDiskEvent = procedure(Sender: TObject; PreviousDisk: Integer; PreviousFile: string; Status: TZipDiskStatus; var Action: TZipDiskAction) of object;
    TFileCommentEvent = procedure(Sender: TObject; ForFile: string; var FileComment: string; var IsChanged: Boolean) of object;

    TZipStream = class(TMemoryStream)
    public
        constructor Create;
        destructor Destroy; override;

        procedure SetPointer(Ptr: Pointer; Size: Integer); virtual;
    end;

    TZipMaster = class(TComponent)
    private
        // fields of published properties
        FAddCompLevel: Integer;
        fAddOptions: AddOpts;
        FAddStoreSuffixes: AddStoreExts;
        { Private versions of property variables }
        fCancel: Boolean;
        FDirOnlyCount: Integer;
        fErrCode: Integer;
        fFullErrCode: Integer;
        fHandle: HWND;
        FIsSpanned: Boolean;
        fMessage: string;
        fVerbose: Boolean;
        fTrace: Boolean;
        fZipContents: TList;
        fExtrBaseDir: string;
        fZipBusy: Boolean;
        fUnzBusy: Boolean;
        FExtrOptions: ExtrOpts;
        FFSpecArgs: TStrings;
        FZipFileName: string;
        FSuccessCnt: Integer;
        FPassword: ShortString;
        FEncrypt: Boolean;
        FSFXOffset: Integer;
        FDLLDirectory: string;
        FUnattended: Boolean;

        AutoExeViaAdd: Boolean;
        FVolumeName: string;
        FSizeOfDisk: LargeInt;          { Int64 or Comp }
        FDiskFree: LargeInt;
        FFreeOnDisk: LargeInt;
        FDiskSerial: Integer;
        FDrive: string;

        FHowToDelete: DeleteOpts;
        FTotalSizeToProcess: Cardinal;
        FDiskNr: Integer;
        FTotalDisks: Integer;
        FFileSize: Integer;
        FRealFileSize: Cardinal;
        FWrongZipStruct: Boolean;
        FInFileName: string;
        FInFileHandle: Integer;
        FOutFileHandle: Integer;
        FVersionMadeBy1: Integer;
        FVersionMadeBy0: Integer;
        FDateStamp: Integer; { DOS formatted date/time - use Delphi's
        FileDateToDateTime function to give you TDateTime format.}
		fFromDate: TDate;
        FTempDir: string;
        FShowProgress: Boolean;
        FFreeOnDisk1: Integer;
        FMaxVolumeSize: Integer;
        FMinFreeVolSize: Integer;
        FCodePage: CodePageOpts;
        FZipEOC: Integer;               // End-Of-Central-Dir location
        FZipSOC: Integer;               // Start-Of-Central-Dir location
        FZipComment: string;
        FVersionInfo: string;
        FZipStream: TZipStream;
        FPasswordReqCount: LongWord;
        GAssignPassword: Boolean;
        GModalResult: TModalResult;
        FFSpecArgsExcl: TStrings;
        FUseDirOnlyEntries: Boolean;
        FRootDir: string;
        FCurWaitCount: Integer;
        FSaveCursor: TCursor;
        // Dll related variables
        fMinZipDllVer: integer;         // new 1.70
        fMinUnzDllVer: integer;         // new 1.70
        { Main call to execute a ZIP add or Delete.  This call returns the
          number of files that were sucessfully operated on. }
        ZipDllExec: function(ZipRec: pZipParms): DWord; stdcall;
        GetZipDllVersion: function: DWord; stdcall;
        ZipDllHandle: HWND;
        { Main call to execute a ZIP add or Delete.  This call returns the
          number of files that were sucessfully operated on. }
        UnzDllExec: function(UnZipRec: pUnZipParms): DWord; stdcall;
        GetUnzDllVersion: function: DWord; stdcall;
        UnzDllHandle: HWND;

        ZipParms: pZipParms;            { declare an instance of ZipParms 1 or 2 }
        UnZipParms: pUnZipParms;        { declare an instance of UnZipParms 2 }

        { Event variables }
        FOnDirUpdate: TNotifyEvent;
        FOnProgress: TProgressEvent;
        FOnMessage: TMessageEvent;
        FOnSetNewName: TSetNewNameEvent;
        FOnNewName: TNewNameEvent;
        FOnPasswordError: TPasswordErrorEvent;
        FOnCRC32Error: TCRC32ErrorEvent;
        FOnExtractOverwrite: TExtractOverwriteEvent;
        FOnExtractSkipped: TExtractSkippedEvent;
        FOnCopyZipOverwrite: TCopyZipOverwriteEvent;
        FOnFileComment: TFileCommentEvent;
        {$IFNDEF NO_SPAN}
        fConfirmErase: Boolean;
        FDiskWritten: Integer;
        FDriveNr: Integer;
        FFormatErase: Boolean;          // New 1.70
        FInteger: Integer;
        FNewDisk: Boolean;
        FOnGetNextDisk: TGetNextDiskEvent;
        FOnStatusDisk: TStatusDiskEvent;
        FOutFileName: string;
        FZipDiskAction: TZipDiskAction;
        FZipDiskStatus: TZipDiskStatus;
        {$ENDIF}
        {$IFNDEF NO_SFX}
        FSFXCaption: string;            // dflt='Self-extracting Archive'
        FSFXCommandLine: string;        // dflt=''
        FSFXDefaultDir: string;         // dflt=''
        FSFXIcon: TIcon;
        FSFXMessage: string;
        FSFXOptions: SFXOpts;
        FSFXOverWriteMode: OvrOpts;     // ovrConfirm  (others: ovrAlways, ovrNever)
        FSFXPath: string;
        FJumpValue: array[#0..#255] of Integer;
        {$ENDIF}

        { Property get/set functions }
        function GetCount: Integer;
        procedure SetFSpecArgs(Value: TStrings);
        procedure SetFileName(Value: string);
        function GetZipVers: Integer;
        function GetUnzVers: Integer;
        procedure SetDLLDirectory(Value: string);
        procedure SetVersionInfo(Value: string);
        function GetZipComment: string;
        procedure SetZipComment(zComment: string);
        procedure SetPasswordReqCount(Value: LongWord);
        procedure SetFSpecArgsExcl(Value: TStrings);

        { Private "helper" functions }
        function Load_ZipDll(var autoload: boolean): integer; // new 1.70
        function Load_UnzDll(var autoload: boolean): integer; // new 1.70
        procedure SetMinZipDllVers(Value: integer); // New 1.70
        procedure SetMinUnzDllVers(Value: integer); // New 1.70
        function GetDirEntry(idx: integer): ZipDirEntry; // New 1.70
        function GetZipDllPath(handle: cardinal): string; // New 1.70
        function GetUnzDllPath(handle: cardinal): string; // New 1.70
        procedure FreeZipDirEntryRecords;
        procedure SetZipSwitches(var NameOfZipFile: string; zpVersion: Integer);
        procedure SetUnZipSwitches(var NameOfZipFile: string; uzpVersion: Integer);
        procedure ShowExceptionError(const ZMExcept: EZipMaster);
        function LoadZipStr(Ident: Integer; DefaultStr: string): string;
        function ConvCodePage(Source: string; Direction: CodePageDirection): string;
        function IsDiskPresent: Boolean;
        function CheckIfLastDisk(var EOC: ZipEndOfCentral; DoExcept: Boolean): Boolean;
        function ReplaceForwardSlash(aStr: string): string;
        function CopyBuffer(InFile, OutFile, ReadLen: Integer): Integer;
        procedure WriteJoin(Buffer: pChar; BufferSize, DSErrIdent: Integer);
        procedure GetNewDisk(DiskSeq: Integer);

        procedure DiskFreeAndSize(Action: Integer);
        procedure AddSuffix(const SufOption: AddStoreSuffixEnum; var sStr: string; sPos: Integer);
        procedure ExtExtract(UseStream: Integer; MemStream: TMemoryStream);
		procedure ExtAdd(UseStream: Integer; StrFileDate, StrFileAttr: DWORD; MemStream: TMemoryStream);
        procedure SetDeleteSwitches;
        procedure StartWaitCursor;
        procedure StopWaitCursor;
        procedure TraceMessage(Msg: string);

        //		procedure DoOnMessage(Sender: TObject; ErrCode: Integer; Message: string);	// New 1.70
        {$IFNDEF NO_SPAN}
        function CheckForDisk: Integer;
        procedure ClearFloppy(dir: string); // New 1.70
        function IsRightDisk(drt: Integer): Boolean;
        function MakeString(Buffer: pChar; Size: Integer): string;
        procedure RWJoinData(Buffer: pChar; ReadLen, DSErrIdent: Integer);
        procedure RWSplitData(Buffer: pChar; ReadLen, ZSErrVal: Integer);
        procedure WriteSplit(Buffer: pChar; Len: Integer; MinSize: Integer);
        function ZipFormat: Integer;    // New 1.70
        {$ENDIF}
        {$IFNDEF NO_SFX}
        function IsInstallShield(const fh: THandle): Boolean;
        function ReplaceIcon(SFXFile, SFXSize: Integer): Integer;
        function RWCentralDir(OutFile: Integer; EOC: ZipEndOfCentral; OffsetChange: Integer): Integer;
        procedure SetSFXIcon(aIcon: TIcon);
        {$ENDIF}

    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;

        { Public Properties (run-time only) }
        property Handle: HWND read fHandle write fHandle;
        property ErrCode: Integer read fErrCode write fErrCode;
        property Message: string read fMessage write fMessage;

        property ZipContents: TList read FZipContents;
        property Cancel: Boolean read fCancel write fCancel;
        property ZipBusy: Boolean read fZipBusy;
        property UnzBusy: Boolean read fUnzBusy;

        property Count: Integer read GetCount;
        property SuccessCnt: Integer read FSuccessCnt;

        property ZipVers: Integer read GetZipVers;
        property UnzVers: Integer read GetUnzVers;

        property SFXOffset: Integer read FSFXOffset;
        property ZipSOC: Integer read FZipSOC default 0;
        property ZipEOC: Integer read FZipEOC default 0;
        property IsSpanned: Boolean read FIsSpanned default False;
        property ZipFileSize: Cardinal read FRealFileSize default 0;
        property FullErrCode: Integer read FFullErrCode;
        property TotalSizeToProcess: Cardinal read FTotalSizeToProcess;

        property ZipComment: string read GetZipComment write SetZipComment;
        property ZipStream: TZipStream read FZipStream;
        property DirOnlyCount: Integer read FDirOnlyCount default 0;

        { Public Methods }
        { NOTE: Test is an sub-option of extract }
        procedure Add;
        procedure Delete;
        procedure Extract;
        procedure List;
        // load dll - return version
        function Load_Zip_Dll: integer;
        function Load_Unz_Dll: integer;
        procedure Unload_Zip_Dll;
        procedure Unload_Unz_Dll;
        procedure AbortDlls;
        function CopyFile(const InFileName, OutFileName: string): Integer;
        function EraseFile(const Fname: string; How: DeleteOpts): Integer;
        function GetAddPassword: string;
        function GetExtrPassword: string;
        function AppendSlash(sDir: string): string;
        { New in v1.6 }
        function Rename(RenameList: TList; DateTime: Integer): Integer;
        function ExtractFileToStream(Filename: string): TZipStream;
        function AddStreamToStream(InStream: TMemoryStream): TZipStream;
        {$IFDEF VERD4+}
        function ExtractStreamToStream(InStream: TMemoryStream; OutSize: LongWord = 32768): TZipStream;
        procedure AddStreamToFile(Filename: string = ''; FileDate: DWord = 0; FileAttr: DWord = 0);
        function MakeTempFileName(Prefix: string = 'zip'; Extension: string = '.zip'): string;
        procedure ShowZipMessage(Ident: Integer; UserStr: string = '');
        {$ELSE}
        procedure AddStreamToFile(Filename: string; FileDate, FileAttr: Dword);
        function ExtractStreamToStream(InStream: TMemoryStream; OutSize: Longword): TZipStream;
        function MakeTempFileName(Prefix, Extension: string): string;
        procedure ShowZipMessage(Ident: Integer; UserStr: string);
        {$ENDIF}
        function GetPassword(DialogCaption, MsgTxt: string; pwb: TPasswordButtons; var ResultStr: string): TPasswordButton;
        function CopyZippedFiles(DestZipMaster: TZipMaster; DeleteFromSource: boolean; OverwriteDest: OvrOpts): Integer;

        property DirEntry[idx: integer]: ZipDirEntry read GetDirEntry; // New 1.70
        function FullVersionString: string; // New 1.70
        {$IFNDEF NO_SPAN}
        function ReadSpan(InFileName: string; var OutFilePath: string): Integer;
        function WriteSpan(InFileName, OutFileName: string): Integer;
        {$ENDIF}
        {$IFNDEF NO_SFX}
        function ConvertSFX: Integer;
        function ConvertZIP: Integer;
        function IsZipSFX(const SFXExeName: string): Integer;
        {$ENDIF}

    published
        { Public properties that also show on Object Inspector }
        property Verbose: Boolean read FVerbose
            write FVerbose;
        property Trace: Boolean read FTrace
            write FTrace;
        property AddCompLevel: Integer read FAddCompLevel
            write FAddCompLevel;
        property AddOptions: AddOpts read FAddOptions
			write fAddOptions;
		property AddFrom: TDate read fFromDate write fFromDate;
        property ExtrBaseDir: string read FExtrBaseDir
            write FExtrBaseDir;
        property ExtrOptions: ExtrOpts read FExtrOptions
            write FExtrOptions;
        property FSpecArgs: TStrings read FFSpecArgs
            write SetFSpecArgs;
        property Unattended: Boolean read FUnattended
            write FUnattended;
        { At runtime: every time the filename is assigned a value,
          the ZipDir will automatically be read. }
        property ZipFileName: string read FZipFileName
            write SetFileName;
        property Password: ShortString read FPassword
            write FPassword;
        property DLLDirectory: string read FDLLDirectory
            write SetDLLDirectory;
        property MinZipDllVers: integer read fMinZipDllVer
            write SetMinZipDllVers;     // default Min_ZipDll_Vers; // new 1.70
        property MinUnzDllVers: integer read fMinUnzDllVer
            write SetMinUnzDllVers;     // default Min_UnzDll_Vers; // new 1.70
        property TempDir: string read FTempDir
            write FTempDir;
        property CodePage: CodePageOpts read FCodePage
            write FCodePage default cpAuto;
        property HowToDelete: DeleteOpts read FHowToDelete
            write FHowToDelete default htdAllowUndo;
        { New in 1.52k }
        property VersionInfo: string read FVersionInfo
            write SetVersionInfo;
        { New in v1.6 }
        property AddStoreSuffixes: AddStoreExts read FAddStoreSuffixes
            write FAddStoreSuffixes;
        property PasswordReqCount: LongWord read FPasswordReqCount
            write SetPasswordReqCount default 1;
        property FSpecArgsExcl: TStrings read FFSpecArgsExcl
            write SetFSpecArgsExcl;
        property UseDirOnlyEntries: Boolean read FUseDirOnlyEntries
            write FUseDirOnlyEntries default False;
        property RootDir: string read FRootDir
            write fRootDir;

        { Events }
        property OnDirUpdate: TNotifyEvent read FOnDirUpdate
            write FOnDirUpdate;
        property OnProgress: TProgressEvent read FOnProgress
            write FOnProgress;
        property OnMessage: TMessageEvent read fOnMessage write fOnMessage;
        { New in v1.6 }
        property OnSetNewName: TSetNewNameEvent read FOnSetNewName
            write FOnSetNewName;
        property OnNewName: TNewNameEvent read FOnNewName
            write FOnNewName;
        property OnCRC32Error: TCRC32ErrorEvent read FOnCRC32Error
            write FOnCRC32Error;
        property OnPasswordError: TPasswordErrorEvent read FOnPasswordError
            write FOnPasswordError;
        property OnExtractOverwrite: TExtractOverwriteEvent read FOnExtractOverwrite
            write FOnExtractOverwrite;
        property OnExtractSkipped: TExtractSkippedEvent read FOnExtractSkipped
            write FOnExtractSkipped;
        property OnCopyZipOverwrite: TCopyZipOverwriteEvent read FOnCopyZipOverwrite
            write FOnCopyZipOverwrite;
        property OnFileComment: TFileCommentEvent read FOnFileComment
            write FOnFileComment;
        {$IFNDEF NO_SPAN}
        property ConfirmErase: Boolean read fConfirmErase write fConfirmErase default True;
        property FormatErase: Boolean read FFormatErase write FFormatErase default False;
        property KeepFreeOnDisk1: Integer read FFreeOnDisk1 write FFreeOnDisk1;
        property MaxVolumeSize: Integer read FMaxVolumeSize write FMaxVolumesize default 0;
        property MinFreeVolumeSize: Integer read FMinFreeVolSize write FMinFreeVolSize default 65536;
        property OnGetNextDisk: TGetNextDiskEvent read FOnGetNextDisk write FOnGetNextDisk;
        property OnStatusDisk: TStatusDiskEvent read FOnStatusDisk write FOnStatusDisk;
        {$ENDIF}
        {$IFNDEF NO_SFX}
        property SFXCaption: string read FSFXCaption write FSFXCaption;
        property SFXCommandLine: string read FSFXCommandLine write FSFXCommandLine;
        property SFXDefaultDir: string read FSFXDefaultDir write FSFXDefaultDir;
        property SFXIcon: TIcon read FSFXIcon write SetSFXIcon;
        property SFXMessage: string read FSFXMessage write FSFXMessage;
        property SFXOptions: SfxOpts read FSFXOptions write FSFXOptions default [SFXCheckSize];
        property SFXOverWriteMode: OvrOpts read FSFXOverWriteMode write FSFXOverWriteMode;
        property SFXPath: string read FSFXPath write FSFXPath;
        {$ENDIF}
    end;

function PathConcat(path, extra: string): string;

procedure Register;

implementation

uses ZipStructs;
{$R ZipMstr.Res}

const                                   { these are stored in reverse order }
    LocalFileHeaderSig = $04034B50;     { 'PK'34  (in file: 504b0304) }
    CentralFileHeaderSig = $02014B50;   { 'PK'12 }
    EndCentralDirSig = $06054B50;       { 'PK'56 }
    ExtLocalSig = $08074B50;            { 'PK'78 }
    BufSize = 8192;                     // Keep under 12K to avoid Winsock problems on Win95.
    // If chunks are too large, the Winsock stack can
    // lose bytes being sent or received.
    FlopBufSize = 65536;
    RESOURCE_ERROR: string = 'ZipMsgXX.res is probably not linked to the executable' + #10 + 'Missing String ID is: ';

    ZIPVERSION = 170;
    UNZIPVERSION = 170;

type
    TBuffer = array[0..BufSize - 1] of Byte;
    pBuffer = ^TBuffer;
    { Define the functions that are not part of the TZipMaster class. }
    { The callback function must NOT be a member of a class. }
    { We use the same callback function for ZIP and UNZIP. }

function ZCallback(ZCallBackRec: pZCallBackStruct): LongBool; stdcall; export; forward;

type
    TPasswordDlg = class(TForm)
    private
        PwBtn: array[0..3] of TBitBtn;
        PwdEdit: TEdit;
        PwdTxt: TLabel;

    public
        constructor CreateNew2(Owner: TComponent; pwb: TPasswordButtons); virtual;
        destructor Destroy; override;

        function ShowModalPwdDlg(DlgCaption, MsgTxt: string): string; virtual;
    end;

type
    MDZipData = record                  // MyDirZipData
        Diskstart: Word;                // The disk number where this file begins
        RelOffLocal: LongWord;          // offset from the start of the first disk
        FileNameLen: Word;              // length of current filename
        FileName: array[0..254] of Char; // Array of current filename
        CRC32: LongWord;
        ComprSize: LongWord;
        UnComprSize: LongWord;
        DateTime: Integer;
    end;
    pMZipData = ^MDZipData;

    TMZipDataList = class(TList)
    private
        function GetItems(Index: integer): pMZipData;
    public
        constructor Create(TotalEntries: integer);
        destructor Destroy; override;
        property Items[Index: integer]: pMZipData read GetItems;
        function IndexOf(fname: string): integer;
    end;

    // ==================================================================
    {$IFDEF VER90}                      // if Delphi 2

function AnsiStrPos(S1, S2: pChar): pChar;
begin
    Result := StrPos(S1, S2);           // not will not work with MBCS
end;

function AnsiStrIComp(S1, S2: pChar): Integer;
begin
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, S1, -1, S2, -1) - 2;
end;

function AnsiPos(const Substr, S: string): Integer;
begin
    Result := Pos(Substr, S);
end;
{$ENDIF}
// ---------------------------- ZipDataList --------------------------------

function TMZipDataList.GetItems(Index: integer): pMZipData;
begin
    if Index >= Count then
        raise Exception.CreateFmt('Index (%d) outside range 1..%d',
            [Index, Count - 1]);
    Result := inherited Items[Index];
end;

constructor TMZipDataList.Create(TotalEntries: integer);
var
    i: Integer; MDZDp: pMZipData;
begin
    inherited Create;
    Capacity := TotalEntries;
    for i := 1 to TotalEntries do
    begin
        New(MDZDp);
        MDZDp^.FileName := '';
        Add(MDZDp);
    end;
end;

destructor TMZipDataList.Destroy;
var
    i: Integer; MDZDp: pMZipData;
begin
    if Count > 0 then
    begin
        for i := (Count - 1) downto 0 do
        begin
            MDZDp := Items[i];
            if Assigned(MDZDp) then     // dispose of the memory pointed-to by this entry
                Dispose(MDZDp);

            Delete(i);                  // delete the TList pointer itself
        end;
    end;
    inherited Destroy;
end;

function TMZipDataList.IndexOf(fname: string): integer;
var
    MDZDp: pMZipData;
begin
    for Result := 0 to (Count - 1) do
    begin
        MDZDp := Items[Result];
        if CompareText(fname, MDZDp^.FileName) = 0 then // case insensitive compare
            break;
    end;

    // Should not happen, but maybe in a bad archive...
    if Result = Count then
        raise EZipMaster.CreateResDisp(DS_EntryLost, True);
end;
//----------------------------------------------------------------------------
{ Dennis Passmore (Compuserve: 71640,2464) contributed the idea of passing an
  instance handle to the DLL, and, in turn, getting it back from the callback.
  This lets us referance variables in the TZipMaster class from within the
  callback function.  Way to go Dennis! }

function ZCallback(ZCallBackRec: PZCallBackStruct): LongBool; stdcall; export;
var
    Msg, OldFileName, pwd, FileComment: string;
    IsChanged, DoExtract, DoOverwrite: Boolean;
    RptCount: LongWord;
    Action: TPasswordButton;
begin
    with ZCallBackRec^, (TObject(Caller) as TZipMaster) do
    begin
        Msg := ReplaceForwardSlash(TrimRight(FileNameOrMsg));
        case ActionCode of
            1:                          { progress type 1 = starting any ZIP operation on a new file }
                if Assigned(FOnProgress) then
                    FOnProgress(Caller, NewFile, Msg, FileSize);

            2:                          { progress type 2 = increment bar }
                if Assigned(FOnProgress) then
                    FOnProgress(Caller, ProgressUpdate, '', FileSize);

            3:                          { end of a batch of 1 or more files }
                if Assigned(FOnProgress) then
                    FOnProgress(Caller, EndOfBatch, '', 0);

            4:                          { a routine status message }
                begin
                    Message := Msg;
                    if ErrorCode <> 0 then // W'll always keep the last ErrorCode
                    begin
                        ErrCode := Integer(Char(ErrorCode and $FF));
                        fFullErrCode := ErrorCode;
                    end;
                    if Assigned(OnMessage) then
                        OnMessage(Caller, ErrorCode, Msg);
                end;

            5:                          { total number of files to process }
                if Assigned(OnProgress) then
                    OnProgress(Caller, TotalFiles2Process, '', FileSize);

            6:                          { total size of all files to be processed }
                begin
                    FTotalSizeToProcess := FileSize;

                    if Assigned(FOnProgress) then
                        FOnProgress(Caller, TotalSize2Process, '', FileSize);
                end;

            7:                          { new in v1.60, request for a new path+name just before zipping or extracting }
                if Assigned(FOnSetNewName) then
                begin
                    OldFileName := Msg;
                    IsChanged := False;

                    FOnSetNewName(Caller, OldFileName, IsChanged);
                    if IsChanged then
                    begin
                        StrPLCopy(FileNameOrMsg, OldFileName, 512);
                        ErrorCode := 1;
                    end
                    else
                        ErrorCode := 0;
                end;

            8:                          { New or other password needed during Extract() }
                begin
                    pwd := '';
                    RptCount := FileSize;
                    Action := pwbOk;

                    GAssignPassword := False;
                    if Assigned(FOnPasswordError) then
                    begin
                        GModalResult := mrNone;
                        FOnPasswordError(Caller, IsOperationZip, pwd, Msg, RptCount, Action);
                        if Action <> pwbOk then
                            pwd := '';
                        if Action = pwbCancelAll then
                            GModalResult := mrNoToAll;
                        if Action = pwbAbort then
                            GModalResult := mrAbort;
                    end
                    else
                        if (ErrorCode and $01) <> 0 then
                            pwd := GetAddPassword()
                        else
                            pwd := GetExtrPassword();

                    if pwd <> '' then
                    begin
                        StrPLCopy(FileNameOrMsg, pwd, PWLEN);
                        ErrorCode := 1;
                    end
                    else
                    begin
                        RptCount := 0;
                        ErrorCode := 0;
                    end;
                    if RptCount > 15 then
                        FileSize := 15
                    else
                        FileSize := RptCount;
                    if GModalResult = mrNoToAll then // Cancel all
                        ActionCode := 0;
                    if GModalResult = mrAbort then // Abort
                        Cancel := True;
                    GAssignPassword := True;
                end;

            9:                          { CRC32 error, (default action is extract/test the file) }
                begin
                    DoExtract := true;  // This was default for versions <1.6

                    if Assigned(FOnCRC32Error) then
                        FOnCRC32Error(Caller, Msg, ErrorCode, FileSize, DoExtract);
                    ErrorCode := Integer(DoExtract);
                    { This will let the Dll know it should send some warnings }
                    if not Assigned(FOnCRC32Error) then
                        ErrorCode := 2;
                end;

            10:                         { Extract(UnZip) Overwrite ask }
                if Assigned(FOnExtractOverwrite) then
                begin
                    DoOverwrite := Boolean(FileSize);
                    FOnExtractOverwrite(Caller, Msg, (ErrorCode and $10000) = $10000, DoOverwrite, ErrorCode and $FFFF);
                    FileSize := Integer(DoOverwrite);
                end;

            11:                         { Extract(UnZip) and Skipped }
                begin
                    if ErrorCode <> 0 then
                    begin
                        ErrCode := Integer(Char(ErrorCode and $FF));
                        FFullErrCode := ErrorCode;
                    end;
                    if Assigned(FOnExtractSkipped) then
                        //FOnExtractSkipped( Caller, Msg, UnZipSkipTypes(FileSize), ErrorCode );
                        FOnExtractSkipped(Caller, Msg, UnZipSkipTypes((FileSize and $FF) - 1), ErrorCode);
                end;

            12:                         { Add(Zip) FileComments. v1.60L }
                if Assigned(FOnFileComment) then
                begin
                    FileComment := FileNameOrMsg[256];
                    IsChanged := False;
                    FOnFileComment(Caller, Msg, FileComment, IsChanged);
                    if IsChanged and (FileComment <> '') then
                        StrPLCopy(FileNameOrMsg, FileComment, 511)
                    else
                        FileNameOrMsg[0] := #0;
                    ErrorCode := Integer(IsChanged);
                    FileSize := Length(FileComment);
                    if FileSize > 511 then
                        FileSize := 511;
                end;

            13:                         { Stream2Stream extract. v1.60M }
                begin
                    try
                        FZipStream.SetSize(FileSize);
                    except
                        ErrorCode := 1;
                        FileSize := 0;
                    end;
                    if ErrorCode <> 1 then
                        FileSize := Integer(FZipStream.Memory);
                end;

        end;                            {end case }

        { If you return TRUE, then the DLL will abort it's current
          batch job as soon as it can. }
        Result := Cancel;
    end;                                { end with }
    Application.ProcessMessages;
end;

{ Implementation of TZipMaster class member functions }
{-----------------------------------------------------}

constructor TZipMaster.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    fZipContents := TList.Create;
    FFSpecArgs := TStringList.Create;
    FFSpecArgsExcl := TStringList.Create; { New in v1.6 }
    fHandle := Application.Handle;
    ZipParms {.zp1} := nil;
    UnZipParms := nil;
    FZipFileName := '';
    FPassword := '';
    FPasswordReqCount := 1;             { New in v1.6 }
    FEncrypt := False;
    FSuccessCnt := 0;
    FAddCompLevel := 9;                 { dflt to tightest compression }
    FDLLDirectory := '';
    AutoExeViaAdd := False;
    FUnattended := False;
    FRealFileSize := 0;
    FSFXOffset := 0;
    FZipSOC := 0;
    FFreeOnDisk1 := 0;                  { Don't leave any freespace on disk 1. }
    FMaxVolumeSize := 0;                { Use the maximum disk size. }
    FMinFreeVolSize := 65536;           { Reject disks with less free bytes than... }
    FCodePage := cpAuto;
    FIsSpanned := False;
    FZipComment := '';
    HowToDelete := htdAllowUndo;
    FAddStoreSuffixes := [assGIF, assPNG, assZ, assZIP, assZOO, assARC, assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR, assACE, assCAB, assGZ, assGZIP, assJAR];
    FZipStream := TZipStream.Create;
    FUseDirOnlyEntries := False;
    FDirOnlyCount := 0;
    FVersionInfo := ZIPMASTERVERSION;
    FCurWaitCount := 0;
    ZipDllHandle := 0;
    UnzDllHandle := 0;
    fMinZipDllVer := Min_ZipDll_Vers;   // new 1.70
    fMinUnzDllVer := Min_UnzDll_Vers;   // new 1.70
    {$IFNDEF NO_SPAN}
    fFormatErase := False;
    fConfirmErase := True;
    {$ENDIF}
    {$IFNDEF NO_SFX}
    FSFXIcon := TIcon.Create;           { New in v1.6 }
    FSFXOverWriteMode := ovrConfirm;
    FSFXCaption := 'Self-extracting Archive';
    FSFXDefaultDir := '';
    FSFXCommandLine := '';
    FSFXOptions := [SFXCheckSize];      { Select this opt by default. }
    FSFXPath := 'ZipSFX.bin';
    {$ENDIF}
end;

destructor TZipMaster.Destroy;
begin
    Unload_Zip_Dll;
    Unload_Unz_Dll;
    FZipStream.Free;
    FreeZipDirEntryRecords;
    fZipContents.Free;
    FFSpecArgsExcl.Free;
    FFSpecArgs.Free;
    {$IFNDEF NO_SPAN}
    {$ENDIF}
    {$IFNDEF NO_SFX}
    FSFXIcon.Free;
    {$ENDIF}
    inherited Destroy;
end;

function TPasswordDlg.ShowModalPwdDlg(DlgCaption, MsgTxt: string): string;
begin
    Caption := DlgCaption;
    PwdTxt.Caption := MsgTxt;
    ShowModal();
    if ModalResult = mrOk then
        Result := PwdEdit.Text
    else
        Result := '';
end;

constructor TPasswordDlg.CreateNew2(Owner: TComponent; pwb: TPasswordButtons);
var
    BtnCnt, Btns, i, k: Integer;
begin
    inherited CreateNew(Owner{$IFDEF VERD4+}, 0{$ENDIF});
    // Convert Button Set to a bitfield
    BtnCnt := 1;                        // We need at least the Ok button
    Btns := 1;

    if pwbCancel in pwb then
    begin
        Inc(BtnCnt);
        Btns := Btns or 2;
    end;
    if pwbCancelAll in pwb then
    begin
        Inc(BtnCnt);
        Btns := Btns or 4;
    end;
    if pwbAbort in pwb then
    begin
        Inc(BtnCnt);
        Btns := Btns or 8;
    end;

    Parent := Self;
    Width := 124 * BtnCnt + 35;
    Height := 137;
    Font.Name := 'Arial';
    Font.Height := -12;
    Font.Style := Font.Style + [fsBold];
    BorderStyle := bsDialog;
    Position := poScreenCenter;

    PwdTxt := TLabel.Create(Self);
    PwdTxt.Parent := Self;
    PwdTxt.Left := 20;
    PwdTxt.Top := 8;
    PwdTxt.Width := 297;
    PwdTxt.Height := 18;
    PwdTxt.AutoSize := False;

    PwdEdit := TEdit.Create(Self);
    PwdEdit.Parent := Self;
    PwdEdit.Left := 20;
    PwdEdit.Top := 40;
    PwdEdit.Width := 124 * BtnCnt - 10;
    PwdEdit.PasswordChar := '*';
    PwdEdit.MaxLength := PWLEN;

    for i := 1 to 3 do
        PwBtn[i] := nil;
    k := 0;
    for i := 1 to 8 do
    begin
        if (i = 3) or ((i > 4) and (i < 8)) then
            Continue;
        if (Btns and i) = 0 then
            Continue;
        PwBtn[k] := TBitBtn.Create(Self);
        PwBtn[k].Parent := Self;
        PwBtn[k].Top := 72;
        PwBtn[k].Height := 28;
        PwBtn[k].Width := 114;
        PwBtn[k].Left := 20 + 124 * k;
        case i of
            1: PwBtn[k].Kind := bkOk;
            2: PwBtn[k].Kind := bkCancel;
            4: PwBtn[k].Kind := bkNo;
            8: PwBtn[k].Kind := bkAbort;
        end;
        if i = 4 then
            PwBtn[k].ModalResult := mrNoToAll;
        case i of
            1: PwBtn[k].Caption := LoadStr(PW_Ok);
            2: PwBtn[k].Caption := LoadStr(PW_Cancel);
            4: PwBtn[k].Caption := LoadStr(PW_CancelAll);
            8: PwBtn[k].Caption := LoadStr(PW_Abort);
        end;
        Inc(k);
    end;
end;

destructor TPasswordDlg.Destroy;
var
    i: Integer;
begin
    for i := 0 to 3 do
        PwBtn[i].Free;
    PwdEdit.Free;
    PwdTxt.Free;
    inherited Destroy;
end;

// defaults if old resource used

function LoadZipMsg(Ident: Integer): string;
begin
    case Ident of
        LZ_OldZipDll: Result := 'Old Dll from ';
        LU_OldUnzDll: Result := 'Old Dll from ';
        SF_NOSFXSupport: Result := 'SFX not supported';
        DS_NoDiskSpan: Result := 'Span not supported';
    else
        Result := RESOURCE_ERROR + IntToStr(Ident);
    end;
end;

procedure TZipMaster.ShowZipMessage(Ident: Integer; UserStr: string);
var
    Msg: string;
begin
    //    Msg := LoadZipStr(Ident, RESOURCE_ERROR + IntToStr(Ident)) + UserStr;
    Msg := LoadStr(Ident);
    if Msg = '' then
        Msg := LoadZipMsg(Ident);
    Msg := Msg + UserStr;
    Message := Msg;
    ErrCode := Ident;

    if FUnattended = False then
        ShowMessage(Msg);

    if Assigned(OnMessage) then
        OnMessage(Self, 0, Msg);        // No ErrCode here else w'll get a msg from the application
end;

function TZipMaster.LoadZipStr(Ident: Integer; DefaultStr: string): string;
begin
    Result := LoadStr(Ident);

    if Result = '' then
        Result := DefaultStr;
end;

procedure TZipMaster.TraceMessage(Msg: string);
begin
    if Trace and Assigned(OnMessage) then
        OnMessage(Self, 0, Msg);        // No ErrCode here else w'll get a msg from the application
end;

//---------------------------------------------------------------------------
// Somewhat different from ShowZipMessage() because the loading of the resource
// string is already done in the constructor of the exception class.

procedure TZipMaster.ShowExceptionError(const ZMExcept: EZipMaster);
begin
    if (ZMExcept.FDisplayMsg = True) and (Unattended = False) then
        ShowMessage(ZMExcept.Message);

    ErrCode := ZMExcept.FResIdent;
    Message := ZMExcept.Message;

    if Assigned(OnMessage) then
        OnMessage(Self, 0, ZMExcept.Message);
end;

{  Convert filename (and file comment string) into "internal" charset (ISO).
 * This function assumes that Zip entry filenames are coded in OEM (IBM DOS)
 * codepage when made on:
 *  -> DOS (this includes 16-bit Windows 3.1) (FS_FAT_  0 )
 *  -> OS/2                                   (FS_HPFS_ 6 )
 *  -> Win95/WinNT with Nico Mak's WinZip     (FS_NTFS_ 11 && hostver == "5.0" 50)
 *
 * All other ports are assumed to code zip entry filenames in ISO 8859-1.
 *
 * NOTE: Norton Zip v1.0 sets the host byte incorrectly. In this case you need
 * to set the CodePage property manually to cpOEM to force the conversion.
}

function TZipMaster.ConvCodePage(Source: string; Direction: CodePageDirection): string;
const
    FS_FAT: Integer = 0;
    FS_HPFS: Integer = 6;
    FS_NTFS: Integer = 11;
var
    i: Integer;
begin
    SetLength(Result, Length(Source));
    if ((FCodePage = cpAuto) and (FVersionMadeBy1 = FS_FAT) or (FVersionMadeBy1 = FS_HPFS)
        or ((FVersionMadeBy1 = FS_NTFS) and (FVersionMadeBy0 = 50))) or (FCodePage = cpOEM) then
    begin
        for i := 1 to Length(Source) do
            if Char(Source[i]) < Char($80) then
                Result[i] := Source[i]
            else
                if Direction = cpdOEM2ISO then
                    OemToCharBuff(@Source[i], @Result[i], 1)
                else
                    CharToOemBuff(@Source[i], @Result[i], 1)
    end
    else
        Result := Source;
end;

{ We'll normally have a TStringList value, since TStrings itself is an
  abstract class. }

procedure TZipMaster.SetFSpecArgs(Value: TStrings);
begin
    FFSpecArgs.Assign(Value);
end;

procedure TZipMaster.SetFSpecArgsExcl(Value: TStrings);
begin
    FFSpecArgsExcl.Assign(Value);
end;

procedure TZipMaster.SetFilename(Value: string);
begin
    FZipFileName := Value;
    if not (csDesigning in ComponentState) then
        List;                           { automatically build a new TLIST of contents in "ZipContents" }
end;

// NOTE: we will allow a dir to be specified that doesn't exist,
// since this is not the only way to locate the DLLs.

procedure TZipMaster.SetDLLDirectory(Value: string);
var
    ValLen: Integer;
begin
    if Value <> FDLLDirectory then
    begin
        ValLen := Length(Value);
        // if there is a trailing \ in dirname, cut it off:
        if ValLen > 0 then
            if Value[ValLen] = '\' then
                SetLength(Value, ValLen - 1); // shorten the dirname by one
        FDLLDirectory := Value;
    end;
end;

function TZipMaster.GetCount: Integer;
begin
    if ZipFileName <> '' then
        Result := ZipContents.Count
    else
        Result := 0;
end;

// We do not want that this can be changed, but we do want to see it in the OI.

procedure TZipMaster.SetVersionInfo(Value: string);
begin
end;

procedure TZipMaster.SetPasswordReqCount(Value: LongWord);
begin
    if Value <> FPasswordReqCount then
    begin
        if Value > 15 then
            Value := 15;
        FPasswordReqCount := Value;
    end;
end;

function TZipMaster.GetZipComment: string;
begin
    Result := ConvCodePage(FZipComment, cpdOEM2ISO);
end;

procedure TZipMaster.SetZipComment(zComment: string);
var
    EOC: ZipEndOfCentral;
    len: Integer;
    CommentBuf: pChar;
    Fatal: Boolean;
begin
    FInFileHandle := -1;
    Fatal := False;
    CommentBuf := nil;

    try
        { ============================ Changed by Jim Turner =========================}
        if Length(zComment) = 0 then
            FZipComment := ''
        else
            FZipComment := ConvCodePage(zComment, cpdISO2OEM);
        if Length(ZipFileName) = 0 then
            raise EZipMaster.CreateResDisp(GE_NoZipSpecified {DS_NoInFile}, True);
        len := Length(FZipComment);
        GetMem(CommentBuf, len + 1);
        StrPLCopy(CommentBuf, zComment, len + 1);
        FInFileHandle := FileOpen(ZipFileName, fmShareDenyWrite or fmOpenReadWrite);

        if FInFileHandle <> -1 then     // RP 1.60 -2
        begin
            {		if FInFileHandle = -1 then
      raise EZipMaster.CreateResDisp(DS_FileOpen, True);}
            if FileSeek(FInFileHandle, FZipEOC, 0) = -1 then
                raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
            if (FileRead(FInFileHandle, EOC, SizeOf(EOC)) <> SizeOf(EOC)) or (EOC.HeaderSig <> EndCentralDirSig) then
                raise EZipMaster.CreateResDisp(DS_EOCBadRead, True);
            EOC.ZipCommentLen := len;
            if FileSeek(FInFileHandle, -SizeOf(EOC), 1) = -1 then
                raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
            Fatal := True;
            if FileWrite(FInFileHandle, EOC, SizeOf(EOC)) <> SizeOf(EOC) then
                raise EZipMaster.CreateResDisp(DS_EOCBadWrite, True);
            if FileWrite(FInFileHandle, CommentBuf^, len) <> len then
                raise EZipMaster.CreateResDisp(DS_NoWrite, True);
            Fatal := False;
            // if SetEOF fails we get garbage at the end of the file, not nice but
                     // also not important.
            SetEndOfFile(FInFileHandle);
        end;                            // RP -2
    except
        on ews: EZipMaster do
        begin
            ShowExceptionError(ews);
            FZipComment := '';
        end;
        on EOutOfMemory do
        begin
            ShowZipMessage(GE_NoMem, '');
            FZipComment := '';
        end;
    end;
    FreeMem(CommentBuf);
    if FInFileHandle <> -1 then
        FileClose(FInFileHandle);
    if Fatal then                       // Try to read the zipfile, maybe it still works.
        List();
end;

{ Empty fZipContents and free the storage used for dir entries }

procedure TZipMaster.FreeZipDirEntryRecords;
var
    i: Integer;
begin
    if ZipContents.Count = 0 then
        Exit;
    for i := (ZipContents.Count - 1) downto 0 do
    begin
        if Assigned(ZipContents[i]) then
        begin
            StrDispose(pZipDirEntry(ZipContents[i]).ExtraData);
            // dispose of the memory pointed-to by this entry
            Dispose(pZipDirEntry(ZipContents[i]));
        end;
        ZipContents.Delete(i);          // delete the TList pointer itself
    end;                                { end for }
    // The caller will free the FZipContents TList itself, if needed
end;

procedure TZipMaster.StartWaitCursor;
begin
    if FCurWaitCount = 0 then
    begin
        FSaveCursor := Screen.Cursor;
        Screen.Cursor := crHourglass;
    end;
    Inc(FCurWaitCount);
end;

procedure TZipMaster.StopWaitCursor;
begin
    if FCurWaitCount > 0 then
    begin
        Dec(FCurWaitCount);
        if FCurWaitCount = 0 then
            Screen.Cursor := FSaveCursor;
    end;
end;

{ New in v1.50: We are now looking at the Central zip Dir, instead of
  the local zip dir.  This change was needed so we could support
  Disk-Spanning, where the dir for the whole disk set is on the last disk.}
{ The List method reads thru all entries in the central Zip directory.
  This is triggered by an assignment to the ZipFilename, or by calling
  this method directly. }

procedure TZipMaster.List;              { all work is local - no DLL calls }
var
    pzd: pZipDirEntry;
    EOC: ZipEndOfCentral;
    CEH: ZipCentralHeader;
    OffsetDiff: Integer;
    Name: string;
    i, LiE: Integer;
begin
    LiE := 0;
    if (csDesigning in ComponentState) then
        Exit;                           { can't do LIST at design time }

    { zero out any previous entries }
    FreeZipDirEntryRecords;

    FRealFileSize := 0;
    FZipSOC := 0;
    FSFXOffset := 0;                    // must be before the following "if"
    FZipComment := '';
    OffsetDiff := 0;
    FIsSpanned := False;
    FDirOnlyCount := 0;

    if not FileExists(FZipFileName) then
    begin
        { let user's program know there's no entries }
        if Assigned(FOnDirUpdate) then
            FOnDirUpdate(Self);
        Exit;                           { don't complain - this may intentionally be a new zip file }
    end;

    try
        StartWaitCursor;
        try
            FInFileName := FZipFileName;
            FDrive := ExtractFileDrive(ExpandFileName(FInFileName)) + '\';

            if not IsDiskPresent then   // Not present, raise an exception!
                raise EZipMaster.CreateResDrive(DS_DriveNoMount, FDrive);
            CheckIfLastDisk(EOC, True); // Not last, w'll get an exception!

            // The function CheckIfLastDisk read the EOC record, and set some
            // global values such as FFileSize.  It also opens the zipfile
   // and left it's open handle in: FInFileHandle

            FTotalDisks := EOC.ThisDiskNo; // Needed in case GetNewDisk is called.

            // This could also be set to True if it's the first and only disk.
            if EOC.ThisDiskNo > 0 then
                FIsSpanned := True;

            // Do we have to request for a previous disk first?
            if EOC.ThisDiskNo <> EOC.CentralDiskNo then
            begin
                GetNewDisk(EOC.CentralDiskNo);
                FFileSize := FileSeek(FInFileHandle, 0, 2); //v1.52i
                OffsetDiff := EOC.CentralOffset; //v1.52i
            end
            else                        //v1.52i
                // Due to the fact that v1.3 and v1.4x programs do not change the archives
                // EOC and CEH records in case of a SFX conversion (and back) we have to
                // make this extra check.
                OffsetDiff := Longword(FFileSize) - EOC.CentralSize - SizeOf(EOC) - EOC.ZipCommentLen;
            FZipSOC := OffsetDiff;      // save the location of the Start Of Central dir
            FSFXOffset := FFileSize;    // initialize this - we will reduce it later
            if FFileSize = 22 then
                FSFXOffset := 0;

            FWrongZipStruct := False;
            if EOC.CentralOffset <> Longword(OffsetDiff) then
            begin
                FWrongZipStruct := True; // We need this in the ConvertXxx functions.
                ShowZipMessage(LI_WrongZipStruct, '');
            end;

            // Now we can go to the start of the Central directory.
            if FileSeek(FInFileHandle, OffsetDiff, 0) = -1 then
                raise EZipMaster.CreateResDisp(LI_ReadZipError, True);

            // Read every entry: The central header and save the information.
            for i := 0 to (EOC.TotalEntries - 1) do
            begin
                // Read a central header entry for 1 file
                while FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) do //v1.52i
                begin
                    // It's possible that we have the central header split up.
                    if FDiskNr >= EOC.ThisDiskNo then
                        raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
                    // We need the next disk with central header info.
                    GetNewDisk(FDiskNr + 1);
                end;

                //validate the signature of the central header entry
                if CEH.HeaderSig <> CentralFileHeaderSig then
                    raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

                // Now the filename
                SetLength(Name, CEH.FileNameLen);
                if FileRead(FInFileHandle, Name[1], CEH.FileNameLen) <> CEH.FileNameLen then
                    raise EZipMaster.CreateResDisp(DS_CENameLen, True);

                // Save version info globally for use by codepage translation routine
                FVersionMadeBy0 := CEH.VersionMadeBy0;
                FVersionMadeBy1 := CEH.VersionMadeBy1;
                Name := ConvCodePage(Name, cpdOEM2ISO);

                // Create a new ZipDirEntry pointer.
                New(pzd);               // These will be deleted in: FreeZipDirEntryRecords.

                // Copy the needed file info from the central header.
                CopyMemory(pzd, @CEH.VersionMadeBy0, 42);
                pzd^.FileName := ReplaceForwardSlash(Name);
                pzd^.Encrypted := (pzd^.Flag and 1) > 0;

                // Read the extra data if present new v1.6
                if pzd^.ExtraFieldLength > 0 then
                begin
                    pzd^.ExtraData := StrAlloc(CEH.ExtraLen + 1);
                    if FileRead(FInFileHandle, pzd^.ExtraData[0], CEH.ExtraLen) <> CEH.ExtraLen then // v1.60m
                        raise EZipMaster.CreateResDisp(LI_ReadZipError, True);
                end
                else
                    pzd^.ExtraData := nil;

                // Read the FileComment, if present, and save.
                if CEH.FileComLen > 0 then
                begin
                    // get the file comment
                    SetLength(pzd^.FileComment, CEH.FileComLen);
                    if FileRead(FInFileHandle, pzd^.FileComment[1], CEH.FileComLen) <> CEH.FileComLen then
                        raise EZipMaster.CreateResDisp(DS_CECommentLen, True);
                    pzd^.FileComment := ConvCodePage(pzd^.FileComment, cpdOEM2ISO);
                end;

                if FUseDirOnlyEntries or (ExtractFileName(pzd^.FileName) <> '') then
                begin                   // Add it to our contents tabel.
                    ZipContents.Add(pzd);
                    // Notify user, when needed, of the next entry in the ZipDir.
                    if Assigned(FOnNewName) then
                        FOnNewName(self, i + 1, pzd^);
                end
                else
                begin
                    Inc(FDirOnlyCount);
                    StrDispose(pzd^.ExtraData);
                    Dispose(pzd);
                end;

                // Calculate the earliest Local Header start
                if Longword(FSFXOffset) > CEH.RelOffLocal then
                    FSFXOffset := CEH.RelOffLocal;
            end;
            FTotalDisks := EOC.ThisDiskNo; // We need this when we are going to extract.
        except
            on ezl: EZipMaster do       // Catch all Zip List specific errors.
            begin
                ShowExceptionError(ezl);
                LiE := 1;
            end;
            on EOutOfMemory do
            begin
                ShowZipMessage(GE_NoMem, '');
                LiE := 1;
            end;
            on E: Exception do
            begin
                // the error message of an unknown error is displayed ...
                ShowZipMessage(LI_ErrorUnknown, E.Message);
                LiE := 1;
            end;
        end;
    finally
        StopWaitCursor;
        if FInFileHandle <> -1 then
            FileClose(FInFileHandle);
        if LiE = 1 then
        begin
            FZipFileName := '';
            FSFXOffset := 0;
        end
        else
            FSFXOffset := FSFXOffset + (OffsetDiff - Integer(EOC.CentralOffset)); // Correct the offset for v1.3 and 1.4x

        // Let the user's program know we just refreshed the zip dir contents.
        if Assigned(FOnDirUpdate) then
            FOnDirUpdate(Self);
    end;
end;

// Add a new suffix to the suffix string if contained in the set 'FAddStoreSuffixes'

procedure TZipMaster.AddSuffix(const SufOption: AddStoreSuffixEnum; var sStr: string; sPos: Integer);
const
    SuffixStrings: array[0..17, 0..3] of Char = ('gif', 'png', 'z', 'zip', 'zoo', 'arc', 'lzh', 'arj', 'taz', 'tgz', 'lha', 'rar', 'ace', 'cab', 'gz', 'gzip', 'jar', 'exe');
begin
    if SufOption in fAddStoreSuffixes then
        sStr := sStr + '.' + string(SuffixStrings[sPos]) + ':';
end;

procedure TZipMaster.SetZipSwitches(var NameOfZipFile: string; zpVersion: Integer);
var
    i: Integer;
    SufStr, Dts: string;
    pExFiles: pExcludedFileSpec;
begin
    with ZipParms^ do
    begin
        if Length(FZipComment) <> 0 then
        begin
            fArchComment := StrAlloc(Length(FZipComment) + 1);
            StrPLCopy(fArchComment, FZipComment, Length(FZipComment) + 1);
        end;
        if AddArchiveOnly in fAddOptions then
            fArchiveFilesOnly := 1;
        if AddResetArchive in fAddOptions then
            fResetArchiveBit := 1;

        if (FFSpecArgsExcl.Count <> 0) then
        begin
            fTotExFileSpecs := FFSpecArgsExcl.Count;
            fExFiles := AllocMem(SizeOf(ExcludedFileSpec) * FFSpecArgsExcl.Count);
            for i := 0 to (fFSpecArgsExcl.Count - 1) do
            begin
                pExFiles := fExFiles;
                Inc(pExFiles, i);
                pExFiles.fFileSpec := StrAlloc(Length(fFSpecArgsExcl[i]) + 1);
                StrPLCopy(pExFiles.fFileSpec, fFSpecArgsExcl[i], Length(fFSpecArgsExcl[i]) + 1);
            end;
        end;
        // New in v 1.6M Dll 1.6017, used when Add Move is choosen.
        if FHowToDelete = htdAllowUndo then
            fHowToMove := True;
        if FCodePage = cpOEM then
            fWantedCodePage := 2;
    end;                                { end with }

    if (Length(FTempDir) <> 0) then
    begin
        ZipParms.fTempPath := StrAlloc(Length(FTempDir) + 1);
        StrPLCopy(ZipParms.fTempPath, FTempDir, Length(FTempDir) + 1);
    end;

    with ZipParms^ do
    begin
        Version := zpVersion;           //ZIPVERSION;          // version we expect the DLL to be
        Caller := Self;                 // point to our VCL instance; returned in callback

        fQuiet := True;                 { we'll report errors upon notification in our callback }
        { So, we don't want the DLL to issue error dialogs }

        ZCallbackFunc := ZCallback;     // pass addr of function to be called from DLL
        fJunkSFX := False;              { if True, convert input .EXE file to .ZIP }

        SufStr := '';
        for i := 0 to Integer(assEXE) do
            AddSuffix(AddStoreSuffixEnum(i), SufStr, i);
        if Length(SufStr) <> 0 then
        begin
            System.Delete(SufStr, Length(SufStr), 1);
            pSuffix := StrAlloc(Length(SufStr) + 1);
            StrPLCopy(pSuffix, SufStr, Length(SufStr) + 1);
        end;
        // fComprSpecial := False;     { if True, try to compr already compressed files }

        fSystem := False;               { if True, include system and hidden files }

        if AddVolume in fAddOptions then
            fVolume := True             { if True, include volume label from root dir }
        else
            fVolume := False;

        fExtra := False;                { if True, include extended file attributes-NOT SUPTED }

		fDate := AddFromDate in fAddOptions; { if True, exclude files earlier than specified date }
		{ Date := '100592'; }{ Date to include files after; only used if fDate=TRUE }
		dts:=FormatDateTime('mm dd yy',fFromDate);
		for i:=0 to 7 do
			Date[i]:=dts[i+1];   


        fLevel := FAddCompLevel;        { Compression level (0 - 9, 0=none and 9=best) }
        fCRLF_LF := False;              { if True, translate text file CRLF to LF (if dest Unix)}
        fGrow := True;                  { if True, Allow appending to a zip file (-g)}

        fDeleteEntries := False;        { distinguish bet. Add and Delete }

        if fTrace then
            fTraceEnabled := True
        else
            fTraceEnabled := False;
        if fVerbose then
            fVerboseEnabled := True
        else
            fVerboseEnabled := False;
        if (fTraceEnabled and not fVerbose) then
            fVerboseEnabled := True;    { if tracing, we want verbose also }

        if FUnattended then
            Handle := 0
        else
            Handle := fHandle;

        if AddForceDOS in fAddOptions then
            fForce := True              { convert all filenames to 8x3 format }
        else
            fForce := False;
        if AddZipTime in fAddOptions then
            fLatestTime := True         { make zipfile's timestamp same as newest file }
        else
            fLatestTime := False;
        if AddMove in fAddOptions then
            fMove := True               { dangerous, beware! }
        else
            fMove := False;
        if AddFreshen in fAddOptions then
            fFreshen := True
        else
            fFreshen := False;
        if AddUpdate in fAddOptions then
            fUpdate := True
        else
            fUpdate := False;
        if (fFreshen and fUpdate) then
            fFreshen := False;          { Update has precedence over freshen }

        if AddEncrypt in fAddOptions then
            fEncrypt := True            { DLL will prompt for password }
        else
            fEncrypt := False;

        { NOTE: if user wants recursion, then he probably also wants
          AddDirNames, but we won't demand it. }
        if AddRecurseDirs in fAddOptions then
            fRecurse := True
        else
            fRecurse := False;

        if AddHiddenFiles in fAddOptions then
            fSystem := True
        else
            fSystem := False;

        if AddSeparateDirs in fAddOptions then
            fNoDirEntries := False { do make separate dirname entries - and also
            include dirnames with filenames }
        else
            fNoDirEntries := True; { normal zip file - dirnames only stored
        with filenames }

        if AddDirNames in fAddOptions then
            fJunkDir := False           { we want dirnames with filenames }
        else
            fJunkDir := True;           { don't store dirnames with filenames }

        pZipFN := StrAlloc(Length(NameOfZipFile) + 1); { allocate room for null terminated string }
        StrPLCopy(pZipFN, NameOfZipFile, Length(NameOfZipFile) + 1); { name of zip file }
        if Length(FPassword) > 0 then
        begin
            pZipPassword := StrAlloc(Length(FPassword) + 1); { allocate room for null terminated string }
            StrPLCopy(pZipPassword, FPassword, PWLEN + 1); { password for encryption/decryption }
        end;
    end;                                {end else with do }
end;

procedure TZipMaster.SetDeleteSwitches; { override "add" behavior assumed by SetZipSwitches: }
begin
    with ZipParms^ do
    begin
        fDeleteEntries := True;
        fGrow := False;
        fJunkDir := False;
        fMove := False;
        fFreshen := False;
        fUpdate := False;
        fRecurse := False;              // bug fix per Angus Johnson
        fEncrypt := False;              // you don't need the pwd to delete a file
    end;
end;

procedure TZipMaster.SetUnZipSwitches(var NameOfZipFile: string; uzpVersion: Integer);
begin
    with UnZipParms^ do
    begin
        Version := uzpVersion;          //UNZIPVERSION;        // version we expect the DLL to be
        Caller := Self;                 // point to our VCL instance; returned in callback

        fQuiet := True;                 { we'll report errors upon notification in our callback }
        { So, we don't want the DLL to issue error dialogs }

        ZCallbackFunc := ZCallback;     // pass addr of function to be called from DLL

        if fTrace then
            fTraceEnabled := True
        else
            fTraceEnabled := False;
        if fVerbose then
            fVerboseEnabled := True
        else
            fVerboseEnabled := False;
        if (fTraceEnabled and not fVerboseEnabled) then
            fVerboseEnabled := True;    { if tracing, we want verbose also }

        if FUnattended then
            Handle := 0
        else
            Handle := fHandle;          // used for dialogs (like the pwd dialogs)

        fQuiet := True;                 { no DLL error reporting }
        fComments := False;             { zipfile comments - not supported }
        fConvert := False;              { ascii/EBCDIC conversion - not supported }

        if ExtrDirNames in fExtrOptions then
            fDirectories := True
        else
            fDirectories := False;
        if ExtrOverWrite in fExtrOptions then
            fOverwrite := True
        else
            fOverwrite := False;

        if ExtrFreshen in fExtrOptions then
            fFreshen := True
        else
            fFreshen := False;
        if ExtrUpdate in fExtrOptions then
            fUpdate := True
        else
            fUpdate := False;
        if fFreshen and fUpdate then
            fFreshen := False;          { Update has precedence over freshen }

        if ExtrTest in fExtrOptions then
            fTest := True
        else
            fTest := False;

        { allocate room for null terminated string }
        pZipFN := StrAlloc(Length(NameOfZipFile) + 1);
        StrPLCopy(pZipFN, NameOfZipFile, Length(NameOfZipFile) + 1); { name of zip file }

        UnZipParms.fPwdReqCount := FPasswordReqCount;
        // We have to be carefull doing an unattended Extract when a password is needed
        // for some file in the archive. We set it to an unlikely password, this way
        // encrypted files won't be extracted.
  // From verion 1.60 and up the event OnPasswordError is called in this case.

        pZipPassword := StrAlloc(Length(FPassword) + 1); // Allocate room for null terminated string.
        StrPLCopy(pZipPassword, FPassword, Length(FPassword) + 1); // Password for encryption/decryption.
    end;                                { end with }
end;

function TZipMaster.GetAddPassword: string;
var
    p1, p2: string;
begin
    p2 := '';
    if FUnattended then
        ShowZipMessage(PW_UnatAddPWMiss, '')
    else
    begin
        if (GetPassword(LoadZipStr(PW_Caption, RESOURCE_ERROR), LoadStr(PW_MessageEnter), [pwbCancel], p1) = pwbOk) and (p1 <> '') then
        begin
            if (GetPassword(LoadZipStr(PW_Caption, RESOURCE_ERROR), LoadStr(PW_MessageConfirm), [pwbCancel], p2) = pwbOk) and (p2 <> '') then
            begin
                if AnsiCompareStr(p1, p2) <> 0 then
                begin
                    ShowZipMessage(GE_WrongPassword, '');
                    p2 := '';
                end
                else
                    if GAssignPassword then
                        FPassword := p2;
            end;
        end;
    end;
    Result := p2;
end;

// Same as GetAddPassword, but does NOT verify

function TZipMaster.GetExtrPassword: string;
var
    p1: string;
begin
    p1 := '';
    if FUnattended then
        ShowZipMessage(PW_UnatExtPWMiss, '')
    else
        if (GetPassword(LoadZipStr(PW_Caption, RESOURCE_ERROR), LoadStr(PW_MessageEnter), [pwbCancel, pwbCancelAll], p1) = pwbOk) and (p1 <> '') then
            if GAssignPassword then
                FPassword := p1;
    Result := p1;
end;

function TZipMaster.GetPassword(DialogCaption, MsgTxt: string; pwb: TPasswordButtons; var ResultStr: string): TPasswordButton;
var
    Pdlg: TPasswordDlg;
begin
    Pdlg := TPasswordDlg.CreateNew2(Self, pwb);
    ResultStr := Pdlg.ShowModalPwdDlg(DialogCaption, MsgTxt);
    GModalResult := Pdlg.ModalResult;
    Pdlg.Free;
    case GModalResult of
        mrOk: Result := pwbOk;
        mrCancel: Result := pwbCancel;
        mrNoToAll: Result := pwbCancelAll;
    else
        Result := pwbAbort;
    end;
end;

procedure TZipMaster.Add;
begin
    ExtAdd(0, 0, 0, nil);
end;

//---------------------------------------------------------------------------
// FileAttr are set to 0 as default.
// FileAttr can be one or a logical combination of the following types:
// FILE_ATTRIBUTE_ARCHIVE, FILE_ATTRIBUTE_HIDDEN, FILE_ATTRIBUTE_READONLY, FILE_ATTRIBUTE_SYSTEM.
// FileName is as default an empty string.
// FileDate is default the system date.

// EWE: I think 'Filename' is the name you want to use in the zip file to
// store the contents of the stream under.

procedure TZipMaster.AddStreamToFile(Filename: string; FileDate, FileAttr: DWORD);
var
    st: TSystemTime;
    ft: TFileTime;
    FatDate, FatTime: Word;
begin
    TraceMessage('AddStreamToFile, fname=' + Filename); //  qqq
    if Length(Filename) > 0 then
    begin
        FFSpecArgs.Clear();
        FFSpecArgs.Append(FileName);
    end;
    if FileDate = 0 then
    begin
        GetLocalTime(st);
        SystemTimeToFileTime(st, ft);
        FileTimeToDosDateTime(ft, FatDate, FatTime);
        FileDate := (DWORD(FatDate) shl 16) + FatTime;
    end;
    // Check if wildcards are set.
    if FFSpecArgs.Count > 0 then
    begin
        if (AnsiPos(FFSpecArgs.Strings[0], '*') > 0) or (AnsiPos(FFSpecArgs.Strings[0], '?') > 0) then
            ShowZipMessage(AD_InvalidName, '')
        else
            ExtAdd(1, FileDate, FileAttr, nil);
    end
    else
        ShowZipMessage(AD_NothingToZip, '');
end;

//---------------------------------------------------------------------------

function TZipMaster.AddStreamToStream(InStream: TMemoryStream): TZipStream;
begin
    if InStream = FZipStream then
    begin
        ShowZipMessage(AD_InIsOutStream, '');
        Result := nil;
        Exit;
    end;
    if InStream.Size > 0 then
    begin
        FZipStream.SetSize(InStream.Size + 6);
        // Call the extended Add procedure:
        ExtAdd(2, 0, 0, InStream);
        // The size of the output stream is reset by the dll in ZipParms2 in fOutStreamSize.
        // Also the size is 6 bytes more than the actual output size because:
        // - the first two bytes are used as flag, STORED=0 or DEFLATED=8.
        // - the next four bytes are set to the calculated CRC value.
  // The size is reset from Inputsize +6 to the actual data size +6.
        // (you do not have to set the size yourself, in fact it won't be taken into account.
        // The start of the stream is set to the actual data start.
        if FSuccessCnt = 1 then
            FZipStream.Position := 6
        else
            FZipStream.SetSize(0);
    end
    else
        ShowZipMessage(AD_NothingToZip, '');
    Result := FZipStream;
end;

//---------------------------------------------------------------------------
// UseStream = 0 ==> Add file to zip archive file.
// UseStream = 1 ==> Add stream to zip archive file.
// UseStream = 2 ==> Add stream to another (zipped) stream.

procedure TZipMaster.ExtAdd(UseStream: Integer; StrFileDate, StrFileAttr: DWORD; MemStream: TMemoryStream);
var
    i, DLLVers: Integer;
    {$IFNDEF NO_SPAN}
    drt: Integer;
    {$ENDIF}
    {$IFNDEF NO_SFX}
    SFXResult: Integer;
    {$ENDIF}
    AutoLoad: Boolean;
    TmpZipName: string;
    pFDS: pFileData;
    pExFiles: pExcludedFileSpec;
    len, b, p, RootLen: Integer;
    rdir: string;
begin
    FSuccessCnt := 0;
    if (UseStream = 0) and (fFSpecArgs.Count = 0) then
    begin
        ShowZipMessage(AD_NothingToZip, '');
        Exit;
    end;
    {$IFDEF NO_SPAN}
    if (AddDiskSpanErase in FAddOptions) or (AddDiskSpan in FAddOptions) then
    begin
        ShowZipMessage(DS_NODISKSPAN, '');
        Exit;
    end;
    {$ENDIF}
    { We must allow a zipfile to be specified that doesn't already exist,
         so don't check here for existance. }
    if (UseStream < 2) and (FZipFileName = '') then { make sure we have a zip filename }
    begin
        ShowZipMessage(GE_NoZipSpecified, '');
        Exit;
    end;
    // We can not do an Unattended Add if we don't have a password.
    if FUnattended and (AddEncrypt in FAddOptions) and (FPassword = '') then
    begin
        ShowZipMessage(AD_UnattPassword, '');
        Exit
    end;

    // If we are using disk spanning, first create a temporary file
    if (UseStream < 2) and (AddDiskSpan in FAddOptions) or (AddDiskSpanErase in FAddOptions) then
    begin
        {$IFDEF NO_SPAN}
        ShowZipMessage(DS_NoDiskSpan, '');
        exit;
        {$ELSE}
        // We can't do this type of Add() on a spanned archive.
        if (AddFreshen in FAddOptions) or (AddUpdate in FAddOptions) then
        begin
            ShowZipMessage(AD_NoFreshenUpdate, '');
            Exit;
        end;
        // We can't make a spanned SFX archive
        if (UpperCase(ExtractFileExt(FZipFileName)) = '.EXE') then
        begin
            ShowZipMessage(DS_NoSFXSpan, '');
            Exit;
        end;
        TmpZipName := MakeTempFileName('', '');

        if FVerbose and Assigned(FOnMessage) then
            FOnMessage(Self, 0, 'Temporary zipfile: ' + TmpZipName);
        {$ENDIF}
    end
    else
        TmpZipName := FZipFileName;     // not spanned - create the outfile directly

    { Make sure we can't get back in here while work is going on }
    if fZipBusy then
        Exit;

    if (UseStream < 2) and (Uppercase(ExtractFileExt(FZipFileName)) = '.EXE')
        and (FSFXOffset = 0) and not FileExists(FZipFileName) then
    begin
        {$IFDEF NO_SFX}
        ShowZipMessage(SF_NOSFXSUPPORT, '');
        exit;
        {$ELSE}
        try
            { This is the first "add" operation following creation of a new
              .EXE archive.  We need to add the SFX code now, before we add
              the files. }
            AutoExeViaAdd := True;
            SFXResult := ConvertSFX;
            AutoExeViaAdd := False;
            if SFXResult <> 0 then
                raise EZipMaster.CreateResDisk(AD_AutoSFXWrong, SFXResult);
        except
            on ews: EZipMaster do       // All SFX creation errors will be caught and returned in this one message.
            begin
                ShowExceptionError(ews);
                Exit;
            end;
        end;
        {$ENDIF}
    end;

    DLLVers := Load_ZipDll(AutoLoad);
    if DLLVers = 0 then
        exit;                           // could not load valid dll

    fZipBusy := True;
    Cancel := False;

    try
        try
            ZipParms := AllocMem(SizeOf(ZipParms2));
            SetZipSwitches(TmpZipName, DLLVers);

            with ZipParms^ do
            begin
                if UseStream = 1 then
                begin
                    fUseInStream := True;
                    fInStream := FZipStream.Memory;
                    fInStreamSize := FZipStream.Size;
                    fStrFileAttr := StrFileAttr;
                    fStrFileDate := StrFileDate;
                end;
                if UseStream = 2 then
                begin
                    fUseOutStream := True;
                    fOutStream := FZipStream.Memory;
                    fOutStreamSize := MemStream.Size + 6;
                    fUseInStream := True;
                    fInStream := MemStream.Memory;
                    fInStreamSize := MemStream.Size;
                end;
                fFDS := AllocMem(SizeOf(FileData) * FFSpecArgs.Count);
                for i := 0 to (fFSpecArgs.Count - 1) do
                begin
                    len := Length(FFSpecArgs.Strings[i]);
                    p := 1;
                    pFDS := fFDS;
                    Inc(pFDS, i);

                    // Added to version 1.60L to support recursion and encryption on a FFileSpec basis.
                    // Regardless of what AddRecurseDirs is set to, a '>' will force recursion, and a '|' will stop recursion.
                    pFDS.fRecurse := Word(fRecurse); // Set default
                    if Copy(FFSpecArgs.Strings[i], 1, 1) = '>' then
                    begin
                        pFDS.fRecurse := $FFFF;
                        Inc(p);
                    end;
                    if Copy(FFSpecArgs.Strings[i], 1, 1) = '|' then
                    begin
                        pFDS.fRecurse := 0;
                        Inc(p);
                    end;

                    // Also it is possible to specify a password after the FFileSpec, separated by a '<'
                    // If there is no other text after the '<' then, an existing password, is temporarily canceled.
                    pFDS.fEncrypt := LongWord(fEncrypt); // Set default
                    if Length(pZipPassword) > 0 then // v1.60L
                    begin
                        pFDS.fPassword := StrAlloc(Length(pZipPassword) + 1);
                        StrLCopy(pFDS.fPassword, pZipPassword, Length(pZipPassword));
                    end;
                    b := AnsiPos('<', FFSpecArgs.Strings[i]);
                    if b <> 0 then
                    begin               // Found...
                        pFDS.fEncrypt := $FFFF; // the new default, but...
                        StrDispose(pFDS.fPassword);
                        pFDS.fPassword := nil;
                        if Copy(FFSpecArgs.Strings[i], b + 1, 1) = '' then
                            pFDS.fEncrypt := 0 // No password, so cancel for this FFspecArg
                        else
                        begin
                            pFDS.fPassword := StrAlloc(len - b + 1);
                            StrPLCopy(pFDS.fPassword, Copy(FFSpecArgs.Strings[i], b + 1, len - b), len - b + 1);
                            len := b - 1;
                        end;
                    end;

                    // And to set the RootDir, possibly later with override per FSpecArg v1.70
                    if RootDir <> '' then
                    begin
                        rdir := ExpandFileName(fRootDir); // allow relative root
                        RootLen := Length(rdir);
                        pFDS.fRootDir := StrAlloc(RootLen + 1);
                        StrPLCopy(pFDS.fRootDir, rdir, RootLen + 1);
                    end;
                    pFDS.fFileSpec := StrAlloc(len - p + 2);
                    StrPLCopy(pFDS.fFileSpec, Copy(FFSpecArgs.Strings[i], p, len - p + 1), len - p + 2);
                end;
                fSeven := 7;
            end;                        { end with }

            ZipParms.argc := fSpecArgs.Count;
            { pass in a ptr to parms }
            fSuccessCnt := ZipDLLExec(ZipParms);
            // If Add was successful and we want spanning, copy the
            // temporary file to the destination.
            if (UseStream < 2) and (fSuccessCnt > 0) and
                ((AddDiskSpan in FAddOptions) or (AddDiskSpanErase in FAddOptions)) then
                {$IFDEF NO_SPAN}
                raise EZipMaster.CreateResDisp(DS_NODISKSPAN, true);
            {$ELSE}
            begin
                // write the temp zipfile to the right target:
                if WriteSpan(TmpZipName, FZipFileName) = 0 then
                begin                   // Change the zipfilename when needed 1.52N, 1.60N
                    drt := GetDriveType(pChar(FDrive));
                    if (drt = DRIVE_FIXED) or (drt = DRIVE_REMOTE) then
                        FZipFilename := Copy(FZipFileName, 1, Length(FZipFileName) - Length(ExtractFileExt(FZipFileName))) +
                            Copy(IntToStr(1001 + FDiskNr), 2, 3) + ExtractFileExt(FZipFileName);
                end
                else
                    fSuccessCnt := 0;   // error occurred during write span
                DeleteFile(TmpZipName);
            end;
            {$ENDIF}
            if (UseStream = 2) and (FSuccessCnt = 1) then
                FZipStream.SetSize(ZipParms.fOutStreamSize);
        except
            ShowZipMessage(GE_FatalZip, '');
        end;
    finally
        fFSpecArgs.Clear;
        fFSpecArgsExcl.Clear;
        with ZipParms^ do
        begin
            { Free the memory for the zipfilename and parameters }
            { we know we had a filename, so we'll dispose it's space }
            StrDispose(pZipFN);
            StrDispose(pZipPassword);
            StrDispose(pSuffix);
            pZipPassword := nil;        // v1.60L

            StrDispose(fTempPath);
            StrDispose(fArchComment);
            for i := (Argc - 1) downto 0 do
            begin
                pFDS := fFDS;
                Inc(pFDS, i);
                StrDispose(pFDS.fFileSpec);
                StrDispose(pFDS.fPassword); // v1.60L
                StrDispose(pFDS.fRootDir); // v1.60L
            end;
            FreeMem(fFDS);
            for i := (fTotExFileSpecs - 1) downto 0 do
            begin
                pExFiles := fExFiles;
                Inc(pExFiles, i);
                StrDispose(pExFiles.fFileSpec);
            end;
            FreeMem(fExFiles);
        end;
        FreeMem(ZipParms);
        ZipParms := nil;
    end;                                {end try finally }

    if AutoLoad then
        Unload_Zip_Dll;

    Cancel := False;
    fZipBusy := False;
    if fSuccessCnt > 0 then
        List();                         { Update the Zip Directory by calling List method }
end;

procedure TZipMaster.Delete;
var
    i, DLLVers: Integer;
    AutoLoad: Boolean;
    pFDS: pFileData;
    EOC: ZipEndOfCentral;
    pExFiles: pExcludedFileSpec;
begin
    FSuccessCnt := 0;
    if fFSpecArgs.Count = 0 then
    begin
        ShowZipMessage(DL_NothingToDel, '');
        Exit;
    end;
    if not FileExists(FZipFileName) then
    begin
        ShowZipMessage(GE_NoZipSpecified, '');
        Exit;
    end;
    // new 1.7 - stop delete from spanned
    CheckIfLastDisk(EOC, true);
    FileClose(fInFileHandle);           // only needed to test it
    if (IsSpanned) then
        raise EZipMaster.CreateResDisp(DL_NoDelOnSpan, true);

    { Make sure we can't get back in here while work is going on }
    if fZipBusy then
        Exit;
    fZipBusy := True;                   { delete uses the ZIPDLL, so it shares the FZipBusy flag }
    Cancel := False;

    if ZipDllHandle = 0 then
    begin
        AutoLoad := True;               // user's program didn't load the DLL
        Load_Zip_Dll;                   // load it
    end
    else
        AutoLoad := False;              // user's pgm did load the DLL, so let him unload it
    if ZipDllHandle = 0 then
    begin
        fZipBusy := False;
        Exit;                           // load failed - error msg was shown to user
    end;

    DLLVers := ZipVers;
    if DLLVers < 170 then
    begin
        ShowZipMessage(LZ_OldZipDll, GetZipDllPath(ZipDllHandle));
        exit;
    end;
    try
        try
            ZipParms := AllocMem(SizeOf(ZipParms2));
            SetZipSwitches(fZipFileName, DLLVers);
            SetDeleteSwitches;

            with ZipParms^ do
            begin
                fFDS := AllocMem(SizeOf(FileData) * FFSpecArgs.Count);
                for i := 0 to (fFSpecArgs.Count - 1) do
                begin
                    pFDS := fFDS;
                    Inc(pFDS, i);
                    pFDS.fFileSpec := StrAlloc(Length(fFSpecArgs[i]) + 1);
                    StrPLCopy(pFDS.fFileSpec, fFSpecArgs[i], Length(fFSpecArgs[i]) + 1);
                end;
                Argc := fSpecArgs.Count;
                fSeven := 7;
            end;                        { end with }
            { pass in a ptr to parms }
            fSuccessCnt := ZipDLLExec(ZipParms);
        except
            ShowZipMessage(GE_FatalZip, '');
        end;
    finally
        fFSpecArgs.Clear;
        fFSpecArgsExcl.Clear;

        with ZipParms^ do
        begin
            StrDispose(pZipFN);
            StrDispose(pZipPassword);
            StrDispose(pSuffix);
            StrDispose(fTempPath);
            StrDispose(fArchComment);
            for i := (Argc - 1) downto 0 do
            begin
                pFDS := fFDS;
                Inc(pFDS, i);
                StrDispose(pFDS.fFileSpec);
            end;
            FreeMem(fFDS);
            for i := (fTotExFileSpecs - 1) downto 0 do
            begin
                pExFiles := fExFiles;
                Inc(pExFiles, i);
                StrDispose(pExFiles.fFileSpec);
            end;
            FreeMem(fExFiles);
        end;
        FreeMem(ZipParms);
        ZipParms := nil;
    end;

    if AutoLoad then
        Unload_Zip_Dll;
    fZipBusy := False;
    Cancel := False;
    if fSuccessCnt > 0 then
        List;                           { Update the Zip Directory by calling List method }
end;

constructor TZipStream.Create;
begin
    inherited Create;
    Clear();
end;

destructor TZipStream.Destroy;
begin
    inherited Destroy;
end;

procedure TZipStream.SetPointer(Ptr: Pointer; Size: Integer);
begin
    inherited SetPointer(Ptr, Size);
end;

function TZipMaster.ExtractFileToStream(FileName: string): TZipStream;
begin
    // Use FileName if set, if not expect the filename in the FFSpecArgs.
    if FileName <> '' then
    begin
        FFSpecArgs.Clear();
        FFSpecArgs.Add(FileName);
    end;
    FZipStream.Clear();
    ExtExtract(1, nil);
    if FSuccessCnt <> 1 then
        Result := nil
    else
        Result := FZipStream;
end;

function TZipMaster.ExtractStreamToStream(InStream: TMemoryStream; OutSize: Longword): TZipStream;
begin
    if InStream = FZipStream then
    begin
        ShowZipMessage(AD_InIsOutStream, '');
        Result := nil;
        Exit;
    end;
    FZipStream.Clear();
    FZipStream.SetSize(OutSize);
    ExtExtract(2, InStream);
    if FSuccessCnt <> 1 then
        Result := nil
    else
        Result := FZipStream;
end;

procedure TZipMaster.Extract();
begin
    ExtExtract(0, nil);
end;

// UseStream = 0 ==> Extract file from zip archive file.
// UseStream = 1 ==> Extract stream from zip archive file.
// UseStream = 2 ==> Extract (zipped) stream from another stream.

procedure TZipMaster.ExtExtract(UseStream: Integer; MemStream: TMemoryStream);
var
    i, UnzDLLVers: Integer;
    OldPRC: Integer;
    AutoLoad: Boolean;
    TmpZipName: string;
    pUFDS: pUnzFileData;
    {$IFNDEF NO_SPAN}
    NewName: array[0..512] of Char;
    {$ENDIF}
begin
    FSuccessCnt := 0;
    OldPRC := FPasswordReqCount;

    if (UseStream < 2) and (not FileExists(FZipFileName)) then
    begin
        ShowZipMessage(GE_NoZipSpecified, '');
        Exit;
    end;

    { Make sure we can't get back in here while work is going on }
    if fUnzBusy then
        Exit;

    // We have to be carefull doing an unattended Extract when a password is needed
    // for some file in the archive.
    if FUnattended and (FPassword = '') and not Assigned(FOnPasswordError) then
    begin
        FPasswordReqCount := 0;
        ShowZipMessage(EX_UnAttPassword, '');
    end;

    Cancel := False;
    fUnzBusy := True;

    // We do a check if we need UnSpanning first, this depends on
    // The number of the disk the EOC record was found on. ( provided by List() )
    // If we have a spanned set consisting of only one disk we don't use ReadSpan().
    if FTotalDisks <> 0 then
    begin
        {$IFDEF NO_SPAN}
        fUnzBusy := False;
        ShowZipMessage(DS_NODISKSPAN, '');
        exit;
        {$ELSE}
        if FTempDir = '' then
        begin
            GetTempPath(MAX_PATH, NewName);
            TmpZipName := NewName;
        end
        else
            TmpZipName := AppendSlash(FTempDir);
        if ReadSpan(FZipFileName, TmpZipName) <> 0 then
        begin
            fUnzBusy := False;
            {            if AutoLoad then
                Unload_Unz_Dll(); }
            Exit;
        end;
        // We returned without an error, now  TmpZipName contains a real name.
        {$ENDIF}
    end
    else
        TmpZipName := FZipFileName;

    UnzDLLVers := Load_UnzDll(AutoLoad);
    if UnzDllVers = 0 then
    begin
        FUnzBusy := false;
        exit;                           // could not load valid DLL
    end;
    //    UnzDLLVers := UnzVers;
    try
        try
            UnZipParms := AllocMem(SizeOf(UnZipParms2));
            SetUnZipSwitches(TmpZipName, UnzDLLVers);

            with UnzipParms^ do
            begin
                if ExtrBaseDir <> '' then
                begin
                    fExtractDir := StrAlloc(Length(fExtrBaseDir) + 1);
                    StrPLCopy(fExtractDir, fExtrBaseDir, Length(fExtrBaseDir));
                end
                else
                    fExtractDir := nil;

                fUFDS := AllocMem(SizeOf(UnzFileData) * FFSpecArgs.Count);
                for i := 0 to (fFSpecArgs.Count - 1) do
                begin
                    pUFDS := fUFDS;
                    Inc(pUFDS, i);
                    pUFDS.fFileSpec := StrAlloc(Length(fFSpecArgs[i]) + 1);
                    StrPLCopy(pUFDS.fFileSpec, fFSpecArgs[i], Length(fFSpecArgs[i]) + 1);
                end;
                fArgc := FFSpecArgs.Count;
                if UseStream = 1 then
                begin
                    for i := 0 to Count - 1 do { Find the wanted file in the ZipDirEntry list. }
                    begin
                        with ZipDirEntry(ZipContents[i]^) do
                        begin
                            if AnsiStrIComp(pChar(FFSpecArgs.Strings[0]), pChar(FileName)) = 0 then { Found? }
                            begin
                                FZipStream.SetSize(UncompressedSize);
                                fUseOutStream := True;
                                fOutStream := FZipStream.Memory;
                                fOutStreamSize := UncompressedSize;
                                fArgc := 1;
                                Break;
                            end;
                        end;
                    end;
                end;
                if UseStream = 2 then
                begin
                    fUseInStream := True;
                    fInStream := MemStream.Memory;
                    fInStreamSize := MemStream.Size;
                    fUseOutStream := True;
                    fOutStream := FZipStream.Memory;
                    fOutStreamSize := FZipStream.Size;
                end;
                fSeven := 7;
            end;
            { Argc is now the no. of filespecs we want extracted }
            if (UseStream = 0) or ((UseStream > 0) and UnZipParms {.up2}.fUseOutStream) then
                fSuccessCnt := UnzDLLExec(Pointer(UnZipParms {.up1}));
            { Remove from memory if stream is not Ok. }
            if (UseStream > 0) and (FSuccessCnt <> 1) then
                FZipStream.Clear();
            { If UnSpanned we still have this temporary file hanging around. }
            if FTotalDisks > 0 then
                DeleteFile(TmpZipName);
        except
            ShowZipMessage(EX_FatalUnZip, '');
        end;
    finally
        fFSpecArgs.Clear;
        with UnZipParms^ do
        begin
            StrDispose(pZipFN);
            StrDispose(pZipPassword);
            if (fExtractDir <> nil) then
                StrDispose(fExtractDir);

            for i := (fArgc - 1) downto 0 do
            begin
                pUFDS := fUFDS;
                Inc(pUFDS, i);
                StrDispose(pUFDS.fFileSpec);
            end;
            FreeMem(fUFDS);
        end;
        FreeMem(UnZipParms);

        UnZipParms := nil;
    end;

    if FUnattended and (FPassword = '') and not Assigned(FOnPasswordError) then
        FPasswordReqCount := OldPRC;

    if AutoLoad then
        Unload_Unz_Dll;
    Cancel := False;
    fUnzBusy := False;
    { no need to call the List method; contents unchanged }
end;

//---------------------------------------------------------------------------
// Returns 0 if good copy, or a negative error code.

function TZipMaster.CopyFile(const InFileName, OutFileName: string): Integer;
const
    SE_CreateError = -1;                { Error in open or creation of OutFile. }
    SE_OpenReadError = -3;              { Error in open or Seek of InFile.      }
    SE_SetDateError = -4;               { Error setting date/time of OutFile.   }
    SE_GeneralError = -9;
var
    InFile, OutFile, InSize, OutSize: Integer;
begin
    InSize := -1;
    OutSize := -1;
    Result := SE_OpenReadError;
    FShowProgress := False;

    if not FileExists(InFileName) then
        Exit;
    StartWaitCursor;
    InFile := FileOpen(InFileName, fmOpenRead or fmShareDenyWrite);
    if InFile <> -1 then
    begin
        if FileExists(OutFileName) then
            EraseFile(OutFileName, FHowToDelete);
        OutFile := FileCreate(OutFileName);
        if OutFile <> -1 then
        begin
            Result := CopyBuffer(InFile, OutFile, -1);
            if (Result = 0) and (FileSetDate(OutFile, FileGetDate(InFile)) <> 0) then
                Result := SE_SetDateError;
            OutSize := FileSeek(OutFile, 0, 2);
            FileClose(OutFile);
        end
        else
            Result := SE_CreateError;
        InSize := FileSeek(InFile, 0, 2);
        FileClose(InFile);
    end;
    // An extra check if the filesizes are the same.
    if (Result = 0) and ((InSize = -1) or (OutSize = -1) or (InSize <> OutSize)) then
        Result := SE_GeneralError;
    // Don't leave a corrupted outfile lying around. (SetDateError is not fatal!)
    if (Result <> 0) and (Result <> SE_SetDateError) then
        DeleteFile(OutFileName);

    StopWaitCursor;
end;

{ Delete a file and put it in the recyclebin on demand. }

function TZipMaster.EraseFile(const Fname: string; How: DeleteOpts): Integer;
var
    SHF: TSHFileOpStruct;
    DelFileName: string;
begin
    // If we do not have a full path then FOF_ALLOWUNDO does not work!?
    DelFileName := Fname;
    if ExtractFilePath(Fname) = '' then
        DelFileName := GetCurrentDir() + '\' + Fname;

    Result := -1;
    // We need to be able to 'Delete' without getting an error
    // if the file does not exists as in ReadSpan() can occur.
    if not FileExists(DelFileName) then
        Exit;
    with SHF do
    begin
        Wnd := Application.Handle;
        wFunc := FO_DELETE;
        pFrom := pChar(DelFileName + #0);
        pTo := nil;
        fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
        if How = htdAllowUndo then
            fFlags := fFlags or FOF_ALLOWUNDO;
    end;
    Result := SHFileOperation(SHF);
end;

// Make a temporary filename like: C:\...\zipxxxx.zip
// Prefix and extension are default: 'zip' and '.zip'

function TZipMaster.MakeTempFileName(Prefix, Extension: string): string;
var
    Buffer: pChar;
    len: DWORD;
begin
    Buffer := nil;
    if Prefix = '' then
        Prefix := 'zip';
    if Extension = '' then
        Extension := '.zip';
    try
        if Length(FTempDir) = 0 then    // Get the system temp dir
        begin
            // 1.	The path specified by the TMP environment variable.
            //	2.	The path specified by the TEMP environment variable, if TMP is not defined.
            //	3.	The current directory, if both TMP and TEMP are not defined.
            len := GetTempPath(0, Buffer);
            GetMem(Buffer, len + 12);
            GetTempPath(len, Buffer);
        end
        else                            // Use Temp dir provided by ZipMaster
        begin
            FTempDir := AppendSlash(FTempDir);
            GetMem(Buffer, Length(FTempDir) + 13);
            StrPLCopy(Buffer, FTempDir, Length(FTempDir) + 1);
        end;
        if GetTempFileName(Buffer, pChar(Prefix), 0, Buffer) <> 0 then
        begin
            DeleteFile(Buffer);         // Needed because GetTempFileName creates the file also.
            Result := ChangeFileExt(Buffer, Extension); // And finally change the extension.
        end;
    finally
        FreeMem(Buffer);
    end;
end;

function TZipMaster.CopyBuffer(InFile, OutFile, ReadLen: Integer): Integer;
const
    SE_CopyError = -2;                  // Write error or no memory during copy.
var
    SizeR, ToRead: Integer;
    Buffer: pBuffer;
begin
    // both files are already open
    Result := 0;
    ToRead := BufSize;
    Buffer := nil;
    try
        New(Buffer);
        repeat
            if ReadLen >= 0 then
            begin
                ToRead := ReadLen;
                if BufSize < ReadLen then
                    ToRead := BufSize;
            end;
            SizeR := FileRead(InFile, Buffer^, ToRead);
            if FileWrite(OutFile, Buffer^, SizeR) <> SizeR then
            begin
                Result := SE_CopyError;
                Break;
            end;
            if Assigned(FOnProgress) and FShowProgress then
                FOnProgress(Self, ProgressUpdate, '', SizeR);
            if ReadLen > 0 then
                Dec(ReadLen, SizeR);
            Application.ProcessMessages; // Mostly for winsock.
        until ((ReadLen = 0) or (SizeR <> ToRead));
    except
        Result := SE_CopyError;
    end;
    if Buffer <> nil then
        Dispose(Buffer);
    // leave both files open
end;

//---------------------------------------------------------------------------
// Function to find the EOC record at the end of the archive (on the last disk.)
// We can get a return value( true::Found, false::Not Found ) or an exception if not found.

function TZipMaster.CheckIfLastDisk(var EOC: ZipEndOfCentral; DoExcept: boolean): boolean;
var
    Sig: Cardinal;
    DiskNo, Size, i, j: Integer;
    ShowGarbageMsg: Boolean;
    First: Boolean;
    ZipBuf: pChar;
begin
    FZipComment := '';
    First := False;
    DiskNo := 0;
    ZipBuf := nil;
    FZipEOC := 0;

    // Open the input archive, presumably the last disk.
    FInFileHandle := FileOpen(FInFileName, fmShareDenyWrite or fmOpenRead);
    if FInFileHandle = -1 then
    begin
        if DoExcept = True then
            raise EZipMaster.CreateResDisp(DS_NoInFile, True);
        ShowZipMessage(DS_FileOpen, '');
        Result := False;
        Exit;
    end;

    // Get the volume number if it's disk from a set.
    if Pos('PKBACK# ', FVolumeName) = 1 then
        DiskNo := StrToIntDef(Copy(FVolumeName, 9, 3), 0);

    // First a check for the first disk of a spanned archive,
    // could also be the last so we don't issue a warning yet.
    if (FileRead(FInFileHandle, Sig, 4) = 4) and (Sig = ExtLocalSig) and
        (FileRead(FInFileHandle, Sig, 4) = 4) and (Sig = LocalFileHeaderSig) then
    begin
        First := True;
        FIsSpanned := True;
    end;

    // Next we do a check at the end of the file to speed things up if
    // there isn't a Zip archive comment.
    FFileSize := FileSeek(FInFileHandle, -SizeOf(EOC), 2);
    if FFileSize <> -1 then
    begin
        Inc(FFileSize, SizeOf(EOC));    // Save the archive size as a side effect.
        FRealFileSize := FFileSize;     // There could follow a correction on FFileSize.
        if (FileRead(FInFileHandle, EOC, SizeOf(EOC)) = SizeOf(EOC)) and
            (EOC.HeaderSig = EndCentralDirSig) then
        begin
            FZipEOC := FFileSize - SizeOf(EOC);
            Result := True;
            Exit;
        end;
    end;

    // Now we try to find the EOC record within the last 65535 + sizeof( EOC ) bytes
    // of this file because we don't know the Zip archive comment length at this time.
    try
        Size := 65535 + SizeOf(EOC);
        if FFileSize < Size then
            Size := FFileSize;
        GetMem(ZipBuf, Size + 1);
        if FileSeek(FInFileHandle, -Size, 2) = -1 then
            raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
        if not (FileRead(FInFileHandle, ZipBuf^, Size) = Size) then
            raise EZipMaster.CreateResDisp(DS_EOCBadRead, True);
        for i := Size - SizeOf(EOC) - 1 downto 0 do
            if (ZipBuf[i] = 'P') and (ZipBuf[i + 1] = 'K') and (ZipBuf[i + 2] = #$05) and (ZipBuf[i + 3] = #$06) then
            begin
                FZipEOC := FFileSize - Size + i;
                Move(ZipBuf[i], EOC, SizeOf(EOC)); // Copy from our buffer to the EOC record.
                // Check if we really are at the end of the file, if not correct the filesize
    // and give a warning. (It should be an error but we are nice.)
                if not (i + SizeOf(EOC) + EOC.ZipCommentLen - Size = 0) then
                begin
                    Inc(FFileSize, i + SizeOf(EOC) + Integer(EOC.ZipCommentLen) - Size);
                    // Now we need a check for WinZip Self Extractor which makes SFX files which
                    // allmost always have garbage at the end (Zero filled at 512 byte boundary!)
                    // In this special case 'we' don't give a warning.
                    ShowGarbageMsg := True;
                    if (FRealFileSize - Cardinal(FFileSize) < 512) and ((FRealFileSize mod 512) = 0) then
                    begin
                        j := i + SizeOf(EOC) + EOC.ZipCommentLen;
                        while (ZipBuf[j] = #0) and (j <= Size) do
                            Inc(j);
                        if j = Size + 1 then
                            ShowGarbageMsg := False;
                    end;
                    if ShowGarbageMsg then
                        ShowZipMessage(LI_GarbageAtEOF, '');
                end;
                // If we have ZipComment: Save it, must be after Garbage check because a #0 is set!
                if not (EOC.ZipCommentLen = 0) then
                begin
                    ZipBuf[i + SizeOf(EOC) + EOC.ZipCommentLen] := #0;
                    FZipComment := ZipBuf + i + SizeOf(EOC); // No codepage translation yet, wait for CEH read.
                end;
                FreeMem(ZipBuf);
                Result := True;
                Exit;
            end;
        FreeMem(ZipBuf);
    except
        FreeMem(ZipBuf);
        if DoExcept = True then
            raise;
    end;
    if DoExcept = True then
    begin
        if (First = False) and (DiskNo <> 0) then
            raise EZipMaster.CreateResDisk(DS_NotLastInSet, DiskNo);
        if First = True then
            if DiskNo = 1 then
                raise EZipMaster.CreateResDisp(DS_FirstInSet, True)
            else
                raise EZipMaster.CreateResDisp(DS_FirstFileOnHD, True)
        else
            raise EZipMaster.CreateResDisp(DS_NoValidZip, True);
    end;
    Result := False;
end;

// concat path

function PathConcat(path, extra: string): string;
var
    pathLst: char; pathLen: integer;
begin
    pathLen := Length(path);
    Result := path;
    if pathLen > 0 then
    begin
        pathLst := path[pathLen];
        if (pathLst <> ':') and (Length(extra) > 0) then
        begin
            if (extra[1] = '\') = (pathLst = '\') then
            begin
                if pathLst = '\' then
                    Result := Copy(path, 1, pathLen - 1) // remove trailing
                else
                    Result := path + '\'; // append trailing
            end;
        end;
    end;
    Result := Result + extra;
end;

// returns version - checks valid

function TZipMaster.Load_ZipDll(var autoload: boolean): integer; // New 1.70
begin
    autoload := false;
    if ZipDllHandle = 0 then
    begin
        Result := Load_Zip_Dll;
        autoload := Result <> 0;
    end
    else
        Result := GetZipDllVersion;
    if Result < MinZipDllVers then
    begin
        ShowZipMessage(LZ_OldZipDll, GetZipDllPath(ZipDllHandle));
        Unload_Zip_Dll;
        Result := 0;
        autoload := false;
    end
    else
        if FVerbose and Assigned(FOnMessage) then
            FOnMessage(Self, 0, 'Loaded ZipDll ver: ' + IntToStr(Result)
                + ' from ' + GetZipDllPath(ZipDllHandle));
end;

function TZipMaster.Load_Zip_Dll: integer; // CHANGED 1.70
var
    fullpath: string;
begin
    // This is new code that tries to locate the DLL before loading it.
    // The user can specify a dir in the DLLDirectory property.
    // The user's dir is our first choice, but we'll still try the
    // standard Windows DLL dirs (Windows, Windows System, Current dir).
    Result := 0;                        // dll version
    fullpath := '';
    if FDLLDirectory <> '' then
    begin
        fullpath := PathConcat(FDLLDirectory, '\ZIPDLL.DLL');
        if not FileExists(fullpath) then
        begin
            fullpath := PathConcat(ExtractFilePath(ParamStr(0)), fullpath);
            if (copy(FDLLDirectory, 1, 1) <> '.') or not FileExists(fullpath) then
                fullpath := '';
        end;
    end;
    if fullpath = '' then
        fullpath := 'ZIPDLL.DLL';       // Let Windows search the std dirs

    SetErrorMode(SEM_FAILCRITICALERRORS or SEM_NOGPFAULTERRORBOX);
    try
        ZipDllHandle := LoadLibrary(pChar(fullpath));
        if ZipDllHandle > HInstance_Error then
        begin
            if FTrace then
                ShowZipMessage(LZ_ZipDllLoaded, ' ' + GetZipDllPath(ZipDllHandle));
            @ZipDllExec := GetProcAddress(ZipDllHandle, 'ZipDllExec');
            @GetZipDllVersion := GetProcAddress(ZipDllHandle, 'GetZipDllVersion');
            if @ZipDllExec = nil then
                ShowZipMessage(LZ_NoZipDllExec, '');
            if @GetZipDllVersion = nil then
                ShowZipMessage(LZ_NoZipDllVers, '');
        end
        else
        begin
            ZipDllHandle := 0;          {reset}
            ShowZipMessage(LZ_NoZipDll, '');
        end;
    except
    end;
    SetErrorMode(0);
    if (ZipDllHandle <> 0) and (@ZipDllExec <> nil) and (@GetZipDllVersion <> nil) then
        Result := GetZipDllVersion;
    if Result = 0 then
    begin
        Unload_Zip_Dll;
        ShowZipMessage(LZ_NoZipDll, ' unloaded');
    end;
end;

function TZipMaster.Load_UnzDll(var autoload: boolean): integer; // New 1.70
begin
    autoload := false;
    if UnzDllHandle = 0 then
    begin
        Result := Load_Unz_Dll;
        autoload := Result <> 0;
    end
    else
        Result := GetUnzDllVersion;
    if Result < MinUnzDllVers then
    begin
        ShowZipMessage(LU_OldUnzDll, GetUnzDllPath(UnzDllHandle));
        Unload_Unz_Dll;
        Result := 0;
        autoload := false;
    end
    else
        if FVerbose and Assigned(FOnMessage) then
            FOnMessage(Self, 0, 'Loaded UnzDll ver: ' + IntToStr(Result)
                + ' from ' + GetUnzDllPath(UnzDllHandle));
end;

// CHANGED 1.70 - return version if loaded

function TZipMaster.Load_Unz_Dll: integer;
var
    fullpath: string;
begin
    Result := 0;
    // This is new code that tries to locate the DLL before loading it.
    // The user can specify a dir in the DLLDirectory property.
 // The user's dir is our first choice, but we'll still try the
 // standard Windows DLL dirs (Windows, Windows System, Current dir).
    fullpath := '';
    if FDLLDirectory <> '' then
    begin
        fullpath := PathConcat(FDLLDirectory, '\UNZDLL.DLL');
        if not FileExists(fullpath) then
        begin
            fullpath := PathConcat(ExtractFilePath(ParamStr(0)), fullpath);
            if (copy(FDLLDirectory, 1, 1) <> '.') or not FileExists(fullpath) then
                fullpath := '';
        end;
    end;
    if fullpath = '' then
        fullpath := 'UNZDLL.DLL';       // Let Windows search the std dirs

    SetErrorMode(SEM_FAILCRITICALERRORS or SEM_NOGPFAULTERRORBOX);
    try
        UnzDllHandle := LoadLibrary(pChar(fullpath));
        if UnzDllHandle > HInstance_Error then
        begin
            if FTrace then
                ShowZipMessage(LU_UnzDllLoaded, ' ' + GetUnzDllPath(UnzDllHandle));
            @UnzDllExec := GetProcAddress(UnzDllHandle, 'UnzDllExec');
            @GetUnzDllVersion := GetProcAddress(UnzDllHandle, 'GetUnzDllVersion');
            if @UnzDllExec = nil then
                ShowZipMessage(LU_NoUnzDllExec, '');
            if @GetUnzDllVersion = nil then
                ShowZipMessage(LU_NoUnzDllVers, '');
        end
        else
        begin
            UnzDllHandle := 0;          {reset}
            ShowZipMessage(LU_NoUnzDll, '');
        end;
    except
    end;
    SetErrorMode(0);
    if (UnzDllHandle <> 0) and (@UnzDllExec <> nil) and (@GetUnzDllVersion <> nil) then
        Result := GetUnzDllVersion;
    if Result = 0 then
    begin
        Unload_Unz_Dll;
        ShowZipMessage(LU_NoUnzDll, ' unloaded');
    end;
end;

procedure TZipMaster.Unload_Zip_Dll;
begin
    if ZipDllHandle <> 0 then
        FreeLibrary(ZipDllHandle);
    ZipDllHandle := 0;
end;

procedure TZipMaster.Unload_Unz_Dll;
begin
    if UnzDllHandle <> 0 then
        FreeLibrary(UnzDllHandle);
    UnzDllHandle := 0;
end;

function TZipMaster.GetZipDllPath(handle: cardinal): string;
var
    buf: array[0..4097] of char; AutoLoad: boolean;
begin
    AutoLoad := false;
    if handle = 0 then                  // load ZipDll
    begin
        if ZipDllHandle = 0 then
        begin
            AutoLoad := True;           // user's program didn't load the DLL
            Load_Zip_Dll;               // load it
        end;
        handle := ZipDllHandle;
    end;
    if handle <> 0 then
    begin
        if GetModuleFileName(handle, buf, 4096) <> 0 then
            Result := buf;
    end;
    if AutoLoad then
        Unload_Zip_Dll;
end;

function TZipMaster.GetUnzDllPath(handle: cardinal): string;
var
    buf: array[0..4097] of char; AutoLoad: boolean;
begin
    AutoLoad := false;
    if handle = 0 then                  // load UnzDll
    begin
        if UnzDllHandle = 0 then
        begin
            AutoLoad := True;           // user's program didn't load the DLL
            Load_Unz_Dll;               // load it
        end;
        handle := UnzDllHandle;
    end;
    if handle <> 0 then
    begin
        if GetModuleFileName(handle, buf, 4096) <> 0 then
            Result := buf;
    end;
    if AutoLoad then
        Unload_Unz_Dll;
end;

function TZipMaster.GetZipVers: Integer;
begin
    if ZipDllHandle = 0 then
    begin
        Result := Load_Zip_Dll;         // load it - get version
        Unload_Zip_Dll;
    end
    else
        Result := GetZipDLLVersion;
end;

function TZipMaster.GetUnzVers: Integer;
begin
    if UnzDllHandle = 0 then
    begin
        Result := Load_Unz_Dll;         // load it
        Unload_Unz_Dll;
    end
    else
        Result := GetUnzDLLVersion;
end;

procedure TZipMaster.AbortDlls;
var
    r: integer;
begin
    r := 0;
    if ZipBusy and (ZipDllHandle <> 0) then
        ZipDllExec(nil);
    if UnzBusy and (UnzDllHandle <> 0) then
        r := UnzDllExec(nil);
    if r <> 0 then
        application.MessageBox(pchar(IntToStr(r)), 'Abort');
end;

{ Replacement for the functions DiskFree and DiskSize. }
{ This should solve problems with drives > 2Gb and UNC filenames. }
{ Path FDrive ends with a backslash. }
{ Action=1 FreeOnDisk, 2=SizeOfDisk, 3=Both }

procedure TZipMaster.DiskFreeAndSize(Action: Integer); // RCV150199
var
    GetDiskFreeSpaceEx: function(RootName: pChar; var FreeForCaller, TotNoOfBytes: LargeInt; TotNoOfFreeBytes: pLargeInt): BOOL; stdcall;
    SectorsPCluster, BytesPSector, FreeClusters, TotalClusters: DWORD;
    LDiskFree, LSizeOfDisk: LargeInt;
    Lib: THandle;
begin
    LDiskFree := -1;
    LSizeOfDisk := -1;
    Lib := GetModuleHandle('Kernel32');
    if Lib <> 0 then
    begin
        @GetDiskFreeSpaceEx := GetProcAddress(Lib, 'GetDiskFreeSpaceExA');
        if (@GetDiskFreeSpaceEx <> nil) then // We probably have W95+OSR2 or better.
            if GetDiskFreeSpaceEx(pChar(FDrive), LDiskFree, LSizeOfDisk, nil) then
            begin
                LDiskFree := -1;
                LSizeOfDisk := -1;
            end;
        FreeLibrary(Lib);               //v1.52i
    end;
    if (LDiskFree = -1) then            // We have W95 original or W95+OSR1 or an error.
    begin                               // We use this because DiskFree/Size don't support UNC drive names.
        if GetDiskFreeSpace(pChar(FDrive), SectorsPCluster, BytesPSector, FreeClusters, TotalClusters) then
        begin
            LDiskFree := {$IFDEF VERD2D3}(1.0 * BytesPSector)
            {$ELSE}LargeInt(BytesPSector){$ENDIF}
            * SectorsPCluster * FreeClusters;
            LSizeOfDisk := {$IFDEF VERD2D3}(1.0 * BytesPSector)
            {$ELSE}LargeInt(BytesPSector){$ENDIF}
            * SectorsPCluster * TotalClusters;
        end;
    end;
    if (Action and 1) <> 0 then
        FFreeOnDisk := LDiskFree;
    if (Action and 2) <> 0 then
        FSizeOfDisk := LSizeOfDisk;
end;

// Check to see if drive in FDrive is a valid drive.
// If so, put it's volume label in FVolumeName,
//        put it's size in FSizeOfDisk,
//        put it's free space in FDiskFree,
//        and return true.
// If not valid, return false.
// Called by List() and CheckForDisk().

function TZipMaster.IsDiskPresent: Boolean;
var
    SysFlags, OldErrMode: DWord;
    NamLen: Cardinal;
    SysLen: {$IFDEF VERD2D3}Integer{$ELSE}DWord{$ENDIF};
    VolNameAry: array[0..255] of Char;
    Num: Integer;
    Bits: set of 0..25;
    DriveLetter: Char;
begin
    NamLen := 255;
    SysLen := 255;
    FSizeOfDisk := 0;
    FDiskFree := 0;
    FVolumeName := '';
    Result := False;
    DriveLetter := UpperCase(FDrive)[1];

    if DriveLetter <> '\' then          // Only for local drives
    begin
        if (DriveLetter < 'A') or (DriveLetter > 'Z') then
            raise EZipMaster.CreateResDrive(DS_NotaDrive, FDrive);

        Integer(Bits) := GetLogicalDrives();
        Num := Ord(DriveLetter) - Ord('A');
        if not (Num in Bits) then
            raise EZipMaster.CreateResDrive(DS_DriveNoMount, FDrive);
    end;

    OldErrMode := SetErrorMode(SEM_FAILCRITICALERRORS); // Turn off critical errors:

    // Since v1.52c no exception will be raised here; moved to List() itself.
    if not GetVolumeInformation(pChar(FDrive), VolNameAry, NamLen, @FDiskSerial, SysLen, SysFlags, nil, 0) then
    begin
        // W'll get this if there is a disk but it is not or wrong formatted
        // so this disk can only be used when we also want formatting.
        if (GetLastError() = 31) and (AddDiskSpanErase in FAddOptions) then
            Result := True;
        SetErrorMode(OldErrMode);       //v1.52i
        Exit;
    end;

    FVolumeName := VolNameAry;
    { get free disk space and size. }
    DiskFreeAndSize(3);                 // RCV150199

    SetErrorMode(OldErrMode);           // Restore critical errors:

    // -1 is not very likely to happen since GetVolumeInformation catches errors.
    // But on W95(+OSR1) and a UNC filename w'll get also -1, this would prevent
    // opening the file. !!!Potential error while using spanning with a UNC filename!!!
    if (DriveLetter = '\') or ((DriveLetter <> '\') and (FSizeOfDisk <> -1)) then
        Result := True;
end;

function TZipMaster.AppendSlash(sDir: string): string;
begin
    if (sDir <> '') and (sDir[Length(sDir)] <> '\') then
        Result := sDir + '\'
    else
        Result := sDir;
end;

function TZipMaster.ReplaceForwardSlash(aStr: string): string;
var
    i: Integer;
begin
    SetLength(Result, Length(aStr));
    for i := 1 to Length(aStr) do
        if aStr[i] = '/' then
            Result[i] := '\'
        else
            Result[i] := aStr[i];
end;

//---------------------------------------------------------------------------

procedure TZipMaster.WriteJoin(Buffer: pChar; BufferSize, DSErrIdent: Integer);
begin
    if FileWrite(FOutFileHandle, Buffer^, BufferSize) <> BufferSize then
        raise EZipMaster.CreateResDisp(DSErrIdent, True);

    // Give some progress info while writing.
    // While processing the central header we don't want messages.
    if Assigned(FOnProgress) and FShowProgress then
        FOnProgress(Self, ProgressUpdate, '', BufferSize);
end;

//---------------------------------------------------------------------------

// RP - changed to not use class MDZD
// Function to read a Zip archive and change one or more file specifications.
// Source and Destination should be of the same type. (path or file)
// If NewDateTime is 0 then no change is made in the date/time fields.
// Return values:
// 0            All Ok.
// -7           Rename errors. See ZipMsgXX.rc
// -8           Memory allocation error.
// -9           General unknown Rename error.
// -10          Dest should also be a filename.

function TZipMaster.Rename(RenameList: TList; DateTime: Integer): Integer;
var
    EOC: ZipEndOfCentral;
    CEH: ZipCentralHeader;
    LOH: ZipLocalHeader;
    OrigFileName: string;
    MsgStr: string;
    OutFilePath: string;
    Buffer: array[0..BufSize - 1] of Char;
    i, k, m: Integer;
    TotalBytesToRead: Integer;
    TotalBytesWrite: Integer;
    RenRec: pZipRenameRec;
    MDZD: TMZipDataList; MDZDp: pMZipData;
begin
    Result := 0;
    TotalBytesToRead := 0;
    fZipBusy := True;
    FShowProgress := False;

    FInFileName := FZipFileName;
    FInFileHandle := -1;
    MDZD := nil;

    StartWaitCursor;

    // If we only have a source path make sure the destination is also a path.
    for i := 0 to RenameList.Count - 1 do
    begin
        RenRec := RenameList.Items[i];
        RenRec^.Source := ReplaceForwardSlash(RenRec^.Source);
        RenRec^.Dest := ReplaceForwardSlash(RenRec^.Dest);
        if Length(ExtractFileName(RenRec^.Source)) = 0 then // Assume it's a path.
        begin                           // Make sure destination is a path also.
            RenRec^.Dest := AppendSlash(ExtractFilePath(RenRec^.Dest));
            RenRec^.Source := AppendSlash(RenRec^.Source);
        end
        else
            if Length(ExtractFileName(RenRec^.Dest)) = 0 then
            begin
                StopWaitCursor;
                fZipBusy := false;
                Result := -10;          // Dest should also be a filename.
                Exit;
            end;
    end;
    try
        // Check the input file.
        if not FileExists(FZipFileName) then
            raise EZipMaster.CreateResDisp(GE_NoZipSpecified {DS_NoInFile}, True);
        // Make a temporary filename like: C:\...\zipxxxx.zip
        OutFilePath := MakeTempFileName('', '');
        if OutFilePath = '' then
            raise EZipMaster.CreateResDisp(DS_NoTempFile, True);

        // Create the output file.
        FOutFileHandle := FileCreate(OutFilePath);
        if FOutFileHandle = -1 then
            raise EZipMaster.CreateResDisp(DS_NoOutFile, True);

        // The following function will read the EOC and some other stuff:
        CheckIfLastDisk(EOC, True);

        // Get the date-time stamp and save for later.
        FDateStamp := FileGetDate(FInFileHandle);

        // Now we now the number of zipped entries in the zip archive
        FTotalDisks := EOC.ThisDiskNo;
        if EOC.ThisDiskNo <> 0 then
            raise EZipMaster.CreateResDisp(RN_NoRenOnSpan, True);

        // Go to the start of the input file.
        if FileSeek(FInFileHandle, 0, 0) = -1 then
            raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        // Write the SFX header if present.
        if CopyBuffer(FInFileHandle, FOutFileHandle, FSFXOffset) <> 0 then
            raise EZipMaster.CreateResDisp(RN_ZipSFXData, True);

        // Go to the start of the Central directory.
        if FileSeek(FInFileHandle, EOC.CentralOffset, 0) = -1 then
            raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        MDZD := TMZipDataList.Create(EOC.TotalEntries);

        // Read for every entry: The central header and save information for later use.
        for i := 0 to (EOC.TotalEntries - 1) do
        begin
            // Read a central header.
            if FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) then
                raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);

            if CEH.HeaderSig <> CentralFileHeaderSig then
                raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Now the filename.
            if FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen then
                raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Save the file name info in the MDZD structure.
            MDZDp := MDZD[i];
            MDZDp^.FileNameLen := CEH.FileNameLen;
            StrLCopy(MDZDp^.FileName, Buffer, CEH.FileNameLen);
            MDZDp^.RelOffLocal := CEH.RelOffLocal;
            MDZDp^.DateTime := DateTime;

            // We need the total number of bytes we are going to read for the progress event.
            TotalBytesToRead := TotalBytesToRead + Integer(CEH.ComprSize + CEH.FileNameLen + CEH.ExtraLen);

            // Seek past the extra field and the file comment.
            if FileSeek(FInFileHandle, CEH.ExtraLen + CEH.FileComLen, 1) = -1 then
                raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
        end;

        FShowProgress := True;
        if Assigned(FOnProgress) then
        begin
            FOnProgress(Self, TotalFiles2Process, '', EOC.TotalEntries);
            FOnProgress(Self, TotalSize2Process, '', TotalBytesToRead);
        end;

        // Read for every zipped entry: The local header, variable data, fixed data
        // and if present the Data descriptor area.
        for i := 0 to (EOC.TotalEntries - 1) do
        begin
            // Seek to the first entry.
            MDZDp := MDZD[i];
            FileSeek(FInFileHandle, MDZDp^.RelOffLocal, 0);

            // First the local header.
            while FileRead(FInFileHandle, LOH, SizeOf(LOH)) <> SizeOf(LOH) do
                raise EZipMaster.CreateResDisp(DS_LOHBadRead, True);
            if LOH.HeaderSig <> LocalFileHeaderSig then
                raise EZipMaster.CreateResDisp(DS_LOHWrongSig, True);

            // Now the filename.
            if FileRead(FInFileHandle, Buffer, LOH.FileNameLen) <> LOH.FileNameLen then
                raise EZipMaster.CreateResDisp(DS_LONameLen, True);

            // Set message info on the start of this new fileread because we still have the old filename.
            MsgStr := LoadZipStr(RN_ProcessFile, 'Processing: ') + MDZDp^.FileName;

            // Calculate the bytes we are going to write; we 'forget' the difference
            // between the old and new filespecification.
            TotalBytesWrite := LOH.FileNameLen + LOH.ExtraLen + LOH.ComprSize;

            // Check if the original path and/or filename needs to be changed.
            OrigFileName := ReplaceForwardSlash(MDZDp^.FileName);
            for m := 0 to RenameList.Count - 1 do
            begin
                RenRec := RenameList.Items[m];
                k := Pos(UpperCase(RenRec^.Source), UpperCase(OrigFileName));
                if k <> 0 then
                begin
                    System.Delete(OrigFileName, k, Length(RenRec^.Source));
                    Insert(RenRec^.Dest, OrigFileName, k);
                    LOH.FileNameLen := Length(OrigFileName);
                    for k := 1 to Length(OrigFileName) do
                        if OrigFileName[k] = '\' then
                            OrigFileName[k] := '/';
                    MsgStr := MsgStr + LoadZipStr(RN_RenameTo, ' renamed to: ') + OrigFileName;
                    StrPLCopy(MDZDp^.FileName, OrigFileName, LOH.FileNameLen + 1);
                    MDZDp^.FileNameLen := LOH.FileNameLen;
                    // Change Date and Time if needed.
                    if RenRec^.DateTime <> 0 then
                        MDZDp^.DateTime := RenRec^.DateTime;
                end;
            end;
            if Assigned(FOnMessage) then
                OnMessage(Self, 0, MsgStr);

            // Change Date and/or Time if needed.
            if MDZDp^.DateTime <> 0 then
            begin
                LOH.ModifDate := HIWORD(MDZDp^.DateTime);
                LOH.ModifTime := LOWORD(MDZDp^.DateTime);
            end;
            // Change info for later while writing the central dir.
            MDZDp^.RelOffLocal := FileSeek(FOutFileHandle, 0, 1);

            if Assigned(FOnProgress) then
                FOnProgress(Self, NewFile, ReplaceForwardSlash(MDZDp^.FileName), TotalBytesWrite);

            // Write the local header to the destination.
            WriteJoin(@LOH, SizeOf(LOH), DS_LOHBadWrite);

            // Write the filename.
            WriteJoin(MDZDp^.FileName, LOH.FileNameLen, DS_LOHBadWrite);

            // And the extra field
            if CopyBuffer(FInFileHandle, FOutFileHandle, LOH.ExtraLen) <> 0 then
                raise EZipMaster.CreateResDisp(DS_LOExtraLen, True);

            // Read and write Zipped data
            if CopyBuffer(FInFileHandle, FOutFileHandle, LOH.ComprSize) <> 0 then
                raise EZipMaster.CreateResDisp(DS_ZipData, True);

            // Read DataDescriptor if present.
            if (LOH.Flag and Word(#$0008)) = 8 then
                if CopyBuffer(FInFileHandle, FOutFileHandle, SizeOf(ZipDataDescriptor)) <> 0 then
                    raise EZipMaster.CreateResDisp(DS_DataDesc, True);
        end;                            // Now we have written al entries.

        // Now write the central directory with possibly changed offsets and filename(s).
        FShowProgress := False;
        for i := 0 to (EOC.TotalEntries - 1) do
        begin
            MDZDp := MDZD[i];
            // Read a central header which can be span more than one disk.
            if FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) then
                raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
            if CEH.HeaderSig <> CentralFileHeaderSig then
                raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Change Date and/or Time if needed.
            if MDZDp^.DateTime <> 0 then
            begin
                CEH.ModifDate := HIWORD(MDZDp^.DateTime);
                CEH.ModifTime := LOWORD(MDZDp^.DateTime);
            end;

            // Now the filename.
            if FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen then
                raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Save the first Central directory offset for use in EOC record.
            if i = 0 then
                EOC.CentralOffset := FileSeek(FOutFileHandle, 0, 1);

            // Change the central header info with our saved information.
            CEH.RelOffLocal := MDZDp^.RelOffLocal;
            CEH.DiskStart := 0;
            EOC.CentralSize := EOC.CentralSize - CEH.FileNameLen + MDZDp^.FileNameLen;
            CEH.FileNameLen := MDZDp^.FileNameLen;

            // Write this changed central header to disk
            WriteJoin(@CEH, SizeOf(CEH), DS_CEHBadWrite);

            // Write to destination the central filename and the extra field.
            WriteJoin(MDZDp^.FileName, CEH.FileNameLen, DS_CEHBadWrite);

            // And the extra field
            if CopyBuffer(FInFileHandle, FOutFileHandle, CEH.ExtraLen) <> 0 then
                raise EZipMaster.CreateResDisp(DS_CEExtraLen, True);

            // And the file comment.
            if CopyBuffer(FInFileHandle, FOutFileHandle, CEH.FileComLen) <> 0 then
                raise EZipMaster.CreateResDisp(DS_CECommentLen, True);
        end;
        // Write the changed EndOfCentral directory record.
        EOC.CentralDiskNo := 0;
        EOC.ThisDiskNo := 0;
        WriteJoin(@EOC, SizeOf(EOC), DS_EOCBadWrite);

        // And finally the archive comment
  { ==================== Changed by Jin Turner ===================}
        if (FZipComment <> '')
            and (FileWrite(FOutFileHandle, FZipComment[1], Length(FZipComment)) < 0) then
            //        if CopyBuffer(FInFileHandle, FOutFileHandle, EOC.ZipCommentLen) <> 0 then
            raise EZipMaster.CreateResDisp(DS_EOArchComLen, True);
    except
        on ers: EZipMaster do           // All Rename specific errors.
        begin
            ShowExceptionError(ers);
            Result := -7;
        end;
        on EOutOfMemory do              // All memory allocation errors.
        begin
            ShowZipMessage(GE_NoMem, '');
            Result := -8;
        end;
        on E: Exception do
        begin
            // the error message of an unknown error is displayed ...
            ShowZipMessage(DS_ErrorUnknown, E.Message);
            Result := -9;
        end;
    end;
    if Assigned(MDZD) then
        MDZD.Free;

    // Give final progress info at the end.
    if Assigned(FOnProgress) then
        FOnProgress(Self, EndOfBatch, '', 0);

    if FInFileHandle <> -1 then
        FileClose(FInFileHandle);
    if FOutFileHandle <> -1 then
    begin
        FileSetDate(FOutFileHandle, FDateStamp);
        FileClose(FOutFileHandle);
        if Result <> 0 then             // An error somewhere, OutFile is not reliable.
            DeleteFile(OutFilePath)
        else
        begin
            EraseFile(FZipFileName, FHowToDelete);
            RenameFile(OutFilePath, FZipFileName);
            List();
        end;
    end;

    fZipBusy := False;
    StopWaitCursor;
end;

// RP - changed to not use class MDZD
// Function to copy one or more zipped files from the zip archive to another zip archive
// FSpecArgs in source is used to hold the filename(s) to be copied.
// When this function is ready FSpecArgs contains the file(s) that where not copied.
// Return values:
// 0            All Ok.
// -6           CopyZippedFiles Busy
// -7           CopyZippedFiles errors. See ZipMsgXX.rc
// -8           Memory allocation error.
// -9           General unknown CopyZippedFiles error.

function TZipMaster.CopyZippedFiles(DestZipMaster: TZipMaster; DeleteFromSource: boolean; OverwriteDest: OvrOpts): Integer;
var
    EOC: ZipEndOfCentral;
    CEH: ZipCentralHeader;
    OutFilePath: string;
    In2FileHandle: Integer;
    Found, Overwrite: Boolean;
    DestMemCount: Integer;
    NotCopiedFiles: TStringList;
    pzd, zde: pZipDirEntry;
    s, d: Integer;
    MDZD: TMZipDataList; MDZDp: pMZipData;
begin
    if fZipBusy then
    begin
        Result := -6;
        Exit;
    end;
    fZipBusy := True;
    FShowProgress := False;
    NotCopiedFiles := nil;
    Result := 0;
    In2FileHandle := -1;
    MDZD := nil;

    StartWaitCursor;
    try
        // Are source and destination different?
        if (DestZipMaster = self) or (AnsiStrIComp(pChar(ZipFileName), pChar(DestZipMaster.ZipFileName)) = 0) then
            raise EZipMaster.CreateResDisp(CF_SourceIsDest, True);
        // new 1.7 - stop attempt to copy spanned file
        CheckIfLastDisk(EOC, True);
        if (DestZipMaster.IsSpanned or IsSpanned) then
            raise EZipMaster.CreateResDisp(CF_NoCopyOnSpan, True);
        // Now check for every source file if it is in the destination archive and determine what to do.
        // we use the three most significant bits from the Flag field from ZipDirEntry to specify the action
        // None           = 000xxxxx, Destination no change. Action: Copy old Dest to New Dest
        // Add            = 001xxxxx (New).                  Action: Copy Source to New Dest
        // Overwrite      = 010xxxxx (OvrAlways)             Action: Copy Source to New Dest
        // AskToOverwrite = 011xxxxx (OvrConfirm)	Action to perform: Overwrite or NeverOverwrite
        // NeverOverwrite = 100xxxxx (OvrNever)				  Action: Copy old Dest to New Dest
        for s := 0 to FSpecArgs.Count - 1 do
        begin
            Found := False;
            for d := 0 to DestZipMaster.Count - 1 do
            begin
                zde := pZipDirEntry(DestZipMaster.ZipContents.Items[d]);
                if AnsiStrIComp(pChar(FSpecArgs.Strings[s]), pChar(zde^.FileName)) = 0 then
                begin
                    Found := True;
                    zde^.Flag := zde^.Flag and $1FFF; // Clear the three upper bits.
                    if OverwriteDest = OvrAlways then
                        zde^.Flag := zde^.Flag or $4000
                    else
                        if OverwriteDest = OvrNever then
                            zde^.Flag := zde^.Flag or $8000
                        else
                            zde^.Flag := zde^.Flag or $6000;
                    Break;
                end;
            end;
            if not Found then
            begin                       // Add the Filename to the list and set flag
                New(zde);
                DestZipMaster.ZipContents.Add(zde);
                zde^.FileName := FSpecArgs.Strings[s];
                zde^.FileNameLength := Length(FSpecArgs.Strings[s]);
                zde^.Flag := zde^.Flag or $2000; // (a new entry)
                zde^.ExtraData := nil;  // Needed when deleting zde
            end;
        end;
        // Make a temporary filename like: C:\...\zipxxxx.zip for the new destination
        OutFilePath := MakeTempFileName('', '');
        if OutFilePath = '' then
            raise EZipMaster.CreateResDisp(DS_NoTempFile, True);

        // Create the output file.
        FOutFileHandle := FileCreate(OutFilePath);
        if FOutFileHandle = -1 then
            raise EZipMaster.CreateResDisp(DS_NoOutFile, True);

        // The following function a.o. open the input file no. 1.
        CheckIfLastDisk(EOC, True);

        // Open the second input archive, i.e. the original destination.
        In2FileHandle := FileOpen(DestZipMaster.ZipFileName, fmShareDenyWrite or fmOpenRead);
        if In2FileHAndle = -1 then
            raise EZipMaster.CreateResDisp(CF_DestFileNoOpen, True);

        // Get the date-time stamp and save for later.
        FDateStamp := FileGetDate(In2FileHandle);

        // Write the SFX header if present.
        if CopyBuffer(In2FileHandle, FOutFileHandle, DestZipMaster.SFXOffset) <> 0 then
            raise EZipMaster.CreateResDisp(CF_SFXCopyError, True);

        NotCopiedFiles := TStringList.Create();
        // Now walk trough the destination, copying and replacing
        DestMemCount := DestZipMaster.ZipContents.Count;

        MDZD := TMZipDataList.Create(DestMemCount);

        // Copy the local data and save central header info for later use.
        for d := 0 to DestMemCount - 1 do
        begin
            zde := pZipDirEntry(DestZipMaster.ZipContents.Items[d]);
            if (zde^.Flag and $E000) = $6000 then // Ask first if we may overwrite.
            begin
                Overwrite := False;
                // Do we have a event assigned for this then don't ask.
                if Assigned(FOnCopyZipOverwrite) then
                    FOnCopyZipOverwrite(DestZipMaster, zde^.FileName, Overwrite)
                else
                    if MessageBox(Handle, pChar(Format(LoadZipStr(CF_OverwriteYN, 'Overwrite %s in %s ?'), [zde^.FileName, DestZipMaster.ZipFileName])),
                        pChar(Application.Title), MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) = IDYES then
                        Overwrite := True;
                zde^.Flag := zde^.Flag and $1FFF; // Clear the three upper bits.
                if Overwrite then
                    zde^.Flag := zde^.Flag or $4000
                else
                    zde^.Flag := zde^.Flag or $8000;
            end;
            // Change info for later while writing the central dir in new Dest.
            MDZDp := MDZD[d];
            MDZDp^.RelOffLocal := FileSeek(FOutFileHandle, 0, 1);

            if (zde^.Flag and $6000) = $0000 then // Copy from original dest to new dest.
            begin
                // Set the file pointer to the start of the local header.
                FileSeek(In2FileHandle, zde^.RelOffLocalHdr, 0);
                if CopyBuffer(In2FileHandle, FOutFileHandle, SizeOf(ZipLocalHeader) + zde^.FileNameLength + zde^.ExtraFieldLength + zde^.CompressedSize) <> 0 then
                    raise EZipMaster.CreateResFile(CF_CopyFailed, DestZipMaster.ZipFileName, DestZipMaster.ZipFileName);
                if zde^.Flag and $8000 <> 0 then
                begin
                    NotCopiedFiles.Add(zde^.FileName);
                    // Delete also from FSpecArgs, should not be deleted from source later.
                    FSpecArgs.Delete(FSpecArgs.IndexOf(zde^.FileName));
                end;
            end
            else
            begin                       // Copy from source to new dest.
                // Find the filename in the source archive and position the file pointer.
                for s := 0 to Count - 1 do
                begin
                    pzd := pZipDirEntry(ZipContents.Items[s]);
                    if AnsiStrIComp(pChar(pzd^.FileName), pChar(zde^.FileName)) = 0 then
                    begin
                        FileSeek(FInFileHandle, pzd^.RelOffLocalHdr, 0);
                        if CopyBuffer(FInFileHandle, FOutFileHandle, SizeOf(ZipLocalHeader) + pzd^.FileNameLength + pzd^.ExtraFieldLength + pzd^.CompressedSize) <> 0 then
                            raise EZipMaster.CreateResFile(CF_CopyFailed, ZipFileName, DestZipMaster.ZipFileName);
                        Break;
                    end;
                end;
            end;
            // Save the file name info in the MDZD structure.
            MDZDp^.FileNameLen := zde^.FileNameLength;
            StrPLCopy(MDZDp^.FileName, zde^.FileName, zde^.FileNameLength);
        end;                            // Now we have written al entries.

        // Now write the central directory with possibly changed offsets.
        // Remember the EOC we are going to use is from the wrong input file!
        EOC.CentralSize := 0;
        for d := 0 to DestMemCount - 1 do
        begin
            zde := pZipDirEntry(DestZipMaster.ZipContents.Items[d]);
            pzd := nil;
            Found := False;
            // Rebuild the CEH structure.
            if (zde^.Flag and $6000) = $0000 then // Copy from original dest to new dest.
            begin
                pzd := pZipDirEntry(DestZipMaster.ZipContents.Items[d]);
                Found := True;
            end
            else                        // Copy from source to new dest.
            begin
                // Find the filename in the source archive and position the file pointer.
                for s := 0 to Count - 1 do
                begin
                    pzd := pZipDirEntry(ZipContents.Items[s]);
                    if AnsiStrIComp(pChar(pzd^.FileName), pChar(zde^.FileName)) = 0 then
                    begin
                        Found := True;
                        Break;
                    end;
                end;
            end;
            if not Found then
                raise EZipMaster.CreateResFile(CF_SourceNotFound, zde^.FileName, ZipFileName);
            CopyMemory(@CEH.VersionMadeBy0, pzd, SizeOf(ZipCentralHeader) - 4);
            CEH.HeaderSig := CentralFileHeaderSig;
            CEH.Flag := CEH.Flag and $1FFF;
            MDZDp := MDZD[d];
            CEH.RelOffLocal := MDZDp^.RelOffLocal;
            // Save the first Central directory offset for use in EOC record.
            if d = 0 then
                EOC.CentralOffset := FileSeek(FOutFileHandle, 0, 1);
            EOC.CentralSize := EOC.CentralSize + SizeOf(CEH) + CEH.FileNameLen + CEH.ExtraLen + CEH.FileComLen;

            // Write this changed central header to disk
            WriteJoin(@CEH, SizeOf(CEH), DS_CEHBadWrite);

            // Write to destination the central filename.
            WriteJoin(MDZDp^.FileName, CEH.FileNameLen, DS_CEHBadWrite);

            // And the extra field from zde or pzd.
            if CEH.ExtraLen <> 0 then
                WriteJoin(pzd^.ExtraData, CEH.ExtraLen, DS_CEExtraLen);

            // And the file comment.
            if CEH.FileComLen <> 0 then
                WriteJoin(pChar(pzd^.FileComment), CEH.FileComLen, DS_CECommentLen);
        end;
        EOC.CentralEntries := DestMemCount;
        EOC.TotalEntries := EOC.CentralEntries;
        EOC.ZipCommentLen := Length(DestZipMaster.ZipComment);

        // Write the changed EndOfCentral directory record.
        WriteJoin(@EOC, SizeOf(EOC), DS_EOCBadWrite);

        // And finally the archive comment
        FileSeek(In2FileHandle, DestZipMaster.ZipEOC + SizeOf(EOC), 0);
        if CopyBuffer(In2FileHandle, FOutFileHandle, Length(DestZipMaster.ZipComment)) <> 0 then
            raise EZipMaster.CreateResDisp(DS_EOArchComLen, True);

        if FInFileHandle <> -1 then
            FileClose(FInFileHandle);
        // Now delete all copied files from the source when deletion is wanted.
        if DeleteFromSource and (FSpecArgs.Count > 0) then
        begin
            fZipBusy := False;
            Delete();                   // Delete files specified in FSpecArgs and update the contents.
        end;
        FSpecArgs.Assign(NotCopiedFiles); // Info for the caller.
    except
        on ers: EZipMaster do           // All CopyZippedFiles specific errors..
        begin
            ShowExceptionError(ers);
            Result := -7;
        end;
        on EOutOfMemory do              // All memory allocation errors.
        begin
            ShowZipMessage(GE_NoMem, '');
            Result := -8;
        end;
        on E: Exception do
        begin
            ShowZipMessage(DS_ErrorUnknown, E.Message);
            Result := -9;
        end;
    end;

    if Assigned(MDZD) then
        MDZD.Free;
    NotCopiedFiles.Free;

    if In2FileHandle <> -1 then
        FileClose(In2FileHandle);
    if FOutFileHandle <> -1 then
    begin
        FileSetDate(FOutFileHandle, FDateStamp);
        FileClose(FOutFileHandle);
        if Result <> 0 then             // An error somewhere, OutFile is not reliable.
            DeleteFile(OutFilePath)
        else
        begin
            EraseFile(DestZipMaster.FZipFileName, DestZipMaster.HowToDelete);
            if not RenameFile(OutFilePath, DestZipMaster.FZipFileName) then
                EraseFile(OutFilePath, DestZipMaster.HowToDelete);
        end;
    end;
    DestZipMaster.List();               // Update the old(possibly some entries were added temporarily) or new destination.
    StopWaitCursor;
    fZipBusy := False;
end;

function TZipMaster.GetDirEntry(idx: integer): ZipDirEntry;
begin
    Result := pZipDirEntry(ZipContents.Items[idx])^;
end;

function FileVersion(fname: string): string;
var
    siz: Integer; buf, value: pChar; hndl: cardinal;
begin
    Result := '?.?.?.?';
    siz := GetFileVersionInfoSize(PChar(fname), hndl);
    if siz > 0 then
    begin
        buf := AllocMem(siz);
        try
            GetFileVersionInfo(PChar(fname), 0, siz, buf);
            if VerQueryValue(buf, pChar('StringFileInfo\040904E4\FileVersion')
                , pointer(value), hndl) then
                Result := value
            else
                if VerQueryValue(buf, pChar('StringFileInfo\040904B0\FileVersion')
                    , pointer(value), hndl) then
                    Result := value;
        finally
            FreeMem(buf);
        end;
    end;
end;

function TZipMaster.FullVersionString: string;
begin
    Result := 'ZipMaster ' + ZIPMASTERBUILD + ' '
        {$IFDEF NO_SPAN}
    + ' -SPAN '
        {$ELSE}
    {$ENDIF}
    {$IFDEF NO_SFX}
    + ' -SFX '
        {$ENDIF}
    ;
    if ZipDllHandle <> 0 then
    begin
        Result := Result + ', ZipDll ' + FileVersion(GetZipDllPath(ZipDllHandle));
    end;
    if UnzDllHandle <> 0 then
        Result := Result + ', UnzDll ' + FileVersion(GetUnzDllPath(UnzDllHandle));
end;

procedure TZipMaster.SetMinZipDllVers(Value: integer); // New 1.70
begin
    if Value >= Min_ZipDll_Vers then
        fMinZipDllVer := Value;
end;

procedure TZipMaster.SetMinUnzDllVers(Value: integer); // New 1.70
begin
    if Value >= Min_UnzDll_Vers then
        fMinUnzDllVer := Value;
end;
//================================================================================
// The default exception constructor used.

constructor EZipMaster.CreateResDisp(const Ident: Integer; const Display: Boolean);
begin
    inherited CreateRes(Ident);

    if Message = '' then
        Message := RESOURCE_ERROR + IntToStr(Ident);
    FDisplayMsg := Display;
    FResIdent := Ident;
end;

constructor EZipMaster.CreateResDisk(const Ident: Integer; const DiskNo: Integer);
begin
    inherited CreateRes(Ident);

    if Message = '' then
        Message := LoadZipMsg(Ident)    //RESOURCE_ERROR + IntToStr(Ident)
    else
        Message := Format(Message, [DiskNo]);
    FDisplayMsg := True;
    FResIdent := Ident;
end;

constructor EZipMaster.CreateResDrive(const Ident: Integer; const Drive: string);
begin
    inherited CreateRes(Ident);

    if Message = '' then
        Message := LoadZipMsg(Ident)    //RESOURCE_ERROR + IntToStr(Ident)
    else
        Message := Format(Message, [Drive]);
    FDisplayMsg := True;
    FResIdent := Ident;
end;

constructor EZipMaster.CreateResFile(const Ident: Integer; const File1, File2: string);
begin
    inherited CreateRes(Ident);

    if Message = '' then
        Message := LoadZipMsg(Ident)    //RESOURCE_ERROR + IntToStr(Ident)
    else
        Message := Format(Message, [File1, File2]);
    FDisplayMsg := True;
    FResIdent := Ident;
end;

// ================================================================================
{$IFDEF NO_SPAN}

procedure TZipMaster.GetNewDisk(DiskSeq: Integer);
begin
    raise EZipMaster.CreateResDisp(DS_NODISKSPAN, True);
end;
{$ELSE}

//---------------------------------------------------------------------------

procedure TZipMaster.GetNewDisk(DiskSeq: Integer);
var
    drt: Integer;
begin
    drt := DRIVE_REMOVABLE;
    FileClose(FInFileHandle);           // Close the file on the old disk first.
    FDiskNr := DiskSeq;
    repeat
        if FInFileHandle = -1 then
        begin
            if (drt <> DRIVE_FIXED) and (drt <> DRIVE_REMOTE) then
                ShowZipMessage(DS_NoInFile, '')
                    // This prevents and endless loop if for some reason spanned parts
// on harddisk are missing.
            else
                raise EZipMaster.CreateResDisp(DS_NoInFile, True);
        end;
        repeat
            FNewDisk := True;
            drt := CheckForDisk();
        until IsRightDisk(drt);

        // Open the the input archive on this disk.
        FInFileHandle := FileOpen(FInFileName, fmShareDenyWrite or fmOpenRead);
    until not (FInFileHandle = -1);
end;

// RP - does not use MDZD
//---------------------------------------------------------------------------
// Function to read a split up Zip source file from multiple disks and write it to one destination file.
// Return values:
// 0            All Ok.
// -7           ReadSpan errors. See ZipMsgXX.rc
// -8           Memory allocation error.
// -9           General unknown ReadSpan error.

function TZipMaster.ReadSpan(InFileName: string; var OutFilePath: string): Integer;
var
    Buffer: array[0..BufSize - 1] of Char;
    TotalBytesToRead: Integer;
    EOC: ZipEndOfCentral;
    LOH: ZipLocalHeader;
    DD: ZipDataDescriptor;
    CEH: ZipCentralHeader;
    i, k, drt, diskno: Integer;
    ExtendedSig: Integer;
    MsgStr: string;
    TotalBytesWrite: Integer;
    MDZD: TMZipDataList; MDZDp: pMZipData;
begin
    Result := 0;
    TotalBytesToRead := 0;

    fUnzBusy := True;
    FDrive := ExtractFileDrive(InFileName) + '\';
    FDiskNr := -1;
    FNewDisk := False;
    FShowProgress := False;
    FInFileName := InFileName;
    FInFileHandle := -1;
    MDZD := nil;

    StartWaitCursor;
    try
        // If we don't have a filename we make one first.
        if ExtractFileName(OutFilePath) = '' then
        begin
            OutFilePath := MakeTempFileName('', '');
            if OutFilePath = '' then
                raise EZipMaster.CreateResDisp(DS_NoTempFile, True);
        end
        else
        begin
            EraseFile(OutFilePath, FHowToDelete);
            OutFilePath := ChangeFileExt(OutFilePath, '.zip');
        end;

        // Create the output file.
        FOutFileHandle := FileCreate(OutFilePath);
        if FOutFileHandle = -1 then
            raise EZipMaster.CreateResDisp(DS_NoOutFile, True);

        // Try to get the last disk from the user.
        drt := DRIVE_REMOVABLE;
        repeat
            if (drt = DRIVE_FIXED) or (drt = DRIVE_REMOTE) then
            begin
                DiskNo := StrToIntDef(Copy(FInFileName,
                    Length(FInFileName) - 2 - Length(ExtractFileExt(FInFileName)), 3), 0);
                if DiskNo = 1 then
                    raise EZipMaster.CreateResDisp(DS_FirstInSet, True);
                if DiskNo <> 1 then
                    raise EZipMaster.CreateResDisk(DS_NotLastInSet, DiskNo);
            end;
            drt := CheckForDisk;
            FNewDisk := True;
        until CheckIfLastDisk(EOC, False);

        // Get the date-time stamp and save for later.
        FDateStamp := FileGetDate(FInFileHandle);

        // Now we now the number of zipped entries in the zip archive
        // and the starting disk number of the central directory.
        FTotalDisks := EOC.ThisDiskNo;
        if EOC.ThisDiskNo <> EOC.CentralDiskNo then
            GetNewDisk(EOC.CentralDiskNo); // request a previous disk first
        // We go to the start of the Central directory. v1.52i
        if FileSeek(FInFileHandle, EOC.CentralOffset, 0) = -1 then
            raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        MDZD := TMZipDataList.Create(EOC.TotalEntries);

        // Read for every entry: The central header and save information for later use.
        for i := 0 to (EOC.TotalEntries - 1) do
        begin
            // Read a central header.
            while FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) do //v1.52i
            begin
                // It's possible that we have the central header split up
                if FDiskNr >= EOC.ThisDiskNo then
                    raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
                // We need the next disk with central header info.
                GetNewDisk(FDiskNr + 1);
            end;

            if CEH.HeaderSig <> CentralFileHeaderSig then
                raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Now the filename.
            if FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen then
                raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Save the file name info in the MDZD structure.
            MDZDp := MDZD[i];
            MDZDp^.FileNameLen := CEH.FileNameLen;
            StrLCopy(MDZDp^.FileName, Buffer, CEH.FileNameLen);

            // Save the compressed size, we need this because WinZip sometimes sets this to
            // zero in the local header. New v1.52d
            MDZDp^.ComprSize := CEH.ComprSize;

            // We need the total number of bytes we are going to read for the progress event.
            TotalBytesToRead := TotalBytesToRead + Integer(CEH.ComprSize + CEH.FileNameLen + CEH.ExtraLen + CEH.FileComLen);

            // Seek past the extra field and the file comment.
            if FileSeek(FInFileHandle, CEH.ExtraLen + CEH.FileComLen, 1) = -1 then
                raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
        end;

        // Now we need the first disk and start reading.
        GetNewDisk(0);

        FShowProgress := True;
        if Assigned(FOnProgress) then
        begin
            FOnProgress(Self, TotalFiles2Process, '', EOC.TotalEntries);
            FOnProgress(Self, TotalSize2Process, '', TotalBytesToRead);
        end;

        // Read extended local Sig. first; is only present if it's a spanned archive.
        if FileRead(FInFileHandle, ExtendedSig, 4) <> 4 then
            raise EZipMaster.CreateResDisp(DS_ExtWrongSig, True);
        if ExtendedSig <> ExtLocalSig then
            raise EZipMaster.CreateResDisp(DS_ExtWrongSig, True);

        // Read for every zipped entry: The local header, variable data, fixed data
        // and if present the Data decriptor area.
        for i := 0 to (EOC.TotalEntries - 1) do
        begin
            // First the local header.
            while FileRead(FInFileHandle, LOH, SizeOf(LOH)) <> SizeOf(LOH) do
            begin
                // Check if we are at the end of a input disk not very likely but...
                if FileSeek(FInFileHandle, 0, 1) <> FileSeek(FInFileHandle, 0, 2) then
                    raise EZipMaster.CreateResDisp(DS_LOHBadRead, True);
                // Well it seems we are at the end, so get a next disk.
                GetNewDisk(FDiskNr + 1);
            end;
            if LOH.HeaderSig <> LocalFileHeaderSig then
                raise EZipMaster.CreateResDisp(DS_LOHWrongSig, True);

            // Now the filename, should be on the same disk as the LOH record.
            if FileRead(FInFileHandle, Buffer, LOH.FileNameLen) <> LOH.FileNameLen then
                raise EZipMaster.CreateResDisp(DS_LONameLen, True);

            // Change some info for later while writing the central dir.
            k := MDZD.IndexOf(MakeString(Buffer, LOH.FileNameLen));
            MDZDp := MDZD[k];
            MDZDp^.DiskStart := 0;
            MDZDp^.RelOffLocal := FileSeek(FOutFileHandle, 0, 1);

            // Give message and progress info on the start of this new file read.
            MsgStr := LoadZipStr(GE_CopyFile, 'Copying: ') + ReplaceForwardSlash(MDZDp^.FileName);
            if Assigned(FOnMessage) then
                OnMessage(Self, 0, MsgStr);

            TotalBytesWrite := SizeOf(LOH) + LOH.FileNameLen + LOH.ExtraLen + LOH.ComprSize;
            if (LOH.Flag and Word(#$0008)) = 8 then
                Inc(TotalBytesWrite, SizeOf(DD));
            if Assigned(FOnProgress) then
                FOnProgress(Self, NewFile, ReplaceForwardSlash(MDZDp^.FileName), TotalBytesWrite);

            // Write the local header to the destination.
            WriteJoin(@LOH, SizeOf(LOH), DS_LOHBadWrite);

            // Write the filename.
            WriteJoin(Buffer, LOH.FileNameLen, DS_LOHBadWrite);

            // And the extra field
            RWJoinData(Buffer, LOH.ExtraLen, DS_LOExtraLen);

            // Read Zipped data, if the size is not known use the size from the central header.
            if LOH.ComprSize = 0 then
                LOH.ComprSize := MDZDp^.ComprSize; // New v1.52d
            RWJoinData(Buffer, LOH.ComprSize, DS_ZipData);

            // Read DataDescriptor if present.
            if (LOH.Flag and Word(#$0008)) = 8 then
                RWJoinData(@DD, SizeOf(DD), DS_DataDesc);
        end;                            // Now we have written al entries to the (hard)disk.

        // Now write the central directory with changed offsets.
        FShowProgress := False;
        for i := 0 to (EOC.TotalEntries - 1) do
        begin
            // Read a central header which can be span more than one disk.
            while FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) do
            begin
                // Check if we are at the end of a input disk.
                if FileSeek(FInFileHandle, 0, 1) <> FileSeek(FInFileHandle, 0, 2) then
                    raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
                // Well it seems we are at the end, so get a next disk.
                GetNewDisk(FDiskNr + 1);
            end;
            if CEH.HeaderSig <> CentralFileHeaderSig then
                raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Now the filename.
            if FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen then
                raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Save the first Central directory offset for use in EOC record.
            if i = 0 then
                EOC.CentralOffset := FileSeek(FOutFileHandle, 0, 1);

            // Change the central header info with our saved information.
            //			k := FindZipEntry(EOC.TotalEntries, MakeString(Buffer, CEH.FileNameLen));
            k := MDZD.IndexOf(MakeString(Buffer, CEH.FileNameLen));
            MDZDp := MDZD[k];
            CEH.RelOffLocal := MDZDp^.RelOffLocal;
            CEH.DiskStart := 0;

            // Write this changed central header to disk
            // and make sure it fit's on one and the same disk.
            WriteJoin(@CEH, SizeOf(CEH), DS_CEHBadWrite);

            // Write to destination the central filename and the extra field.
            WriteJoin(Buffer, CEH.FileNameLen, DS_CEHBadWrite);

            // And the extra field
            RWJoinData(Buffer, CEH.ExtraLen, DS_CEExtraLen);

            // And the file comment.
            RWJoinData(Buffer, CEH.FileComLen, DS_CECommentLen);
        end;

        // Write the changed EndOfCentral directory record.
        EOC.CentralDiskNo := 0;
        EOC.ThisDiskNo := 0;
        WriteJoin(@EOC, SizeOf(EOC), DS_EOCBadWrite);

        // Skip past the original EOC to get to the ZipComment if present. v1.52M
        if (FileSeek(FInFileHandle, SizeOf(EOC), 1) = -1) then
            raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        // And finally the archive comment
        RWJoinData(Buffer, EOC.ZipCommentLen, DS_EOArchComLen);
    except
        on ers: EZipMaster do           // All ReadSpan specific errors.
        begin
            ShowExceptionError(ers);
            Result := -7;
        end;
        on EOutOfMemory do              // All memory allocation errors.
        begin
            ShowZipMessage(GE_NoMem, '');
            Result := -8;
        end;
        on E: Exception do
        begin
            // The remaining errors, should not occur.
            ShowZipMessage(DS_ErrorUnknown, E.Message);
            Result := -9;
        end;
    end;

    // Give final progress info at the end.
    if Assigned(FOnProgress) then
        FOnProgress(Self, EndOfBatch, '', 0);

    if Assigned(MDZD) then
        MDZD.Free;

    if FInFileHandle <> -1 then
        FileClose(FInFileHandle);
    if FOutFileHandle <> -1 then
    begin
        FileSetDate(FOutFileHandle, FDateStamp);
        FileClose(FOutFileHandle);
        if Result <> 0 then             // An error somewhere, OutFile is not reliable.
        begin
            DeleteFile(OutFilePath);
            OutFilePath := '';
        end;
    end;

    fUnzBusy := False;
    StopWaitCursor;
end;

function TZipMaster.CheckForDisk: Integer;
var
    drt: Integer;                       // drive type
    Res, MsgFlag: Integer;
    SizeOfDisk: LargeInt;               // RCV150199
    MsgStr: string;
    AbortAction: Boolean;
begin
    Application.ProcessMessages;
    drt := GetDriveType(pChar(FDrive));
    Res := IDOK;
    MsgFlag := MB_OKCANCEL;

    // First check if we want a new one or if there is a disk (still) present.
    while (((Res = IDOK) and not IsDiskPresent) or FNewDisk) do
    begin
        if ((drt = DRIVE_FIXED) or (drt = DRIVE_REMOTE)) then
        begin                           // If it is a fixed disk we don't want a new one.
            FNewDisk := False;
            break;
        end;
        if FUnattended then
            raise EZipMaster.CreateResDisp(DS_NoUnattSpan, True);
        if FDiskNr < 0 then             // -1=ReadSpan(), 0=WriteSpan()
        begin
            MsgStr := LoadZipStr(DS_InsertDisk, 'Please insert last disk in set');
            MsgFlag := MsgFlag or MB_ICONERROR;
        end
        else
        begin
            if fZipBusy then            // Are we from ReadSpan() or WriteSpan()?
            begin
                // This is an estimate, we can't know if every future disk has the same space available and
                // if there is no disk present we can't determine the size unless it's set by MaxVolumeSize.
                SizeOfDisk := FSizeOfDisk;
                if (FMaxVolumeSize <> 0) and (FMaxVolumeSize < FSizeOfDisk) then
                    SizeOfDisk := FMaxVolumeSize;

                FTotalDisks := FDiskNr;
                if (SizeOfDisk > 0) and (FTotalDisks < Trunc((FFileSize + 4 + FFreeOnDisk1) / SizeOfDisk)) then // RCV150199
                    FTotalDisks := Trunc((FFileSize + 4 + FFreeOnDisk1) / SizeOfDisk);
                if SizeOfDisk > 0 then
                    MsgStr := Format(LoadZipStr(DS_InsertVolume, 'Please insert disk volume %.1d of %.1d'), [FDiskNr + 1, FTotalDisks + 1])
                else
                    MsgStr := Format(LoadZipStr(DS_InsertAVolume, 'Please insert disk volume %.1d'), [FDiskNr + 1]);
            end
            else
                MsgStr := Format(LoadZipStr(DS_InsertVolume, 'Please insert disk volume %.1d of %.1d'), [FDiskNr + 1, FTotalDisks + 1]);
        end;
        MsgStr := MsgStr + Format(LoadZipStr(DS_InDrive, #13#10'in drive: %s'), [FDrive]);

        if Assigned(FOnGetNextDisk) then // v1.60L
        begin
            AbortAction := False;
            FOnGetNextDisk(self, FDiskNr + 1, FTotalDisks + 1, Copy(FDrive, 1, 1), AbortAction);
            if AbortAction then
                Res := IDABORT
            else
                Res := IDOK;
        end
        else
            Res := MessageBox(Handle, pChar(MsgStr), pChar(Application.Title), MsgFlag);
        FNewDisk := False;
    end;

    // Check if user pressed Cancel or memory is running out.
    if Res <> IDOK then
        raise EZipMaster.CreateResDisp(DS_Canceled, False);
    if Res = 0 then
        raise EZipMaster.CreateResDisp(DS_NoMem, True);
    Result := drt;
end;

//---------------------------------------------------------------------------

function TZipMaster.IsRightDisk(drt: Integer): Boolean;
var
    Ext: string;
begin
    Result := False;
    // For fixed disks the disk is always right, we only need to change
    // the filename.
    if (drt = DRIVE_FIXED) or (drt = DRIVE_REMOTE) or (drt = DRIVE_CDROM) then
    begin
        // Get the file extension.
        Ext := ExtractFileExt(FInFileName);
        // Strip file extension and the last 3 numbers.
        SetLength(FInFileName, Length(FInFileName) - 3 - Length(Ext));
        // Set the filename to the diskfile number we want now.
        FInFileName := FInFileName + Copy(IntToStr(1001 + FDiskNr), 2, 3) + Ext;
        Result := True;
        Exit;
    end;
    if FVolumeName = ('PKBACK# ' + Copy(IntToStr(1001 + FDiskNr), 2, 3)) then
        Result := True;
end;

//---------------------------------------------------------------------------
// Read data from the input file with a maximum of 8192(BufSize) bytes per read
// and write this to the output file.
// In case of an error an Exception is raised and this will
// be caught in WriteSpan.

procedure TZipMaster.RWSplitData(Buffer: pChar; ReadLen, ZSErrVal: Integer);
var
    SizeR, ToRead: Integer;
begin
    while ReadLen > 0 do
    begin
        ToRead := BufSize;
        if ReadLen < BufSize then
            ToRead := ReadLen;
        SizeR := FileRead(FInFileHandle, Buffer^, ToRead);
        if SizeR <> ToRead then
            raise EZipMaster.CreateResDisp(ZSErrVal, True);
        WriteSplit(Buffer, SizeR, 0);
        Dec(ReadLen, SizeR);
    end;
end;

//---------------------------------------------------------------------------

procedure TZipMaster.RWJoinData(Buffer: pChar; ReadLen, DSErrIdent: Integer);
var
    ToRead, SizeR: Integer;
begin
    while ReadLen > 0 do
    begin
        ToRead := BufSize;
        if ReadLen < BufSize then
            ToRead := ReadLen;
        SizeR := FileRead(FInFileHandle, Buffer^, ToRead);
        if SizeR <> ToRead then
        begin
            // Check if we are at the end of a input disk.
            if FileSeek(FInFileHandle, 0, 1) <> FileSeek(FInFileHandle, 0, 2) then
                raise EZipMaster.CreateResDisp(DSErrIdent, True);
            // It seems we are at the end, so get a next disk.
            GetNewDisk(FDiskNr + 1);
        end;
        if SizeR > 0 then               // Fix by Scott Schmidt v1.52n
        begin
            WriteJoin(Buffer, SizeR, DSErrIdent);
            Dec(ReadLen, SizeR);
        end;
    end;
end;

//---------------------------------------------------------------------------
//  Format floppy disk

procedure TZipMaster.ClearFloppy(dir: string);
var
    SRec: TSearchRec; Name: string;
begin
    if FindFirst(Dir + '*.*', faAnyFile, SRec) = 0 then
        repeat
            name := Dir + SRec.Name;
            if ((SRec.Attr and faDirectory) <> 0) and (SRec.Name <> '.') and (SRec.Name <> '..') then
            begin
                Name := Name + '\';
                ClearFloppy(Name);
                TraceMessage('EraseFloopy - Removing ' + Name);
                Application.ProcessMessages; //allow time for OS to delete last file
                RemoveDir(Name);
            end
            else
            begin
                TraceMessage('EraseFloopy - Deleting ' + Name);
                DeleteFile(Name);
            end;
        until FindNext(SRec) <> 0;
    FindClose(SRec);
end;

function FormatFloppy(WND: HWND; Drive: string): integer;
const
    SHFMT_ID_DEFAULT = $FFFF;
    {options}
    SHFMT_OPT_FULL = $0001;
    SHFMT_OPT_SYSONLY = $0002;
    {return values}
    SHFMT_ERROR = $FFFFFFFF;            // -1 Error on last format, drive may be formatable
    SHFMT_CANCEL = $FFFFFFFE;           // -2 last format cancelled
    SHFMT_NOFORMAT = $FFFFFFFD;         // -3 drive is not formatable
type
    TSHFormatDrive = function(WND: HWND; Drive, fmtID, Options: DWORD): DWORD; stdcall;
const
    SHFormatDrive: TSHFormatDrive = nil;
var
    drv: integer; hLib: THandle; OldErrMode: integer;
begin
    result := -3;                       // error
    if not ((Length(Drive) > 1) and (Drive[2] = ':') and (Upcase(Drive[1]) in ['A'..'Z'])) then
        exit;
    if GetDriveType(pChar(Drive)) <> DRIVE_REMOVABLE then
        exit;
    drv := ord(Upcase(Drive[1])) - ord('A');
    OldErrMode := SetErrorMode(SEM_FAILCRITICALERRORS or SEM_NOGPFAULTERRORBOX);
    hLib := LoadLibrary('Shell32');
    if hLib <> 0 then
    begin
        @SHFormatDrive := GetProcAddress(hLib, 'SHFormatDrive');
        if @SHFormatDrive <> nil then
        try
            Result := SHFormatDrive(WND, drv, SHFMT_ID_DEFAULT, SHFMT_OPT_FULL);
        finally
            FreeLibrary(hLib);
        end;
        SetErrorMode(OldErrMode);
    end;
end;

//---------------------------------------------------------------------------

function TZipMaster.ZipFormat: Integer;
var
    Vol: string; Res: Integer;
begin
    Result := -3;
    if FormatErase then
        Result := FormatFloppy(Application.Handle, FDrive);
    if Result = -3 then
    begin
        Res := MessageBox(Handle, pChar('Erase ' + FDrive), pChar('Confirm')
            , MB_YESNO or MB_DEFBUTTON2 or MB_ICONWARNING);
        if Res <> IDYES then
        begin
            Result := -2;               // cancel
            Exit;
        end;
        ClearFloppy(FDrive);
        Result := 0;
    end;
    if Length(FVolumeName) > 11 then
        Vol := Copy(FVolumeName, 1, 11)
    else
        Vol := FVolumeName;
    if Result = 0 then                  // did it
        SetVolumeLabel(pChar(FDrive), pChar(Vol));

end;

// RP - does not use class MDZD
//---------------------------------------------------------------------------
// Function to read a Zip source file and write it back to one or more disks.
// Return values:
//  0           All Ok.
// -7           WriteSpan errors. See ZipMsgXX.rc
// -8           Memory allocation error.
// -9           General unknown WriteSpan error.

function TZipMaster.WriteSpan(InFileName, OutFileName: string): Integer;
var
    LOH: ZipLocalHeader;
    DD: ZipDataDescriptor;
    CEH: ZipCentralHeader;
    EOC: ZipEndOfCentral;
    i, k: Integer;
    MsgStr: string;
    TotalBytesWrite: Integer;
    StartCentral: Integer;
    CentralOffset: Integer;
    Buffer: array[0..BufSize - 1] of Char;
    MDZD: TMZipDataList; MDZDp: pMZipData;
begin
    Result := 0;
    fZipBusy := True;
    FDrive := ExtractFileDrive(OutFileName) + '\';
    FDiskNr := 0;
    FFreeOnDisk := 0;
    FNewDisk := True;
    FDiskWritten := 0;
    FInFileName := InFileName;
    FOutFileName := OutFileName;
    FOutFileHandle := -1;
    FShowProgress := False;
    CentralOffset := 0;
    MDZD := nil;

    StartWaitCursor;
    try
        if not FileExists(InFileName) then
            raise EZipMaster.CreateResDisp(DS_NoInFile, True);

        // The following function will read the EOC and some other stuff:
        CheckIfLastDisk(EOC, True);

        // Get the date-time stamp and save for later.
        FDateStamp := FileGetDate(FInFileHandle);

        // go back to the start the zip archive.
        if (FileSeek(FInFileHandle, 0, 0) = -1) then
            raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        MDZD := TMZipDataList.Create(EOC.TotalEntries);

        // Write extended local Sig. needed for a spanned archive.
        FInteger := ExtLocalSig;
        WriteSplit(@FInteger, 4, 0);

        // Read for every zipped entry: The local header, variable data, fixed data
        // and, if present, the Data decriptor area.
        FShowProgress := True;
        if Assigned(FOnProgress) then
        begin
            FOnProgress(Self, TotalFiles2Process, '', EOC.TotalEntries);
            FOnProgress(Self, TotalSize2Process, '', FFileSize);
        end;

        for i := 0 to (EOC.TotalEntries - 1) do
        begin
            // First the local header.
            if not (FileRead(FInFileHandle, LOH, SizeOf(LOH)) = SizeOf(LOH)) then
                raise EZipMaster.CreateResDisp(DS_LOHBadRead, True);
            if not (LOH.HeaderSig = LocalFileHeaderSig) then
                raise EZipMaster.CreateResDisp(DS_LOHWrongSig, True);

            // Now the filename
            if not (FileRead(FInFileHandle, Buffer, LOH.FileNameLen) = LOH.FileNameLen) then
                raise EZipMaster.CreateResDisp(DS_LONameLen, True);

            // Save some information for later. ( on the last disk(s) ).
            MDZDp := MDZD.Items[i];
            MDZDp^.DiskStart := FDiskNr;
            MDZDp^.FileNameLen := LOH.FileNameLen;

            StrLCopy(MDZDp^.FileName, Buffer, LOH.FileNameLen); // like makestring

            // Give message and progress info on the start of this new file read.
            if Assigned(OnMessage) then
            begin
                MsgStr := LoadZipStr(GE_CopyFile, 'Copying: ') + ReplaceForwardSlash(MDZDp^.FileName);
                OnMessage(Self, 0, MsgStr);
            end;

            TotalBytesWrite := SizeOf(LOH) + LOH.FileNameLen + LOH.ExtraLen + LOH.ComprSize;
            if (LOH.Flag and Word(#$0008)) = 8 then
                Inc(TotalBytesWrite, SizeOf(DD));

            if Assigned(FOnProgress) then
                FOnProgress(Self, NewFile, ReplaceForwardSlash(MDZDp^.FileName), TotalBytesWrite);

            // Write the local header to the destination.
            WriteSplit(@LOH, SizeOf(LOH), SizeOf(LOH) + LOH.FileNameLen + LOH.ExtraLen);

            // Save the offset of the LOH on this disk for later.
            MDZDp^.RelOffLocal := FDiskWritten - SizeOf(LOH);

            // Write the filename.
            WriteSplit(Buffer, LOH.FileNameLen, 0);

            // And the extra field
            RWSplitData(Buffer, LOH.ExtraLen, DS_LOExtraLen);

            // Read Zipped data !!!For now assume we know the size!!!
            RWSplitData(Buffer, LOH.ComprSize, DS_ZipData);

            // Read DataDescriptor if present.
            if (LOH.Flag and Word(#$0008)) = 8 then
                RWSplitData(@DD, SizeOf(DD), DS_DataDesc);
        end;
        // We have written all entries to disk.
        if Assigned(FOnMessage) then
            OnMessage(Self, 0, LoadZipStr(GE_CopyFile, 'Copying: ') + LoadZipStr(DS_CopyCentral, 'Central directory'));
        if Assigned(FOnProgress) then
            FOnProgress(Self, NewFile, LoadZipStr(DS_CopyCentral, 'Central directory'), EOC.CentralSize + SizeOf(EOC) + EOC.ZipCommentLen);

        // Now write the central directory with changed offsets.
        StartCentral := FDiskNr;
        for i := 0 to (EOC.TotalEntries - 1) do
        begin
            // Read a central header.
            if FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) then
                raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
            if CEH.HeaderSig <> CentralFileHeaderSig then
                raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Now the filename.
            if FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen then
                raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Change the central directory with information stored previously in MDZD.
         //            k := FindZipEntry(EOC.TotalEntries, MakeString(Buffer, CEH.FileNameLen));
            k := MDZD.IndexOf(MakeString(Buffer, CEH.FileNameLen));
            MDZDp := MDZD[k];
            CEH.DiskStart := MDZDp^.DiskStart;
            CEH.RelOffLocal := MDZDp^.RelOffLocal;

            // Write this changed central header to disk
            // and make sure it fit's on one and the same disk.
            WriteSplit(@CEH, SizeOf(CEH), SizeOf(CEH) + CEH.FileNameLen + CEH.ExtraLen + CEH.FileComLen);

            // Save the first Central directory offset for use in EOC record.
            if i = 0 then
                CentralOffset := FDiskWritten - SizeOf(CEH);

            // Write to destination the central filename and the extra field.
            WriteSplit(Buffer, CEH.FileNameLen, 0);

            // And the extra field
            RWSplitData(Buffer, CEH.ExtraLen, DS_CEExtraLen);

            // And the file comment.
            RWSplitData(Buffer, CEH.FileComLen, DS_CECommentLen);
        end;

        // Write the changed EndOfCentral directory record.
        EOC.CentralDiskNo := StartCentral;
        EOC.ThisDiskNo := FDiskNr;
        EOC.CentralOffset := CentralOffset;
        WriteSplit(@EOC, SizeOf(EOC), SizeOf(EOC) + EOC.ZipCommentLen);

        // Skip past the original EOC to get to the ZipComment if present. v1.52j
        if (FileSeek(FInFileHandle, SizeOf(EOC), 1) = -1) then
            raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        // And finally the archive comment
        RWSplitData(Buffer, EOC.ZipCommentLen, DS_EOArchComLen);
        FShowProgress := False;
    except
        on ews: EZipMaster do           // All WriteSpan specific errors.
        begin
            ShowExceptionError(ews);
            Result := -7;
        end;
        on EOutOfMemory do              // All memory allocation errors.
        begin
            ShowZipMessage(GE_NoMem, '');
            Result := -8;
        end;
        on E: Exception do
        begin
            // The remaining errors, should not occur.
            ShowZipMessage(DS_ErrorUnknown, E.Message);
            Result := -9;
        end;
    end;

    // Give the last progress info on the end of this file read.
    if Assigned(FOnProgress) then
        FOnProgress(Self, EndOfBatch, '', 0);

    if Assigned(MDZD) then
        MDZD.Free;

    FileSetDate(FOutFileHandle, FDateStamp);
    if FOutFileHandle <> -1 then
        FileClose(FOutFileHandle);
    if FInFileHandle <> -1 then
        FileClose(FInFileHandle);

    fZipBusy := False;
    StopWaitCursor;
end;

function TZipMaster.MakeString(Buffer: pChar; Size: Integer): string;
begin
    SetLength(Result, Size);
    StrLCopy(pChar(Result), Buffer, Size);
end;

//---------------------------------------------------------------------------
// This function actually writes the zipped file to the destination while
// taking care of disk changes and disk boundary crossings.
// In case of an write error, or user abort, an exception is raised.

procedure TZipMaster.WriteSplit(Buffer: pChar; Len: Integer; MinSize: Integer);
var
    Res, MaxLen: Integer;
    Buf: pChar;                         // Used if Buffer doesn't fit on the present disk.
    drt, DiskSeq: Integer;
    DiskFile, MsgQ: string;
begin
    Buf := Buffer;
    Application.ProcessMessages;
    if Cancel then
        raise EZipMaster.CreateResDisp(DS_Canceled, False);

    while True do                       // Keep writing until error or buffer is empty.
    begin
        // Check if we have an output file already opened, if not: create one,
        // do checks, gather info.
        if FOutFileHandle = -1 then
        begin
            drt := CheckForDisk();
            DiskFile := FOutFileName;

            // If we write on a fixed disk the filename must change.
            // We will get something like: FileNamexxx.zip where xxx is 001,002 etc.
            if (drt = DRIVE_FIXED) or (drt = DRIVE_REMOTE) then
            begin
                DiskFile := Copy(DiskFile, 1, Length(DiskFile) - Length(ExtractFileExt(DiskFile))) +
                    Copy(IntToStr(1001 + FDiskNr), 2, 3) + ExtractFileExt(DiskFile);
            end
            else
                if AddDiskSpanErase in FAddOptions then
                begin
                    if (not Assigned(FOnGetNextDisk))
                        or (Assigned(FOnGetNextDisk)
                        and (FZipDiskAction = zdaErase)) then // Added v1.60L
                    begin
                        // Do we want a format first?
                        FDriveNr := Ord(UpperCase(FDrive)[1]) - Ord('A');
                        FVolumeName := 'PKBACK# ' + Copy(IntToStr(1001 + FDiskNr), 2, 3);
                        // Ok=6 NoFormat=-3, Cancel=-2, Error=-1
                        case ZipFormat of // Start formating and wait until finished...
                            -1: raise EZipMaster.CreateResDisp(DS_Canceled, True);
                            -2: raise EZipMaster.CreateResDisp(DS_Canceled, False);
                        end;
                    end;
                end;

            // Do we want to overwrite an existing file?
            if FileExists(DiskFile) then
            begin
                DiskSeq := StrToIntDef(Copy(FVolumeName, 9, 3), 1);
                if Unattended then
                    raise EZipMaster.CreateResDisp(DS_NoUnattSpan, True); // we assume we don't.
                FZipDiskStatus := [];   // v1.60L
                // A more specific check if we have a previous disk from this set.
                if (FileAge(DiskFile) = FDateStamp) and (Pred(DiskSeq) < FDiskNr) then
                begin
                    MsgQ := Format(LoadZipStr(DS_AskPrevFile, 'Overwrite previous disk no %d'), [DiskSeq]);
                    FZipDiskStatus := FZipDiskStatus + [zdsPreviousDisk]; // v1.60L
                end
                else
                begin
                    MsgQ := Format(LoadZipStr(DS_AskDeleteFile, 'Overwrite previous file %s'), [DiskFile]);
                    FZipDiskStatus := FZipDiskStatus + [zdsSameFileName]; // v1.60L
                end;
                if FSizeOfDisk - FFreeOnDisk <> 0 then // v1.60L
                    FZipDiskStatus := FZipDiskStatus + [zdsHasFiles] // But not the same name
                else
                    FZipDiskStatus := FZipDiskStatus + [zdsEmpty];
                if Assigned(FOnStatusDisk) then // v1.60L
                begin
                    FZipDiskAction := zdaOk; // The default action
                    FOnStatusDisk(Self, DiskSeq, DiskFile, FZipDiskStatus, FZipDiskAction);
                    case FZipDiskAction of
                        zdaCancel: Res := IDCANCEL;
                        zdaReject: Res := IDNO;
                        zdaErase: Res := IDOK;
                        zdaOk: Res := IDOK;
                    else
                        Res := IDOK;
                    end;
                end
                else
                    Res := MessageBox(Handle, pChar(MsgQ), pChar('Confirm'), MB_YESNOCANCEL or MB_DEFBUTTON2 or MB_ICONWARNING);
                if (Res = 0) or (Res = IDCANCEL) then
                    raise EZipMaster.CreateResDisp(DS_Canceled, False);

                if Res = IDNO then
                begin                   // we will try again...
                    FDiskWritten := 0;
                    FNewDisk := True;
                    Continue;
                end;
            end;

            // Create the output file.
            FOutFileHandle := FileCreate(DiskFile);
            if FOutFileHandle = -1 then
                raise EZipMaster.CreateResDisp(DS_NoOutFile, True);

            // Get the free space on this disk, correct later if neccessary.
            DiskFreeAndSize(1);         // RCV150199

            // Set the maximum number of bytes that can be written to this disk(file).
            if MaxVolumeSize > 0 then
                if MaxVolumeSize < FFreeOnDisk then
                    FFreeOnDisk := MaxVolumeSize;

            // Reserve space on/in the first disk(file).
            if FDiskNr = 0 then
                FFreeOnDisk := FFreeOnDisk - KeepFreeOnDisk1; // RCV150199

            // Do we still have enough free space on this disk.
            if FFreeOnDisk < MinFreeVolumeSize then // No, too bad...
            begin
                FileClose(FOutFileHandle);
                DeleteFile(DiskFile);
                FOutFileHandle := -1;
                if FUnattended then
                    raise EZipMaster.CreateResDisp(DS_NoUnattSpan, True);
                if Assigned(FOnStatusDisk) then // v1.60L
                begin
                    DiskSeq := StrToIntDef(Copy(FVolumeName, 9, 3), 1);
                    FZipDiskAction := zdaOk; // The default action
                    FZipDiskStatus := [zdsNotEnoughSpace];
                    FOnStatusDisk(Self, DiskSeq, DiskFile, FZipDiskStatus, FZipDiskAction);
                    case FZipDiskAction of
                        zdaCancel: Res := IDCANCEL;
                        zdaOk: Res := IDRETRY;
                        zdaErase: Res := IDRETRY;
                        zdaReject: Res := IDRETRY;
                    else
                        Res := IDRETRY;
                    end;
                end
                else
                begin
                    MsgQ := LoadZipStr(DS_NoDiskSpace, 'This disk has not enough free space available');
                    Res := MessageBox(Handle, pChar(MsgQ), pChar(Application.Title), MB_RETRYCANCEL or MB_ICONERROR);
                end;
                if Res = 0 then
                    raise EZipMaster.CreateResDisp(DS_NoMem, True);
                if Res <> IDRETRY then
                    raise EZipMaster.CreateResDisp(DS_Canceled, False);
                FDiskWritten := 0;
                FNewDisk := True;
                // If all this was on a HD then this would't be useful but...
                Continue;
            end;

            // Set the volume label of this disk if it is not a fixed one.
            if (drt <> DRIVE_FIXED) and (drt <> DRIVE_REMOTE) then
            begin
                FVolumeName := 'PKBACK# ' + Copy(IntToStr(1001 + FDiskNr), 2, 3);
                if not SetVolumeLabel(pChar(FDrive), pChar(FVolumeName)) then
                    raise EZipMaster.CreateResDisp(DS_NoVolume, True);
            end;
        end;                            // END OF: if FOutFileHandle = -1

        // Check if we have at least MinSize available on this disk,
        // headers are not allowed to cross disk boundaries. ( if zero than don't care.)
        if (MinSize > 0) and (MinSize > FFreeOnDisk) then
        begin
            FileSetDate(FOutFileHandle, FDateStamp);
            FileClose(FOutFileHandle);
            FOutFileHandle := -1;
            FDiskWritten := 0;
            FNewDisk := True;
            Inc(FDiskNr);               // RCV270299
            Continue;
        end;

        // Don't try to write more bytes than allowed on this disk.
        MaxLen := {$IFDEF VERD4+}Integer(FFreeOnDisk){$ELSE}Trunc(FFreeOnDisk){$ENDIF}; // RCV150199
        if Len < FFreeOnDisk then
            MaxLen := Len;
        Res := FileWrite(FOutFileHandle, Buf^, MaxLen);

        // Sleep( 250 );  // This will keep the progress events more synchronised, but it's slower.
        // Give some progress info while writing
        // While processing the central header we don't want messages.
        if Assigned(FOnProgress) and FShowProgress then
            FOnProgress(Self, ProgressUpdate, '', MaxLen);
        if Res = -1 then
            raise EZipMaster.CreateResDisp(DS_NoWrite, True); // A write error (disk removed?)
        Inc(FDiskWritten, Res);
        FFreeOnDisk := FFreeOnDisk - MaxLen; // RCV150199
        if MaxLen = Len then
            Break;

        // We still have some data left, we need a new disk.
        FileSetDate(FOutFileHandle, FDateStamp);
        FileClose(FOutFileHandle);
        FOutFileHandle := -1;
        FFreeOnDisk := 0;
        FDiskWritten := 0;
        Inc(FDiskNr);
        FNewDisk := True;
        Inc(Buf, MaxLen);
        Dec(Len, MaxLen);
    end;
end;

{$ENDIF}
{$IFNDEF NO_SFX}
function SearchResDirEntry(const ResStart: pIRD; const entry: pIRDirE;
    Depth: Integer): DWord; forward;
// Browse through all resource Directories.

function BrowseResDir(const ResStart: pIRD; const dir: pIRD; Depth: Integer): DWord;
var
    SingleRes: pIRDirE;
    i: Integer;
begin
    Result := 0;
    SingleRes := pIRDirE(pChar(dir) + SizeOf(IMAGE_RESOURCE_DIRECTORY));
    for i := 0 to dir.NumberOfNamedEntries + dir.NumberOfIdEntries - 1 do
    begin
        Result := SearchResDirEntry(ResStart, SingleRes, Depth);
        if Result <> 0 then
            Break;                      // Found the one w're looking for.
        Inc(SingleRes, 1);
    end;
end;

// Search for the right(with our icon) resource directory entry.

function SearchResDirEntry(const ResStart: pIRD; const entry: pIRDirE; Depth: Integer): DWord;
var
    data: pIRDatE;
begin
    Result := 0;
    if (entry.un1.NameIsString and $80000000) <> 0 then
        Exit;                           // No named resources.
    if (Depth = 0) and (entry.un1.Id <> 3) then
        Exit;                           // Only icon resources.
    if (Depth = 1) and (entry.un1.Id <> 1) then
        Exit;                           // Only icon with ID 0x1.
    if (entry.un2.DataIsDirectory and $80000000) = 0 then
    begin
        data := pIRDatE(pChar(ResStart) + entry.un2.OffsetToData);
        if data.Size = 744 then
            Result := data.OffsetToData;
    end
    else
        Result := BrowseResDir(ResStart, pIRD(pChar(ResStart) + (entry.un2.OffsetToDirectory and $7FFFFFFF)), Depth + 1)
end;

// Find Resource directory entry.

function LookForDirs(const SectionData: Pointer; const SectionVirtualStart: DWord;
    const SectionLen: Integer; const directories: pIDD): DWord;
var
    ResStart: Pointer;
    dirs: pIDD;
begin
    Result := 0;
    dirs := directories;
    Inc(dirs, IMAGE_DIRECTORY_ENTRY_RESOURCE);
    if (dirs.VirtualAddress <> 0) and (pChar(dirs.VirtualAddress) >= pChar(SectionVirtualStart)) and
        (pChar(dirs.VirtualAddress) < (pChar(SectionVirtualStart) + SectionLen)) then
    begin
        ResStart := pChar(SectionData) + (dirs.VirtualAddress - SectionVirtualStart);
        Result := BrowseResDir(ResStart, ResStart, 0);
    end;
end;

procedure TZipMaster.SetSFXIcon(aIcon: TIcon);
begin
    FSFXIcon.Assign(aIcon);
end;

// Replace the icon resource in the copied ZipSFX.bin
// Return values: All ok: =0   Error: <0

function TZipMaster.ReplaceIcon(SFXFile, SFXSize: Integer): Integer;
const
    SE_NoFoundError = -10;
    SE_MemStreamError = -11;
    SE_IconSizeError = -12;
var
    SFXBuffer: pChar;
    IconStream: TMemoryStream;
    DOSHead: ^IMAGE_DOS_HEADER;
    Header: ^PEheader;
    Section: Integer;
    FoundAddr: DWord;
    SectionHeader: pISH;
begin
    Result := SE_NoFoundError;
    FoundAddr := 0;
    SFXBuffer := nil;
    IconStream := nil;
    try
        try
            // Put the SFX file into a buffer.
            GetMem(SFXBuffer, SFXSize);
            FileSeek(SFXFile, 0, soFromBeginning);
            FileRead(SFXFile, SFXBuffer^, SFXSize);
            // Read and check the ZipSFX.bin file for an icon resource.
            DOSHead := Pointer(SFXBuffer);
            if DOSHead.e_magic <> IMAGE_DOS_SIGNATURE then
                Exit;
            Header := Pointer(pChar(DOSHead) + DOSHead._lfanew);
            if Header.signature <> IMAGE_NT_SIGNATURE then
                Exit;
            SectionHeader := Addr(Header.section_header);
            for Section := 0 to Header._head.NumberOfSections - 1 do // Walk through sections.
            begin
                if StrComp(pChar(Addr(SectionHeader.Name[0])), '.rsrc') = 0 then
                begin                   // Found the resource section.
                    FoundAddr := LookForDirs(SFXBuffer + SectionHeader.PointerToRawData, SectionHeader.VirtualAddress,
                        SectionHeader.SizeOfRawData, Addr(Header.opt_head.DataDirectory[0]));
                    if FoundAddr = 0 then
                        Exit;
                    // Change memory offset to file offset.
                    FoundAddr := FoundAddr - SectionHeader.VirtualAddress + SectionHeader.PointerToRawData;
                    Break;
                end;
                Inc(SectionHeader, 1);
            end;
            // Save the icon data to a stream.
            IconStream := TMemoryStream.Create;
            FSFXIcon.SaveToStream(IconStream);
            // Only handle icons with this size.
            if IconStream.Size = 766 then
            begin
                // Reposition to the actual data and put it into a buffer.
                IconStream.Seek(22, soFromBeginning);
                IconStream.ReadBuffer(SFXBuffer^, 744);
                // Go to start of the icon resource in the new created file.
                FileSeek(SFXFile, FoundAddr, soFromBeginning);
                // And write the changed icon data from the buffer.
                FileWrite(SFXFile, SFXBuffer^, 744);
                Result := 0;
            end
            else
                Result := SE_IconSizeError;
        except
            Result := SE_MemStreamError;
        end;
    finally
        FreeMem(SFXBuffer);
        IconStream.Free;
        FileSeek(SFXFile, 0, soFromEnd);
    end;
end;

{ Convert an .ZIP archive to a .EXE archive. }
{ returns 0 if good, or else a negative error code -10,-11,-12 from ReplaceIcon }
{ Version 1.6x sets the new variable length SFXblock(MPV) }

function TZipMaster.ConvertSFX: Integer;
const
    SE_CreateError = -1;                { error in open of outfile }
    SE_CopyError = -2;                  { read or write error during copy }
    SE_OpenReadError = -3;              { error in open of infile }
    SE_SetDateError = -4;               { error setting date/time of outfile }
    SE_GeneralError = -9;
var
    InFile, OutFile: Integer;
    OutFileName: string;
    ZipSize, SFXSize: Integer;
    OutSize: Integer;
    j, SFXBlkSize: Integer;
    dirbuf: array[0..MAX_PATH] of Char;
    sfxblk: pChar;
    cll: Byte;
    EOC: ZipEndOfCentral;
begin
    Result := SE_GeneralError;
    SFXSize := -1;
    ZipSize := -1;
    OutSize := -1;
    FShowProgress := False;

    if (not FileExists(FZipFileName)) and (not AutoExeViaAdd) then
    begin
        ShowZipMessage(GE_NoZipSpecified, '');
        Exit;
    end;

    SFXBlkSize := 12 + Length(FSFXCaption) + Length(FSFXDefaultDir) + Length(FSFXCommandLine) + Length(FSFXMessage);
    SFXBlkSize := ((SFXBlkSize + 3) div 4) * 4; // DWord Alignment.

    { Do a simple validation to ensure that the 4 variable length text
      fields are small enough to fit inside the SFX control block. }
    if (Length(FSFXCaption) > 255) or (Length(FSFXDefaultDir) > 255) or
        (Length(FSFXCommandLine) > 255) or (Length(FSFXMessage) > 255) then
    begin
        ShowZipMessage(SF_StringToLong, #13#10 + 'SFXCaption + SFXDefaultDir + SFXCommandLine + SFXMessage = ' + IntToStr(SFXBlkSize + 1));
        Exit;
    end;

    // Try to find the SFX binary file: ZIPSFX.BIN
    // Look in the location given by the SFXPath property first.
    repeat
        if FileExists(FSFXPath) then
            Break;
        if copy(fSFXPath, 1, 1) = '.' then
        begin
            FSFXPath := ExtractFilePath(ParamStr(0)) + fSFXPath;
            if FileExists(FSFXPath) then
                Break;
        end;
        // Try the current directory.
        FSFXPath := 'ZIPSFX.BIN';
        if FileExists(FSFXPath) then
            Break;
        // Try the application directory.
        FSFXPath := ExtractFilePath(ParamStr(0)) + 'ZIPSFX.BIN';
        if FileExists(FSFXPath) then
            Break;
        // Try the Windows System dir.
        GetSystemDirectory(dirbuf, MAX_PATH);
        FSFXPath := AnsiString(dirbuf) + '\ZIPSFX.BIN';
        if FileExists(FSFXPath) then
            Break;
        // Try the Windows dir.
        GetWindowsDirectory(dirbuf, MAX_PATH);
        FSFXPath := AnsiString(dirbuf) + '\ZIPSFX.BIN';
        if FileExists(FSFXPath) then
            Break;
        // Try the dir specified in the DLLDirectory property.
        FSFXPath := FDLLDirectory + '\ZIPSFX.BIN';
        if (FDLLDirectory <> '') and FileExists(FSFXPath) then
            Break;
        ShowZipMessage(SF_NoZipSFXBin, '');
        Exit;
    until (False);

    try
        GetMem(sfxblk, SFXBlkSize + 1);
    except
        ShowZipMessage(GE_NoMem, '');
        Exit;
    end;
    StartWaitCursor;

    { Empty the special SFX parameter block }
    FillChar(sfxblk^, SFXBlkSize + 1, 0);
    sfxblk[0] := 'M';
    sfxblk[1] := 'P';
    sfxblk[2] := 'V';

    { create a packed byte with various 1 bit settings }
    cll := 0;
    if SFXAskCmdLine in FSFXOptions then
        cll := 1;                       // don't ask user if he wants to run cmd line
    if SFXAskFiles in FSFXOptions then
        cll := cll or 2;                // allow user to edit files in selection box
    if SFXHideOverWriteBox in FSFXOptions then
        cll := cll or 4;                // hide overwrite mode box at runtime
    case FSFXOverWriteMode of           // dflt = ovrConfirm
        ovrAlways: cll := cll or 8;
        ovrNever: cll := cll or 16;
    end;
    if not (SFXCheckSize in FSFXOptions) then
        cll := cll or 32;               // prevent the Self-check of SFX archive at expand time
    if SFXAutoRun in fSFXOptions then
        cll := cll or 64;               // autorun
    if SFXNoSuccessMsg in fSFXOptions then // New v1.6
        cll := cll or 128;              // Don't show success message after extraction.

    sfxblk[3] := Char(cll);
    sfxblk[5] := #1;
    sfxblk[6] := Char(LOBYTE(LOWORD(SFXBlkSize)));
    sfxblk[7] := Char(HIBYTE(LOWORD(SFXBlkSize)));

    j := Length(FSFXCaption);
    sfxblk[8] := Char(j);
    StrPCopy(sfxblk + 9, FSFXCaption);

    sfxblk[j + 9] := Char(Length(FSFXDefaultDir));
    StrPCopy(sfxblk + j + 10, FSFXDefaultDir);
    j := j + Length(FSFXDefaultDir);

    sfxblk[j + 10] := Char(Length(FSFXCommandLine));
    StrPCopy(sfxblk + j + 11, FSFXCommandLine);
    j := j + Length(FSFXCommandLine);

    sfxblk[j + 11] := Char(Length(FSFXMessage));
    StrPLCopy(sfxblk + j + 12, FSFXMessage, Length(FSFXMessage));

    if AutoExeViaAdd then
        { We're going to add SFX code to a new archive just created with
          an extension of .EXE }
        OutFileName := FZipFileName     // already ends in .exe
    else
    begin
        if UpperCase(ExtractFileExt(FZipFileName)) <> '.ZIP' then
        begin
            ShowZipMessage(SF_InputIsNoZip, '');
            FreeMem(sfxblk);
            Exit;
        end;
        OutFileName := ChangeFileExt(FZipFileName, '.exe');
    end;

    if FileExists(OutFileName) then
        EraseFile(OutFileName, FHowToDelete);
    OutFile := FileCreate(OutFileName);
    if (OutFile <> -1) then
    begin
        InFile := FileOpen(SFXPath, fmOpenRead or fmShareDenyWrite);
        if (InFile <> -1) then
        begin
            Result := CopyBuffer(InFile, OutFile, -1);
            SFXSize := FileSeek(InFile, 0, 2);
            FileClose(InFile);
            // Copy the SFX code to destination .EXE file.
            if (Result = 0) and not FSFXIcon.Empty then
                Result := ReplaceIcon(OutFile, SFXSize);
        end
        else
            Result := SE_OpenReadError;
        // Copy the special SFX block to the destination.
        if Result = 0 then
        begin
            if FileWrite(OutFile, sfxblk^, SFXBlkSize) <> SFXBlkSize then
                Result := SE_CopyError;
            if Result = 0 then
            begin
                if AutoExeViaAdd then
                begin
                    FillChar(EOC, SizeOf(EOC), 0);
                    EOC.HeaderSig := EndCentralDirSig;
                    EOC.CentralOffset := SFXSize + SFXBlkSize; // Central offset=EOC offset=end of SFX code.
                    // Copy the EOC header to the .exe file.
                    if FileWrite(OutFile, EOC, SizeOf(EOC)) <> SizeOf(EOC) then
                        Result := SE_CopyError;
                    // Let's close the file and get out - we don't
                    // have a zipfile to append in this case.
                end
                else
                begin
                    // Copy the ZIP file to the destination
                    try
                        CheckIfLastDisk(EOC, True); // Read the EOC or we get an exception.
                        FileSeek(FInFileHandle, 0, 0);
                        // If we got a warning in List() we assume it's a pre v1.5 .ZIP.
                             // (converted back from a .EXE ) and we will not change the offsets.
                        if FWrongZipStruct then
                        begin
                            Result := CopyBuffer(FInFileHandle, OutFile, -1);
                            ZipSize := FRealFileSize;
                        end
                        else
                        begin
                            // Copy until we get at the start of the central header.
                            Result := CopyBuffer(FInFileHandle, OutFile, EOC.CentralOffset);
                            if Result = 0 then // Now read all headers and change the offsets.
                                Result := RWCentralDir(OutFile, EOC, SFXSize + SFXBlkSize);
                            ZipSize := FFileSize; // Garbage is now removed if it were present.
                        end;
                    except
                        Result := SE_OpenReadError;
                    end;
                    if FInFileHandle <> -1 then
                        FileClose(FInFileHandle);
                end;
            end;
        end;
        OutSize := FileSeek(OutFile, 0, 2);
        FileClose(OutFile);
    end
    else
        Result := SE_CreateError;

    if (Result <> 0) or (AutoExeViaAdd = False) then
    begin
        // An extra check if file is ok.
        if (Result = 0) and ((SFXSize = -1) or (ZipSize = -1) or (OutSize = -1) or (OutSize <> SFXSize + ZipSize + SFXBlkSize)) then
            Result := SE_GeneralError;

        if Result = 0 then
        begin
            EraseFile(FZipFileName, FHowToDelete);
            ZipFileName := OutFileName; // The .EXE file is now the default archive andList() is invoked.
        end
        else
            DeleteFile(OutFileName);
    end;
    if Assigned(sfxblk) then
        FreeMem(sfxblk);
    StopWaitCursor;
end;

//---------------------------------------------------------------------------
// Function to copy the central header of an archive and change while copying
// the Local Header offsets and finally the Central Header offset.
// We return 0 if no error or -2 (SE_CopyError) in case something goes wrong.

function TZipMaster.RWCentralDir(OutFile: Integer; EOC: ZipEndOfCentral; OffsetChange: Integer): Integer;
var
    CEH: ZipCentralHeader;
    i: Integer;
begin
    Result := 0;
    try
        for i := 0 to (EOC.TotalEntries - 1) do
        begin
            // Read a central header (a dir entry for 1 file)
            if FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) then
                raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
            if CEH.HeaderSig <> CentralFileHeaderSig then
                raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);
            // Change the offset
            CEH.RelOffLocal := Integer(CEH.RelOffLocal) + OffsetChange;
            // Write this changed central header to disk
            if FileWrite(OutFile, CEH, SizeOf(CEH)) <> SizeOf(CEH) then
                raise EZipMaster.CreateResDisp(DS_CEHBadWrite, True);
            // And the remaining bytes of the central header for this file
            if CopyBuffer(FInFileHandle, OutFile, CEH.FileNameLen + CEH.ExtraLen + CEH.FileComLen) <> 0 then
                raise EZipMaster.CreateResDisp(DS_CEHBadCopy, True);
        end;

        // Skip the EOC record (we already have read it.)
        if FileSeek(FInFileHandle, SizeOf(EOC), 1) = -1 then
            raise EZipMaster.CreateResDisp(DS_EOCBadSeek, True);
        // Write the changed EndOfCentral directory record.
        EOC.CentralOffset := Integer(EOC.CentralOffset) + OffsetChange;
        if FileWrite(OutFile, EOC, SizeOf(EOC)) <> SizeOf(EOC) then
            raise EZipMaster.CreateResDisp(DS_EOCBadWrite, True);
        // And finally the archive comment
        if CopyBuffer(FInFileHandle, OutFile, EOC.ZipCommentLen) <> 0 then
            raise EZipMaster.CreateResDisp(DS_EOCBadCopy, True);
    except
        //ShowZipMessage( 0, 'Exception in RWCentralDir' );
        Result := -2;
    end;
end;

{ Convert an .EXE archive to a .ZIP archive. }
{ returns 0 if good, or else a negative error code }

function TZipMaster.ConvertZIP: Integer;
const
    SE_CreateError = -1;                { error in open of outfile }
    SE_CopyError = -2;                  { read or write error during copy }
    SE_OpenReadError = -3;              { error in open of infile }
    SE_GeneralError = -9;
    SE_OutOfMemError = -10;
var
    OutFileName: string;
    OutFile, InSize, OutSize: Integer;
    i, SFXBlkSize: Integer;
    EOC: ZipEndOfCentral;
    cll: Byte;
    sfxblk, sfxstr: pChar;
    IconHandle: HICON;
begin
    InSize := -1;
    OutSize := -1;
    sfxblk := nil;
    Result := SE_GeneralError;
    FShowProgress := False;

    if not FileExists(FZipFileName) then
    begin
        ShowZipMessage(CZ_NoExeSpecified, '');
        Result := SE_OpenReadError;
        Exit;
    end;

    if UpperCase(ExtractFileExt(FZipFileName)) <> '.EXE' then
    begin
        ShowZipMessage(CZ_InputNotExe, '');
        Result := SE_OpenReadError;
        Exit;
    end;

    // The FSFXOffset is the location where the zip file starts inside
    // the .EXE archive.  It is calculated during a ZipMaster List operation.
    // Since a LIST is done when a filename is assigned, we know that
    // a LIST has already been done on the correct archive.
    // Note: FSFXOffset = SFXSize + 256(or variable)
    if FSFXOffset = 0 then
    begin
        ShowZipMessage(CZ_SFXTypeUnknown, '');
        Exit;
    end;

    // Create the destination.
    StartWaitCursor;
    Result := SE_CopyError;
    OutFileName := ChangeFileExt(FZipFileName, '.zip');

    if FileExists(OutFileName) then
        EraseFile(OutFileName, FHowToDelete);
    OutFile := FileCreate(OutFileName);
    if (OutFile <> -1) then
    begin
        try
            SFXBlkSize := 1032;
            if FSFXOffset < 1032 then
                SFXBlkSize := FSFXOffset;
            GetMem(sfxblk, SFXBlkSize);
            CheckIfLastDisk(EOC, True); // Read the EOC record or we get an exception.
            // Step over SFX code at the begin of the .EXE file
                // and read the SFX MPU or MPV block.
            if (FileSeek(FInFileHandle, FSFXOffset - SFXBlkSize, 0) <> -1) and (FileRead(FInFileHandle, sfxblk^, SFXBlkSize) = SFXBlkSize) then
            begin
                // Find the start of the MPV or MPU block.
                for i := 0 to SFXBlkSize - 3 do
                begin
                    if (sfxblk[i] = 'M') and (sfxblk[i + 1] = 'P') and ((sfxblk[i + 2] = 'U') or (sfxblk[i + 2] = 'V')) then
                    begin
                        // Read the 'custom' icon back from the executable.
                        IconHandle := ExtractIcon(HInstance, pChar(FZipFileName), 0);
                        if (IconHandle <> 0) and (Integer(IconHandle) <> 1) then
                        begin
                            if SFXIcon.Handle <> 0 then
                                SFXIcon.ReleaseHandle();
                            SFXIcon.Handle := IconHandle;
                        end;
                        // Read back the original values from the MPU block.
                        FSFXOptions := [];
                        FSFXOverWriteMode := OvrConfirm;
                        cll := Byte(sfxblk[i + 3]);
                        if (cll and 1) > 0 then
                            FSFXOptions := FSFXOptions + [SFXAskCmdLine];
                        if (cll and 2) > 0 then
                            FSFXOptions := FSFXOptions + [SFXAskFiles];
                        if (cll and 4) > 0 then
                            FSFXOptions := FSFXOptions + [SFXHideOverWriteBox];
                        if (cll and 8) > 0 then
                            FSFXOverWriteMode := OvrAlways;
                        if (cll and 16) > 0 then
                            FSFXOverWriteMode := OvrNever;
                        if not (cll and 32 > 0) then
                            FSFXOptions := FSFXOptions + [SFXCheckSize];
                        if (cll and 64) > 0 then
                            FSFXOptions := FSFXOptions + [SFXAutoRun];
                        if sfxblk[i + 2] = 'U' then
                        begin
                            SetString(FSFXCaption, sfxblk + i + 7, Integer(sfxblk[i + 4]));
                            SetString(FSFXDefaultDir, sfxblk + i + Integer(sfxblk[i + 4]) + 7, Integer(sfxblk[i + 5]));
                            SetString(FSFXCommandLine, sfxblk + i + Integer(sfxblk[i + 4]) + Integer(sfxblk[i + 5]) + 7, Integer(sfxblk[i + 6]));
                        end
                        else
                        begin
                            if (cll and 128) > 0 then
                                FSFXOptions := FSFXOptions + [SFXNoSuccessMsg];
                            sfxstr := sfxblk + i + 8;
                            SetString(FSFXCaption, sfxstr + 1, Integer(sfxstr[0]));
                            sfxstr := sfxstr + Integer(sfxstr[0]) + 1;
                            SetString(FSFXDefaultDir, sfxstr + 1, Integer(sfxstr[0]));
                            sfxstr := sfxstr + Integer(sfxstr[0]) + 1;
                            SetString(FSFXCommandLine, sfxstr + 1, Integer(sfxstr[0]));
                            sfxstr := sfxstr + Integer(sfxstr[0]) + 1;
                            SetString(FSFXMessage, sfxstr + 1, Integer(sfxstr[0]));
                        end;
                        Break;
                    end;
                end;
                // If we got a warning in List() we assume it's a pre v1.5 .EXE.
                // and we will not change the offsets.
                if FWrongZipStruct = True then
                begin
                    Result := CopyBuffer(FInFileHandle, OutFile, -1);
                    InSize := FRealFileSize;
                end
                else
                begin
                    // Copy until the start of the first Central header.
                    Result := CopyBuffer(FInFileHandle, OutFile, EOC.CentralOffset - Longword(FSFXOffset));
                    if Result = 0 then  // Now read all headers and change the offsets.
                        Result := RWCentralDir(OutFile, EOC, -FSFXOffset);
                    InSize := FFileSize;
                end;
            end;
        except
            on EOutOfMemory do
                Result := SE_OutOfMemError;
        else
            Result := SE_OpenReadError;
        end;
        if FInFileHandle <> -1 then
            FileClose(FInFileHandle);
        OutSize := FileSeek(OutFile, 0, 2);
        FileClose(OutFile);
    end
    else
        Result := SE_CreateError;

    if (Result = 0) and ((InSize = -1) or (OutSize = -1) or (OutSize <> InSize - FSFXOffset)) then
        Result := SE_GeneralError;

    if Result = 0 then
    begin
        EraseFile(FZipFileName, FHowToDelete);
        ZipFileName := OutFileName;     // The .ZIP file is now the default archive and invoke List().
    end
    else
        DeleteFile(OutFileName);

    if Assigned(sfxblk) then
        FreeMem(sfxblk);
    StopWaitCursor;
end;

{* Return value:
 0 = The specified file is not a SFX
 1 = It is one
 -7  = Open, read or seek error
 -8  = memory error
 -9  = exception error
 -10 = all other exceptions
*}

function TZipMaster.IsZipSFX(const SFXExeName: string): Integer;
var
    EOC: ZipEndOfCentral;
    n, Size, BufPos: LongWord;
    CentralSig: LongWord;
    ZipBuf: pChar;
    br: DWord;
    fh: THandle;
    i: Char;
begin
    Result := 0;
    BufPos := 0;
    fh := 0;
    ZipBuf := nil;

    StartWaitCursor();
    if FJumpValue[#0] = 0 then
    begin
        for i := #0 to #255 do
            FJumpValue[i] := 4;
        FJumpValue['P'] := 3;
        FJumpValue['K'] := 2;
        FJumpValue[#5] := 1;
        FJumpValue[#6] := 0;
    end;
    try
        // Open the input archive, presumably the last disk.
        fh := CreateFile(pChar(SFXExeName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
        if fh = INVALID_HANDLE_VALUE then
            raise EZipMaster.CreateResDisp(DS_NoInFile, True);

        repeat
            if IsInstallShield(fh) then
                Break;

            // A test for a zip archive without a ZipComment.
            FFileSize := Integer(SetFilePointer(fh, -SizeOf(EOC), nil, FILE_END));
            if DWord(FFileSize) <> $FFFFFFFF then
            begin
                Inc(FFileSize, SizeOf(EOC)); // Save the archive size as a side effect.
                ReadFile(fh, EOC, sizeof(EOC), br, nil);
                if (br = SizeOf(EOC)) and (EOC.HeaderSig = EndCentralDirSig) then
                begin
                    Result := 1;
                    Break;
                end;
            end;
            if FFileSize < LongInt(65535 + SizeOf(EOC)) then
                Size := FFileSize
            else
                Size := LongInt(65535 + SizeOf(EOC));
            GetMem(ZipBuf, Size + 1);
            if SetFilePointer(fh, (0 - Size), nil, FILE_END) = $FFFFFFFF then
                raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
            ReadFile(fh, ZipBuf^, Size, br, nil);
            if br <> Size then
                raise EZipMaster.CreateResDisp(DS_EOCBadRead, True);

            // Finally try to find the EOC record within the last 65K...
            while BufPos < Size do
            begin
                n := FJumpValue[(ZipBuf + BufPos)^];
                if n = 0 then           // a '6' found at least...
                begin
                    if ((ZipBuf + BufPos - 3)^ = 'P') and ((ZipBuf + BufPos - 2)^ = 'K') and ((ZipBuf + BufPos - 1)^ = #5) and (BufPos + SizeOf(EOC) - 4 < Size) then
                    begin
                        Move((ZipBuf + BufPos - 3)^, EOC, SizeOf(EOC));
                        if (SetFilePointer(fh, EOC.CentralOffset, nil, FILE_BEGIN) <> $FFFFFFFF) and
                            (ReadFile(fh, CentralSig, 4, br, nil)) and (CentralSig = CentralFileHeaderSig) then
                        begin
                            Result := 1;
                            Break;
                        end
                        else
                            Inc(BufPos, 4);
                    end
                    else
                        Inc(BufPos, 4);
                end
                else
                    Inc(BufPos, n);
            end;
            Break;
        until False;
    except
        on ers: EZipMaster do           // All IsZipSFX specific errors.
        begin
            ShowExceptionError(ers);
            Result := -7;
        end;
        on EOutOfMemory do              // All memory allocation errors.
        begin
            ShowZipMessage(GE_NoMem, '');
            Result := -8;
        end;
        on E: Exception do
        begin
            ShowZipMessage(DS_ErrorUnknown, E.Message);
            Result := -9;
        end;
    else                                // The remaining errors, should not occur.
        ShowZipMessage(DS_ErrorUnknown, '');
        Result := -10;
    end;

    FreeMem(ZipBuf);
    CloseHandle(fh);
    StopWaitCursor();
end;

function TZipMaster.IsInstallShield(const fh: THandle): Boolean;
var
    buf: pChar;
    br, i: DWORD;
begin
    Result := False;
    buf := nil;

    try
        GetMem(buf, 2049);
        ReadFile(fh, buf^, 2048, br, nil);

        // Make zero terminated string by eliminating zeros
        // and setting last byte to zero
        for i := 0 to br - 1 do
            if (buf + i)^ = #0 then
                (buf + i)^ := ' ';
        (buf + br)^ := #0;
        if AnsiStrPos(buf, 'InstallShield Self-Extracting Stub program') <> nil then
            Result := True
    except
    end;
    FreeMem(buf);
end;

{$ENDIF}

procedure Register;
begin
    RegisterComponents('Delphi Zip', [TZipMaster]);
end;
end.

