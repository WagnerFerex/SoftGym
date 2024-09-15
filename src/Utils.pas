unit Utils;

interface

type
  TUtils = class
    class function IfThen<T>(const AValue: Boolean; const ATrue, AFalse: T): T;
  end;

  function iif(Value: Boolean; ATrue, AFalse: Variant): Variant;

implementation

{ TGenerics }

class function TUtils.IfThen<T>(const AValue: Boolean; const ATrue, AFalse: T): T;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function iif(Value: Boolean; ATrue, AFalse: Variant): Variant;
begin
  if Value then
    Result := ATrue
  else
    Result := AFalse;
end;

end.
