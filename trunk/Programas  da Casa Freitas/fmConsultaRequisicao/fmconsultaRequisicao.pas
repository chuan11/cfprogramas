unit fmconsultaRequisicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelComboBox, ComCtrls,
  adLabelDBDateTimePicker, DB, ADODB, Grids, DBGrids, SoftDBGrid,funcsql,funcoes,
  fCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    Connection: TADOConnection;
    Query: TADOQuery;
    cbLojas: TadLabelComboBox;
    cbLojaEstoque: TadLabelComboBox;
    btConsultar: TFlatButton;
    dti: TfsDateTimePicker;
    dtf: TfsDateTimePicker;

    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    lbCodigo: TLabel;
    lbDesc: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ConsultaPedidos(Sender:Tobject);
    procedure ajustaLoja(Sender:TObject; combo:TcomboBox;loja:string);
    procedure btConsultarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ConnectionWillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  is_ref:String;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   Connection.Connected := false;
   Connection.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   Connection.Connected := true;

   form1.Caption := '11.02.03  Consulta Requisição por período.     '+ Connection.DefaultDatabase;


   if ParamStr(1) = '-c' then
   begin
      screen.Cursor := crHourGlass;
      // paramStr(0) = programa
      // paramStr(1) = se for  -c ele deispara a consulta
      // paramstr(2) = e o codigo da loja q consulta
      // paramstr(3) = e o codigo da loja q CONSULTADA
      // paramStr(4) = data inicial
      // paramStr95)  = data final
      // ParamStr(6) = is_ref

      cbLojas.Items := funcsQL.GetNomeLojas(Connection,true,false,'','');
      cbLojaEstoque.Items  := cbLojas.items;
      ajustaLoja(Sender, cbLojas, ParamStr(2)  );
      ajustaLoja(Sender, cbLojaEstoque, ParamStr(3)  );
      dti.Date := StrToDate( ParamStr(4) );
      dtf.Date := StrToDate( ParamStr(5) );
      is_ref := paramStr(6);

      lbCodigo.Caption := funcSQl.GetValorWell ('O', 'Select cd_ref from crefe with(nolock) where is_ref = ' + is_ref, 'cd_ref', connection);
      lbDesc.Caption := funcSQl.GetValorWell ('O', 'Select ds_ref from crefe with(nolock) where is_ref = ' + is_ref, 'ds_ref', connection);

      screen.Cursor := crDefault;
   end;
end;

procedure TForm1.ConsultaPedidos(Sender: Tobject);
var
  cmd:String;
  i:integer;
begin
   cmd :=  ' Select  dspd.dt_planod as [Data], '
          +' dspdi.is_planod as [Requisição], '
          +' tbuo.ds_uo as Loja, '
          +' dspdi.qt_ped as [Pedido], '
          +' dspdi.qt_Pend as [Pendente] , '
          +' dspdi.QtdEmSeparacao as [Em Separação], '
          +' dspdi.QtdSeparada as [Separada], '
          +' dspdi.qtdTransferida as [Transferida], '
          +' dspdi.qtdCancelada  as [Cancelada] '
          +' from dspdi with(NoLock) '
          +' inner join dspd  with(NoLock) on dspd.is_planod = dspdi.is_planod '
          +' inner join tbuo  with(NoLock) on dspdi.is_estoque = tbuo.is_uo '
          +' where '
          +' dspdi.dt_movpd between ' +   funcoes.DateTimeToSqlDateTime(dti.DateTime,' 00:00:00')
          +' and ' + funcoes.DateTimeToSqlDateTime(dtf.DateTime, ' 23:59:59')
          +' and dspd.is_estoque = ' + trim(copy(cbLojaEstoque.Items[cbLojaEstoque.ItemIndex],40,50));

          if cbLojas.ItemIndex > 0 then
             cmd := cmd +' and dspdi.is_estoque = ' + trim(copy(cbLojas.Items[cbLojas.ItemIndex],40,50));

          cmd := cmd +' and dspdi.is_ref = ' + is_ref + ' order by dspd.dt_planod ';

   Query.SQL.Clear;
   Query.SQL.add(cmd);
   query.open;

   for i := 0 to grid.columns.count -1 do
      grid.Columns[i].Title.Font.Style := [fsBold];


   grid.Columns[0].Width := 65;
   grid.Columns[01].Width := 70;
   grid.Columns[02].Width := 137;
   grid.Columns[03].Width := 55;
   grid.Columns[04].Width := 65;
   grid.Columns[05].Width := 85;
   grid.Columns[06].Width := 70;
   grid.Columns[07].Width := 70;
   grid.Columns[08].Width := 78;
end;

procedure TForm1.ajustaLoja(Sender: TObject; combo: TcomboBox;loja: string);
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

procedure TForm1.btConsultarClick(Sender: TObject);
begin
   ConsultaPedidos(Sender);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    Grid.Width := form1.Width -20;
    grid.Height := form1.Height - (grid.Top +45)
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   if Paramstr(1) = '-c' then
   begin
      screen.Cursor := crHourGlass;
      form1.Refresh;
      sleep(300);
      btConsultarClick(Sender);
      screen.Cursor := crDefault;
   end;   
end;

procedure TForm1.ConnectionWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
begin
   funcoes.gravaLog(CommandText);
end;

end.
