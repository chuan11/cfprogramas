unit uHorarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, Mask, ExtCtrls,
  Buttons, fCtrls, funcoes, funcDatas, funcsql;

type
  TfmHorarios = class(TForm)
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    tbHor: TADOTable;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edSegEnt: TMaskEdit;
    edSegIntIni: TMaskEdit;
    edSegIntFim: TMaskEdit;
    edSegSai: TMaskEdit;
    edTerEnt: TMaskEdit;
    edTerIntIni: TMaskEdit;
    edTerIntFim: TMaskEdit;
    edTerSai: TMaskEdit;
    edQuaIntIni: TMaskEdit;
    edQuaIntFim: TMaskEdit;
    edQuaSai: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edQuaEnt: TMaskEdit;
    btCarregaHorario: TfsBitBtn;
    fsBitBtn4: TfsBitBtn;
    fsBitBtn5: TfsBitBtn;
    fsBitBtn6: TfsBitBtn;
    fsBitBtn7: TfsBitBtn;
    fsBitBtn8: TfsBitBtn;
    edSabSai: TMaskEdit;
    edSabIntFim: TMaskEdit;
    edSabIntIni: TMaskEdit;
    edSabEnt: TMaskEdit;
    edSexEnt: TMaskEdit;
    edSexIntIni: TMaskEdit;
    edSexIntFim: TMaskEdit;
    edSexSai: TMaskEdit;
    edQuiSai: TMaskEdit;
    edQuiIntFim: TMaskEdit;
    edQuiIntIni: TMaskEdit;
    edQuiEnt: TMaskEdit;
    Label12: TLabel;
    lbTotHoras: TLabel;
    btDeleta: TfsBitBtn;
    Panel2: TPanel;
    fsBitBtn2: TfsBitBtn;
    fsBitBtn3: TfsBitBtn;
    procedure carregaTabela();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure fsBitBtn3Click(Sender: TObject);
    procedure fsBitBtn4Click(Sender: TObject);
    procedure fsBitBtn5Click(Sender: TObject);
    procedure fsBitBtn6Click(Sender: TObject);
    procedure fsBitBtn7Click(Sender: TObject);
    procedure fsBitBtn8Click(Sender: TObject);
    procedure btCarregaHorarioClick(Sender: TObject);
    procedure fsBitBtn2Click(Sender: TObject);
    function verificaCamposPreenchidos():boolean;
    procedure calculaHorasHorario();
    procedure edSegEntExit(Sender: TObject);
    procedure tbHorBeforeDelete(DataSet: TDataSet);
    procedure btDeletaClick(Sender: TObject);
    procedure salvaHorario();
    procedure gridCellClick(Column: TColumn);
    procedure preparaParaModal();
    procedure gridTitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmHorarios: TfmHorarios;

implementation

uses UmanBat;

{$R *.dfm}

procedure TfmHorarios.carregaTabela;
var
  i:integer;
begin
   tbHor.TableName := 'zcf_pontoHorarios';
   tbHor.Filter := 'num >= 1 ';
   tbHor.Filtered := true;
   tbHor.Open();
   grid.Columns[ tbHor.FieldByName('num').Index].Visible := false;

   for i:= 2 to tbHor.FieldCount -1 do
      grid.Columns[i].Visible := false;
end;


procedure TfmHorarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    action := CaFree;
    fmHorarios:= nil;
end;

procedure TfmHorarios.FormCreate(Sender: TObject);
begin
   carregaTabela();
end;

procedure TfmHorarios.fsBitBtn3Click(Sender: TObject);
begin
  if (fmHorarios.FormStyle = fsMDIChild) then
     salvaHorario()
  else
     ModalResult := mrOK;
end;

procedure TfmHorarios.fsBitBtn4Click(Sender: TObject);
begin
   edTerEnt.Text := edSegEnt.Text;
   edTerIntIni.Text := edSegIntIni.Text;
   edTerIntFim.Text := edSegIntFim.Text;
   edTerSai.Text := edSegSai.Text;
end;

procedure TfmHorarios.fsBitBtn5Click(Sender: TObject);
begin
   edQuaEnt.Text := edTerEnt.Text;
   edQuaIntIni.Text := edTerIntIni.Text;
   edQuaIntFim.Text := edTerIntFim.Text;
   edQuaSai.Text := edTerSai.Text;
end;

procedure TfmHorarios.fsBitBtn6Click(Sender: TObject);
begin
   edQuiEnt.Text := edQuaEnt.Text;
   edQuiIntIni.Text := edQuaIntIni.Text;
   edQuiIntFim.Text := edQuaIntFim.text;
   edQuiSai.Text := edQuaSai.Text;
end;

procedure TfmHorarios.fsBitBtn7Click(Sender: TObject);
begin
   edSexEnt.Text := edQuiEnt.Text;
   edSexIntIni.Text := edQuiIntIni.Text;
   edSexIntFim.Text := edQuiIntFim.Text;
   edSexSai.Text := edQuiSai.Text;
