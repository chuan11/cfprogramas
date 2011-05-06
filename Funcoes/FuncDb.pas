unit FuncDb; {unit identifier }
interface
uses	{ uses clause }  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  Dialogs, Buttons, Grids, DBGrids, DB, ADODB,comObj, ExtCtrls,  StdCtrls;
type
 TForm1 = class(TForm)	{ class declaration }
 private
   { Private declarations }
 public
    function ExportaQuery(Query: TadoQUery): boolean;
 end;
var
 Form1: TForm1;	{ instance declaration }
implementation



function ExportaQuery(Query: TadoQUery): boolean;
var
   Excel : Variant;
   L,i:Integer;
   panel:tpanel;
begin
   panel := tpanel.Create(self);
   with panel do
   begin
      Parent := application.MainForm;
      setbounds((application.MainForm.Width div 2)-150 ,(application.MainForm.height div 2) - 25,300,50);
      font.Name := 'arial';
      font.Size := 09;
      font.Style:= [fsbold];
   end;

   Excel := CreateOleObject('Excel.Application');
   Excel.WorkBooks.open('c:\NovoArquivo.xls');
   L:=1;
   Query.First;
   While Query.Eof = false do
   Begin
      for i:=0 to Query.FieldCount -1 do
      begin
         Panel.Caption := 'Exportando Registo: ' + IntToStr(L);
         panel.Refresh;
         Excel.WorkBooks[1].Sheets[1].Cells[l,i+1]:= Query.Fields[i].AsString;
      end;
      Query.Next;
      inc(l);
   end;

   Panel.Caption := 'Total de Registros Exportandos: ' + IntToStr(L);
   panel.Refresh;
   sleep(1000);
   panel.Destroy;
   Excel.Visible :=True;
end;


end.
 