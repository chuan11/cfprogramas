unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, Grids,funcoes, Buttons,Clipbrd,
  adLabelNumericEdit, mxExport, DB, ADODB, TFlatButtonUnit, DBGrids;

type
  TForm2 = class(TForm)
    Edit1: TadLabelEdit;
    sg2: TStringGrid;
    edit2: TadLabelNumericEdit;
    edit4: TadLabelNumericEdit;
    edit3: TadLabelNumericEdit;
    Query: TADOQuery;
    Memo1: TMemo;
    edit6: TadLabelNumericEdit;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    Edit5: TadLabelNumericEdit;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Uprecoswell;

{$R *.dfm}
function FloatSqlToStr(str:string):string;
begin
   if pos(',',str) = 0 then str := str +',00';
   if pos(',',str) = length(str)-1 then str:= str + '0';
   if pos(',',str) = 0 then str:= str + ',00';
   FloatSqlToStr := str;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   sg2.ColWidths[0] := StrToInt(funcoes.lerParam( ARQ_INI ,03));
   sg2.ColWidths[1] := StrToInt(funcoes.lerParam( ARQ_INI ,04));
   sg2.ColWidths[2] := StrToInt(funcoes.lerParam( ARQ_INI ,05));
   sg2.ColWidths[3] := StrToInt(funcoes.lerParam( ARQ_INI ,06));
   sg2.ColWidths[4] := StrToInt(funcoes.lerParam( ARQ_INI ,07));
   sg2.ColWidths[5] := StrToInt(funcoes.lerParam( ARQ_INI ,08));
   sg2.ColWidths[6] := StrToInt(funcoes.lerParam( ARQ_INI ,09));
   edit2.text := funcoes.lerParam( ARQ_INI ,10);
   edit3.text := funcoes.lerParam( ARQ_INI ,11);
   edit4.text := funcoes.lerParam( ARQ_INI ,12);
end;

procedure TForm2.FlatButton3Click(Sender: TObject);
var
  i:integer;
begin
   query.SQL.clear;
   query.SQL.Add('select prod.is_ref, Prod.cd_ref, Prod.ds_ref, CAST ( item.qt_ped as int) as quantidade, item.pr_uni, item.pc_ipi ');
   query.SQL.Add('from crefe prod, dsipe item where prod.is_ref = item.is_ref');
   query.SQL.Add(' and item.is_pedf = '+ quotedStr(edit1.text) );
   query.Open;
   query.First;
   sg2.RowCount := 0;
   i:=0;
   while query.Eof = false do
   begin
      sg2.Cells[1,i] := query.Fields[1].AsString; // codigo
      sg2.Cells[2,i] := query.Fields[2].AsString;// DESC
      sg2.Cells[3,i] := query.Fields[3].AsString; //QUANT
      sg2.Cells[4,i] := FloatSqlToStr( query.Fields[4].asstring  ); //VALOR
      sg2.Cells[5,i] := FloatSqlToStr( query.Fields[5].asstring  );   // IPI
      sg2.Cells[6,i] := query.Fields[0].asString  ;    // REF WELL
      sg2.Cells[7,i] := edit2.text ;    // REF WELL
      sg2.RowCount := sg2.RowCount +1;
      query.Next;
      inc(i);
 end;
end;

procedure TForm2.FlatButton1Click(Sender: TObject);
var
  i:integer;
  VlVenda,desconto,ipi,frete,margem01,margem02:real;
