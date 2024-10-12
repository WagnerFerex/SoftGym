unit module.sessao.controller;

interface

uses
  Windows,
  DB,
  Forms,
  StrUtils,
  Controls,
  StdCtrls,
  IniFiles,
  Utils,
  SysUtils,
  module.sessao.service;


type
  ISessaoController = interface
    ['{4EFE8C03-2139-48B5-8D5A-EAADD657705B}']
    procedure Entrar;
    procedure RecuperarSenha(Usuario: string);
    procedure Login(Value: string); overload;
    procedure Senha(Value: string); overload;
    procedure Lembrar(Value: Boolean); overload;
    function Login: string; overload;
    function Senha: string; overload;
    function Lembrar: Boolean; overload;
    function DataSet: TDataSet;
  end;

  TSessaoController = class(TInterfacedObject, ISessaoController)
  private
    FIniFile: TIniFile;
    FService: ISessaoService;
    FLogin: string;
    FSenha: string;
    FLembrar: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    class function New(): ISessaoController;
    procedure RecuperarSenha(Usuario: string);
    procedure Entrar;
    procedure Login(Value: string); overload;
    procedure Senha(Value: string); overload;
    procedure Lembrar(Value: Boolean); overload;
    function Login: string; overload;
    function Senha: string; overload;
    function Lembrar: Boolean; overload;
    function DataSet: TDataSet;
  end;

var
  FSingleton: ISessaoController;

implementation

{ TLoginController }

constructor TSessaoController.Create;
begin
  FIniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  FService := TSessaoService.Instance;

  if FIniFile.ReadBool('LOGIN', 'LEMBRAR', False) then
  begin
    FLembrar := FIniFile.ReadBool('LOGIN', 'LEMBRAR', False);
    FLogin := FIniFile.ReadString('LOGIN', 'USUARIO', '');
    FSenha := FIniFile.ReadString('LOGIN', 'SENHA', '');
  end;
end;

function TSessaoController.DataSet: TDataSet;
begin
  Result := FService.DataSet;
end;

destructor TSessaoController.Destroy;
begin
  FIniFile.Free;
  inherited;
end;

procedure TSessaoController.Entrar;
begin
  FService.Autenticar(FLogin, FSenha);

  FIniFile.WriteString('LOGIN', 'USUARIO', ifThen(FLembrar, FLogin));
  FIniFile.WriteString('LOGIN', 'SENHA', ifThen(FLembrar, FSenha));
  FIniFile.WriteBool('LOGIN', 'LEMBRAR', FLembrar);
  Sleep(2000);
end;

procedure TSessaoController.Lembrar(Value: Boolean);
begin
  FLembrar := Value;
end;

function TSessaoController.Lembrar: Boolean;
begin
  Result := FLembrar;
end;

function TSessaoController.Login: string;
begin
  Result := FLogin;
end;

procedure TSessaoController.Login(Value: string);
begin
  FLogin := Value;
end;

class function TSessaoController.New: ISessaoController;
begin
  if not Assigned(FSingleton) then
    FSingleton := TSessaoController.Create;

  Result := FSingleton;
end;

procedure TSessaoController.RecuperarSenha(Usuario: string);
begin
  if Application.MessageBox(
    'Deseja receber uma nova senha de acesso por e-mail?',
    'SoftGym | Recuperar senha',
    MB_YESNO + MB_ICONEXCLAMATION) = mrNo then
  begin
    Exit;
  end;

  FService.RecuperarSenha(Usuario);

  Application.MessageBox(
    'Email enviado com sucesso para teste@teste.com',
    'SoftGym | Recuperar senha',
    MB_OK + MB_ICONEXCLAMATION)
end;

function TSessaoController.Senha: string;
begin
  Result := FSenha;
end;

procedure TSessaoController.Senha(Value: string);
begin
  FSenha := Value;
end;

end.