end;

procedure TfmHorarios.fsBitBtn8Click(Sender: TObject);
begin
   edSabEnt.Text := edSexEnt.Text;
   edSabIntIni.Text := edSexIntIni.Text;
   edSabIntFim.Text := edSexIntFim.Text;
   edSabSai.Text := edSexSai.Text;
end;

procedure TfmHorarios.btCarregaHorarioClick(Sender: TObject);
var
   ds:TdataSet;
begin
   if (tbHor.IsEmpty = false) then
begin

   ds := funcsql.getDataSetQ('Select * from zcf_pontoHorarios where num  = ' + tbHor.fieldByName('num').AsString, fmMain.conexaoWell);
   edSegEnt.Text := ds.fieldByName('hSegIni').AsString;
   edSegIntIni.Text := ds.fieldByName('hSegIntIni').AsString;
   edSegIntFim.Text := ds.fieldByName('hSegIntFim').AsString;
   edSegSai.Text := ds.fieldByName('hSegFim').AsString;

   edTerEnt.Text := ds.fieldByName('hTerIni').AsString;
   edTerIntIni.Text := ds.fieldByName('hTerIntIni').AsString;
   edTerIntFim.Text := ds.fieldByName('hTerIntFim').AsString;
   edTerSai.Text := ds.fieldByName('hTerFim').AsString;

   edQuaEnt.Text := ds.fieldByName('hQuaIni').AsString;
   edQuaIntIni.Text := ds.fieldByName('hQuaIntIni').AsString;
   edQuaIntFim.Text := ds.fieldByName('hQuaIntFim').AsString;
   edQuaSai.Text := ds.fieldByName('hQuaFim').AsString;

   edQuiEnt.Text := ds.fieldByName('hQuiIni').AsString;
   edQuiIntIni.Text := ds.fieldByName('hQuiIntIni').AsString;
   edQuiIntFim.Text := ds.fieldByName('hQuiIntFim').AsString;
   edQuiSai.Text := ds.fieldByName('hQuiFim').AsString;

   edSexEnt.Text := ds.fieldByName('hSexIni').AsString;
   edSexIntIni.Text := ds.fieldByName('hSexIntIni').AsString;
   edSexIntFim.Text := ds.fieldByName('hSexIntFim').AsString;
   edSexSai.Text := ds.fieldByName('hSexFim').AsString;

   edSabEnt.Text := ds.fieldByName('hSabIni').AsString;
   edSabIntIni.Text := ds.fieldByName('hSabIntIni').AsString;
   edSabIntFim.Text := ds.fieldByName('hSabIntFim').AsString;
   edSabSai.Text := ds.fieldByName('hSabFim').AsString;

   ds.Destroy();
   btCarregaHorario.Visible := false;
   btDeleta.Visible := false;

   Panel1.Visible := true;


   calculaHorasHorario();
end;
end;

procedure TfmHorarios.fsBitBtn2Click(Sender: TObject);
begin
   if( fmHorarios.FormStyle = fsStayOnTop) then
     ModalResult := mrCancel
   else
   begin
      btCarregaHorario.Visible := true;
      btDeleta.Visible := true;
      Panel1.Visible := false;
   end;
end;

function TfmHorarios.verificaCamposPreenchidos:boolean;
var
   i:integer;
begin
   for i:=0 to fmHorarios.ComponentCount-1 do
      if (fmHorarios.Components[i].ClassName = 'TMaskEdit') then
         if ((fmHorarios.Components[i] as TMaskEdit).Text = '00:00') then
         begin
            result := true;
            break;
         end;
end;

procedure TfmHorarios.calculaHorasHorario;
begin
   lbTotHoras.Caption :=
   intToHora (
   (horaToInt(edSegSai.Text) - horaToInt(edSegEnt.Text)) -  ( horaToInt(edSegIntFim.Text) - horaToInt(edSegIntIni.Text))  +
   (horaToInt(edTerSai.Text) - horaToInt(edTerEnt.Text)) -  ( horaToInt(edTerIntFim.Text) - horaToInt(edTerIntIni.Text))  +
   (horaToInt(edQuaSai.Text) - horaToInt(edQuaEnt.Text)) -  ( horaToInt(edQuaIntFim.Text) - horaToInt(edQuaIntIni.Text))  +
   (horaToInt(edQuiSai.Text) - horaToInt(edQuiEnt.Text)) -  ( horaToInt(edQuiIntFim.Text) - horaToInt(edQuiIntIni.Text))  +
   (horaToInt(edSexSai.Text) - horaToInt(edSexEnt.Text)) -  ( horaToInt(edSexIntFim.Text) - horaToInt(edSexIntIni.Text))  +
   (horaToInt(edSabSai.Text) - horaToInt(edSabEnt.Text)) -  ( horaToInt(edSabIntFim.Text) - horaToInt(edSabIntIni.Text))
   )
end;


