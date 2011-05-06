unit uImportaCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, fCtrls, ComCtrls, fDBCtrls,
  Dialogs, db, funcoes, funcsql, ADODB, funcDatas;

type
  TfmExportaEmp = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbDemitidos: TfsCheckBox;
    Memo1: TMemo;
    Button1: TButton;
    Label2: TLabel;
    dtAdmissao: TDateTimePicker;
    cbDataAdmissao: TfsCheckBox;
    procedure selecionarEmpregados2(base, filiais:String; impDemitidos:boolean);
    procedure preparaCadastroParaservidor();
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure copiaRegistroDeFerias();
    procedure copiaRegistroAfastamentos;
    procedure desativaDemitidos();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExportaEmp: TfmExportaEmp;
implementation

uses UmanBat, uPessoal, uUtil;

{$R *.dfm}

//
procedure TfmExportaEmp.copiaRegistroAfastamentos;
var
   ds:TDataSet;
   strDataInicio, cmd:String;
   qtInseridos:integer;
begin
  qtInseridos := 0;
  if ( cbDataAdmissao.Checked = true) then
     strDataInicio := ' '
  else
     strDataInicio := ' where afa_dataAfastamento >=' + funcDATAS.DateTimeToSqlDateTime(dtAdmissao.date, '');

   cmd := 'select afa_matricula, afa_dataAfastamento, afa_dataRetorno, ''A'' ' +
          'from afastamentos ' + strDataInicio;
   ds := funcsql.getDataSetQ(cmd, fmMain.Conexao );
   ds.First();

   while (ds.Eof = false) do
   begin
      if (uUtil.insereRegistroFerias('A', ds.fieldByName('afa_matricula').AsString, ds.fieldByName('afa_dataAfastamento').AsDateTime, ds.fieldByName('afa_dataRetorno').AsDateTime) = true) then
         inc(qtInseridos);
      ds.Next();
   end;
   ds.Close();
   Memo1.Lines.Add('Afastamentos inseridos: ' + intToStr(qtInseridos));
end;

procedure TfmExportaEmp.copiaRegistroDeFerias;
var
   ds:TDataSet;
   strDataInicio, cmd:String;
   qtInseridos:integer;
begin


  qtInseridos := 0;
  if ( cbDataAdmissao.Checked = true) then
     strDataInicio := ' '
  else
     strDataInicio := ' and rel_dataref1 >=' + funcDATAS.DateTimeToSqlDateTime(dtAdmissao.date, '');

   cmd := 'select rel_matricula, rel_dataref1, rel_dataref2, ''F'' ' +
          'from Relatorios where REL_GRUPO =''Férias'' ' + strDataInicio;
   ds := funcsql.getDataSetQ(cmd, fmMain.Conexao );

   ds.First();

   while (ds.Eof = false) do
   begin
      if (uUtil.insereRegistroFerias('F', ds.fieldByName('rel_matricula').AsString, ds.fieldByName('rel_dataRef1').AsDateTime, ds.fieldByName('rel_dataRef1').AsDateTime) = true) then
         inc(qtInseridos);
      ds.Next();
   end;
   ds.Close();
   Memo1.Lines.Add('Ferias inseridas: ' + intToStr(qtInseridos));
end;

procedure TfmExportaEmp.selecionarEmpregados2(base, filiais: String;impDemitidos: boolean);
var
  strData, cmd:String;
  tbEmp:TADOTable;
