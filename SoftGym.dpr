program SoftGym;



{$R *.dres}

uses
  Forms,
  FormPrincipal in 'src\FormPrincipal.pas' {frmPrincipal},
  Router in 'src\Router.pas',
  PageDashboard in 'src\PageDashboard.pas' {frmPageDashboard},
  ConnZeosLib in 'src\ConnZeosLib.pas' {DMConnZeosLib: TDataModule},
  PageAlunos in 'src\PageAlunos.pas' {frmPageAlunos},
  ApiCep in 'src\ApiCep.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ExtractDataBase;
  Application.Title := 'SoftGym';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDMConnZeosLib, DMConnZeosLib);
  Application.Run;
end.
