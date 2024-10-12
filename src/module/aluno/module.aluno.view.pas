unit module.aluno.view;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Buttons, StdCtrls, Grids, DBGrids, DB, ComCtrls,
  Mask, Generics.Collections, StrUtils,
  module.aluno.interfaces,
  module.aluno.factory;

type
  TfrmPageAlunos = class(TForm)
    dsrAlunos: TDataSource;
    pcAluno: TPageControl;
    tsList: TTabSheet;
    tsCrud: TTabSheet;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    edtPesquisa: TEdit;
    btnNovo: TSpeedButton;
    DBNavigator1: TDBNavigator;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Label3: TLabel;
    btnCancelar: TSpeedButton;
    gbEndereco: TGroupBox;
    Label6: TLabel;
    edtEndereco: TDBEdit;
    Label7: TLabel;
    edtBairro: TDBEdit;
    Label8: TLabel;
    edtMunicipio: TDBEdit;
    Label9: TLabel;
    edtUF: TDBEdit;
    Label11: TLabel;
    edtCEP: TDBEdit;
    gbDadosPrincipais: TGroupBox;
    Label4: TLabel;
    edtCodigo: TDBEdit;
    Label5: TLabel;
    edtNome: TDBEdit;
    lblTelefone: TLabel;
    edtTelefone: TDBEdit;
    edtCPF: TDBEdit;
    lblCpf: TLabel;
    gbObservacoes: TGroupBox;
    mmObservacao: TDBMemo;
    Label14: TLabel;
    edtNumero: TDBEdit;
    Label12: TLabel;
    edtComplemento: TDBEdit;
    Label15: TLabel;
    Label16: TLabel;
    lblTelefoneMsgCampo: TLabel;
    SpeedButton1: TSpeedButton;
    edtEmail: TDBEdit;
    Label10: TLabel;
    edtDataNascimento: TMaskEdit;
    btnSalvar: TBitBtn;
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edtPesquisaChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dsrAlunosStateChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtCEPChange(Sender: TObject);
    procedure edtTelefoneChange(Sender: TObject);
    procedure edtTelefoneClick(Sender: TObject);
    procedure tsCrudShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edtDataNascimentoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FController: IAlunoController;
  end;

implementation

uses Router;

{$R *.dfm}

procedure TfrmPageAlunos.DBGrid1DblClick(Sender: TObject);
begin
  FController.DataSet.Edit;
end;

procedure TfrmPageAlunos.DBGrid1TitleClick(Column: TColumn);
var
  I: SmallInt;
begin
  for I := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns[I].Title.Font.Style := [];

  Column.Title.Font.Style := [fsBold, fsUnderline];
//  FController.DAO.OrderBy(Column.FieldName);
end;

procedure TfrmPageAlunos.dsrAlunosStateChange(Sender: TObject);
begin
  case dsrAlunos.DataSet.State of
    dsBrowse: begin
      pcAluno.ActivePage := tsList;
    end;
    dsEdit, dsInsert: begin
      pcAluno.ActivePage := tsCrud;
      edtDataNascimento.Text := dsrAlunos.DataSet.FieldByName('DataNascimento').AsString;
    end;
  end;

  Label2.Caption := Format('%d Registro(s) encontrado(s)', [dsrAlunos.DataSet.RecordCount]);
end;

procedure TfrmPageAlunos.edtPesquisaChange(Sender: TObject);
begin
//  FController.DataSet.Filter('Nome LIKE ' + QuotedStr(Trim((Sender as TEdit).Text) + '%'));
end;

procedure TfrmPageAlunos.edtCEPChange(Sender: TObject);
begin
  FController.BuscarCep(edtCEP.Text);
end;

procedure TfrmPageAlunos.edtDataNascimentoChange(Sender: TObject);
begin
//  if (Sender as TDBEdit).Text = '  /  /    ' then
//    Sender.Clear
//  else
//    Sender.Value := Text;
end;

procedure TfrmPageAlunos.edtTelefoneChange(Sender: TObject);
begin
  if Trim((Sender as TDBEdit).Text) = '' then
  begin
    lblTelefone.Font.Color := clRed;
    lblTelefoneMsgCampo.Visible := true;
    (Sender as TDBEdit).Color := clInfoBk;
  end
  else
  begin
    lblTelefone.Font.Color := clBlack;
    lblTelefoneMsgCampo.Visible := false;
    (Sender as TDBEdit).Color := clWhite;
  end;
end;

procedure TfrmPageAlunos.edtTelefoneClick(Sender: TObject);
begin
  (Sender as TCustomEdit).SelectAll;
end;

procedure TfrmPageAlunos.FormCreate(Sender: TObject);
begin
  FController := TAlunoFactory.Controller;
  FController.DataSource(dsrAlunos);
  FController.DAO.Find;
end;

procedure TfrmPageAlunos.SpeedButton1Click(Sender: TObject);
begin
//  FController.DAO.Export;
end;

procedure TfrmPageAlunos.tsCrudShow(Sender: TObject);
begin
  edtNome.SetFocus;
end;

procedure TfrmPageAlunos.btnCancelarClick(Sender: TObject);
begin
  FController.DataSet.Cancel;
end;

procedure TfrmPageAlunos.btnNovoClick(Sender: TObject);
begin
  pcAluno.ActivePage := tsCrud;
  FController.DataSet.Insert;
end;

procedure TfrmPageAlunos.btnSalvarClick(Sender: TObject);
begin
  btnSalvar.SetFocus;

  if edtDataNascimento.Text = '  /  /    ' then
    FController.DataSet.FieldByName('DataNascimento').Clear
  else
    FController.DataSet.FieldByName('DataNascimento').Value := edtDataNascimento.Text;


  dsrAlunos.DataSet.DisableControls;
  try
    if dsrAlunos.DataSet.State = dsInsert then
      FController.DAO.Insert.Find()
    else
      FController.DAO.Update.Find();
  finally
    dsrAlunos.DataSet.EnableControls;
  end;
end;

initialization
  TRouter.Add('PageAlunos', TfrmPageAlunos);

end.

