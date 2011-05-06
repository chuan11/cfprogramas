unit unClasses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, StdCtrls, Buttons, fCtrls, DB, ADODB,
  funcoes;

type
  TFmClasses = class(TForm)
    grClasse1: TSoftDBGrid;
    grClasse2: TSoftDBGrid;
    grClasse3: TSoftDBGrid;
    fsBitBtn1: TfsBitBtn;
    qrClasse1: TADOQuery;
    qrClasse2: TADOQuery;
    qrClasse3: TADOQuery;
    DsClasse1: TDataSource;
    dsClasse2: TDataSource;
    dsClasse3: TDataSource;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grClasse1CellClick(Column: TColumn);
    procedure grClasse2CellClick(Column: TColumn);
    procedure grClasse3CellClick(Column: TColumn);
    procedure fsBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmClasses: TFmClasses;
  c1,c2,c3:string;
  nClasse, nivelClasse : string;
implementation

uses Unit1;

{$R *.dfm}
procedure TFmClasses.FormCreate(Sender: TObject);
begin
   c1:='';
   c2:='';
   c3:='';
   qrClasse1.SQL.Clear;
   qrClasse1.SQL.Add('select cd_vcampo, ds_vcampo  from tvcom  with(NoLock) where cd_campo =1 order by ds_vcampo');
   qrClasse1.Open;
   grClasse1.Columns[0].Visible := false;
   grClasse1.Columns[1].Title.caption := 'Departamento';
end;

procedure TFmClasses.grClasse1CellClick(Column: TColumn);
begin
   c2 := '';

   qrClasse2.sql.clear;
   qrClasse2.SQL.add('select cd_vcampo, ds_vcampo  from tvcom  where cd_campo =2 and cd_vcampopai = '+ quotedStr(qrClasse1.Fields[0].AsString ) + '  order by ds_vcampo');
   qrClasse2.Open;

   c1 := qrClasse1.fieldByname('cd_vcampo').AsString;

   qrClasse3.SQL.Clear;
   c3:= '';
   Label1.Caption := '1/'+c1;
end;

procedure TFmClasses.grClasse2CellClick(Column: TColumn);
begin
   qrClasse3.SQL.Clear;
   c3:= '';

   qrClasse3.sql.clear;
   qrClasse3.SQL.add('select cd_vcampo, ds_vcampo  from tvcom  where cd_campo =3 and cd_vcampopai = '+ quotedStr(qrClasse2.Fields[0].AsString ) + '  order by ds_vcampo');
   qrClasse3.Open;

   c2:= qrClasse2.fieldByname('cd_vcampo').AsString;
   Label1.Caption := '2/'+c2;
end;

procedure TFmClasses.grClasse3CellClick(Column: TColumn);
begin
   c3 := qrClasse3.fieldByname('cd_vcampo').AsString;
   Label1.Caption := '3/'+c3;
end;

procedure TFmClasses.fsBitBtn1Click(Sender: TObject);
begin
   nivelClasse := '0';
   nClasse := '0000';
   form1.lbClasse1.caption := '--------------------';
   form1.lbClasse2.caption := '--------------------';
   form1.lbClasse3.caption := '--------------------';


   if  c1 <> '' then
   begin
      form1.lbClasse1.Caption := qrClasse1.fieldByname('ds_vcampo').AsString;
      nClasse := qrClasse1.fieldByname('cd_vcampo').AsString;
      nivelClasse := '1';
      form1.lbClasse2.caption := '--------------------';
      form1.lbClasse3.caption := '--------------------';
   end;

   if  c2 <> '' then
   begin
      form1.lbClasse2.Caption := qrClasse2.fieldByname('ds_vcampo').AsString;
      nClasse := qrClasse2.fieldByname('cd_vcampo').AsString;
      nivelClasse := '2';
      form1.lbClasse3.caption := '--------------------'
   end;

   if  c3 <> '' then
   begin
      form1.lbClasse3.Caption := qrClasse3.fieldByname('ds_vcampo').AsString;
      nivelClasse := '3';
      nClasse := qrClasse3.fieldByname('cd_vcampo').AsString;
   end;
   fmClasses.Close;
   form1.lbNivel.Caption := nivelClasse;
   form1.lbCodigo.Caption := nClasse;
end;

end.
