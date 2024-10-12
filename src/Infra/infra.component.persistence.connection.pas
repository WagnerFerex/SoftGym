unit infra.component.persistence.connection;

interface

uses
  Windows,
  SysUtils,
  Classes,
  ZAbstractConnection,
  ZConnection;

type
  TDmZeosLib = class(TDataModule)
    ConnSQlite: TZConnection;
    procedure ConnSQliteBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Instance: TZConnection;
  end;

var
  DmZeosLib: TDmZeosLib;

implementation

{$R *.dfm}

procedure ExtractResource(ResourceName: string; FileName: string);
var
  rs: TResourceStream;
  fs: TFileStream;
begin
  if not FileExists(GetCurrentDir + '/'+ FileName) then
  begin
    rs := TResourceStream.Create(hInstance, ResourceName, RT_RCDATA);
    try
      fs := TFileStream.Create(GetCurrentDir + '/' + FileName, fmCreate);
      try
        rs.SaveToStream(fs);
      finally
        fs.Free;
      end;
    finally
      rs.Free;
    end;
  end;
end;

procedure ExtractDataBase;
begin
//  ExtractResource('softgym_db', 'database.db3');
//  ExtractResource('sqlite_dll', 'sqlite3.dll');
end;

procedure TDmZeosLib.ConnSQliteBeforeConnect(Sender: TObject);
begin
  (Sender as TZConnection).Database := GetCurrentDir +'\database.db3';
  (Sender as TZConnection).LibraryLocation := GetCurrentDir +'\sqlite3.dll';
end;

class function TDmZeosLib.Instance: TZConnection;
begin
  Result := DmZeosLib.ConnSQlite;
end;

initialization
  ExtractDataBase;

end.
