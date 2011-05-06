unit ucopiarPlanodeContas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, funcoes, StdCtrls, TFlatMemoUnit, TFlatButtonUnit;

type
  TForm1 = class(TForm)
    ADOconnection1: TADOConnection;
    FlatButton1: TFlatButton;
    Query: TADOQuery;
    memo: TFlatMemo;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
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
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' )) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;

   ADOconnection1.Connected := false;
   ADOConnection1.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   ADOconnection1.Connected := true;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
   Screen.Cursor := CrHourglass;
   memo.lines.Add('Pepara para copiar o Plano de contas da PFM' );
   QUERY.SQL.Clear;
   QUERY.SQL.add('delete from dscon where cod_emp = '+ quotedstr('PM') );
   query.ExecSQL;

   memo.lines.Add('Copiar o plano de contas da FL para PFM' );
   QUERY.SQL.Clear;
   QUERY.SQL.add( ' INSERT DSCON (CATEGORIA,COD_EMP,CON_ALTER,CON_CAD,CON_GP_CMI,CON_SIMP,CONTR_SAL,DIG_CAD,EXIBE_REL,INT_CAD,MAINT,QTD_NIVEIS, '+
                  ' RATEIO,STA_CONTA,TIPO_CMI,TIT_CONTA,DATA_BLOQ,EXIBE_PLAN_CONTA, CON_ALTER) ' +
                  ' SELECT CATEGORIA, ' + quotedStr('PM') + ' AS COD_EMP ,CON_ALTER,CON_CAD,CON_GP_CMI,CON_SIMP,CONTR_SAL,DIG_CAD,EXIBE_REL,INT_CAD,MAINT,QTD_NIVEIS, ' +
                  ' RATEIO,STA_CONTA,TIPO_CMI,TIT_CONTA,DATA_BLOQ,EXIBE_PLAN_CONTA, CON_ALTER FROM DSCON WHERE COD_EMP = ' + quotedStr('FL')
                );
   query.ExecSQL;


   memo.lines.Add('Pepara para copiar o Plano de contas da CF' );
   QUERY.SQL.Clear;
   QUERY.SQL.add('delete from dscon where cod_emp = '+ quotedstr('CF') );
   query.ExecSQL;

   memo.lines.Add('Copiar o plano de contas da FL para CF' );
   QUERY.SQL.Clear;
   QUERY.SQL.add( ' INSERT DSCON (CATEGORIA,COD_EMP,CON_ALTER,CON_CAD,CON_GP_CMI,CON_SIMP,CONTR_SAL,DIG_CAD,EXIBE_REL,INT_CAD,MAINT,QTD_NIVEIS, '+
                  ' RATEIO,STA_CONTA,TIPO_CMI,TIT_CONTA,DATA_BLOQ,EXIBE_PLAN_CONTA, CON_ALTER) ' +
                  ' SELECT CATEGORIA, ' + quotedStr('CF') + ' AS COD_EMP ,CON_ALTER,CON_CAD,CON_GP_CMI,CON_SIMP,CONTR_SAL,DIG_CAD,EXIBE_REL,INT_CAD,MAINT,QTD_NIVEIS, ' +
                  ' RATEIO,STA_CONTA,TIPO_CMI,TIT_CONTA,DATA_BLOQ,EXIBE_PLAN_CONTA, CON_ALTER FROM DSCON WHERE COD_EMP = ' + quotedStr('FL')
                );
   query.ExecSQL;
   memo.lines.Add('');


   QUERY.SQL.Clear;
   QUERY.SQL.add('delete from dscon where cod_emp = '+ quotedstr('PF') );
   query.ExecSQL;
   memo.lines.Add('Copiar o plano de contas da FL para PF' );
   QUERY.SQL.Clear;
   QUERY.SQL.add( ' INSERT DSCON (CATEGORIA,COD_EMP,CON_ALTER,CON_CAD,CON_GP_CMI,CON_SIMP,CONTR_SAL,DIG_CAD,EXIBE_REL,INT_CAD,MAINT,QTD_NIVEIS, '+
                  ' RATEIO,STA_CONTA,TIPO_CMI,TIT_CONTA,DATA_BLOQ,EXIBE_PLAN_CONTA, CON_ALTER) ' +
                  ' SELECT CATEGORIA, ' + quotedStr('PF') + ' AS COD_EMP ,CON_ALTER,CON_CAD,CON_GP_CMI,CON_SIMP,CONTR_SAL,DIG_CAD,EXIBE_REL,INT_CAD,MAINT,QTD_NIVEIS, ' +
                  ' RATEIO,STA_CONTA,TIPO_CMI,TIT_CONTA,DATA_BLOQ,EXIBE_PLAN_CONTA, CON_ALTER FROM DSCON WHERE COD_EMP = ' + quotedStr('FL')
                );
   query.ExecSQL;
   memo.lines.Add('');

   memo.lines.Add('Plano de contas Copiado.' );

   Screen.Cursor := CrDefault;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ADOconnection1.Connected := false;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   Application.Terminate();
end;

end.
