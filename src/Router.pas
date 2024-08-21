unit Router;

interface

uses
  Classes,
  Controls,
  Forms,
  Generics.Collections;

type
  TRouter = class
  strict private
    class var FList: TDictionary<String, TComponentClass>;
    class var FForm: TForm;
  public
    class procedure Add(AKey: String; AClass: TComponentClass);
    class procedure Clean;
    class function Get(AKey: String): TComponentClass;
    class procedure Render(AKey: String; ARender: TWinControl);
  end;


implementation

uses
  SysUtils;

{ TRouter }

class procedure TRouter.Add(AKey: String; AClass: TComponentClass);
begin
  if not Assigned(FList) then
    FList := TDictionary<String, TComponentClass>.Create();

  FList.Add(AKey, AClass);
end;

class procedure TRouter.Clean;
begin
  if Assigned(FList) then
    FList.Free;
end;

class function TRouter.Get(AKey: String): TComponentClass;
begin
  Result := FList.Items[AKey];
end;

class procedure TRouter.Render(AKey: String; ARender: TWinControl);
begin
  if (not Assigned(FForm)) or (FList.Items[AKey].ClassName <> FForm.ClassName) then
  begin
    if Assigned(FForm) then
      FreeAndNil(FForm);

    Application.CreateForm(FList.Items[AKey], FForm);
    FForm.Parent := ARender;
    FForm.Show;
  end;
end;

initialization

finalization
  TRouter.Clean;

end.
