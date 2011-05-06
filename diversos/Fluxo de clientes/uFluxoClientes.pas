unit uFluxoClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, fCtrls, ComCtrls, funcSQL, funcoes, Buttons,
  Grids, DBGrids;

type
  TForm1 = class(TForm)
    cbLoja: TfsComboBox;
    ADOConnection1: TADOConnection;
    label2: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    dtinicio: TfsDateTimePicker;
    dtFim: TfsDateTimePicker;
    fsBitBtn1: TfsBitBtn;
    Query: TADOQuery;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure GerarFluxo(sender:Tobject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure dtinicioChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
   if (length(ParamStr(1)) = 0) and (FileExists('Upgrade.exe')) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;
   ADOconnection1.Connected := false;
   ADOConnection1.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   ADOconnection1.Connected := true;

   cbLoja.Items := funcSQL.GetNomeLojas(ADOCOnnection1, false);

   cbLoja.itemIndex := funcoes.RParRegint('ProgramasCF\fluxoVendas','Loja');

   dtinicio.Date :=  funcoes.RParRegDate('ProgramasCF\fluxoVendas','di');
   dtFim.Date :=  funcoes.RParRegDate('ProgramasCF\fluxoVendas','df');

   FORM1.Caption := FORM1.CAPTION  + '   ' + ADOconnection1.DefaultDatabase;
   form1.top:= 1;
   Form1.left := screen.Width - form1.Width-50;
end;

procedure TForm1.GerarFluxo(sender: Tobject);
var
  auxHora, hora,i:integer;
  nVendas: array[0..14] of real;
  vVendas: array[0..14] of real;

  ntVendas:real;
  vtVendas:real;

  percAtend,percVenda:real;
begin
   for i:=0 to 14 do
   begin
      nVendas[i] :=0;
      vVendas[i] :=0;
   end;
   query.SQL.Clear;

   query.SQL.add(' zcf_FluxodeClientePorHora ' +
//                  quotedStr( 'transacoesdocaixa.codloja = ' + funcoes.SohNumeros(Copy(cbLoja.Items[cbLoja.itemIndex],51,50)) )+' , '+
                  '@Uo = ' + funcoes.SohNumeros(Copy(cbLoja.Items[cbLoja.itemIndex],51,50) )+' , '+
                  '@Di = ' + funcoes.StrToSqlDate(DateToStr(dtinicio.Date) )+' , '+
                  '@df = ' + funcoes.StrToSqlDate(DateToStr(dtfim.Date))
                ) ;
   query.SQL.SaveToFile('C:\zFluxoClintes.txt');

   query.open;
   QUERY.First;
   while query.Eof = false do
   begin

      hora := funcoes.HoraToInt( copy(query.FieldByname('dt_trab').AsString, 12,05 )) ;

      auxHora := 08;
      if hora  <= ( 60 * auxHora )  then
      begin
         nVendas[0] := nVendas[0] +1;
         vvendas[0] := vVendas[0] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 08;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 09;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 10;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 11;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 12;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 13;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 14;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 15;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 16;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 17;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7]:= vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 18;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 19;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 20;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 21;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7]+1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 22;
      if ( hora  > (( 60 * auxHora ) ) )   then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + query.FieldByname('vl_Venda').AsFloat;
      end;
      Query.Next();
   end;

   ntVendas := 0;
   for i:= 0 to 14 do
     ntVendas:= ntVendas + nVendas[i];

   vtVendas := 0;
   for i:= 0 to 14 do
     vtVendas := vtVendas +vVendas[i];

// mostrar o resultado

   if vtVendas > 0 then
   begin
      percAtend := ( nVendas[0]* 100 ) / ntVendas ;
      percVenda := ( vVendas[0]* 100 ) / vtVendas ;

      memo1.lines.add('Loja: '+copy(cbLoja.Items[cbLoja.itemIndex],01,50)   );
      memo1.lines.add('----------------------------------------------------------------------------');

      memo1.lines.Add( '00:00 ate 08:00 - Nº de vendas: ' +  funcoes.preencheCampo(5,' ','e', FloatToStr(nVendas[0]) ) + '(' +  funcoes.preencheCampo(6,' ','e', floattostrf( percAtend  ,ffNumber,18,2) )  +'%)'+
                       ' Valor: '+
                       funcoes.preencheCampo(12,' ', 'e', floattostrf(  vVendas[0]  ,ffNumber,18,2) ) +
                       '(' +  funcoes.preencheCampo(6,' ','e', floattostrf( percVenda  ,ffNumber,18,2) )  +'%)'
                     );
      for i:=1 to 13 do
      begin
         percAtend := (nVendas[i]*100 ) / ntVendas  ;
         percVenda := (vVendas[i]* 100 ) / vtVendas ;

         memo1.lines.Add( funcoes.preencheCampo(2,'0','e', inttoStr(i+7))  +
                          ':00 ate ' +
                          funcoes.preencheCampo(2,'0','e', inttoStr(i+8))  +
                          ':00 - Nº de vendas: ' + funcoes.preencheCampo(5,' ','e', FloatToStr(nVendas[i]) ) +
                          '(' +  funcoes.preencheCampo(6,' ','e', floattostrf( percAtend  ,ffNumber,18,2) )  +'%)'+
                          ' Valor: '+
                          funcoes.preencheCampo(12,' ', 'e', floattostrf(  vVendas[i]  ,ffNumber,18,2) ) +
                          '(' +  funcoes.preencheCampo(6,' ','e', floattostrf( percVenda  ,ffNumber,18,2) )  +'%)'
                        );
      end;

      percAtend := ( nVendas[14]* 100 ) / ntVendas ;
      percVenda := ( vVendas[14]* 100 ) / vtVendas ;
      memo1.lines.Add( '21:00 ate 24:00 - Nº de vendas: ' +  funcoes.preencheCampo(5,' ','e', FloatToStr(nVendas[14]) )     +
                       '(' +  funcoes.preencheCampo(6,' ','e', floattostrf( percAtend  ,ffNumber,18,2) )  +'%)'+
                       ' Valor: '+
                       funcoes.preencheCampo(12,' ', 'e', floattostrf(  vVendas[i]  ,ffNumber,18,2) ) +
                       '(' +  funcoes.preencheCampo(6,' ','e', floattostrf( percVenda  ,ffNumber,18,2) )  +'%)'
                     );
      memo1.lines.add('----------------------------------------------------------------------------');
      memo1.Lines.Add('Total de atendimentos :  '+  floatToStr(ntVendas)  ) ;
      memo1.Lines.Add('Total de Vendas: ' + floattostrf(  vtVendas  ,ffNumber,18,2) )
   end
   else
      memo1.Lines.Add('Sem vendas............');
{}
end;

procedure TForm1.fsBitBtn1Click(Sender: TObject);
begin
   memo1.Lines.Clear;
   screen.Cursor := crHourGlass;
   GerarFluxo(sender);
   screen.Cursor := crDefault;
end;

procedure TForm1.dtinicioChange(Sender: TObject);
begin
   dtfim.Date := dtinicio.Date;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.WParReg('ProgramasCF\fluxoVendas','Loja', InttoStr(cbLoja.ItemIndex) );
   funcoes.WParReg('ProgramasCF\fluxoVendas','di', DateToStr(dtinicio.Date));
   funcoes.WParReg('ProgramasCF\fluxoVendas','df', DateToStr(dtFim.Date));
end;

end.
