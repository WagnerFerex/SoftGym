unit infra.component.persistence.dao;

interface

uses
  DB,
  DBXJSON,
  Generics.Collections,
  ZDataset,
  Classes,
  infra.component.persistence.connection;

type
  IAttributeSQL<T> = interface;
  IPersistenceDAO<T> = interface
    ['{C945AA1F-8F42-4B67-AB1B-8FB70D9F90EB}']
    function DataSet: TDataSet;
    function Find(var AList: TList<T>): IPersistenceDAO<T>; overload;
    function Find: IPersistenceDAO<T>; overload;
    function Find(AId: Integer): T; overload;
    function Insert(AInstance: T): IPersistenceDAO<T>; overload;
    function Insert: IPersistenceDAO<T>; overload;
    function Update(AInstance: T): IPersistenceDAO<T>; overload;
    function Update: IPersistenceDAO<T>; overload;
    function Delete(AInstance: T): IPersistenceDAO<T>; overload;
    function Delete: IPersistenceDAO<T>; overload;
    function Delete(AKey: string; AValue: Variant): IPersistenceDAO<T>; overload;
    function SQL: IAttributeSQL<T>;
  end;

  TTemplateDAO<T> = class(TInterfacedObject, IPersistenceDAO<T>)
  protected
    FQuery: TZQuery;
    FSQLAttribute: IAttributeSQL<T>;
  public
    constructor Create;
    function SQL: IAttributeSQL<T>;
    function DataSet: TDataSet;
    function Find(var AList: TList<T>): IPersistenceDAO<T>; overload; virtual; abstract;
    function Find: IPersistenceDAO<T>; overload; virtual; abstract;
    function Find(AId: Integer): T; overload; virtual; abstract;
    function Insert(AInstance: T): IPersistenceDAO<T>; overload; virtual; abstract;
    function Insert: IPersistenceDAO<T>; overload; virtual; abstract;
    function Update(AInstance: T): IPersistenceDAO<T>; overload; virtual; abstract;
    function Update: IPersistenceDAO<T>; overload; virtual; abstract;
    function Delete(AInstance: T): IPersistenceDAO<T>; overload; virtual; abstract;
    function Delete: IPersistenceDAO<T>; overload; virtual; abstract;
    function Delete(AKey: string; AValue: Variant): IPersistenceDAO<T>; overload; virtual; abstract;
  end;

  IAttributeSQL<T> = interface
    ['{C5BFD367-3122-4792-962F-CE7C671C466B}']
    function Fields(aSQL: String): IAttributeSQL<T>; overload;
    function AddField(AField: string; AAlias: string = ''): IAttributeSQL<T>;
    function Where(aSQL: String): IAttributeSQL<T>; overload;
    function OrderBy(aSQL: String): IAttributeSQL<T>; overload;
    function GroupBy(aSQL: String): IAttributeSQL<T>; overload;
    function Join(aSQL: String): IAttributeSQL<T>; overload;
    function Join: String; overload;
    function Clear: IAttributeSQL<T>;
    function Fields: String; overload;
    function Where: String; overload;
    function OrderBy: String; overload;
    function GroupBy: String; overload;
    function &End: IPersistenceDAO<T>;
  end;

  TAttributeSQL<T> = class(TInterfacedObject, IAttributeSQL<T>)
  private
    FParent: IPersistenceDAO<T>;
    FFields: String;
    FWhere: String;
    FOrderBy: String;
    FGroupBy: String;
    FJoin: String;
  public
    constructor Create(Parent: IPersistenceDAO<T>);
    destructor Destroy; override;
    class function New(Parent: IPersistenceDAO<T>): IAttributeSQL<T>;
    function Fields(aSQL: String): IAttributeSQL<T>; overload;
    function AddField(AField: string; AAlias: string = ''): IAttributeSQL<T>;
    function Where(aSQL: String): IAttributeSQL<T>; overload;
    function OrderBy(aSQL: String): IAttributeSQL<T>; overload;
    function GroupBy(aSQL: String): IAttributeSQL<T>; overload;
    function Join(aSQL: String): IAttributeSQL<T>; overload;
    function Join: String; overload;
    function Clear: IAttributeSQL<T>;
    function Fields: String; overload;
    function Where: String; overload;
    function OrderBy: String; overload;
    function GroupBy: String; overload;
    function &End: IPersistenceDAO<T>;
  end;

  IDBQuery = interface
    ['{F80E95C7-576C-426D-A93A-1A99AD6D372B}']
    function DataSet: TDataSet;
    function RecordCount: Integer;
    procedure Open;
    procedure Cancel;
    procedure Post;
    procedure Edit;
    procedure Insert;
    procedure Filter(Value: string);
    procedure Close;
    procedure &Export;
    procedure OrderBy(Value: string);
  end;

  TDBQueryZeosLib = class(TInterfacedObject, IDBQuery)
  private
    FQuery: TZQuery;
    FDataModule: TDataModule;
  public
    constructor Create(Query: TZQuery; Parent: TDataModule);
    destructor Destroy; override;
    class function New(Query: TZQuery; Parent: TDataModule): IDBQuery;
    function DataSet: TDataSet;
    function RecordCount: Integer;
    procedure Open;
    procedure Cancel;
    procedure Post;
    procedure Edit;
    procedure Insert;
    procedure Filter(Value: string);
    procedure Close;
    procedure &Export;
    procedure OrderBy(FieldName: string);
  end;

implementation

uses
  StrUtils, SysUtils, Variants, ComObj;


{ TTemplateDAO }

constructor TTemplateDAO<T>.Create;
begin
  FQuery := TZQuery.Create(nil);
  FQuery.Connection := DmZeosLib.ConnSQlite;
  FQuery.CachedUpdates := True;
  FSQLAttribute := TAttributeSQL<T>.New(Self);
