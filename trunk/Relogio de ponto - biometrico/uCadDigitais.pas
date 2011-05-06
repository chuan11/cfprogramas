unit uCadDigitais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OleCtrls, GrFingerXLib_TLB;

type
  TfmCadDigitais = class(TForm)
    Image1: TImage;
    Bevel2: TBevel;
    grFinger: TGrFingerXCtrl;
    procedure FormCreate(Sender: TObject);
    procedure grFingerImageAcquired(ASender: TObject;
      const idSensor: WideString; width, height: Integer;
      var rawImage: OleVariant; res: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grFingerSensorPlug(ASender: TObject;
      const idSensor: WideString);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCadDigitais: TfmCadDigitais;

implementation

uses RelogioPonto, uUtil;

{$R *.dfm}

procedure TfmCadDigitais.FormCreate(Sender: TObject);
begin
//   fmMain.Hide();
   if (PERFIL = '1') then
   begin
      fmMain.GrFingerXCtrl1.Finalize();
      uUtil.FinalizeGrFinger();
   end;

   uUtil.InitializeGrFinger(grFinger);


end;

procedure TfmCadDigitais.grFingerImageAcquired(ASender: TObject; const idSensor: WideString; width, height: Integer;  var rawImage: OleVariant; res: Integer);
begin
   raw.height := height;
   raw.width := width;
   raw.res := res;
   raw.img := rawImage;

  // display fingerprint image
   begin
      uUtil.PrintBiometricDisplay(Image1, grFinger, false, GR_DEFAULT_CONTEXT);
      uUtil.ExtractTemplate();
  //    uUtil.PrintBiometricDisplay(Image1, grFinger, true, GR_MEDIUM_QUALITY);
//     image1.reFresh;
      sleep(300);
   end;
end;

procedure TfmCadDigitais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   fmMain.Show();
end;

procedure TfmCadDigitais.grFingerSensorPlug(ASender: TObject;
  const idSensor: WideString);
begin
   grFinger.CapStartCapture (idSensor);
end;

end.
