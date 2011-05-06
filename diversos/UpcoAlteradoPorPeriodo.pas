unit UpcoAlteradoPorPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox,funcsql, DB, ADODB, RpRave, RpCon,
  RpConDS, RpDefine, RpBase, RpSystem, TFlatButtonUnit, ComCtrls,funcoes,
  Grids, DBGrids, fCtrls  ;

type
  TForm1 = class(TForm)
    cb2: TadLabelComboBox;
    cb1: TadLabelComboBox;
    Connection: TADOConnection;
    Label1: TLabel;
    FlatButton1: TFlatButton;
    RvSystem1: TRvSystem;
    RvDataSetConnection1: TRvDataSetConnection;
    RvProject: TRvProject;
    Query: TADOQuery;
    QueryCD_PES: TIntegerField;
    QueryIS_REF: TIntegerField;
    QueryCD_REF: TStringField;
    QueryDS_REF: TStringField;
    QueryNM_PES: TStringField;
    QueryDT_ALTPV: TDateTimeField;
    QueryVL_PRECO: TBCDField;
    QueryTP_PRECO: TIntegerField;
    QueryIS_UO: TIntegerField;
    QueryIS_ALP: TIntegerField;
    QueryVL_PRECO2: TBCDField;
    QueryDT_ALTPV2: TDateTimeField;
    QueryTP_PRECO2: TIntegerField;
    QueryNM_USU: TStringField;
    dp1: TfsDateTimePicker;
    cbexporta: TCheckBox;
    stbar: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExportaArquivo(Sender:Tobject);
    procedure cbexportaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}




procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' )) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;
   Connection.Connected := false;
   connection.ConnectionString := funcoes.getDadosConexaoUDL( extractFilePath(paramStr(0)) + 'ConexaoAoWell.ini' );


   cb2.items :=  funcsql.GetNomeLojas(Connection, False, false);
   cb1.items :=  funcsql.getListaPrecos(Connection,false, false, true);
   dp1.Date := now();

   if funcoes.RParReg('ProgramasCF\RPVAL','preco') <> '' then
     cb1.ItemIndex := StrToInt( funcoes.RParReg('ProgramasCF\RPVAL','preco'))
   else
     cb1.ItemIndex := 0;

   if funcoes.RParReg('ProgramasCF\RPVAL','LOJA') <> '' then
     cb2.ItemIndex := StrToInt( funcoes.RParReg('ProgramasCF\RPVAL','loja'))
   else
     cb2.ItemIndex := 0;

   RvProject.ProjectFile:=  'RPVALWELL.rav';
   form1.Left := 200;
   form1.Top := 100;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
   stbar.SimpleText := 'Verificando as alterações de preço....';
   form1.Refresh;
   Screen.Cursor := crhourglass;
   query.SQL.Clear;
   query.SQL.Add(' Exec stoListarPrecosAlteradosPeriodo ' +
                   funcoes.StrToSqlDate(dateTostr(dp1.date)) + ', '+
                   funcoes.StrToSqlDate(dateTostr(dp1.date)) + ', '+
                   trim(copy(cb2.Items[cb2.itemIndex],51,08)) +', '+
                   quotedStr(copy(cb1.items[cb1.itemIndex],51,03)) + ', ' +
                   quotedStr('')+', '+
                   quotedStr('')+', '+
                   '10034482'
                 );
   query.SQL.SaveToFile(funcoes.TempDir()+ '_PrecosAlteradosPorPeriodo.txt');
   query.Open;

   if  query.IsEmpty = false then
   begin
      if cbexporta.Checked = false then
      begin
         RvProject.SetParam('Loja', trim(copy(cb2.Items[cb2.ItemIndex],01,50)));
         RvProject.SetParam('preco', trim(copy(cb1.Items[cb1.ItemIndex],01,50)));
         RvProject.ExecuteReport('report2');
         form1.Close;
      end
      else
      begin
         stbar.SimpleText := 'Verificando as alterações de preço....';
         form1.Refresh;
         sleep(300);
         cbexportaClick(Sender);
//         ExportaArquivo(nil);
      end;

   end
   else
   application.MessageBox(pchar('Não há reajuste deste tipo de preço nesse dia para essa loja'),pchar(form1.caption),mb_iconError+mb_Ok);
   Screen.Cursor := crdefault;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    funcoes.WParReg('ProgramasCF\RPVAL','LOJA',inttoStr(cb2.ItemIndex));
    funcoes.WParReg('ProgramasCF\RPVAL','preco',inttoStr(cb1.ItemIndex));
    connection.Close;
    application.Terminate;
end;

procedure TForm1.ExportaArquivo(Sender: Tobject);
var
  arq, pc,nomePreco :string;
begin
   case  cb1.ItemIndex of
     0: begin pc := '01' ; nomePreco := 'varejo' end;
     2: begin pc := '02' ; nomePreco := 'atacado' end
   else
      begin
         pc := '99';
         nomePreco := 'outrosPreco'
      end;
   end;
   arq := 'c:\precos_'+nomePreco+'_AlteradosEm'+ copy(dateTostr(now),01,02) +'-'+ copy(dateTostr(now),04,02) +'-'+copy(dateTostr(now),07,04) + '.txt' ;
   if fileExists(arq) then  deleteFile(arq);

   query.First;
   while query.Eof = false do
   begin
      funcoes.GravaLinhaEmUmArquivo(arq ,
           query.fieldByName('cd_ref').AsString + ';'+
           pc +';'+
           funcoes.preencheCampo(12,'0','e',
           funcoes.SohNumeros(
                                FloatToStrF(query.fieldByName('vl_Preco').Asfloat,ffnumber, 18,04 )
                              )
                                 )
      );
      query.Next;
   end;
   stbar.SimpleText := 'Exportado para o arquivo: ' + arq;
   form1.Refresh;
end;

procedure TForm1.cbexportaClick(Sender: TObject);
begin
  if cbexporta.Checked = true then
     if query.IsEmpty = false then
        ExportaArquivo(nil);
end;

end.