end;

function TTemplateDAO<T>.DataSet: TDataSet;
begin
  Result := FQuery;
end;

function TTemplateDAO<T>.SQL: IAttributeSQL<T>;
begin
  Result := FSQLAttribute;
end;

{ TDBQueryZeosLib }

procedure TDBQueryZeosLib.Cancel;
begin
  FQuery.Cancel;
end;

procedure TDBQueryZeosLib.Close;
begin
  FQuery.Close;
end;

constructor TDBQueryZeosLib.Create(Query: TZQuery; Parent: TDataModule);
begin
  FQuery := Query;
  FDataModule := Parent;
end;

function TDBQueryZeosLib.DataSet: TDataSet;
begin
  Result := FQuery;
end;

destructor TDBQueryZeosLib.Destroy;
begin

  inherited;
end;

procedure TDBQueryZeosLib.Edit;
begin
  FQuery.Edit;
end;

procedure TDBQueryZeosLib.Export;
var
  ExcelApp: OleVariant;
  Line, Col: Integer;

begin
  ExcelApp := CreateoleObject('Excel.Application');
  ExcelApp.Visible := True;
  try
    ExcelApp.WorkBooks.Add(1);

    DataSet.First;
    for Line := 0 to DataSet.RecordCount - 1 do
    begin
      for Col := 1 to DataSet.FieldCount -4 do
        ExcelApp.Cells[Line + 2, Col] := DataSet.Fields[Col - 1].AsString;
      DataSet.Next;
    end;

    for Col := 1 to DataSet.FieldCount -4 do
      ExcelApp.Cells[1, Col] := DataSet.Fields[Col - 1].DisplayLabel;

    ExcelApp.columns.Autofit;
  finally
    ExcelApp := Unassigned;
  end;
end;

procedure TDBQueryZeosLib.Filter(Value: string);
begin
  FQuery.Filtered := False;
  FQuery.Filter   := AnsiReplaceStr(Value, '%', '*');
  FQuery.Filtered := Trim(Value) <> '';
end;

procedure TDBQueryZeosLib.Insert;
begin
  FQuery.Insert;
end;

class function TDBQueryZeosLib.New(Query: TZQuery; Parent: TDataModule): IDBQuery;
begin
  Result := Self.Create(Query, Parent);
end;

procedure TDBQueryZeosLib.Open;
begin
  FQuery.Open;
end;

procedure TDBQueryZeosLib.OrderBy(FieldName: string);
begin
  if SameText((DataSet as TZQuery).IndexFieldNames, FieldName+' DESC') then
    (DataSet as TZQuery).IndexFieldNames := FieldName+' ASC'
  else
    (DataSet as TZQuery).IndexFieldNames := FieldName+' DESC';
end;

procedure TDBQueryZeosLib.Post;
var
  I: Integer;
begin
  for I := 0 to FQuery.FieldCount - 1 do
  begin
    if FQuery.Fields[I].Required and (FQuery.Fields[I].AsString = '') then
    begin
      FQuery.Fields[I].Clear;
      FQuery.Fields[I].FocusControl;
      raise Exception.Create('Não informado nenhum valor para o campo '+ FQuery.Fields[I].DisplayName +'.');
    end;
  end;

  FQuery.Post;
end;

function TDBQueryZeosLib.RecordCount: Integer;
begin
  Result := FQuery.RecordCount;
end;

{ TAttributeSQL<T> }

function TAttributeSQL<T>.Clear: IAttributeSQL<T>;
begin
  Result := Self;
  FFields := '';
  FWhere := '';
  FOrderBy := '';
  FGroupBy := '';
  FJoin := '';
end;

constructor TAttributeSQL<T>.Create(Parent: IPersistenceDAO<T>);
begin
  FParent := Parent;
end;

destructor TAttributeSQL<T>.Destroy;
begin

  inherited;
end;

function TAttributeSQL<T>.AddField(AField: string; AAlias: string): IAttributeSQL<T>;
begin
  Result := Self;
  FFields :=
    IfThen(FFields <> '', ', ') + AField +
    IfThen(AAlias <> '', ' AS '+ AAlias);
end;

function TAttributeSQL<T>.Fields: String;
begin
  Result := FFields;
end;

function TAttributeSQL<T>.Fields(aSQL: String): IAttributeSQL<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
      FFields := FFields + ' ' + aSQL;
end;

function TAttributeSQL<T>.GroupBy: String;
begin
  Result := FGroupBy;
end;

function TAttributeSQL<T>.GroupBy(aSQL: String): IAttributeSQL<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
      FFields := FFields + ' ' + aSQL;
end;

function TAttributeSQL<T>.Join(aSQL: String): IAttributeSQL<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
      FJoin := FJoin + ' ' + aSQL;
end;

function TAttributeSQL<T>.Join: String;
begin
  Result := FJoin;
end;

class function TAttributeSQL<T>.New(
  Parent: IPersistenceDAO<T>): IAttributeSQL<T>;
begin
  Result := Self.Create(Parent);
end;

function TAttributeSQL<T>.OrderBy(aSQL: String): IAttributeSQL<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
      FOrderBy := FOrderBy + ' ' + aSQL;
end;

function TAttributeSQL<T>.OrderBy: String;
begin
  Result := FOrderBy;
end;

function TAttributeSQL<T>.Where: String;
begin
   Result := FWhere;
end;

function TAttributeSQL<T>.Where(aSQL: String): IAttributeSQL<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
      FWhere := FWhere + ' ' + aSQL;
end;

function TAttributeSQL<T>.&End: IPersistenceDAO<T>;
begin
  Result := FParent;
end;

end.

