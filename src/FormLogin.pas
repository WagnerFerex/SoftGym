unit FormLogin;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  Buttons,
  GIFImg,
  StrUtils,
  module.sistema.login.controller;

type
  TfrmLogin = class(TForm)
    pnlEntrar: TPanel;
    edtSenha: TEdit;
    edtUsuario: TEdit;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    cbxLembrarme: TCheckBox;
    lblLembrarme: TLabel;
    lblEsqueciSenha: TLabel;
    btnMostrarSenha: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    btnEntrar: TSpeedButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure pnlEntrarEnter(Sender: TObject);
    procedure pnlEntrarExit(Sender: TObject);
    procedure btnMostrarSenhaClick(Sender: TObject);
    procedure lblEsqueciSenhaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure HabDesFormulario(Option: Boolean);
  private
    { Private declarations }
    FController: ILoginController;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses ConnZeosLib, Thread;

{$R *.dfm}

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  HabDesFormulario(False);

  TMyThread.CreateAnonymousThread(procedure
  begin
    try
      FController.Login(edtUsuario.Text);
      FController.Senha(edtSenha.Text);
      FController.Lembrar(cbxLembrarme.Checked);
      FController.Entrar;

      ModalResult := mrOK;
    except on E: Exception do
      Application.MessageBox(PChar(E.Message), 'Dados login', MB_OK + MB_ICONEXCLAMATION);
    end;
  end).Start;
end;

procedure TfrmLogin.pnlEntrarEnter(Sender: TObject);
begin
  pnlEntrar.Color := pnlEntrar.Color + 1000;
end;

procedure TfrmLogin.pnlEntrarExit(Sender: TObject);
begin
  pnlEntrar.Color := pnlEntrar.Color - 1000;
end;

procedure TfrmLogin.btnMostrarSenhaClick(Sender: TObject);
begin
  if edtSenha.PasswordChar = '*' then
    edtSenha.PasswordChar := edtUsuario.PasswordChar
  else
    edtSenha.PasswordChar := '*';
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  FController := TUsuarioController.New;

  edtUsuario.Text      := FController.Login;
  edtSenha.Text        := FController.Senha;
  cbxLembrarme.Checked := FController.Lembrar;

  (Image1.Picture.Graphic as TGIFImage).Animate := True;
  (Image1.Picture.Graphic as TGIFImage).AnimationSpeed := 100;
end;

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then btnEntrar.Click;
end;

procedure TfrmLogin.HabDesFormulario(Option: Boolean);
begin
  Label2.Caption := IfThen(Option, 'Entre com seus dados.', 'Carregando... Aguarde!');

  lblUsuario.Visible := Option;
  edtUsuario.Visible := Option;

  lblSenha.Visible := Option;
  edtSenha.Visible := Option;

  cbxLembrarme.Visible := Option;
  lblLembrarme.Visible := Option;

  pnlEntrar.Visible := Option;
  lblEsqueciSenha.Visible := Option;

  Image1.Visible := not Option;
  Application.ProcessMessages;
end;

procedure TfrmLogin.lblEsqueciSenhaClick(Sender: TObject);
begin
  FController.RecuperarSenha(edtUsuario.Text);
end;

end.
