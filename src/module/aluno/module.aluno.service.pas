unit module.aluno.service;

interface

uses
  db,
  infra.component.persistence.dao,
  module.aluno.entity,
  module.aluno.repository;

type
  IAlunoService = interface
    ['{4C061716-F9E1-48F5-9B3C-06C330455FD3}']
    function DataSet: TDataSet;
    function DAO: IPersistenceDAO<TALUNO>;
  end;

  TAlunoService = class(TInterfacedObject, IAlunoService)
  private
    FDAO: IPersistenceDAO<TALUNO>;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IAlunoService;
    function DataSet: TDataSet;
    function DAO: IPersistenceDAO<TALUNO>;
  end;


implementation

{ TAlunoModel }

constructor TAlunoService.Create;
begin
  FDAO := TAlunoDAO.New;
end;

function TAlunoService.DAO: IPersistenceDAO<TALUNO>;
begin
  Result := FDAO;
end;

function TAlunoService.DataSet: TDataSet;
begin
  Result := FDAO.DataSet;
end;

destructor TAlunoService.Destroy;
begin
  inherited;
end;

class function TAlunoService.New: IAlunoService;
begin
  Result := Self.Create;
end;

end.
