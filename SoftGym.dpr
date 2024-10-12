program SoftGym;

uses
  Forms,
  Controls,
  module.principal.view in 'src\module\principal\module.principal.view.pas' {frmPrincipal},
  Router in 'src\infra\Router.pas',
  Thread in 'src\infra\Thread.pas',
  Email in 'src\infra\Email.pas',
  Utils in 'src\infra\Utils.pas',
  module.principal.dashboard.view in 'src\module\principal\module.principal.dashboard.view.pas' {frmPageDashboard},
  module.aluno.view in 'src\module\aluno\module.aluno.view.pas' {frmPageAlunos},
  ApiCep in 'src\infra\ApiCep.pas',
  module.sessao.login.view in 'src\module\sessao\module.sessao.login.view.pas' {frmLogin},
  infra.component.persistence.connection in 'src\infra\infra.component.persistence.connection.pas' {DmZeosLib: TDataModule},
  infra.component.persistence.dao in 'src\infra\infra.component.persistence.dao.pas',
  module.sessao.controller in 'src\module\sessao\module.sessao.controller.pas',
  module.sessao.service in 'src\module\sessao\module.sessao.service.pas',
  module.aluno.controller in 'src\module\aluno\module.aluno.controller.pas',
  module.aluno.service in 'src\module\aluno\module.aluno.service.pas',
  module.aluno.repository in 'src\module\aluno\module.aluno.repository.pas',
  module.aluno.entity in 'src\module\aluno\module.aluno.entity.pas',
  infra.component.validator in 'src\infra\infra.component.validator.pas',
  module.usuario.entity in 'src\module\usuario\module.usuario.entity.pas',
  module.aluno.factory in 'src\module\aluno\module.aluno.factory.pas',
  module.aluno.interfaces in 'src\module\aluno\module.aluno.interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SoftGym';
  Application.CreateForm(TDmZeosLib, DmZeosLib);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmLogin, frmLogin);
  if frmLogin.ShowModal <> mrCancel then Application.Run;
end.
