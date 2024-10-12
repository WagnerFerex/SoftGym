unit infra.component.validator;

interface

uses
  SysUtils;


  function eCpf(Value: string): Boolean;
  function Number(const ATexto: string): string;

implementation

function eCpf(Value: string): Boolean;
var
  i, j: Integer;
  Soma, Resto: Integer;
  Digito: Integer;
  CPF: string;
begin
  CPF := StringReplace(Trim(Value), '.', '', [rfReplaceAll]);
  CPF := StringReplace(CPF, '-', '', [rfReplaceAll]);

  if CPF = '' then
    Exit(True);

  if Length(CPF) <> 11 then
  begin
    Exit(False);
  end;

  if (CPF = StringOfChar(CPF[1], 11)) then
  begin
    Exit(False);
  end;

  Soma := 0;
  j := 10;
  for i := 1 to 9 do
  begin
    Soma := Soma + StrToInt(CPF[i]) * j;
    Dec(j);
  end;
  Resto := Soma mod 11;
  if Resto < 2 then
    Digito := 0
  else
    Digito := 11 - Resto;

  if StrToInt(CPF[10]) <> Digito then
  begin
    Exit(False);
  end;

  Soma := 0;
  j := 11;
  for i := 1 to 10 do
  begin
    Soma := Soma + StrToInt(CPF[i]) * j;
    Dec(j);
  end;
  Resto := Soma mod 11;
  if Resto < 2 then
    Digito := 0
  else
    Digito := 11 - Resto;

  if StrToInt(CPF[11]) <> Digito then
  begin
    Exit(False);
  end;

  Result := True;
end;

function Number(const ATexto: string): string;
var
  i: Integer;
  Caracter: Char;
begin
  Result := '';
  for i := 1 to Length(ATexto) do
  begin
    Caracter := ATexto[i];
    if CharInSet(Caracter, ['0'..'9']) then
      Result := Result + Caracter;
  end;
end;

end.
