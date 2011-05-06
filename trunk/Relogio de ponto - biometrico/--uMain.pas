unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, uDBClass, funcSQL,
  ExtDlgs, ComCtrls, syncObjs, OleCtrls, GrFingerXLib_TLB, funcoes,
  TFlatButtonUnit, Buttons;

type
  TformMain = class(TForm)
    memoLog: TMemo;
    MainMenu: TMainMenu;
    mnImage: TMenuItem;
    mnOptions: TMenuItem;
    mnImageSave: TMenuItem;
    mnImageLoad: TMenuItem;
    btEnroll: TButton;
    btVerify: TButton;
    btIdentify: TButton;
    btClearDB: TButton;
    btClearLog: TButton;
    ckBoxAutoIdentify: TCheckBox;
    Bevel1: TBevel;
    image: TImage;
    OpenPictureDialog: TOpenPictureDialog;
    SavePictureDialog: TSavePictureDialog;
    ckAutoExtract: TCheckBox;
    btExtract: TButton;
    mnVersion: TMenuItem;
    grFinger: TGrFingerXCtrl;
    RadioGroup1: TRadioGroup;
    cbEmpregados: TComboBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lbEsq: TLabel;
    lbDir: TLabel;
    BitBtn1: TBitBtn;
    Edit2: TEdit;
    btDelete: TButton;
    procedure mnOptionsClick(Sender: TObject);
    procedure btClearDBClick(Sender: TObject);
    procedure btEnrollClick(Sender: TObject);
    procedure btVerifyClick(Sender: TObject);
    procedure btIdentifyClick(Sender: TObject);
    procedure btClearLogClick(Sender: TObject);
    procedure mnImageLoadClick(Sender: TObject);
    procedure mnImageSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btExtractClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnVersionClick(Sender: TObject);
    procedure grFingerSensorPlug(Sender: TObject;
      const idSensor: WideString);
    procedure grFingerSensorUnplug(Sender: TObject;
      const idSensor: WideString);
    procedure grFingerFingerDown(Sender: TObject;
      const idSensor: WideString);
    procedure grFingerFingerUp(Sender: TObject;
      const idSensor: WideString);
    procedure grFingerImageAcquired(Sender: TObject;
      const idSensor: WideString; width, height: Integer;
      var rawImage: OleVariant; res: Integer);
    procedure FormActivate(Sender: TObject);
    procedure CarregaNome(sender: Tobject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    function carregaCbox(edit3:string):integer;
    procedure btDeleteClick(Sender: TObject);
  private
  public
  end;
const
//   PATH = ;
   TITULO = 'Utilitário para editar batidas e arquivos';
//   ARQEMPREGADOS: String = PATH + 'cadastros.cfg';
   HOR_EMPREGADOS: STRING='C:\batidas\cadastros.new' ;
   VERSAO ='2.15';
var
  formMain: TformMain;
  PATH,ARQEMPREGADOS:STRING;
implementation

uses uOptions, uUtil;
{$R *.dfm}

function TformMain.carregaCbox(edit3:string):integer;
var
  i,j:integer;
begin
{   j := -1 ;
   for i:=0 to formMain.CBox1.Items.count do
      if pos(edit3,formMain.CBox1.Items[i]) > 0 then
         j:=i;

   if j = -1 then
     writelog(edit2.text +'  Nao Cadastrado !!!!!!' );
   carregaCbox := j;
}
end;


// Application startup code
procedure TformMain.FormCreate(Sender: TObject);
var
  ret: Integer;
begin
  // Initialize GrFingerX Activex
  ret := InitializeGrFinger(grFinger);
  // Print result in log
  if ret < 0 then
    WriteError(ret)
  else
    WriteLog('**GrFingerX Initialized Successfull**');

   PATH := ExtractFilePath(ParamStr(0));
   ARQEMPREGADOS := PATH +'cadastros.cfg';
end;

// Application finalization code
procedure TformMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // finalize GrFingerX
  FinalizeGrFinger();
end;

// Add a fingerprint to database
procedure TformMain.btEnrollClick(Sender: TObject);
var
  id: Integer;
  erro:string;
begin
   erro := '';

   if radiogroup1.ItemIndex = 0 then
   begin
      if lbdir.Caption = 'Ok' then
         erro := ' - O lado direito já é cadastrado' + #13
   end
   else
   begin
      if lbEsq.Caption = 'Ok' then
         erro := ' - O lado esquerdo já é cadastrado' + #13
   end;

   if cbox1.ItemIndex < 1 then
      erro := ' - Escolha um funcionário para cadastrar. ' + #13;

   if ExtractTemplate() < GR_MEDIUM_QUALITY then
      erro := ' - A digital capturada está com qualidade baixa, capture a digital de novo. ' + #13;

   if erro = '' then
   begin
      if radiogroup1.ItemIndex = 0 then
         id := uUtil.Enroll( copy(cbox1.Items[cbox1.itemIndex],35,08) , 'D', copy(cbox1.Items[cbox1.itemIndex], 01,30) )
      else
         id := uUtil.Enroll( copy(cbox1.Items[cbox1.itemIndex],35,08) , 'E',  copy(cbox1.Items[cbox1.itemIndex],01,30) );

      if id >= 0 then
         WriteLog('Digital Gravada, para ponto ' + funcoes.preencheCampo(08,'0','e',IntToStr(id)))
      else
          WriteLog('Erro a digital não foi gravada. ');
  end
  else
  begin
     erro := ' Atenção ' + #13+#13 + erro ;
     msgTela( formMain.Caption, erro , MB_ICONERROR + MB_OK);
  end;
   BitBtn1Click(Sender);
end;

// Identify a fingerprint
procedure TformMain.btIdentifyClick(Sender: TObject);
var
  ret, score: Integer;
begin
  WriteLog( funcoes.preencheCampo(50,'- ','e','-') );

  score := 0;
  // identify it
  ret := Identify(score);
  // write result to log
  if ret > 0 then
  begin
    WriteLog('Digital cadastrada pertence a matricula = '+ funcoes.preencheCampo(8,'0','e',IntToStr(ret) ) +'.         ( Score = '+         IntToStr(score)+' )');
    PrintBiometricDisplay(image, grFinger, true, GR_DEFAULT_CONTEXT);
  end
  else if ret = 0 then
    WriteLog('Digital não encontrada.')
  else
    WriteError(ret);

  WriteLog( funcoes.preencheCampo(50,'- ','e','- ') );
end;


// Check a fingerprint
procedure TformMain.btVerifyClick(Sender: TObject);
var
  id, score: Integer;
  ret: Integer;
begin
  writelog(datetimeToStr(now));
  // ask target fingerprint ID
  score := 0;
  id := StrToIntDef(InputBox('Enter the ID to verify', 'Verify',''), -1);
  if id >= 0 then
  begin
    // compare fingerprints
    ret := Verify(id, score);
    // write result to log
    if ret < 0 then
      WriteError(ret);
    if ret = GR_NOT_MATCH then
      WriteLog('Did not match with score = ' + IntToStr(score));
    if ret = GR_MATCH then
    begin
      WriteLog('Matched with score = ' + IntToStr(score));
      // if they match, display matching minutiae/segments/directions
      PrintBiometricDisplay(image, grFinger, true, GR_DEFAULT_CONTEXT);
    end;
  end;
  writelog(datetimeToStr(now));
end;

// Extract a template from a fingerprint image
procedure TformMain.btExtractClick(Sender: TObject);
var
  ret: Integer;
begin
  // extract template
  ret := ExtractTemplate();
  // write template quality to log
  if (ret = GR_BAD_QUALITY)
    then writeLog('Imagem extraída, baixa qualidade.')
  else if (ret = GR_MEDIUM_QUALITY)
    then writeLog('Imagem extraída, média qualidade.')
  else if (ret = GR_HIGH_QUALITY)
    then writeLog('Imagem extraída, boa qualidade..');
  if ret >= 1 then
  begin
    // if no error, display minutiae/segments/directions into the image
    PrintBiometricDisplay(image, grFinger, true, GR_NO_CONTEXT);
    // enable operations we can do over extracted template
    BtExtract.Enabled := false;
    btEnroll.Enabled := true;
    btIdentify.Enabled := true;
    btVerify.Enabled := true;
  end
  else
  begin  // write error to log
      WriteError(ret);
      writeLog('Nao consegui capturar a imagem, erro: '+ inttostr(ret) );
  end;
end;

// Clear database
procedure TformMain.btClearDBClick(Sender: TObject);
begin
  // clear database
//  DB.clearDB();
  // write result to log
  WriteLog('Database is clear...');
end;

// Clear log
procedure TformMain.btClearLogClick(Sender: TObject);
begin
  memoLog.Lines.Clear();
end;

procedure TformMain.mnImageSaveClick(Sender: TObject);
begin
end;

// Load a fingerprint image from a file
procedure TformMain.mnImageLoadClick(Sender: TObject);
begin
end;

// Open "Options" window
procedure TformMain.mnOptionsClick(Sender: TObject);
var
  minutiaeColor: Integer;
  minutiaeMatchColor: Integer;
  segmentsColor: Integer;
  segmentsMatchColor: Integer;
  directionsColor: Integer;
  directionsMatchColor: Integer;
  thresholdId : Integer;
  rotationMaxId: Integer;
  thresholdVr : Integer;
  rotationMaxVr: Integer;
  ok: boolean;
  ret: integer;
begin

  while true do begin
        // get current identification/verification parameters
        grFinger.GetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
        grFinger.GetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
        // set current identification/verification parameters on options form
        formOptions.setParameters(thresholdId, rotationMaxId, thresholdVr, rotationMaxVr);

        ok := true;
        // show form with match, display and colors options
        // and get new parameters
        if not formOptions.getParameters(thresholdId, rotationMaxId, thresholdVr, rotationMaxVr,
                minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor) then exit;
        if ((thresholdId < GR_MIN_THRESHOLD) or
         (thresholdId > GR_MAX_THRESHOLD) or
         (rotationMaxId < GR_ROT_MIN) or
         (rotationMaxId > GR_ROT_MAX)) then begin
            ShowMessage('Invalid identify parameters values!');
            ok := false;
        end;
        if ((thresholdVr < GR_MIN_THRESHOLD) or
         (thresholdVr > GR_MAX_THRESHOLD) or
         (rotationMaxVr < GR_ROT_MIN) or
         (rotationMaxVr > GR_ROT_MAX)) then begin
            showmessage ('Invalid verify parameters values!');
            ok := false;
        end;
        // set new identification parameters
        if ok then begin
          ret := grFinger.SetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
          // error?
          if ret = GR_DEFAULT_USED then begin
            showmessage('Invalid identify parameters values. Default values will be used.');
            ok := false;
          end;
          // set the verification parameters
          ret := grFinger.SetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
          // error?
          if ret = GR_DEFAULT_USED then begin
            showmessage('Invalid verify parameters values. Default values will be used.');
            ok := false;
          end;
          // if everything ok
          if ok then begin
            // accept the parameters
            formOptions.AcceptChanges();
            // set the colors
            grFinger.SetBiometricDisplayColors(minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor);
            Exit;
          end;
        end;
  end;
end;

// Display GrFinger version
procedure TformMain.mnVersionClick(Sender: TObject);
begin
  MessageVersion();
end;

// -----------------------------------------------------------------------------------
// GrFingerX events
// -----------------------------------------------------------------------------------

// A fingerprint reader was plugged on system
procedure TformMain.grFingerSensorPlug(Sender: TObject;
  const idSensor: WideString);
begin
  writeLog ('Sensor: ' + idSensor + '. Event: Plugged.');
  grFinger.CapStartCapture (idSensor);
end;

// A fingerprint reader was unplugged on system
procedure TformMain.grFingerSensorUnplug(Sender: TObject;
  const idSensor: WideString);
begin
    writeLog ('Sensor: ' + idSensor + '. Event: Unplugged.');
    grFinger.CapStopCapture (idSensor);
end;

// A finger was placed on reader
procedure TformMain.grFingerFingerDown(Sender: TObject;
  const idSensor: WideString);
begin
//--    writeLog ('Sensor: ' + idSensor + '. Event: Finger Placed.');
end;

// A finger was removed from reader
procedure TformMain.grFingerFingerUp(Sender: TObject;
  const idSensor: WideString);
begin
//    writeLog ('Sensor: ' + idSensor + '. Event: Finger removed.');
end;


procedure TformMain.grFingerImageAcquired(Sender: TObject; const idSensor: WideString; width, height: Integer;  var rawImage: OleVariant; res: Integer);
begin
  // Copying aquired image
  raw.height := height;
  raw.width := width;
  raw.res := res;
  raw.img := rawImage;

  // Signaling that an Image Event occurred.
  writeLog (idSensor + 'Imgagem capturada. -> ');

  // display fingerprint image
  PrintBiometricDisplay(image, grFinger, false, GR_DEFAULT_CONTEXT);

  // now we have a fingerprint, so we can extract template
  btEnroll.Enabled := false;
  btExtract.Enabled := true;
  btIdentify.Enabled := false;
  btVerify.Enabled := false;

  // Extracting template from image.
  if formMain.ckAutoExtract.Checked then
  Begin
      formMain.btExtractClick(nil);

      // identify fingerprint
      if formMain.ckBoxAutoIdentify.Checked then
        formMain.btIdentifyClick(nil);
  End
  else
    formMain.btExtract.Enabled := true;
end;

procedure TformMain.FormActivate(Sender: TObject);
begin
  CarregaNome(nil);
  WriteLog('iniciando...');
  sleep(000);
  try
     DB.getTemplates();
     WriteLog('Abrindo a tabela das digitais...');
  except
     showMessage('Não Foi possivel establelecer conexão com o banco de dados');
  end;
end;

procedure TformMain.CarregaNome(sender: Tobject);
begin
   cbEmpregados := uUtil


end;
procedure TformMain.BitBtn1Click(Sender: TObject);
var
  ret:string;
begin
   if CBox1.ItemIndex > -1 then
   begin
      ret := uutil.VerificaCadastro(copy(cbox1.Items[cbox1.itemIndex],35,08));

      if copy(ret,02,01) = '1' then
         lbEsq.Caption := 'Ok'
      else
         lbEsq.Caption := 'Não cadastrado';

      if copy(ret,01,01) = '1' then
         lbDir.Caption := 'Ok'
      else
         lbDir.Caption := 'Não cadastrado';
    end;

    if (lbdir.Caption  = 'Ok') or (lbesq.Caption  = 'Ok') then
       btDelete.Enabled := true
    else
       btDelete.Enabled := false;
end;


procedure TformMain.Edit2Change(Sender: TObject);
begin
  cbox1.itemindex := carregaCbox(edit2.Text);
end;

procedure TformMain.btDeleteClick(Sender: TObject);
var
   lado:string;
begin
   if RadioGroup1.ItemIndex = 0 then
   lado := 'D'
   else
   lado := 'E';

      uUtil.apagaDigital(      copy(cbox1.Items[cbox1.itemIndex],35,08),lado );
end;

end.
