unit module.aluno.controller;

interface

uses
  Windows,
  DB,
  Forms,
  Variants,
  SysUtils,
  StrUtils,
  ComObj,
  ApiCep,
  module.aluno.interfaces,
  module.aluno.service,
  module.aluno.entity,
  infra.component.persistence.dao;

type
  TAlunoController = class(TInterfacedObject, IAlunoController)
  private
    FModel: IAlunoService;
  public
    constructor Create;
    class function New: IAlunoController;
    function DataSource(DataSource: TDataSource): IAlunoController;
    function DataSet: TDataSet;
    function DAO: IPersistenceDAO<TALUNO>;
    procedure BuscarCep(Cep: string);
  end;

implementation

{ TAlunoController }

procedure TAlunoController.BuscarCep(Cep: string);
var
  LApiCep: TViaCep;
begin
  if (DataSet.State in [dsEdit, dsInsert]) and (Length(Cep) = 8) then
  begin
    LApiCep := TViaCep.Create;
    try
      LApiCep.Find(Cep);
      DataSet.FieldByName('Logradouro').AsString := LApiCep.Logradouro;
      DataSet.FieldByName('Bairro').AsString     := LApiCep.Bairro;
      DataSet.FieldByName('Municipio').AsString  := LApiCep.Municipio;
      DataSet.FieldByName('Uf').AsString         := LApiCep.Uf;
    finally
      LApiCep.Free;
    end;
  end;
end;

constructor TAlunoController.Create;
begin
  FModel := TAlunoService.New;
end;

function TAlunoController.DAO: IPersistenceDAO<TALUNO>;
begin
  Result := FModel.DAO;
end;

function TAlunoController.DataSet: TDataSet;
begin
  Result := FModel.DataSet;
end;

function TAlunoController.DataSource(DataSource: TDataSource): IAlunoController;
begin
  Result := Self;
  DataSource.DataSet := DataSet;
end;

class function TAlunoController.New: IAlunoController;
begin
  Result := Self.Create;
end;

end.
