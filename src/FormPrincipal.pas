unit FormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, jpeg, Buttons;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Image7: TImage;
    Panel5: TPanel;
    lblUsuario: TLabel;
    btnTreinos: TSpeedButton;
    btnConfiguracao: TSpeedButton;
    btnRelatorios: TSpeedButton;
    btnFinanceiro: TSpeedButton;
    btnAlunos: TSpeedButton;
    Edit1: TEdit;
    Image1: TImage;
    Shape1: TShape;
    pnlRender: TPanel;
    btnHome: TSpeedButton;
    Image2: TImage;
    procedure btnHomeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlunosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Sair1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses Router, ConnZeosLib;
{$R *.dfm}

procedure TfrmPrincipal.btnAlunosClick(Sender: TObject);
begin
  TRouter.Render('PageAlunos', pnlRender);
end;

procedure TfrmPrincipal.btnHomeClick(Sender: TObject);
begin
  TRouter.Render('PageDashboard', pnlRender);
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    Perform(WM_NEXTDLGCTL, 0, 0)
  else if Key = 27 then
    Perform(WM_NEXTDLGCTL, 1, 0)
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  lblUsuario.Caption := DMConnZeosLib.qryUsuarioNome.AsString;
  btnHome.Click;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

end.