begin
   if (cbDataAdmissao.Checked = false) then
      strData := funcDatas.DateTimeToSqlDateTime(dtAdmissao.Date,'')
   else
      strData := funcDatas.DateTimeToSqlDateTime('01/01/1900','');

   funcsql.getTable(fmMain.Conexao, tbEmp, 'base int, estabelecimento int, matricula varchar(08), cartaoPonto varchar(08), nome varchar(50), funcao varchar(30), dataAdmissao smallDateTime ');

   cmd :=' insert ' + tbEmp.TableName  + ' select distinct ' + quotedStr(base) +  ', e.emp_estabelecimento, e.emp_matricula, e.emp_cartaoDePonto, e.emp_nome, f.fun_descricao, e.emp_dataAdmissao ' +
         ' from empregados e ' +
         ' inner join funcoes f on e.emp_funcao = f.fun_referencia ' +
         ' where (e.emp_cartaodeponto <> '''') ';

   if (impDemitidos = false) then
      cmd := cmd + ' and (e.EMP_STATUS = 1) '
   else
     cmd := cmd + '( (e.EMP_STATUS  IN  (1,2) )  ';

   cmd := cmd + 'and e.emp_estabelecimento in ( ' + filiais + ') ' +
   ' and e.emp_DataAdmissao >= '+ strData +
   ' order by e.emp_nome';

   funcsql.execSQL(cmd, fmMain.Conexao);
   tbEmp.Close;
   tbEmp.Open();

   uUtil.opendb();

   gravaLog('Quantidade de empregados da empresa ' + base +'  ' +  intTostr(tbEmp.RecordCount-1));
   tbEmp.First();
   while (tbEmp.Eof = false) do
   begin
      if ( uUtil.isPontoCadastrado(tbEmp.fieldByName('cartaoPonto').AsString) = true) then
      begin
         gravaLog('Verificando: ' + tbEmp.fieldByName('matricula').AsString +'  ' +tbEmp.fieldByName('nome').AsString  + ' -  Já existe');
         tbEmp.Delete();
      end
      else
      begin
         gravaLog('Verificando: ' + tbEmp.fieldByName('matricula').AsString +'  ' +tbEmp.fieldByName('nome').AsString + '  -  incluir.');
         tbEmp.Next();
      end;
   end;
   memo1.lines.add('Quantidade de empregados a incluir na empresa ' + base + ': ' + intToStr( tbEmp.RecordCount) );

   try
   tbEmp.First;
   while (tbEmp.Eof = false) do
   begin
      memo1.lines.add(tbEmp.fieldByName('matricula').AsString + '  -  ' + tbEmp.fieldByName('nome').AsString );
      uUtil.insereEmpregado(
         base,
         tbEmp.fieldByName('matricula').AsString,
         tbEmp.fieldByName('cartaoPonto').AsString,
         tbEmp.fieldByName('nome').AsString,
         tbEmp.fieldByName('funcao').AsString,
         tbEmp.fieldByName('dataAdmissao').AsString,
         '0','0','0', '')
         ;
      tbEmp.Next();
   end;
   except
      on e: exception do
      begin
         msgTela('','Erro ao exportar o cadastro, no empregado ' + tbEmp.fieldByName('matricula').AsString + '  -  ' + tbEmp.fieldByName('nome').AsString , 0);
         tbEmp.Last();
      end;
   end;
end;

procedure TfmExportaEmp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
    fmExportaEmp := nil;
end;

procedure TfmExportaEmp.FormActivate(Sender: TObject);
begin
   memo1.Lines.add('Ultima carga em: ' + uUtil.lerParametroBD('ponto.dataUltCarga') );
end;



procedure TfmExportaEmp.desativaDemitidos;
var
   ds:TdataSet;
   strData, cmd:String;
begin
   Memo1.Lines.Add('Empregados desativados:');

   if (cbDataAdmissao.Checked = false) then
      strData := funcDatas.DateTimeToSqlDateTime(dtAdmissao.Date,'')
   else
      strData := funcDatas.DateTimeToSqlDateTime('01/10/2010','');

   cmd := 'select distinct '+
          'relatorios.rel_matricula, empregados.emp_nome, '+
          'relatorios.rel_dataref1 ' +
          'from relatorios '+
          'inner join empregados on empregados.emp_matricula = relatorios.rel_matricula '  +
          'where relatorios.rel_grupo = ''Rescisão'' ' +
          'and relatorios.rel_dataref1 >= ' + strData;
   ds := funcSQL.getDataSetQ(cmd, fmMain.Conexao);

   ds.First();

   while (ds.Eof = false) do
   begin
      if (uUtil.desativaEmpregado(ds.fieldByName('rel_matricula').AsString,  ds.fieldByName('rel_dataref1').AsDateTime ) = true )then
         Memo1.Lines.Add( ds.fieldByName('emp_nome').AsString +' '+ ds.fieldByName('rel_dataref1').AsString);
      ds.Next();
   end;
end;

procedure TfmExportaEmp.PreparaCadastroParaservidor();
var
   i:integer;
   estabelecimentos:array[1..3] of String;
   mnEmpresa:array[1..3] of String;
begin
   estabelecimentos[1] :=  ' ''000'' , ''002'', ''003'' ';
   estabelecimentos[2] :=  ' ''000'' , ''005'' , ''006'' , ''007'' , ''009'' , ''010'' , ''011'', ''012'', ''017'', ''018'' ';
   estabelecimentos[3] :=  ' ''008'' ';
   mnEmpresa[1] := 'Empregados CF';
   mnEmpresa[2] := 'Empregados PFM';
   mnEmpresa[3] := 'Empregados CF';


   for i:=1 to 3 do
   begin
      fmMain.ConectarAoBd(intToStr(i));
      selecionarEmpregados2( intToStr(i), estabelecimentos[i], cbDemitidos.Checked );
      copiaRegistroDeFerias();
      copiaRegistroAfastamentos();
      desativaDemitidos();
   end;
   uUtil.setParamBD('ponto.dataUltCarga','', dateToStr(now));
end;


procedure TfmExportaEmp.Button1Click(Sender: TObject);
begin
   preparaCadastroParaservidor();
end;


end.
