unit uConReqDep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelComboBox, ComCtrls,
  adLabelDBDateTimePicker, DB, ADODB, Grids, DBGrids, SoftDBGrid,funcsql,funcoes,
  fCtrls, ExtCtrls, Buttons;

type
  TfmConReqDep = class(TForm)
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    cbLojas: TadLabelComboBox;
    cbLojaEstoque: TadLabelComboBox;
    dti: TfsDateTimePicker;
    Label1: TLabel;
    pdGrid: TSoftDBGrid;
    Label3: TLabel;
    DataSource2: TDataSource;
    qrProd: TADOQuery;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    dtf: TfsDateTimePicker;
    fsBitBtn1: TfsBitBtn;
    Query: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure ConsultaPedidos(Sender:Tobject);
    procedure ajustaLoja(Sender:TObject; combo:TcomboBox;loja:string);
    procedure FormActivate(Sender: TObject);
    procedure ConnectionWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;      var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure ConnectionExecuteComplete(Connection: TADOConnection;      RecordsAffected: Integer; const Error: Error;      var EventStatus: TEventStatus; const Command: _Command;      const Recordset: _Recordset);
    procedure ListaItensRequicao(Sender:Tobject);
    procedure gridDblClick(Sender: TObject);
    procedure ajustaCabecalho(grid:TDbgrid);
    procedure MontarRelatorioImpressao(Sender:tobject; nLinPorPagina:integer);
    procedure FlatButton1Click(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fsBitBtn2Click(Sender: TObject); //sender:tobject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmConReqDep: TfmConReqDep;
//  is_ref:String;
implementation
uses umain;
{$R *.dfm}

procedure TfmConReqDep.FormCreate(Sender: TObject);
begin
{   cbLojas.Items := funcsQL.GetNomeLojas(fmMain.Conexao,true,false, fmMain.lbPes.Caption,'');
   cbLojaEstoque.Items  := funcsQL.GetNomeLojas( fmMain.Conexao , false ,false,'','');
   cbLojas.ItemIndex := 0;
   cbLojaEstoque.ItemIndex :=0;
}   
end;

procedure TfmConReqDep.ConsultaPedidos(Sender: Tobject);
var
  cmd:String;
begin
   cmd :=  ' Select ( Select top 01 dt_movpd from dspdi with(nolock) where  dspdi.is_planod =  dspd.is_planod )  as Data , ' +#13
           +' dspd.is_planod as [Requisição], '  +#13
           +' tbuo.ds_uo as Loja, dsusu.nm_usu '       +#13
           +' from dspdi with(NoLock) ' +#13
           +' inner join dspd  with(NoLock) on dspd.is_planod = dspdi.is_planod ' +#13
           +' inner join tbuo  with(NoLock) on dspdi.is_estoque = tbuo.is_uo ' +#13
           +' inner join dsusu with(nolock) on dspd.cd_usu = dsusu.cd_pes ' +#13
           +' where dspd.dt_PLANOD '
           +' between ' + funcoes.DateTimeToSqlDateTime(dti.Date,' 00:00:00') + ' and ' + funcoes.DateTimeToSqlDateTime(dtf.Date ,' 00:00:00') +#13
           +' and dspd.is_estoque = ' + getNumUO(cbLojaEstoque);

           if cbLojas.itemIndex > 0 then
              cmd := cmd + ' and dspdi.is_estoque =  ' + getNumUO(cbLojas);

           cmd := cmd
           +' group by dspd.is_planod, dt_planod, tbuo.ds_uo, dspdi.is_estoque, dsusu.nm_usu ' +#13
           +' order by dspd.dt_planod, dspdi.is_estoque';

   Query.SQL.Clear;
   Query.SQL.add(cmd);
   query.SQL.SaveToFile(funcoes.TempDir()+'testeConsultaRequisicao.txt');
   query.open;

   grid.Columns[0].Width := 200;
   grid.Columns[1].Width := 150;
   grid.Columns[2].Width := 150;

   ajustaCabecalho(grid);
end;

procedure TfmConReqDep.ajustaLoja(Sender: TObject; combo: TcomboBox;loja: string);
var
   i:integer;
begin
   combo.itemindex := 0;
   for i:=0 to combo.Items.Count -1 do
   begin
      if funcoes.SohNumeros(copy(combo.Items[i],40,50)) = loja then
         combo.itemindex := i;
   end;
end;
procedure TfmConReqDep.btOkClick(Sender: TObject);

begin
   if dti.Date > dtf.Date then
      funcoes.msgTela('', 'Data inicial maior que a data final.', mb_iconError + mb_ok)
   else if (dtf.Date - dti.Date) > 30 then
      funcoes.msgTela('', 'Período maior que 30 dias.', mb_iconError + mb_ok)
   else
      ConsultaPedidos(Sender)
end;

procedure TfmConReqDep.FormActivate(Sender: TObject);
begin
//   dtf.Date := now;
  // dti.Date := now;
end;

procedure TfmConReqDep.ConnectionWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   screen.Cursor := crHourGlass;
   funcoes.GravaLinhaEmUmArquivo(funcoes.getWinDir()+'_GetValorWell.txt', CommandText );
end;

procedure TfmConReqDep.ConnectionExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
  screen.Cursor := crDefault;
end;

procedure TfmConReqDep.ListaItensRequicao(Sender: Tobject);
var
   cmd :string;
begin
   cmd :=  ' Select '
          +' crefe.cd_ref as [Codigo],'
          +' crefe.ds_ref as [Descrição],'
          +' dspdi.qt_ped as [Pedido], '
          +' dspdi.qt_Pend as [Pend] , '
          +' dspdi.QtdEmSeparacao as [Em Sep], '
          +' dspdi.QtdSeparada as [Separada], '
          +' dspdi.qtdTransferida as [Transf], '
          +' dspdi.qtdCancelada  as [Canc] '
          +' from dspdi with(NoLock) '
          +' inner join crefe with(noLock) on crefe.is_ref = dspdi.is_ref '
          +' where '
          +' dspdi.is_planod = ' + query.FieldByname('Requisição').AsString;

   qrProd.SQL.Clear;
   qrProd.SQL.add(cmd);
   qrProd.Open;

   pdGrid.Columns[0].Width := 50;
   pdGrid.Columns[01].Width := 300;
   pdGrid.Columns[02].Width := 50;
   pdGrid.Columns[03].Width := 50;
   pdGrid.Columns[04].Width := 50;
   pdGrid.Columns[05].Width := 50;
   pdGrid.Columns[06].Width := 50;
   pdGrid.Columns[07].Width := 50;
   ajustaCabecalho(pdGrid);
end;

procedure TfmConReqDep.gridDblClick(Sender: TObject);
begin
  if query.IsEmpty = false then
     ListaItensRequicao(Sender);
end;

procedure TfmConReqDep.ajustaCabecalho(grid: TDbgrid);
var
  i:integer;
begin
   for i:= 0 to grid.Columns.Count -1 do
      grid.Columns[i].Title.Font.Style := [fsBold];
end;

procedure TfmConReqDep.MontarRelatorioImpressao(Sender:tobject; nLinPorPagina:integer); //sender:tobject);
var
   dest:TstringList;
   linha:string;
   l,Fl:integer;
   nmArquivo,codForn:string;
begin
   nmArquivo:= funcoes.SohNumeros( DateTimeToStr(now) ) + 'txt';

   dest:=  TStringList.create();
   Fl := 0; l := 0;

   if nLinPorPagina = 0 then
      nLinPorPagina := 50
   else
      nLinPorPagina := 65;

   qrProd.First;
   while qrProd.Eof = false do
   begin
      inc(fl);
      Dest.Add('                          *** CONSULTA A REQUISICAO ***                                     FL:' + funcoes.preencheCampo(03,'0','e',intToStr(fl)));
      Dest.Add('');
      Dest.Add( 'N requisicao: ' + query.fieldByName('Requisição').AsString + '  Data da requisicao: ' + query.fieldByName('Data').AsString );
      Dest.Add('Loja: ' + query.fieldByName('Loja').AsString +'    '+ 'Loja requisitada: '+ copy(cbLojaEstoque.items[cbLojaEstoque.itemIndex],01,50));
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('CODIGO  DESCRICAO                              .                  Ped  Pend  Tran   Sep  Canc');
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('');

      while ( l < nLinPorPagina ) and ( qrProd.eof = false ) do
      begin
         linha :=
         qrProd.fieldByname('codigo').AsString                                           + ' ' +
         funcoes.preencheCampo(55,' ', 'D', qrProd.fieldByname('Descrição').asString ) +
         funcoes.preencheCampo(06,' ', 'e', qrProd.fieldByname('Pedido').Asstring)       +
         funcoes.preencheCampo(06,' ', 'e', qrProd.fieldByname('Pend').Asstring)     +
         funcoes.preencheCampo(06,' ', 'e', qrProd.fieldByname('Em Sep').Asstring) +
         funcoes.preencheCampo(06,' ', 'e', qrProd.fieldByname('transf').Asstring)  +
         funcoes.preencheCampo(06,' ', 'e', qrProd.fieldByname('Canc').Asstring);
         dest.add(linha);
         qrProd.Next;
      end;

      if ( qrProd.eof = false ) then
      begin
         Dest.Add( '');
         Dest.Add('------------------------------------------------------------------------------------------------');
         Dest.Add('');
         l:=0
      end
      else
      begin
         while ( l < nLinPorPagina ) do
         begin
            Dest.Add('');
            inc(l);
         end;
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('                                                                             Por Walter Carvalho');
      end;
   end;
   Dest.SaveToFile( extractFilePath(ParamStr(0)) + nmArquivo);
   qrProd.First;

   funcoes.imprimeArquivo(fmConReqDep,ExtractFilePath(ParamStr(0)) + nmArquivo , false, 09, 'Consulta a requisicao.', 0);
   DeleteFile(nmArquivo);
end;

procedure TfmConReqDep.FlatButton1Click(Sender: TObject);
begin
   if qrProd.IsEmpty = false then
      MontarRelatorioImpressao(Sender, tpPapel.ItemIndex ); //sender:tobject);
end;

procedure TfmConReqDep.fsBitBtn1Click(Sender: TObject);
begin
   if dti.Date > dtf.Date then
      msgTela('','Data inicial menor que a final',mb_ok + MB_ICONERROR);
   ConsultaPedidos(nil);
end;

procedure TfmConReqDep.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   fmConReqDep := nil;
   action := cafree;
end;

procedure TfmConReqDep.fsBitBtn2Click(Sender: TObject);
begin
   MontarRelatorioImpressao(nil, 50);
end;

end.
