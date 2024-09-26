unit module.sistema.login.controller;

interface

uses
  Windows,
  Forms,
  StrUtils,
  Controls,
  StdCtrls,
  IniFiles,
  Utils,
  SysUtils,
  ConnZeosLib,
  module.sistema.usuario.model;


type
  ILoginController = interface
    ['{4EFE8C03-2139-48B5-8D5A-EAADD657705B}']
    procedure Entrar;
    procedure RecuperarSenha(Usuario: string);
    procedure Login(Value: string); overload;
    procedure Senha(Value: string); overload;
    procedure Lembrar(Value: Boolean); overload;
    function Login: string; overload;
    function Senha: string; overload;
    function Lembrar: Boolean; overload;
  end;

  TUsuarioController = class(TInterfacedObject, ILoginController)
  private
    FIniFile: TIniFile;
    FUsuarioModel: IUsuarioModel;
    FLogin: string;
    FSenha: string;
    FLembrar: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    class function New(): ILoginController;
    procedure RecuperarSenha(Usuario: string);
    procedure Entrar;
    procedure Login(Value: string); overload;
    procedure Senha(Value: string); overload;
    procedure Lembrar(Value: Boolean); overload;
    function Login: string; overload;
    function Senha: string; overload;
    function Lembrar: Boolean; overload;
  end;

implementation

{ TLoginController }

constructor TUsuarioController.Create;
begin
  FIniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  FUsuarioModel := TUsuarioModel.New;

  if IniFile.ReadBool('LOGIN', 'LEMBRAR', False) then
  begin
    FLembrar := IniFile.ReadBool('LOGIN', 'LEMBRAR', False);
    FLogin := IniFile.ReadString('LOGIN', 'USUARIO', '');
    FSenha := IniFile.ReadString('LOGIN', 'SENHA', '');
  end;
end;

destructor TUsuarioController.Destroy;
begin
  FIniFile.Free;
  inherited;
end;

procedure TUsuarioController.Entrar;
begin
  FUsuarioModel.Autenticar(FLogin, FSenha);

  IniFile.WriteString('LOGIN', 'USUARIO', ifThen(FLembrar, FLogin));
  IniFile.WriteString('LOGIN', 'SENHA', ifThen(FLembrar, FSenha));
  IniFile.WriteBool('LOGIN', 'LEMBRAR', FLembrar);
  Sleep(2000);
end;

procedure TUsuarioController.Lembrar(Value: Boolean);
begin
  FLembrar := Value;
end;

function TUsuarioController.Lembrar: Boolean;
begin
  Result := FLembrar;
end;

function TUsuarioController.Login: string;
begin
  Result := FLogin;
end;

procedure TUsuarioController.Login(Value: string);
begin
  FLogin := Value;
end;

class function TUsuarioController.New: ILoginController;
begin
  Result := Self.Create;
end;

procedure TUsuarioController.RecuperarSenha(Usuario: string);
begin
  if Application.MessageBox(
    'Deseja receber uma nova senha de acesso por e-mail?',
    'SoftGym | Recuperar senha',
    MB_YESNO + MB_ICONEXCLAMATION) = mrNo then
  begin
    Exit;
  end;

  try

  except on E: Exception do
    begin
      Application.MessageBox(
        PChar('Falha ao enviar email para teste@teste.com. Msg: '+ E.Message),
        'SoftGym | Recuperar senha',
        MB_OK + MB_ICONERROR)
    end;
  end;

  Application.MessageBox(
    'Email enviado com sucesso para teste@teste.com',
    'SoftGym | Recuperar senha',
    MB_OK + MB_ICONEXCLAMATION)
end;

function TUsuarioController.Senha: string;
begin
  Result := FSenha;
end;

procedure TUsuarioController.Senha(Value: string);
begin
  FSenha := Value;
end;

end.
