unit Utils;

interface

uses
  SysUtils,
  IdHashMessageDigest;


  function MD5(const Value: string): string;

implementation

function MD5(const Value: string): string;
var
  LIdHash : TIdHashMessageDigest5;
begin
  LIdHash := TIdHashMessageDigest5.Create;
  try
    Result := LowerCase(LIdHash.HashStringAsHex(Value));
  finally
    LIdHash.Free;
  end;
end;

end.
