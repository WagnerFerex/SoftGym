program SoftGym;

uses
  Forms,
  FormPrincipal in 'src\FormPrincipal.pas' {frmPrincipal},
  Router in 'src\Router.pas',
  PageDashboard in 'src\PageDashboard.pas' {frmPageDashboard};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SoftGym';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
