unit unAjusteNumeracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, adLabelComboBox, TFlatButtonUnit,
  ExtCtrls, fCtrls, adLabelNumericEdit, adLabelSpinEdit;

type
  TfmAjustaNumNF = class(TForm)
    GroupBox1: TGroupBox;
    cbLoja: TadLabelComboBox;
    adLabelComboBox1: TadLabelComboBox;
    edSerie: TadLabelEdit;
    adLabelSpinEdit1: TadLabelSpinEdit;
    adLabelSpinEdit2: TadLabelSpinEdit;
    GroupBox2: TGroupBox;
    adLabelSpinEdit4: TadLabelSpinEdit;
    fsCheckBox1: TfsCheckBox;
    Panel1: TPanel;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    lbLoja: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbNota: TLabel;
    lbIsNota: TLabel;
    procedure FlatButton1Click(Sender: TObject);
    procedure carregaDadosNota(isNota:String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjustaNumNF: TfmAjustaNumNF;

implementation

uses cf, umain;

{$R *.dfm}

procedure TfmAjustaNumNF.carregaDadosNota(isNota:String);
var
   ds:TdataSet;
begin
   ds := cf.getDadosNota(isNota, '', '');
   lbLoja.Caption := ds.fieldByName('Loja').asString;
   lbNota.Caption := ds.fieldByName('serie').asString) +
                     '/'+
                     ds.fieldByName('num').asString) ;

   lbIsNota.caption := isNota;
   ds.free;
end;

procedure TfmAjustaNumNF.FlatButton1Click(Sender: TObject);
var
   cmd:String;
begin
   cmd := fmMain.getIsNota();
   if (cmd <> '') then
      carregaDadosNota();
end;

end.
