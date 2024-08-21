unit PageDashboard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmPageDashboard = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Shape1: TShape;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPageDashboard: TfrmPageDashboard;

implementation

uses Router;

{$R *.dfm}

initialization
  TRouter.Add('PageDashboard', TfrmPageDashboard);

end.
