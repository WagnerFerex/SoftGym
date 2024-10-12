unit module.aluno.interfaces;

interface

uses
  DB,
  module.aluno.entity,
  infra.component.persistence.dao;

type
  IAlunoController = interface
    ['{5A39CB24-63AE-40B1-8FE9-E61F2C9CC0AF}']
    function DataSource(DataSource: TDataSource): IAlunoController;
    function DataSet: TDataSet;
    function DAO: IPersistenceDAO<TALUNO>;
    procedure BuscarCep(Cep: string);
  end;

implementation

end.
