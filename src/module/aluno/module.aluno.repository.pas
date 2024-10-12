unit module.aluno.repository;

interface

uses
  Variants,
  StrUtils,
  SysUtils,
  DB,
  Generics.Collections,
  infra.component.persistence.dao,
  module.aluno.entity;

type
  TAlunoDAO = class(TTemplateDAO<TALUNO>)
  private
    function BindDataSetToEntity(DataSet: TDataSet): TALUNO;
  public
    class function New: IPersistenceDAO<TALUNO>;
    function Find(var AList: TList<TALUNO>): IPersistenceDAO<TALUNO>; overload; override;
    function Find: IPersistenceDAO<TALUNO>; overload; override;
    function Find(AId: Integer): TALUNO; overload; override;
    function Insert(AInstance: TALUNO): IPersistenceDAO<TALUNO>; overload; override;
    function Insert: IPersistenceDAO<TALUNO>; overload; override;
    function Update(AInstance: TALUNO): IPersistenceDAO<TALUNO>; overload; override;
    function Update: IPersistenceDAO<TALUNO>; overload; override;
    function Delete(AInstance: TALUNO): IPersistenceDAO<TALUNO>; overload; override;
    function Delete: IPersistenceDAO<TALUNO>; overload; override;
    function Delete(AKey: string; AValue: Variant): IPersistenceDAO<TALUNO>; overload; override;
  end;

implementation

{ TAlunoDAO }

function TAlunoDAO.BindDataSetToEntity(DataSet: TDataSet): TALUNO;
begin
  Result := TALUNO.Create(
    DataSet.FieldByName('CodigoAluno').AsInteger,
    DataSet.FieldByName('Nome').AsString,
    DataSet.FieldByName('DataNascimento').Value,
    DataSet.FieldByName('Telefone').AsString,
    DataSet.FieldByName('Email').AsString,
    DataSet.FieldByName('Cpf').AsString,
    DataSet.FieldByName('Observacao').AsString,
    DataSet.FieldByName('Cep').AsInteger,
    DataSet.FieldByName('Logradouro').AsString,
    DataSet.FieldByName('Bairro').AsString,
    DataSet.FieldByName('Municipio').AsString,
    DataSet.FieldByName('Uf').AsString,
    DataSet.FieldByName('Numero').AsString,
    DataSet.FieldByName('Complemento').AsString,
    DataSet.FieldByName('Referencia').AsString
  );
end;

function TAlunoDAO.Delete: IPersistenceDAO<TALUNO>;
begin
  Result := Self;
  Delete('CodigoAluno', DataSet.FieldByName('CodigoAluno').Value );
end;

function TAlunoDAO.Delete(AInstance: TALUNO): IPersistenceDAO<TALUNO>;
begin
  Result := Self;
  Delete('CodigoAluno', AInstance.CodigoAluno );
end;

function TAlunoDAO.Delete(AKey: string; AValue: Variant): IPersistenceDAO<TALUNO>;
begin
  Result := Self;
  FQuery.SQL.Text := 'DELETE ALUNO WHERE '+ AKey + ' = :Key';
  FQuery.Params[0].Value := AValue;
  FQuery.ExecSQL;
end;

function TAlunoDAO.Find(AId: Integer): TALUNO;
begin
  FQuery.SQL.Text := 'SELECT * FROM Aluno WHERE CodigoAluno = ' + IntToStr(AId);
  FQuery.Open;
  Result := BindDataSetToEntity(FQuery);
end;

function TAlunoDAO.Find: IPersistenceDAO<TALUNO>;
begin
  Result := Self;
  FQuery.SQL.Text := 'SELECT '+
    IfThen(FSQLAttribute.Fields <> '', FSQLAttribute.Fields, ' * ') +
    ' FROM Aluno ' +
    IfThen(FSQLAttribute.Join <> '', FSQLAttribute.Join) +
    IfThen(FSQLAttribute.GroupBy <> '', FSQLAttribute.GroupBy) +
    IfThen(FSQLAttribute.OrderBy <> '', FSQLAttribute.OrderBy);
  FQuery.Open;
end;

function TAlunoDAO.Find(var AList: TList<TALUNO>): IPersistenceDAO<TALUNO>;
begin
  Result := Self;
  Find;
  AList.Clear;
  while not FQuery.Eof do
    AList.Add(BindDataSetToEntity(FQuery));
end;

