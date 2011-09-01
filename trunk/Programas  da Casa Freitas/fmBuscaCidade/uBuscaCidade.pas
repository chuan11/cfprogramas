unit uBuscaCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListaFornecedores, DB, StdCtrls, Buttons, fCtrls, adLabelEdit,
  Grids, DBGrids, SoftDBGrid;

type
  TfmBuscaDiversas = class(TfmListaFornecedores)
    edFiltro: TEdit;
    procedure btBuscaClick(Sender: TObject);
    procedure setPerfil(strPerfil:String);
    procedure ajustaPerfilUF();
    procedure ajustaPerfilCidade();
    procedure ajustaPerfilBairro();
    procedure buscaCidade();
    procedure buscaBairro();
    procedure fsBitBtn3Click(Sender: TObject);
    procedure fnGridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBuscaDiversas: TfmBuscaDiversas;
  PERFIL:String;
implementation

uses UCF;

{$R *.dfm}

procedure TfmBuscaDiversas.ajustaPerfilCidade;
begin
   fmBuscaDiversas.Caption := 'Busca Cidade';
   edit1.LabelDefs.Caption := 'Cidade';
end;

procedure TfmBuscaDiversas.ajustaPerfilUF;
begin
    fmBuscaDiversas.Caption := 'Busca Bairro';
    edit1.LabelDefs.Caption := '';
    edit1.Visible := false;
    edFiltro.Visible := false;
    btBusca.Visible := false;
    dspes.DataSet := uCF .getUFS();
    fnGrid.Columns[ dsPes.DataSet.FieldByName('cd_uf').Index  ].Title.Caption := 'UF';
    fnGrid.Columns[ dsPes.DataSet.FieldByName('nm_uf').Index  ].Title.Caption := 'Estado'
end;

procedure TfmBuscaDiversas.ajustaPerfilBairro;
begin
   fmBuscaDiversas.Caption := 'Busca bairro';
   edit1.LabelDefs.Caption := 'Bairro';
   edFiltro.Visible := false;
end;


procedure TfmBuscaDiversas.buscaCidade;
begin
   dspes.DataSet := uCF.getListaCidades(edFiltro.text, edit1.text);
   fnGrid.Columns[ dsPes.DataSet.FieldByName('cd_cid').Index  ].Visible := false;
   fnGrid.Columns[ dsPes.DataSet.FieldByName('nm_cid').Index  ].Title.Caption := 'Cidade';
end;

procedure TfmBuscaDiversas.buscaBairro;
begin
   dspes.dataSet := uCF.getLstaBairros('', edFiltro.Text, edit1.Text);
   fnGrid.Columns[ dsPes.DataSet.FieldByName('cd_bai').Index  ].Visible := false;
   fnGrid.Columns[ dsPes.DataSet.FieldByName('nm_bai').Index  ].Title.Caption := 'Bairro';
end;

procedure TfmBuscaDiversas.btBuscaClick(Sender: TObject);
begin
   if (PERFIL = 'cidade') then
      buscaCidade();

   if (PERFIL = 'bairro') then
      buscaBairro();
end;

procedure TfmBuscaDiversas.setPerfil(strPerfil: String);
begin
   PERFIL := strPerfil;

   if (PERFIL = 'uf') then
      ajustaPerfilUF();

   if (PERFIL = 'cidade') then
      ajustaPerfilCidade();

   if (PERFIL = 'bairro') then
      ajustaPerfilBairro();
end;

procedure TfmBuscaDiversas.fsBitBtn3Click(Sender: TObject);
begin
  if (dspes.DataSet = nil) then
     ModalResult := mrCancel
  else
     ModalResult := mrOk;
end;

procedure TfmBuscaDiversas.fnGridDblClick(Sender: TObject);
begin
//  inherited;
   fsBitBtn3Click(nil);
end;

end.