procedure TfmHorarios.edSegEntExit(Sender: TObject);
begin
  calculaHorasHorario();
end;

procedure TfmHorarios.tbHorBeforeDelete(DataSet: TDataSet);
begin
   if ( funcSQl.openSQL('Select top 01 horario_num from zcf_pontoEmpregados where horario_num = ' +  tbHor.fieldByname('num').asString, 'horario_num', fmMain.conexaoWell ) <> '' ) then
   begin
      MsgTela('','Não posso excluir esse horário pois '+#13+'ele tem empregados associados', MB_ICONERROR );
      tbHor.Cancel();
   end;
end;

procedure TfmHorarios.btDeletaClick(Sender: TObject);
begin
   if MsgTela('','Deseja excluir esse horário? ' , MB_YESNO + MB_ICONQUESTION) = mrYes then
      tbHor.Delete();
end;

procedure TfmHorarios.salvaHorario;
begin
   if (verificaCamposPreenchidos() = true) then
     MsgTela('', 'campos nao preenchidos', 0);

   tbHor.Edit;
   tbHor.FieldByName('hSegIni').AsString := funcoes.preencheCampo(05,'0','d',edSegEnt.Text);
   tbHor.FieldByName('hSegIntIni').AsString := funcoes.preencheCampo(05,'0','d',edSegIntIni.Text);
   tbHor.FieldByName('hSegIntFim').AsString := funcoes.preencheCampo(05,'0','d',edSegIntFim.Text);
   tbHor.FieldByName('hSegFim').AsString := funcoes.preencheCampo(05,'0','d',edSegSai.Text);

   tbHor.FieldByName('hTerIni').AsString := funcoes.preencheCampo(05,'0','d',edTerEnt.Text);
   tbHor.FieldByName('hTerIntIni').AsString := funcoes.preencheCampo(05,'0','d',edTerIntIni.Text);
   tbHor.FieldByName('hTerIntFim').AsString := funcoes.preencheCampo(05,'0','d',edTerIntFim.Text);
   tbHor.FieldByName('hTerFim').AsString := funcoes.preencheCampo(05,'0','d',edTerSai.Text);

   tbHor.FieldByName('hQuaIni').AsString := funcoes.preencheCampo(05,'0','d',edQuaEnt.Text);
   tbHor.FieldByName('hQuaIntIni').AsString := funcoes.preencheCampo(05,'0','d',edQuaIntIni.Text);
   tbHor.FieldByName('hQuaIntFim').AsString := funcoes.preencheCampo(05,'0','d',edQuaIntFim.Text);
   tbHor.FieldByName('hQuaFim').AsString := funcoes.preencheCampo(05,'0','d',edQuaSai.Text);

   tbHor.FieldByName('hQuiIni').AsString := funcoes.preencheCampo(05,'0','d',edQuiEnt.Text);
   tbHor.FieldByName('hQuiIntIni').AsString := funcoes.preencheCampo(05,'0','d',edQuiIntIni.Text);
   tbHor.FieldByName('hQuiIntFim').AsString := funcoes.preencheCampo(05,'0','d',edQuiIntFim.Text);
   tbHor.FieldByName('hQuiFim').AsString := funcoes.preencheCampo(05,'0','d',edQuiSai.Text);

   tbHor.FieldByName('hSexIni').AsString := funcoes.preencheCampo(05,'0','d',edSexEnt.Text);
   tbHor.FieldByName('hSexIntIni').AsString := funcoes.preencheCampo(05,'0','d',edSexIntIni.Text);
   tbHor.FieldByName('hSexIntFim').AsString := funcoes.preencheCampo(05,'0','d',edSexIntFim.Text);
   tbHor.FieldByName('hSexFim').AsString := funcoes.preencheCampo(05,'0','d',edSexSai.Text);

   tbHor.FieldByName('hSabIni').AsString := funcoes.preencheCampo(05,'0','d',edSabEnt.Text);
   tbHor.FieldByName('hSabIntIni').AsString := funcoes.preencheCampo(05,'0','d',edSabIntIni.Text);
   tbHor.FieldByName('hSabIntFim').AsString := funcoes.preencheCampo(05,'0','d',edSabIntFim.Text);
   tbHor.FieldByName('hSabFim').AsString := funcoes.preencheCampo(05,'0','d',edSabSai.Text);

   tbHor.post();
   carregaTabela();
   fsBitBtn2Click(NIL);

end;

procedure TfmHorarios.gridCellClick(Column: TColumn);
begin
    btCarregaHorarioClick(nil);
end;

procedure TfmHorarios.preparaParaModal;
begin
   with fmHorarios do
   begin
      FormStyle := fsStayOnTop;
      Width := 620;
      Height := 385;
      top := fmMain.Top;
      BorderIcons := [biSystemMenu];
      left := fmMain.Left + 50;
   end;
end;

procedure TfmHorarios.gridTitleClick(Column: TColumn);
begin
    FUNCSQL.organizarTabela(TBhOR, COLUMN);
end;

end.
