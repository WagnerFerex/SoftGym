program SoftGym;

uses
  Forms,
  FormPrincipal in 'FormPrincipal.pas' {frmPrincipal},
  Router in 'Router.pas',
  PageDashboard in 'PageDashboard.pas' {frmPageDashboard};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