begin
   memo1.lines.Clear;
   form1.limpasg1(sender);

   for i:=0 to  sg2.rowcount -2 do
   begin
      desconto := ( ( StrtoFloat(edit2.text)  * ( StrTofloat(sg2.cells[4,i]) ) ) / 100  );
      frete :=    ( ( StrtoFloat(edit3.text)  * ( StrTofloat(sg2.cells[4,i]) - desconto ) ) / 100  );
      ipi := ( ( StrtoFloat(sg2.cells[5,i] )  * ( StrTofloat(sg2.cells[4,i]) - desconto ) ) / 100  );

      margem01 :=   ( ( StrtoFloat(edit4.text)  * ( StrTofloat(sg2.cells[4,i]) - desconto ) ) / 100  );

      if StrtoFloat(edit5.text) <> 0 then
         margem02 :=   (  ( StrtoFloat(edit5.text) * margem01 ) - desconto )  / 100  ;

      VlVenda := ( StrTofloat(sg2.cells[4,i]) - desconto ) + frete + ipi + margem01 + margem02  ;

      FloatToStrF(vlvenda,ffFixed,18,02);

      memo1.lines.add( IntToStr(i+1)+ '- '+ sg2.cells[1,i]+' '+sg2.cells[2,i]);
      memo1.lines.add( '     PC Ped: ' + sg2.cells[4,i] );
      memo1.lines.add( '     Desc: '+floatToStr(desconto) );
      memo1.lines.add( '     Frete: '+ floatToStr(frete) );
      memo1.lines.add( '     Margem01: '+ floatToStr(margem01) );
      memo1.lines.add( '     Margem02: '+ floatToStr(margem02) );
      memo1.lines.add( '     IPI: '+floatToStr(ipi)  );
      memo1.lines.add( '     PC Gerado: '+FloatToStrF(vlvenda,ffFixed,18,02));
      memo1.lines.add( '');
      form1.sg.Cells[1,i+1] := sg2.Cells[1,i];
      form1.sg.Cells[2,i+1] := sg2.Cells[2,i];
      form1.sg.Cells[3,i+1] := FloatToStrF(vlvenda,ffFixed,18,02);
      form1.sg.Cells[4,i+1] := form1.AjustaPreco( FloatToStrF(vlvenda,ffFixed,18,02) , '1,'+form1.EDIT4.TEXT );
      form1.sg.Cells[5,i+1] := form1.AjustaPreco( FloatToStrF(vlvenda,ffFixed,18,02) , '1,'+form1.EDIT5.TEXT );

      form1.sg.Cells[6,i+1] := SG2.Cells[6,i];
      form1.sg.Cells[7,i+1] := SG2.Cells[4,i];
      form1.sg.RowCount := form1.sg.RowCount + 1;
   end;

   if checkBox1.Checked = true then
   begin
      memo1.Lines.SaveToFile(Path + 'memDeCaculo.txt');
      Winexec(pchar('notepad.exe '+PATH+ 'memDeCaculo.txt'),sw_normal);
   end;

   form1.AjustaSg1(sender);
   FlatButton2Click(Sender);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FUNCOES.gravaParam(  ARQ_INI  ,  INTTOSTR(sg2.ColWidths[0]),03);
   FUNCOES.gravaParam(  ARQ_INI  ,  INTTOSTR(sg2.ColWidths[1]),04);
   FUNCOES.gravaParam(  ARQ_INI  ,  INTTOSTR(sg2.ColWidths[2]),05);
   FUNCOES.gravaParam(  ARQ_INI  ,  INTTOSTR(sg2.ColWidths[3]),06);
   FUNCOES.gravaParam(  ARQ_INI  ,  INTTOSTR(sg2.ColWidths[4]),07);
   FUNCOES.gravaParam(  ARQ_INI  ,  INTTOSTR(sg2.ColWidths[5]),08);
   FUNCOES.gravaParam(  ARQ_INI  ,  INTTOSTR(sg2.ColWidths[6]),09);
   FUNCOES.gravaParam(  ARQ_INI  ,  edit2.text,10);
   FUNCOES.gravaParam(  ARQ_INI  ,  edit3.text,11);
   FUNCOES.gravaParam(  ARQ_INI  ,  edit4.text,12);
   action := cafree;
end;


procedure TForm2.FlatButton2Click(Sender: TObject);
begin
   form2.Close;
end;


procedure TForm2.FlatButton4Click(Sender: TObject);
var
   i:integer;
begin
   for i:=0 to sg2.RowCount-2 do
      sg2.cells[5,i] := edit6.text;
end;

procedure TForm2.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = VK_return then
      FlatButton3Click(Sender);
end;

end.
