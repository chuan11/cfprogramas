unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelEdit, Grids, DBGrids, DB,
  RpBase, RpSystem, RpCon, RpConDS, RpDefine, RpRave, ADODB,funcoes,
  RpRender, RpRenderPDF, fCtrls, mxExport,funcSql, TFlatSplitterUnit;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    q1: TADOQuery;
    RvP: TRvProject;
    RvDataSetConnection1: TRvDataSetConnection;
    RvSystem1: TRvSystem;
    Edit1: TadLabelEdit;
    FlatButton1: TFlatButton;
    RvRenderPDF1: TRvRenderPDF;
    EDIT2: TadLabelEdit;
    CB: TfsCheckBox;
    Export: TmxDataSetExport;
    cbLojas: TfsComboBox;
    fsGroupBox1: TfsGroupBox;
    cbPrecos: TfsComboBox;
    procedure FlatButton1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FlatButton1Click(Sender: TObject);
var
   dest,aux:string;
   custo,custoSemICMS:real;
begin
   screen.cursor := crhourGlass;
   q1.SQL.Clear;
   q1.SQL.Add('Exec Z_CF_stoDadosNF_DadosClienteTransf ' + quotedStr(edit1.text)+ ', '+ quotedStr(edit2.text) + ', ' + QuotedStr(funcoes.SohNumeros(cbLojas.Items[cbLojas.ItemIndex])) );
   q1.open;

   if q1.IsEmpty = true then
      application.MessageBox('Esta nota não existe ou não é de transferência', pchar(form1.Caption), mb_iconerror + mb_ok)
   else
   begin

      dest :=  q1.Fields[06].AsString + ' - '+q1.Fields[07].AsString + ' '+ q1.Fields[08].AsString+ ' '+ q1.Fields[09].AsString +#13;
      aux:= ' Data   : ' + q1.Fields[04].AsString +#13;
      aux:= aux +' Destino: ' + dest +   ' Valor  : ' + q1.Fields[05].AsString+#13 + ' Prepare a impressora, Continua?';
      if application.MessageBox(pchar(aux), pchar('Dados da nota Fiscal'), mb_iconquestion + mb_YesNo) = mrYes then
      begin
         rvp.SetParam('dataEmissao', q1.Fields[4].AssTRING);
         q1.SQL.Clear;
         q1.SQL.Add('Exec  Z_CF_stoDadosNF_ProdutosComCusto ' + quotedStr(edit1.text)+ ', '+ quotedStr(edit2.text)+', 10033674 , '+
                     funcoes.tiraEspaco(copy(cbPrecos.Items[ cbPrecos.itemIndex],30,100)));

         q1.sql.saveToFile('c:\teste.txt');
         q1.open;

         if cb.Checked then
            export.Execute
         else
         begin
            custo:=0;
            custoSemICMS := 0;
            q1.First;
            while q1.Eof = false do
            begin
              custoSemICMS := custoSemICMS + q1.FieldbYnAME('CustoUnd').AsFloat * q1.FieldbYnAME('qt_mov').AsFloat ;
              custo := custo + q1.FieldbYnAME('total_item').AsFloat;
              q1.Next;
            end;
            rvp.SetParam('NumNota',edit1.text);
            rvp.SetParam('Destino',Dest);
            rvp.SetParam('CustoTotal', floattostrf(custo,ffNumber,18,02));
            rvp.SetParam('CustoSemICMS', floattostrf(custoSemICMS,ffNumber,18,02));
            rvp.SetParam('Frete', floattostrf(custoSemICMS*0.06,ffNumber,18,02));
            rvp.ExecuteReport('Report2');
         end;
      end;
   end;
   edit1.text:='';
   edit1.setfocus;
   screen.cursor := crDefault;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   IF KEY = #13 then
      FlatButton1Click(Sender);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;
   AdoConnection1.Connected := false;
   AdoConnection1.ConnectionString :=  funcoes.getDadosConexaoUDL( extractFilePath( ParamStr(0) ) + 'ConexaoAoWell.ini' );
   AdoConnection1.Connected := true;

   rvp.ProjectFile := extractFilePath( ParamStr(0) )  + 'CustoDeTransferencia.rav';

   cbLojas.Items := funcSql.GetNomeLojas(ADOConnection1,false, false);
   cbLojas.itemIndex:=0;

   cbPrecos.Items := funcSql.getListaPrecos( ADOConnection1, true, false, false );
   cbPrecos.itemIndex:=0;
end;

end.
