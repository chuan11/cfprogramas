unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TFlatButtonUnit, RpBase, RpSystem, RpRave, DB, ADODB,
  RpDefine, RpCon, RpConDS, StdCtrls, adLabelComboBox, Grids, DBGrids,funcoes;

type
  TForm9 = class(TForm)
    cbLojas: TadLabelComboBox;
    RvDataSetConnection3: TRvDataSetConnection;
    q2: TADOQuery;
    RvProject1: TRvProject;
    RvSystem1: TRvSystem;
    BitBtn2: TFlatButton;
    BitBtn3: TFlatButton;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    RvDataSetConnection4: TRvDataSetConnection;
    q1: TADOQuery;
    q2numlista: TIntegerField;
    q2ljBaixa: TWideStringField;
    q2Codigo: TStringField;
    q2NomeProduto: TStringField;
    q2convidado: TStringField;
    q2ObsItem: TStringField;
    q2dtCompra: TDateTimeField;
    q2valor: TBCDField;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation
uses unit1;

{$R *.dfm}

procedure TForm9.FormActivate(Sender: TObject);
begin
   form9.Top := form1.Top + 50;
   cbLojas.items := form1.GetNumLojas(sender, form1.RParReg('Loja'));
   cbLojas.ItemIndex := 0;
   dt1.Date := now;
   dt2.Date := now;
end;

procedure TForm9.BitBtn3Click(Sender: TObject);
begin
   form9.close;
end;

procedure TForm9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Form1.mostraMenu(sender);
   action := Cafree;
end;

procedure TForm9.BitBtn2Click(Sender: TObject);
var
   Numloja,cmd:string;
begin
   if dt2.DateTime < dt1.DateTime then
      form1.MsgTela('A data final não pode ser menor que a data incial.',mb_ok + mb_iconerror)
   else
   begin
      bitbtn2.Enabled := false;
      bitbtn3.Enabled := false;
      rvProject1.SetParam('Dtinicio', DateToStr(dt1.Date));
      rvProject1.SetParam('Dtfim', DateToStr(dt2.Date));
      rvProject1.SetParam('Numloja', cblojas.Items[cblojas.itemindex]);
      rvproject1.SetParam('TpVersao',funcoes.RParReg('listas','Versao')   );
      if cblojas.itemIndex = 0 then
         NumLoja := '99'
      else
         NumLoja := cblojas.Items[cblojas.itemindex] ;

      cmd := ' Exec ListasComItensCompPorData_cabeca '+quotedStr(NumLoja) +' , ' +funcoes.StrToSqlDate(dateToStr(dt1.Date)) +' , ' + funcoes.StrToSqlDate(dateToStr(dt2.Date));
      q1.SQL.Clear;
      q1.SQL.Add(cmd);
      q1.Open;

      q2.SQL.Clear;
      q2.SQL.Add(' Exec ListasComItensCompPorData_corpo '+quotedStr(NumLoja) +' , ' +funcoes.StrToSqlDate(dateToStr(dt1.Date)) +' , ' + funcoes.StrToSqlDate(dateToStr(dt2.Date)) );
      q2.Open;

      if q2.IsEmpty = false then
      begin
         rvproject1.SetParam('nItens','Total de Itens: ' + inttostr(q2.RecordCount ) );
         rvProject1.ExecuteReport('Report2');
      end
      else
         form1.MsgTela('Nenhuma baixa foi realizada nesse período.',mb_ok + mb_iconwarning)
   end;
   BitBtn2.Enabled := true;   
   BitBtn3.Enabled := true;
end;

end.
