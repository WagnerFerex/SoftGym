program SoftGym;



{$R *.dres}

uses
  Forms,
  Controls,
  FormPrincipal in 'src\FormPrincipal.pas' {frmPrincipal},
  Router in 'src\Infra\Router.pas',
  Thread in 'src\Infra\Thread.pas',
  Email in 'src\Infra\Email.pas',
  Utils in 'src\Infra\Utils.pas',
  PageDashboard in 'src\PageDashboard.pas' {frmPageDashboard},
  ConnZeosLib in 'src\ConnZeosLib.pas' {DMConnZeosLib: TDataModule},
  PageAlunos in 'src\PageAlunos.pas' {frmPageAlunos},
  ApiCep in 'src\ApiCep.pas',
  FormLogin in 'src\FormLogin.pas' {frmLogin},
  module.sistema.login.controller in 'src\module\module.sistema.login.controller.pas',
  module.sistema.usuario.model in 'src\module\module.sistema.usuario.model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ExtractDataBase;
  Application.Title := 'SoftGym';
  Application.CreateForm(TDMConnZeosLib, DMConnZeosLib);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmLogin, frmLogin);
  if frmLogin.ShowModal <> mrCancel then Application.Run;
end.
