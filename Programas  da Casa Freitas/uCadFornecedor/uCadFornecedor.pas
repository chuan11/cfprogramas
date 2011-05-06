unit uCadFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, Grids, DBGrids, SoftDBGrid;

type
  TfmCadFornecedor = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    FlatButton1: TFlatButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCadFornecedor: TfmCadFornecedor;

implementation

{$R *.dfm}

end.
