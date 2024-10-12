unit module.principal.dashboard.view;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCGrids, DB, StdCtrls, Mask, DBCtrls, DBClient;

type
  TfrmPageDashboard = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    Panel2: TPanel;
    dsrDashboard: TDataSource;
    DBCtrlGrid1: TDBCtrlGrid;
    Panel3: TPanel;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    Shape2: TShape;
    cdsDashboard: TClientDataSet;
    cdsDashboardQtd: TIntegerField;
    cdsDashboardDescricao: TStringField;
    procedure FormShow(Sender: TObject);
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

procedure TfrmPageDashboard.FormShow(Sender: TObject);
begin
  ShowScrollBar(DBCtrlGrid1.handle, SB_VERT, False);
end;

initialization
  TRouter.Add('PageDashboard', TfrmPageDashboard);

end.
