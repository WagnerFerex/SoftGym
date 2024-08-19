unit uPrincipal;

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
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
//  btnAlunos.Glyph.LoadFromFile('C:\Users\wagner.vasconcelos\Downloads\user (2).png');
// $00301300
end;

end.
