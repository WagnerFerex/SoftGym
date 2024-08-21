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
    Label1: TLabel;
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
    procedure btnHomeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses Router;

{$R *.dfm}

procedure TfrmPrincipal.btnHomeClick(Sender: TObject);
begin
  TRouter.Render('PageDashboard', pnlRender);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  btnHome.Click;
end;

end.
