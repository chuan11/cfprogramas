unit uGetNotas;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,funcoes, uListaItensPorNota;

  function getIsNota():String;

implementation

function getIsNota():String;
var
  aux:String;
begin
   aux := '';
   application.CreateForm(TfmListaItensNota, fmListaItensNota );
   fmListaItensNota.ShowModal ;
   if (fmListaItensNota.ModalResult = mrOk) then
      aux := fmListaItensNota.Caption;
   fmListaItensNota := nil;
   result := aux;
end;

end.
 