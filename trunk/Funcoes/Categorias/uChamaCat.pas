unit uChamaCat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,funcoes, adLabelEdit, adLabelComboBox,funcsql,
  DB, ADODB, TFlatButtonUnit, uSelCat;

procedure mostraCategorias(Sender:Tobject;Conexao:TADOConnection;var cat,valorCat:String);

implementation



procedure mostraCategorias(Sender:Tobject;Conexao:TADOConnection;var cat,valorCat:String);
begin //
   application.CreateForm(TfmSelCat, fmSelCat);
   fmSelCat.qrClasse1.Connection := conexao;
   fmSelCat.qrClasse2.Connection := conexao;
   fmSelCat.qrClasse3.Connection := conexao;
   fmSelCat.ShowModal;
end;

end.
