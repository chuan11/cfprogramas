unit LEDReg;

interface

uses Classes, DsgnIntf;

type

  { Override property editor to prevent the Object Inspector from
    sorting the LEDs color property alphabetically }

  TLEDColorProperty = class(TEnumProperty)
    public
      function GetAttributes: TPropertyAttributes; override;

end;

procedure Register;

implementation

uses LEDR;

function TLEDColorProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paSortList];
end;

procedure Register;
begin
  RegisterComponents('Custom', [TLEDR]);
  RegisterComponents('Custom', [TLEDRLabel]);
  RegisterPropertyEditor(TypeInfo(TLEDColor),TLEDR,'Color',TLEDColorProperty);
end;

end.
