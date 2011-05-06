unit uAlteraFinanceira;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, adLabelEdit, funcSQl, TFlatButtonUnit, funcoes;

type
  TfmAlteraFiananceira = class(TForm)
    edCodigo: TadLabelEdit;
    cbOrigem: TadLabelComboBox;
    Label1: TLabel;
    lbFinanceira: TLabel;
    FlatButton1: TFlatButton;
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAlteraFiananceira: TfmAlteraFiananceira;

implementation

uses uMain;

{$R *.dfm}

procedure TfmAlteraFiananceira.edCodigoKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if key = VK_RETURN  then
   begin
      lbFinanceira.Caption := funcsql.openSQL( ' select  cast( dsagn.cb_codagen as varchar   )   + '' '' +  dsagn.cb_nomc_ag as agente from dsagn (nolock) inner join ' +
                              ' dsfat (nolock)on dsagn.cb_codagen = dsfat.cb_codagen where nr_contrato = '  + QuotedStr(edCodigo.text),
                              'agente',
                              fmMain.conexao
                             );
   end;
end;

procedure TfmAlteraFiananceira.FlatButton1Click(Sender: TObject);
var
   tc:Word;
   SHIF: TShiftState;
begin
    TC := VK_RETURN;
    SHIF := [ssShift];
    if MsgTela('', 'Deseja alterar a financeira desse contrato ? ' , MB_YESNO + MB_ICONQUESTION ) = mrYes then
    begin
        funcsql.execSQL(' Update dsfat set cd_financeira = ' + copy(cbOrigem.Items[cbOrigem.itemIndex],01,01  )  +
                        ', cb_codAgen = ' + copy(cbOrigem.Items[cbOrigem.itemIndex],01,01  )  +
                        ' where nr_contrato = ' + QuotedStr(edCodigo.text), fmMain.Conexao );

        funcsql.execSQL(' Update dsdup set ' +
                        ' cb_codAgen = ' + copy(cbOrigem.Items[cbOrigem.itemIndex],01,01  )  +
                        ' where nr_contrato = ' + QuotedStr(edCodigo.text), fmMain.Conexao );



       edCodigoKeyDown(nil, TC, SHIF);

       if  funcsql.openSQL('Select @@ROWCOUNT as alteradas ', 'alteradas',fmMain.conexao ) <> '0' then
           msgTela('','Alterado com sucesso.', MB_OK + MB_ICONEXCLAMATION)
       else
           msgTela('','Nao consegui alterar esse contrato. O numero está correto? ', MB_OK + MB_ICONERROR);
    end;
end;

procedure TfmAlteraFiananceira.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   funcoes.salvaCampos(fmAlteraFiananceira);
   fmAlteraFiananceira:= nil;
   action := CaFree;
end;

end.
