unit module.aluno.factory;

interface

uses
  module.aluno.entity,
  infra.component.persistence.dao,
  module.aluno.controller,
  module.aluno.repository,
  module.aluno.service,
  module.aluno.interfaces;

type
  TAlunoFactory = class
  public
    class function Service: IAlunoService;
    class function DAO: IPersistenceDAO<TALUNO>;
    class function Controller: IAlunoController;
  end;

implementation

{ TAlunoFactory }

class function TAlunoFactory.Controller: IAlunoController;
begin
  Result := TAlunoController.New;
end;

class function TAlunoFactory.DAO: IPersistenceDAO<TALUNO>;
begin
  Result := TAlunoDAO.New;
end;

class function TAlunoFactory.Service: IAlunoService;
begin
  Result := TAlunoService.New;
end;

end.
