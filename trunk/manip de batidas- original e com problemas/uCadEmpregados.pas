unit uCadEmpregados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, adLabelEdit, adLabelComboBox, Db, Buttons,
  fCtrls, DBGrids, ADODB, Grids, SoftDBGrid, TFlatCheckBoxUnit;

type
  TfmCadEmpregados = class(TForm)
    gpListaEmp: TGroupBox;
    gpEmp: TGroupBox;
    edNome: TadLabelEdit;
    edMatricula: TadLabelEdit;
    edCartaoPonto: TadLabelEdit;
    rgHoraFlexivel: TRadioGroup;
    edFuncao: TadLabelEdit;
    edLocalizacao: TadLabelEdit;
    edHorario: TadLabelEdit;
    btCarregaHorario: TfsBitBtn;
    lbHorario: TLabel;
    lbLocalizacao: TLabel;
    fsBitBtn1: TfsBitBtn;
    Panel2: TPanel;
    fsBitBtn2: TfsBitBtn;
    fsBitBtn3: TfsBitBtn;
    lbDataAdmissao: TLabel;
    lbEmpresa: TLabel;
    gridEmp: TSoftDBGrid;
    DataSource1: TDataSource;
    qr: TADOQuery;
    edLocEmp: TadLabelEdit;
    cbLojas: TComboBox;
    cbBatePonto: TFlatCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbEmpClick(Sender: TObject);
    procedure btCarregaHorarioClick(Sender: TObject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure fsBitBtn3Click(Sender: TObject);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure gridEmpTitleClick(Column: TColumn);
    procedure gridEmpDblClick(Sender: TObject);
    procedure edLocEmpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure carregaCadastro();
    procedure cbLojasChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCadEmpregados: TfmCadEmpregados;

implementation

uses uUtil, UmanBat, uListas, {Horarios,}  funcsql, FUNCOES;

{$R *.dfm}

procedure TfmCadEmpregados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmMain.MsgDeRodape('');
   action := caFree;
   fmCadEmpregados := nil;
end;

procedure TfmCadEmpregados.cbEmpClick(Sender: TObject);
var
   ds:TdataSet;
begin
   gpEmp.Visible := false; 
   ds := uUtil.getDetalheEmpregado( qr.fieldByname('cartaoPonto').asString);
   edMatricula.Text := ds.FieldByName('matricula').AsString;
   edCartaoPonto.Text := ds.FieldByName('cartaoPonto').AsString;
   edFuncao.Text  := ds.FieldByName('funcao').AsString;
   edNome.Text := ds.FieldByName('nome').AsString;
   rgHoraFlexivel.ItemIndex := ds.FieldByName('isHoraFlexivel').AsInteger;
   edLocalizacao.Text := ds.FieldByName('ds_uo').AsString;
   lbLocalizacao.caption := ds.FieldByName('localizacao').AsString;
   lbDataAdmissao.Caption := ds.FieldByName('dataAdmissao').AsString;
   lbEmpresa.Caption := ds.FieldByName('empresa').AsString;

   cbBatePonto.Checked := (ds.FieldByName('dataDemissao').AsString = '');

   edHorario.Text := ds.FieldByName('descricao').AsString;
   lbHorario.Caption := ds.FieldByName('horario_num').AsString;
   gpEmp.Visible := true;
   gridEmp.Enabled := false;
end;

procedure TfmCadEmpregados.btCarregaHorarioClick(Sender: TObject);
begin
   Application.CreateForm(TfmListas, fmListas );
   fmListas.CarregaHorarios();
   fmListas.ShowModal;

   if (fmListas.ModalResult = mrOk) then
   begin
      edHorario.Text :=  fmListas.tb.FieldByName('descricao').AsString;
      lbHorario.Caption := fmListas.tb.FieldByName('num').AsString;
   end;
end;

procedure TfmCadEmpregados.fsBitBtn1Click(Sender: TObject);
begin
   Application.CreateForm(TfmListas, fmListas );
   fmListas.carregaLocalizacoes();
   fmListas.ShowModal;

   if (fmListas.ModalResult = mrOk) then
   begin
      edLocalizacao.Text :=  fmListas.tb.FieldByName('ds_uo').AsString;
      lbLocalizacao.Caption := fmListas.tb.FieldByName('localizacao').AsString;
   end;

end;

procedure TfmCadEmpregados.fsBitBtn3Click(Sender: TObject);
var
  dataDemissao:String;
begin
  if (cbBatePonto.Checked= false) then
     dataDemissao := '01/01/1900'
  else
     dataDemissao := '';

  if( uUtil.deletaEmpregado(edCartaoPonto.Text) = true) and
    (
   uUtil.insereEmpregado( lbEmpresa.Caption, edMatricula.Text, edCartaoPonto.Text,
                          edNome.Text, edFuncao.Text, lbDataAdmissao.Caption,
                          intToStr(rgHoraFlexivel.ItemIndex), lbHorario.Caption,
                          lbLocalizacao.Caption, dataDemissao ) ) then
   MsgTela('','Dados Salvos com sucesso.', MB_OK + MB_ICONEXCLAMATION);
  fsBitBtn2Click(nil);
end;

procedure TfmCadEmpregados.fsBitBtn2Click(Sender: TObject);
begin
  gridEmp.Enabled := true;
  edLocEmp.Text := '';
  edLocEmp.SetFocus();
  gpEmp.Visible := false;
  carregaCadastro();
end;

procedure TfmCadEmpregados.carregaCadastro();
var
   cmd:String;
begin
    cmd:= 'select e.Matricula, e.cartaoPonto, e.Localizacao, e.Nome, L.ds_uo as Local, H.descricao ' +
          'from zcf_pontoEmpregados e (nolock) ' +
          'left join  zcf_pontoLocalizacao L (nolock) on e.localizacao = L.localizacao ' +
          'left join zcf_pontoHorarios H (nolock) on e.horario_num = H.num ';
    if (cbLojas.ItemIndex > 1 ) then
       cmd := cmd + ' where e.localizacao =' + uUtil.getNumLocalEmpresa(cbLojas);

    if (cbLojas.ItemIndex = 1 ) then
       cmd := cmd + ' where e.localizacao = 0 ';

    uUtil.getQuery(qr, cmd );

    gridEmp.columns[0].Width := 70;
    gridEmp.columns[1].Width := 70;
    gridEmp.columns[2].Width := 70;
    gridEmp.columns[3].Width := 200;
    gridEmp.columns[4].Width := 100;
    gridEmp.columns[5].Width := 100;

    fmMain.MsgDeRodape('Quantidade de empregados: ' + intTostr(qr.RecordCount));
end;



procedure TfmCadEmpregados.FormActivate(Sender: TObject);
begin
   cbLojas.Items := uUtil.getNomeLojasPonto(True, true);
   cbLojas.ItemIndex := 0 ;
   carregaCadastro();
end;

procedure TfmCadEmpregados.gridEmpTitleClick(Column: TColumn);
begin
   uUtil.organizarQuery(qr, Column);
end;

procedure TfmCadEmpregados.gridEmpDblClick(Sender: TObject);
begin
   cbEmpClick(nil);
end;

procedure TfmCadEmpregados.edLocEmpKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   qr.Locate('nome',edLocEmp.Text, [loPartialKey] );
end;


procedure TfmCadEmpregados.cbLojasChange(Sender: TObject);
begin
   carregaCadastro();
end;

end.
