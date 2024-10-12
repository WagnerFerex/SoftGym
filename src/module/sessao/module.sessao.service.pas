unit module.sessao.service;

interface

uses
  SysUtils,
  Utils,
  DB,
  ZDataset,
  Email;

type
  ISessaoService = interface
    ['{4C061716-F9E1-48F5-9B3C-06C330455FD3}']
    procedure RecuperarSenha(ALogin: string);
    procedure Autenticar(ALogin, ASenha: string);
    function DataSet: TDataSet;
  end;

  TSessaoService = class(TInterfacedObject, ISessaoService)
  private
    FQuery: TZQuery;
    class var FSessao: ISessaoService;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: ISessaoService;
    procedure RecuperarSenha(ALogin: string);
    procedure Autenticar(ALogin, ASenha: string);
    function DataSet: TDataSet;
  end;

implementation

uses infra.component.persistence.connection;

{ TSessaoService }

procedure TSessaoService.Autenticar(ALogin, ASenha: string);
begin
  FQuery.Open;

  if not FQuery.Locate('Login', Trim(ALogin), []) then
    raise Exception.Create('Usuário não localizado, verifique e tente novamente.');

  if FQuery.FieldByName('Senha').AsString <> MD5(ASenha) then
    raise Exception.Create('Senha inválida, verifique e tente novamente.');

  if FQuery.FieldByName('Ativo').AsString <> 'S' then
    raise Exception.Create('Usuário inativo, verifique e tente novamente.');
end;

constructor TSessaoService.Create;
begin
  FQuery := TZQuery.Create(nil);
  FQuery.Connection := TDmZeosLib.Instance;
  FQuery.SQL.Text := 'SELECT * FROM USUARIO';
end;

function TSessaoService.DataSet: TDataSet;
begin
  Result := FQuery;
end;

destructor TSessaoService.Destroy;
begin
   FreeAndNil(FQuery);

  inherited;
end;

class function TSessaoService.Instance: ISessaoService;
begin
  if not Assigned(FSessao) then
    FSessao := TSessaoService.Create;

  Result := Self.Create;
end;

procedure TSessaoService.RecuperarSenha(ALogin: string);
begin
  FQuery.Open();

  if not FQuery.Locate('Login', ALogin, [loCaseInsensitive]) then
    raise Exception.Create('Não foi possível localizar esse usuário, verifique e tente novamente!');

//    TEmail.New()
//      .FromName('SoftGym')
//      .RecipientsAddress(AEmail)
//      .Subject('SoftGym | Recuperação de Senha')
//      .AddBody('Olá Sr(a)'+ ANome + ', ')
//      .AddBody('')
//      .AddBody('Você solicitou uma recuperação de senha SoftGym')
//      .AddBody('Sua nova senha: 1234')
//    .Send();

//    qryUsuario.Edit;
//    qryUsuario.FieldByName('Senha').Value := MD5('1234');
//    qryUsuario.Post;
end;

end.
