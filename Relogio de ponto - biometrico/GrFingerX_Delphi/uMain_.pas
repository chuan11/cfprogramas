{
 -------------------------------------------------------------------------------
 GrFinger Sample
 (c) 2005-2010 Griaule Biometrics Ltda.
 http://www.griaulebiometrics.com
 -------------------------------------------------------------------------------

 This sample is provided with "GrFinger Fingerprint Recognition Library" and
 can't run without it. It's provided just as an example of using GrFinger
 Fingerprint Recognition Library and should not be used as basis for any
 commercial product.

 Griaule Biometrics makes no representations concerning either the merchantability
 of this software or the suitability of this sample for any particular purpose.

 THIS SAMPLE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL GRIAULE BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 You can download the trial version of GrFinger directly from Griaule website.
                                                                   
 These notices must be retained in any copies of any part of this
 documentation and/or sample.

 -------------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------------
// GUI routines: main form
// -----------------------------------------------------------------------------------

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, uDBClass,
  ExtDlgs, ComCtrls, syncObjs, OleCtrls, GrFingerXLib_TLB;

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
    GrFingerXCtrl1: TGrFingerXCtrl;
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
    procedure GrFingerXCtrl1SensorPlug(Sender: TObject;
      const idSensor: WideString);
    procedure GrFingerXCtrl1SensorUnplug(Sender: TObject;
      const idSensor: WideString);
    procedure GrFingerXCtrl1FingerDown(Sender: TObject;
      const idSensor: WideString);
    procedure GrFingerXCtrl1FingerUp(Sender: TObject;
      const idSensor: WideString);
    procedure GrFingerXCtrl1ImageAcquired(Sender: TObject;
      const idSensor: WideString; width, height: Integer;
      var rawImage: OleVariant; res: Integer);
  private
  public
  end;

var
  formMain: TformMain;

implementation

uses uOptions, uUtil;
{$R *.dfm}

// Application startup code
procedure TformMain.FormCreate(Sender: TObject);
var
  ret: Integer;
begin
  // Initialize GrFingerX Activex
  ret := InitializeGrFinger();
  // Print result in log
  if ret < 0 then
    WriteError(ret)
  else
    WriteLog('**GrFingerX Initialized Successfull**');
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
begin
  // add fingerprint
  id := Enroll();
  if id >= 0 then
    WriteLog('Fingerprint enrolled with id = ' + IntToStr(id))
  else
    WriteLog('Error: Fingerprint not enrolled');
end;

// Identify a fingerprint
procedure TformMain.btIdentifyClick(Sender: TObject);
var
  ret, score: Integer;
begin
  score := 0;
  // identify it
  ret := Identify(score);
  // write result to log
  if ret > 0 then
  begin
    WriteLog('Fingerprint identified. ID = '+IntToStr(ret)+'. Score = '+
             IntToStr(score)+'.');
    PrintBiometricDisplay(true, GR_DEFAULT_CONTEXT);
  end
  else if ret = 0 then
    WriteLog('Fingerprint not Found.')
  else
    WriteError(ret);
end;

// Check a fingerprint
procedure TformMain.btVerifyClick(Sender: TObject);
var
  id, score: Integer;
  ret: Integer;
begin
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
      PrintBiometricDisplay(true, GR_DEFAULT_CONTEXT);
    end;
  end;
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
    then writeLog('Template extracted successfully. Bad quality.')
  else if (ret = GR_MEDIUM_QUALITY)
    then writeLog('Template extracted successfully. Medium quality.')
  else if (ret = GR_HIGH_QUALITY)
    then writeLog('Template extracted successfully. High quality.');
  if ret >= 0 then
  begin
    // if no error, display minutiae/segments/directions into the image
    PrintBiometricDisplay(true, GR_NO_CONTEXT);
    // enable operations we can do over extracted template
    BtExtract.Enabled := false;
    btEnroll.Enabled := true;
    btIdentify.Enabled := true;
    btVerify.Enabled := true;
  end
  else
    // write error to log
    WriteError(ret);
end;

// Clear database
procedure TformMain.btClearDBClick(Sender: TObject);
begin
  // clear database
  DB.clearDB();
  // write result to log
  WriteLog('Database is clear...');
end;

// Clear log
procedure TformMain.btClearLogClick(Sender: TObject);
begin
  memoLog.Lines.Clear();
end;

procedure TformMain.mnImageSaveClick(Sender: TObject);
var fname: string;
begin
  // we need an image
  if (VarIsClear(raw.img)) then begin
    ShowMessage('There is no image to save.');
    exit;
  end;

  // open "save" dialog
  SavePictureDialog.FileName := '';
  SavePictureDialog.Filter := 'BMP files (*.bmp)|*.bmp|All files (*.*)|*.*';
  SavePictureDialog.FilterIndex := 1;

  // Save image.
  if(SavePictureDialog.Execute() = true) then
  begin
    fname := SavePictureDialog.FileName;
    if pos('.BMP', UpperCase(fname)) = 0 then fname := fname + '.bmp';
    if GrFingerXCtrl1.CapSaveRawImageToFile(raw.img, raw.width, raw.Height,
                               fname,
                               GRCAP_IMAGE_FORMAT_BMP) <> GR_OK then
    WriteLog('Fail to save the file.');
  end;
end;

// Load a fingerprint image from a file
procedure TformMain.mnImageLoadClick(Sender: TObject);
Var
  resolution: Integer;
  res: String;
begin
  // open "load" dialog
  OpenPictureDialog.FileName := '';
  OpenPictureDialog.Filter := 'BMP files (*.bmp)|*.bmp|All files (*.*)|*.*';
  OpenPictureDialog.FilterIndex := 1;

  // load image
  if(OpenPictureDialog.Execute() = true) then begin
    // Getting image resolution.
    res := InputBox('What is the image resolution?', 'Resolution', '');
    if(StrComp(PChar(res),'') <> 0) then
    begin
      resolution := StrToInt(res);
      // Checking if the action was canceled, no value or an invalid value was entered.
      if (resolution <> 0) then begin
          if GrFingerXCtrl1.CapLoadImageFromFile(OpenPictureDialog.FileName, resolution) <> GR_OK then
              WriteLog('Fail to load the file.');
      end;
    end;
  end;
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
        GrFingerXCtrl1.GetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
        GrFingerXCtrl1.GetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
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
          ret := GrFingerXCtrl1.SetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
          // error?
          if ret = GR_DEFAULT_USED then begin
            showmessage('Invalid identify parameters values. Default values will be used.');
            ok := false;
          end;
          // set the verification parameters
          ret := GrFingerXCtrl1.SetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
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
            GrFingerXCtrl1.SetBiometricDisplayColors(minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor);
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
procedure TformMain.GrFingerXCtrl1SensorPlug(Sender: TObject;
  const idSensor: WideString);
begin
  writeLog ('Sensor: ' + idSensor + '. Event: Plugged.');
  GrFingerXCtrl1.CapStartCapture (idSensor);
end;

// A fingerprint reader was unplugged on system
procedure TformMain.GrFingerXCtrl1SensorUnplug(Sender: TObject;
  const idSensor: WideString);
begin
    writeLog ('Sensor: ' + idSensor + '. Event: Unplugged.');
    GrFingerXCtrl1.CapStopCapture (idSensor);
end;

// A finger was placed on reader
procedure TformMain.GrFingerXCtrl1FingerDown(Sender: TObject;
  const idSensor: WideString);
begin
    writeLog ('Sensor: ' + idSensor + '. Event: Finger Placed.');
end;

// A finger was removed from reader
procedure TformMain.GrFingerXCtrl1FingerUp(Sender: TObject;
  const idSensor: WideString);
begin
    writeLog ('Sensor: ' + idSensor + '. Event: Finger removed.');
end;


procedure TformMain.GrFingerXCtrl1ImageAcquired(Sender: TObject;
  const idSensor: WideString; width, height: Integer;
  var rawImage: OleVariant; res: Integer);
begin
  // Copying aquired image
  raw.height := height;
  raw.width := width;
  raw.res := res;
  raw.img := rawImage;

  // Signaling that an Image Event occurred.
  writeLog ('Sensor: ' + idSensor + '. Event: Image captured.');

  // display fingerprint image
  PrintBiometricDisplay(false, GR_DEFAULT_CONTEXT);

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

end.
