unit PageAlunos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Buttons, StdCtrls, Grids, DBGrids, DB, ComCtrls,
  Mask, Generics.Collections, StrUtils, ComObj;

type
  TypeData = (tdRequired, tdCpf, tdCep, tdEmail);

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
    btnSalvar: TSpeedButton;
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
    edtDataNascimento: TDBEdit;
    SpeedButton1: TSpeedButton;
    edtEmail: TDBEdit;
    Label10: TLabel;
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dsrAlunosStateChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCEPChange(Sender: TObject);
    procedure edtTelefoneChange(Sender: TObject);
    procedure edtTelefoneClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure tsCrudShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Router, ConnZeosLib, ApiCep;

{$R *.dfm}

procedure TfrmPageAlunos.DBGrid1DblClick(Sender: TObject);
begin
  dsrAlunos.DataSet.Edit;
end;

procedure TfrmPageAlunos.DBGrid1TitleClick(Column: TColumn);
var
  I: SmallInt;
begin
  for I := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns[I].Title.Font.Style := [];

  Column.Title.Font.Style := [fsBold, fsUnderline];
  OrdernarDataSet(dsrAlunos.DataSet, Column.FieldName);
end;

procedure TfrmPageAlunos.dsrAlunosStateChange(Sender: TObject);
begin
  case dsrAlunos.DataSet.State of
    dsBrowse: begin
      pcAluno.ActivePage := tsList;
    end;
    dsEdit, dsInsert: begin
      pcAluno.ActivePage := tsCrud;
    end;
  end;

  Label2.Caption := Format('%d Registro(s) encontrado(s)', [dsrAlunos.DataSet.RecordCount]);
end;

procedure TfrmPageAlunos.edtPesquisaChange(Sender: TObject);
begin
  dsrAlunos.DataSet.Filtered := False;
  dsrAlunos.DataSet.Filter   := 'Nome like ' + QuotedStr(Trim((Sender as TEdit).Text) + '*');
  dsrAlunos.DataSet.Filtered := Trim((Sender as TEdit).Text) <> '';
end;

function Number(const ATexto: string): string;
var
  i: Integer;
  Caracter: Char;
begin
  Result := '';
  for i := 1 to Length(ATexto) do
  begin
    Caracter := ATexto[i];
    if CharInSet(Caracter, ['0'..'9']) then
      Result := Result + Caracter;
  end;
end;

procedure TfrmPageAlunos.edtCEPChange(Sender: TObject);
var
  LApiCep: TViaCep;
begin
  if (dsrAlunos.DataSet.State in [dsEdit, dsInsert]) and (Length(edtCEP.Text) = 8) then
  begin
    LApiCep := TViaCep.Create;
    try
      LApiCep.Find(edtCEP.Text);
      dsrAlunos.DataSet.FieldByName('Logradouro').AsString := LApiCep.Logradouro;
      dsrAlunos.DataSet.FieldByName('Bairro').AsString     := LApiCep.Bairro;
      dsrAlunos.DataSet.FieldByName('Municipio').AsString  := LApiCep.Municipio;
      dsrAlunos.DataSet.FieldByName('Uf').AsString         := LApiCep.Uf;
    finally
      LApiCep.Free;
    end;
  end;
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

procedure TfrmPageAlunos.FormDestroy(Sender: TObject);
begin
  dsrAlunos.DataSet.Close;
end;

procedure TfrmPageAlunos.FormShow(Sender: TObject);
begin
  dsrAlunos.DataSet.Open;
end;

procedure TfrmPageAlunos.SpeedButton1Click(Sender: TObject);
var
  ExcelApp: OleVariant;
  Line, Col: Integer;

begin
  ExcelApp := CreateoleObject('Excel.Application');
  ExcelApp.Visible := True;
  try
    ExcelApp.WorkBooks.Add(1);

    dsrAlunos.DataSet.First;
    for Line := 0 to dsrAlunos.DataSet.RecordCount - 1 do
    begin
      for Col := 1 to dsrAlunos.DataSet.FieldCount -4 do
        ExcelApp.Cells[Line + 2, Col] := dsrAlunos.DataSet.Fields[Col - 1].AsString;
      dsrAlunos.DataSet.Next;
    end;

    for Col := 1 to dsrAlunos.DataSet.FieldCount -4 do
      ExcelApp.Cells[1, Col] := dsrAlunos.DataSet.Fields[Col - 1].DisplayLabel;

    ExcelApp.columns.Autofit;
  finally
    ExcelApp := Unassigned;
  end;
