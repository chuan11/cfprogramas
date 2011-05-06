unit UCalcularComissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, adLabelDBDateTimePicker, StdCtrls, DBCtrls,
  adLabelDBComboBox, DB, Grids, DBGrids, ADODB,funcoes, adLabelComboBox,
  TFlatMemoUnit, mxExport, funcsql;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    cbLojas: TadLabelComboBox;
    Button1: TButton;
    dtInicio: TDateTimePicker;
    dtFim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Query: TADOQuery;
    cbTpVenda: TadLabelComboBox;
    StatusBar1: TStatusBar;
    Button2: TButton;
    memo: TFlatMemo;
    export: TmxDataSetExport;
    function GetNomeLojas(sender: tobject): Tstrings;
    procedure Button1Click(Sender: TObject);
    procedure gravaArquivo(sender:tobject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  di,df:String;

implementation

function TForm1.GetNomeLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := ADOConnection1;
   query.SQL.Clear;
   query.SQL.Add('select ds_uo,is_uo from tbuo where TP_ESTOQUE in (1,2) order by ds_uo');
   query.Open;

   aux := TstringList.create();
   query.First;
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(50,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;
end;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
  p01,p02,p03:string;
  cmd:string;
begin
   screen.cursor := crHourGlass;

   Case  cbTpVenda.ItemIndex of
      0: begin
            case  strToint( funcoes.SohNumeros( copy(cbLojas.Items[cblojas.itemIndex],40,50))) of
               10033591:begin
                           p01 := '106,103 ';
                           p02 := '-1';
                           p03 := '-1';
                        end;
               10033592,
               10042256:begin
                           p01 := '111';
                           p02 := '-1';
                           p03 := '-1';
                        end;
                        else
                        begin
                           p01 := '103';
                           p02 := '-1';
                           p03 := '-1';
                        end;
            end;
        end;
      1:begin
            case  strToint( funcoes.SohNumeros( copy(cbLojas.Items[cblojas.itemIndex],40,50))) of
               10033591:begin
                           p01 := '105, 101';
                           p02 := '0';
                           p03 := '-1';
                        end;
               10033592,
               10042256:begin
                           p01 := '110';
                           p02 := '0';
                           p03 := '-1';
                        end;
                        else
                        begin
                           p01 := '101';
                           p02 := '0';
                           p03 := '-1';
                        end
            end;
        end;
      else
      begin
         case  strToint( funcoes.SohNumeros( copy(cbLojas.Items[cblojas.itemIndex],40,50))) of
            10033591:begin
                        p01 := '105';
                        p02 := '106';
                        p03 := '0';
                     end;
            10033592,
            10042256:begin
                        p01 := '111';
                        p02 := '110';
                        p03 := '0';
                     end;
                     else
                     begin
                        p01 := '103';
                        p02 := '101';
                        p03 := '0';
                    end
            end;
      end;
   end;

//   if application.MessageBox(pchar('Confirma o calculo da loja  ' +  copy(cbLojas.Items[cbLojas.ItemIndex],01,30) + #13+ 'De:' + DateToStr(dtinicio.Date) +' até : '+ DateToStr(dtFim.Date) +#13+#13+ ' ATENÇÃO !!!     Esse processo é demorado') , '', MB_YesNo + mb_IconQuestion ) = mrYes then
   begin
      memo.Lines.Add( copy( cbLojas.Items[cbLojas.itemIndex],01,30) +
                      copy( cbTpVenda.Items[cbtpVenda.itemIndex],02,30) +
                      ' Iniciado as: ' + TimeToStr(now)
                     ) ;
      Query.SQL.Clear;
      form1.Refresh;
      cmd := ('Exec zcf_CacularComissao @CodLoja ='+ copy(cbLojas.Items[cbLojas.ItemIndex],51,10) + ' , ' +
              '@DataInicial = ' + funcoes.StrToSqlDate( dateToStr(dtinicio.Date))   + ' , ' +
              '@DataFinal= ' + funcoes.StrToSqlDate( dateToStr(dtFim.Date))  + ' , ' +
              '@TPpco1= '+ p01  + ' , ' +
              '@TPpco2= '+ p02  + ' , ' +
              '@TPpco3= '+ p03
             );

      query.SQL.Add(cmd);
      funcoes.GravaLinhaEmUmArquivo(funcoes.TempDir()+'_Log_CalculaComissao.txt',cmd);
      Query.Open;

      if query.IsEmpty = false then
      begin
         dbgrid1.Columns[00].Width := 180;
         dbgrid1.Columns[01].Width := 180;
         // salvar o arquivo
         gravaArquivo(sender);
         MessageBeep(0);
      end;
   end;
   memo.Lines.Add( copy( cbLojas.Items[cbLojas.itemIndex],01,30)+
                   copy( cbTpVenda.Items[cbtpVenda.itemIndex],02,30) +
                   ' Finalizado em: ' + TimeToStr(now)
                 );

   memo.Lines.Add( ' -------------------------------------------- ');
   form1.Refresh;
   screen.cursor := crDefault;
end;

procedure TForm1.gravaArquivo(sender: tobject);
var
   arq:string;
   i:integer;
begin
  funcsql.exportaQuery( query, true, 'c:\Comissao '+  inttoStr(cbLojas.ItemIndex)+'_'+ cbTpVenda.Items[cbTpVenda.itemIndex] + '_' + trim( copy(cbLojas.Items[cbLojas.ItemIndex],01,30)) +'_'+ funcoes.SohNumeros( DateToStr(dtInicio.Date) ) + '_' + funcoes.SohNumeros( DateToStr(dtFim.Date) ) ) ;
{

  export.FileName :=
  export.Execute
}
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' )) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;
   ADOconnection1.ConnectionString := funcoes.getDadosConexaoUDL('');
   ADOconnection1.Connected := true;
   form1.Caption :=  form1.Caption  + '   ' + ADOConnection1.DefaultDatabase;
   form1.Left := Screen.Width - form1.Width - 50;
   dtinicio.Date := StrToDate('01/' + copy(dateToStr(now),04,10));
   deleteFile(funcoes.TempDir()+'_Log_CalculaComissao.txt');
   cbLojas.Items := form1.GetNomeLojas(Sender);
   cbLojas.ItemIndex := 0 ;
   dtFim.Date := now;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  i,j:integer;
begin
   if cbLojas.ItemIndex > -1 then
      for i:= cbLojas.itemIndex to cbLojas.Items.Count -1 do
      begin
         cbLojas.ItemIndex := i;
         for j:= 0 to 1 do
         begin
            cbTpVenda.ItemIndex := j;
            Button1Click(nil);
         end;
      end;
end;

end.