function TAlunoDAO.Insert(AInstance: TALUNO): IPersistenceDAO<TALUNO>;
begin
  Result := Self;
  FQuery.Post;
  FQuery.SQL.Text := 'INSERT Aluno ('+
      'Nome, '+
      'DataNascimento, '+
      'Telefone, '+
      'Email, '+
      'Cpf, '+
      'Observacao, '+
      'Cep, '+
      'Logradouro, '+
      'Bairro, '+
      'Municipio, '+
      'Uf, '+
      'Numero, '+
      'Complemento, '+
      'Referencia, '+
      'InseridoEm, '+
      'InseridoPor'+
    ') VALUES ('+
      ':Nome, '+
      ':DataNascimento, '+
      ':Telefone, '+
      ':Email, '+
      ':Cpf, '+
      ':Observacao, '+
      ':Cep, '+
      ':Logradouro, '+
      ':Bairro, '+
      ':Municipio, '+
      ':Uf, '+
      ':Numero, '+
      ':Complemento, '+
      ':Referencia, '+
      ':InseridoEm, '+
      ':InseridoPor)';
  FQuery.Params[0].Value := AInstance.Nome;
  FQuery.Params[1].Value := VarAsType(AInstance.DataNascimento, varDate);
  FQuery.Params[2].Value := AInstance.Telefone;
  FQuery.Params[3].Value := AInstance.Email;
  FQuery.Params[4].Value := AInstance.Cpf;
  FQuery.Params[5].Value := AInstance.Observacao;
  FQuery.Params[6].Value := AInstance.Cep;
  FQuery.Params[7].Value := AInstance.Logradouro;
  FQuery.Params[8].Value := AInstance.Bairro;
  FQuery.Params[9].Value := AInstance.Municipio;
  FQuery.Params[10].Value := AInstance.Uf;
  FQuery.Params[11].Value := AInstance.Numero;
  FQuery.Params[12].Value := AInstance.Complemento;
  FQuery.Params[13].Value := AInstance.Referencia;
  FQuery.Params[14].Value := Now;
  FQuery.Params[15].Value := 1;
  FQuery.ExecSQL;
end;

function TAlunoDAO.Insert: IPersistenceDAO<TALUNO>;
var
  aInstance: TALUNO;
begin
  Result := Self;
  aInstance := BindDataSetToEntity(FQuery);
  try
    Insert(aInstance);
  finally
    aInstance.Free;
  end;
end;

class function TAlunoDAO.New: IPersistenceDAO<TALUNO>;
begin
  Result := Self.Create;
end;

function TAlunoDAO.Update: IPersistenceDAO<TALUNO>;
var
  aInstance: TALUNO;
begin
  Result := Self;
  aInstance := BindDataSetToEntity(FQuery);
  try
    Update(aInstance);
  finally
    aInstance.Free;
  end;
end;

function TAlunoDAO.Update(AInstance: TALUNO): IPersistenceDAO<TALUNO>;
begin
  Result := Self;
  FQuery.SQL.Text := 'UPDATE Aluno SET ' +
    'Nome = :Nome, ' +
    'DataNascimento = :DataNascimento, ' +
    'Telefone = :Telefone, ' +
    'Email = :Email, ' +
    'Cpf = :Cpf, ' +
    'Observacao = :Observacao, ' +
    'Cep = :Cep, ' +
    'Logradouro = :Logradouro, ' +
    'Bairro = :Bairro, ' +
    'Municipio = :Municipio, ' +
    'Uf = :Uf, ' +
    'Numero = :Numero, ' +
    'Complemento = :Complemento, ' +
    'Referencia = :Referencia, ' +
    'ModificadoEm = :ModificadoEm, ' +
    'ModificadoPor = :ModificadoPor ' +
    'WHERE CodigoAluno = :Id';

  FQuery.Params[0].Value := AInstance.Nome;
  FQuery.Params[1].Value := AInstance.DataNascimento;
  FQuery.Params[2].Value := AInstance.Telefone;
  FQuery.Params[3].Value := AInstance.Email;
  FQuery.Params[4].Value := AInstance.Cpf;
  FQuery.Params[5].Value := AInstance.Observacao;
  FQuery.Params[6].Value := AInstance.Cep;
  FQuery.Params[7].Value := AInstance.Logradouro;
  FQuery.Params[8].Value := AInstance.Bairro;
  FQuery.Params[9].Value := AInstance.Municipio;
  FQuery.Params[10].Value := AInstance.Uf;
  FQuery.Params[11].Value := AInstance.Numero;
  FQuery.Params[12].Value := AInstance.Complemento;
  FQuery.Params[13].Value := AInstance.Referencia;
  FQuery.Params[14].Value := Now;
  FQuery.Params[15].Value := 1;
  FQuery.Params[16].Value := AInstance._Id;
  FQuery.ExecSQL;
end;

end.
