unit uSelCat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, Buttons, fCtrls, Grids, DBGrids, SoftDBGrid;

type
  TfmSelCat = class(TForm)
    lbnivel: TLabel;
    grClasse1: TSoftDBGrid;
    grClasse2: TSoftDBGrid;
    grClasse3: TSoftDBGrid;
    fsBitBtn1: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    qrClasse1: TADOQuery;
    qrClasse2: TADOQuery;
    qrClasse3: TADOQuery;
    DsClasse1: TDataSource;
    dsClasse2: TDataSource;
    dsClasse3: TDataSource;
    lbClasse: TLabel;


  procedure AbreCategoria01(Sender:Tobject;Conexao:TADOConnection);
  procedure AbreConexoes(Sender:Tobject);
    procedure FormCreate(Sender: TObject);
    procedure grClasse1CellClick(Column: TColumn);
    procedure grClasse2CellClick(Column: TColumn);
    procedure grClasse3CellClick(Column: TColumn);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure fsBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  fmSelCat: TfmSelCat;

implementation
uses unit1;

{$R *.dfm}


procedure TfmSelCat.AbreCategoria01(Sender:Tobject;Conexao:TADOConnection);
begin//


end;



procedure TfmSelCat.AbreConexoes(Sender: Tobject);
begin
{ grClasse1.DataSource := DsClasse1;
  DsClasse1.DataSet := qrClasse1;
  grClasse2.DataSource := DsClasse3;
  DsClasse2.DataSet := qrClasse3;
  grClasse3.DataSource := DsClasse3;
  DsClasse3.DataSet := qrClasse3;
}
end;

procedure TfmSelCat.FormCreate(Sender: TObject);
begin
   qrclasse1.Open();
end;

procedure TfmSelCat.grClasse1CellClick(Column: TColumn);
begin
   if qrClasse3.IsEmpty = false then
      qrClasse3.Close;
   if qrClasse2.IsEmpty = false then
      qrClasse2.Close;
   qrClasse2.sql.clear;
   qrClasse2.SQL.add('select cd_vcampo, ds_vcampo  from tvcom  where cd_campo =2 and cd_vcampopai = '+ quotedStr( qrClasse1.fieldByName('cd_vcampo').asString ) + '  order by ds_vcampo');
   qrClasse2.Open;

   lbNivel.Caption := '1';
   lbClasse.Caption:= qrClasse1.fieldByName('cd_vcampo').asString;

   form1.lbClasse1.Caption := qrClasse1.fieldByName('ds_vcampo').asString;
   form1.lbClasse2.Caption := '--------------------';
   form1.lbClasse3.Caption := '--------------------';
end;

procedure TfmSelCat.grClasse2CellClick(Column: TColumn);
begin
   if qrClasse3.IsEmpty = false then
      qrClasse3.Close;
   qrClasse3.sql.clear;
   qrClasse3.SQL.add('select cd_vcampo, ds_vcampo  from tvcom  where cd_campo =3 and cd_vcampopai = '+ quotedStr( qrClasse2.fieldByName('cd_vcampo').asString ) + '  order by ds_vcampo');
   qrClasse3.Open;
   lbNivel.Caption := '2';
   lbClasse.Caption:= qrClasse2.fieldByName('cd_vcampo').asString;

   form1.lbClasse2.Caption := qrClasse2.fieldByName('ds_vcampo').asString;
   form1.lbClasse3.Caption := '--------------------';
end;

procedure TfmSelCat.grClasse3CellClick(Column: TColumn);
begin
   lbNivel.Caption := '3';
   lbClasse.Caption:= qrClasse3.fieldByName('cd_vcampo').asString;

   form1.lbClasse3.Caption := qrClasse3.fieldByName('ds_vcampo').asString;
end;

procedure TfmSelCat.fsBitBtn2Click(Sender: TObject);
begin
    form1.lbClasse1.Caption :=     '--------------------';
    form1.lbClasse2.Caption :=     '--------------------';
    form1.lbClasse3.Caption :=     '--------------------';
    form1.lbNivel.Caption := '0';
    form1.lbCodigo.Caption := '0';
end;

procedure TfmSelCat.fsBitBtn1Click(Sender: TObject);
begin
   form1.lbNivel.Caption := lbnivel.caption;
   form1.lbCodigo.Caption := lbClasse.Caption
end;

end.
