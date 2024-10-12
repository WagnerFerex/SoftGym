unit ApiCep;

interface

uses
  SysUtils, Classes, Idhttp, IdSSLOpenSSL, DBXJSON, Character;

type
  TJsonObjectHelper = class helper for TJsonObject
  public
    function Get(const PairName: UnicodeString): TJSONPair; overload;
    class function ParseJSONObject(AValue: string): TJSONObject;
  end;

  TJsonPairHelper = class helper for TJSONPair
  public
    function AsString: string;
    function AsDouble: Double;
    function AsBoolean: Boolean;
    function AsDateTime: TDateTime;
  end;

  TViaCep = class(TInterfacedObject)
  private
    FLogradouro: string;
    FCep: string;
    FBairro: string;
    FMunicipio: string;
    FUf: string;
    function GetHttp(AUrl: string): string;
  public
    class function New: TViaCep;
    property Cep: string read FCep write FCep;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Bairro: string read FBairro write FBairro;
    property Municipio: string read FMunicipio write FMunicipio;
    property Uf: string read FUf write FUf;
    function Find(ACep: string = ''): TViaCep;
  end;

implementation

uses
  Dialogs;

{ TEndereco }


function StripNonJson(s: string): TBytes;
var
  ch: char;
  inString: Boolean;
  Res: string;
begin
  Res := '';
  inString := false;
  for ch in s do
  begin
    if ch = '"' then
      inString := not inString;
    if TCharacter.IsWhiteSpace(ch) and not inString then
      continue;
    Res := Res + ch;
  end;
  Result := TEncoding.ASCII.GetBytes(Res);
end;

function TViaCep.Find(ACep: string): TViaCep;
var
  json: TJSONObject;
  JsonStr: string;

begin
  Result := Self;
  JsonStr := GetHttp(Format('https://viacep.com.br/ws/%s/json/', [Trim(ACep)]));

  json := TJSONObject.ParseJSONObject(JsonStr);
  try
    if Assigned(json.Get('logradouro')) then
    begin
      Cep := ACep;
      Logradouro := json.Get('logradouro').AsString;
      Municipio := json.Get('localidade').AsString;
      Bairro := json.Get('bairro').AsString;
      Uf := json.Get('uf').AsString;
    end;
  finally
    json.Free;
  end;
end;

function TViaCep.GetHttp(AUrl: string): string;
var
  lHTTP: TIdHTTP;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;

begin
  lHTTP := TIdHTTP.Create(nil);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
  IdSSL.SSLOptions.SSLVersions := [sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2,sslvSSLv23];
  lHTTP.IOHandler := IdSSL;
    Result := lHTTP.Get(AUrl);
  finally
    lHTTP.Free;
  end;
end;

class function TViaCep.New: TViaCep;
begin
  Result := Self.Create;
end;

{ TJsonObjectHelper }

function TJsonObjectHelper.Get(const PairName: UnicodeString): TJSONPair;
var
  Candidate: TJSONPair;
  I: Integer;
begin
  for I := 0 to Size - 1 do
  begin
    Candidate := Get(I);
    if (Candidate.JsonString.Value = PairName) then
      Exit(Candidate);
  end;
  Result := nil;
end;

class function TJsonObjectHelper.ParseJSONObject(AValue: string): TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(StripNonJson(AValue), 0) as TJSONObject;
end;

{ TJsonPairHelper }

function TJsonPairHelper.AsBoolean: Boolean;
var
  Field: TJSONValue;

begin
  Field := GetJsonValue;
  Result := (Field is TJSONTrue);
end;

function TJsonPairHelper.AsDateTime: TDateTime;
var
  Field: TJSONString;
begin
  Field := GetJsonValue as TJSONString;
  Result := StrToDateTime(Field.Value);
end;

function TJsonPairHelper.AsDouble: Double;
var
  Field: TJSONNumber;

begin
  Field := GetJsonValue as TJSONNumber;
  Result := Field.AsDouble;
end;

function TJsonPairHelper.AsString: string;
var
  Field: TJSONString;

begin
  Field := GetJsonValue as TJSONString;
  Result := Field.Value;
end;

end.