end;

procedure TfrmPageAlunos.tsCrudShow(Sender: TObject);
begin
  edtNome.SetFocus;
end;

procedure TfrmPageAlunos.btnCancelarClick(Sender: TObject);
begin
  dsrAlunos.DataSet.Cancel;
end;

procedure TfrmPageAlunos.btnNovoClick(Sender: TObject);
begin
  pcAluno.ActivePage := tsCrud;
  dsrAlunos.DataSet.Insert;
end;

function isEmpty(AEdit: TDBEdit; AMsg: string): Boolean;
begin
  if Trim(AEdit.Text) = '' then
  begin
    Application.MessageBox(PWideChar(AMsg), 'Campo obrigat�rio!', MB_OK + MB_ICONERROR);
    AEdit.Clear;
    AEdit.SetFocus;
    Exit(True);
  end;

  Result := False;
end;

function isCpf(AEdit: TDBEdit; AMsg: string): Boolean;
var
  i, j: Integer;
  Soma, Resto: Integer;
  Digito: Integer;
  CPF: string;
begin
  // Remove caracteres n�o num�ricos
  CPF := StringReplace(Trim(AEdit.Text), '.', '', [rfReplaceAll]);
  CPF := StringReplace(CPF, '-', '', [rfReplaceAll]);

  if CPF = '' then
    Exit(True);

  // Verifica se o CPF tem 11 d�gitos
  if Length(CPF) <> 11 then
  begin
    Application.MessageBox(PWideChar(AMsg), 'Campo inv�lido!', MB_OK + MB_ICONERROR);
    AEdit.SetFocus;
    Exit(False);
  end;

  // Verifica se todos os d�gitos s�o iguais (exemplo: 111.111.111-11)
  if (CPF = StringOfChar(CPF[1], 11)) then
  begin
    Application.MessageBox(PWideChar(AMsg), 'Campo inv�lido!', MB_OK + MB_ICONERROR);
    AEdit.SetFocus;
    Exit(False);
  end;

  // Valida��o do primeiro d�gito verificador
  Soma := 0;
  j := 10;
  for i := 1 to 9 do
  begin
    Soma := Soma + StrToInt(CPF[i]) * j;
    Dec(j);
  end;
  Resto := Soma mod 11;
  if Resto < 2 then
    Digito := 0
  else
    Digito := 11 - Resto;

  if StrToInt(CPF[10]) <> Digito then
  begin
    Application.MessageBox(PWideChar(AMsg), 'Campo inv�lido!', MB_OK + MB_ICONERROR);
    AEdit.SetFocus;
    Exit(False);
  end;

  // Valida��o do segundo d�gito verificador
  Soma := 0;
  j := 11;
  for i := 1 to 10 do
  begin
    Soma := Soma + StrToInt(CPF[i]) * j;
    Dec(j);
  end;
  Resto := Soma mod 11;
  if Resto < 2 then
    Digito := 0
  else
    Digito := 11 - Resto;

  if StrToInt(CPF[11]) <> Digito then
  begin
    Application.MessageBox(PWideChar(AMsg), 'Campo inv�lido!', MB_OK + MB_ICONERROR);
    AEdit.SetFocus;
    Exit(False);
  end;

  Result := True;
end;

function MathArray(AValue: Array of Variant; Find: Variant): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(AValue) to High(AValue) do
    if AValue[I] = Find then
    begin
      Result := True;
      Break;
    end;
end;

procedure TfrmPageAlunos.btnSalvarClick(Sender: TObject);
begin
  if isEmpty(edtTelefone, 'N�o informado nenhum valor para o campo telefone.')
    or not isCpf(edtCPF, 'N�o informado um valor v�lido para o campo CPF') then
    Exit;

  dsrAlunos.DataSet.Post;
end;

initialization
  TRouter.Add('PageAlunos', TfrmPageAlunos);

end.

