unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  adLabelEdit;

type
  Tfpesquisa = class(TForm)
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    rg1: TRadioGroup;
    query1: TADOQuery;
    DataSource1: TDataSource;
    Edit1: TadLabelEdit;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn6Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fpesquisa: Tfpesquisa;

implementation

uses unit1 , unit2, Unit4;
{$R *.dfm}

procedure Tfpesquisa.BitBtn1Click(Sender: TObject);
begin
   screen.cursor := crhourglass;
   with  query1.sql do
   begin
      Clear;
      add('Select numlista, loja, noiva, noivo from listas');
      if rg1.ItemIndex = 0 then
         add('Where ( noiva like ' +#39+ '%'+ edit1.text +'%'+#39+ ')')
      else
         add('Where ( noivo like ' +#39+ '%'+ edit1.text +'%'+#39+ ')');
      add('and (tipo <>'+#39+'99'+#39+')' );
      if form1.lerParametro(form1.memo1.lines[3])<> 'S' then
         add('and ( DataCasamento  >= '+#39+ form1.AjustaDataInicioDoMes('')+#39+ ')');
      if rg1.ItemIndex = 0 then
         add('order by noivo')
      else
         add('order by noiva');
   end;
   query1.open;
   edit1.setfocus;
  // QUERY1.SQL.SaveToFile('C:\TESTE.TXT');
   dbgrid1.Columns[0].title.caption := 'NUM';
   dbgrid1.Columns[1].title.caption := 'LOJA';
   dbgrid1.Columns[2].title.caption := 'NOIVA';
   dbgrid1.Columns[3].title.caption := 'NOIV0';
   DBGrid1.Columns[0].Width := 40;
   DBGrid1.Columns[1].Width := 35;
   DBGrid1.Columns[2].Width := 240;
   DBGrid1.Columns[2].Width := 240;
   screen.cursor := crdefault;
end;

procedure Tfpesquisa.FormShow(Sender: TObject);
begin
   fpesquisa.Top := 50;
   edit1.setfocus;
   fpesquisa.KeyPreview:=true;
end;

procedure Tfpesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := Cafree;
end;

procedure Tfpesquisa.BitBtn6Click(Sender: TObject);
begin
   fpesquisa.Close;
end;

procedure Tfpesquisa.DBGrid1CellClick(Column: TColumn);
begin
   try
       if dbgrid1.Fields[0].AsInteger  <> 0 then
          bitbtn5.Enabled:= true;
   except
   on e:exception do
   end;
end;

procedure Tfpesquisa.DBGrid1DblClick(Sender: TObject);
begin
   try
       if dbgrid1.Fields[0].AsInteger  <> 0 then
       begin
          BitBtn5Click(Sender);
       end;
   except
   on e:exception do
   end;
end;

procedure Tfpesquisa.BitBtn5Click(Sender: TObject);
begin
   if fpesquisa.Caption = 'Pesquisa para abrir lista' then
   begin
      produtosnalista.CarregaProdutos(dbgrid1.Fields[0].AsString,dbgrid1.Fields[2].AsString,dbgrid1.Fields[3].AsString,Sender);
      produtosnalista.BitBtn4Clic(Sender);
      BitBtn6Click(Sender);
   end;
   if fpesquisa.Caption = 'Pesquisa para imprimir lista' then
   begin
      with fimpressao do
      begin
         CapturarDadosDasTabelas(fpesquisa.dbgrid1.fields[0].AsString,sender);
         MontarRelatorioImpressao(sender);
         MandarParaImpressora(sender);
         BitBtn4Click(Sender);
      end;
      BitBtn6Click(Sender);
   end;
end;

procedure Tfpesquisa.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
      BitBtn1Click(Sender);
end;

end.
