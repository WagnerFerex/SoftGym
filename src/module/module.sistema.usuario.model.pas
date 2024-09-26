unit module.sistema.usuario.model;

interface

uses
  SysUtils,
  Utils,
  DB,
  ZDataset,
  Email,
  ConnZeosLib;

type
  IUsuarioModel = interface
    ['{4C061716-F9E1-48F5-9B3C-06C330455FD3}']
    procedure RecuperarSenha(ALogin: string);
    procedure Autenticar(ALogin, ASenha: string);
  end;

  TUsuarioModel = class(TInterfacedObject, IUsuarioModel)
  private
    FQuery: TZQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IUsuarioModel;
    procedure RecuperarSenha(ALogin: string);
    procedure Autenticar(ALogin, ASenha: string);
  end;

implementation

{ TUsuarioModel }

procedure TUsuarioModel.Autenticar(ALogin, ASenha: string);
begin
  FQuery.Open;

  if not FQuery.Locate('Login', Trim(ALogin), []) then
    raise Exception.Create('Usuário não localizado, verifique e tente novamente.');

  if FQuery.FieldByName('Senha').AsString <> MD5(ASenha) then
    raise Exception.Create('Senha inválida, verifique e tente novamente.');

  if DMConnZeosLib.qryUsuarioAtivo.Value <> 'S' then
    raise Exception.Create('Usuário inativo, verifique e tente novamente.');
end;

constructor TUsuarioModel.Create;
begin
  FQuery := DMConnZeosLib.qryUsuario;
end;

destructor TUsuarioModel.Destroy;
begin

  inherited;
end;

class function TUsuarioModel.New: IUsuarioModel;
begin
  Result := Self.Create;
end;

procedure TUsuarioModel.RecuperarSenha(ALogin: string);
begin

//    EMail := TEmail.New();
//    EMail
////      .FromAddress(Email.)
//      .FromName('SoftGym')
//      .RecipientsAddress(AEmail)
//      .Subject('SoftGym | Recuperação de Senha')
//      .AddBody('Olá Sr(a)'+ ANome + ', ')
//      .AddBody('')
//      .AddBody('Você solicitou uma recuperação de senha SoftGym')
//      .AddBody('Sua nova senha: 1234');
//    EMail.Send();

  //    EnviarEmailRecuperacaoSenha(
//      qryUsuario.FieldByName('Nome').AsString,
//      qryUsuario.FieldByName('Email').AsString
//    );
//
//    qryUsuario.Edit;
//    qryUsuario.FieldByName('Senha').Value := MD5('1234');
//    qryUsuario.Post;


  if not FQuery.Locate('Login', ALogin, [loCaseInsensitive]) then
    raise Exception.Create('Não foi possível localizar esse usuário, verifique e tente novamente!');
end;

end.
