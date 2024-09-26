unit ConnZeosLib;

interface

uses
  SysUtils, Classes, Provider, DBGrids, WideStrings,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, DB, IniFiles;

type
  TDMConnZeosLib = class(TDataModule)
    ConnSQlite: TZConnection;
    qryAluno: TZQuery;
    qryAlunoCodigoAluno: TZInt64Field;
    qryAlunoNome: TZUnicodeStringField;
    qryAlunoDataNascimento: TZDateField;
    qryAlunoTelefone: TZUnicodeStringField;
    qryAlunoEmail: TZUnicodeStringField;
    qryAlunoCpf: TZUnicodeStringField;
    qryAlunoObservacao: TZUnicodeCLobField;
    qryAlunoCep: TZInt64Field;
    qryAlunoLogradouro: TZUnicodeStringField;
    qryAlunoBairro: TZUnicodeStringField;
    qryAlunoMunicipio: TZUnicodeStringField;
    qryAlunoUf: TZUnicodeStringField;
    qryAlunoNumero: TZUnicodeStringField;
    qryAlunoComplemento: TZUnicodeStringField;
    qryAlunoReferencia: TZUnicodeStringField;
    qryAlunoInseridoEm: TZDateTimeField;
    qryAlunoInseridoPor: TZInt64Field;
    qryAlunoModificadoEm: TZDateTimeField;
    qryAlunoModificadoPor: TZInt64Field;
    qryUsuario: TZQuery;
    qryUsuarioCodigoUsuario: TZInt64Field;
    qryUsuarioNome: TZUnicodeCLobField;
    qryUsuarioLogin: TZUnicodeCLobField;
    qryUsuarioSenha: TZUnicodeCLobField;
    qryUsuarioEmail: TZUnicodeCLobField;
    qryUsuarioAcesso: TZUnicodeCLobField;
    qryUsuarioAtivo: TZUnicodeCLobField;
    procedure ConnSQliteBeforeConnect(Sender: TObject);
    procedure qryAlunoBeforePost(DataSet: TDataSet);
    procedure qryAlunoDataNascimentoSetText(Sender: TField; const Text: string);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  procedure OrdernarDataSet(DataSet: TDataSet; FieldName: String);
  procedure ExtractDataBase;

var
  DMConnZeosLib: TDMConnZeosLib;
  IniFile: TIniFile;

implementation

{$R *.dfm}

uses
  StrUtils, Dialogs, Types, Forms;

procedure OrdernarDataSet(DataSet: TDataSet; FieldName: String);
begin
//  Conn ADO
//  if (DataSet as TADODataSet).IndexFieldNames = FieldName then
//  begin
//    Indice := AnsiUpperCase(FieldName+' DESC');
//
//    if not ((DataSet as TADODataSet).IndexDefs.IndexOf(Indice) > -1) then
//    with (DataSet as TADODataSet).IndexDefs.AddIndexDef do
//    begin
//      Name := Indice;
//      Fields := FieldName;
//      Options := [ixDescending];
//    end;
//  end;
//
//  (DataSet as TADODataSet).IndexFieldNames := ifThen(Indice = '', FieldName, Indice);

  if SameText((DataSet as TZQuery).IndexFieldNames, FieldName+' DESC') then
    (DataSet as TZQuery).IndexFieldNames := FieldName+' ASC'
  else
    (DataSet as TZQuery).IndexFieldNames := FieldName+' DESC';
end;

procedure ExtractResource(ResourceName: string; FileName: string);
var
  rs: TResourceStream;
  fs: TFileStream;
begin
  if not FileExists(GetCurrentDir + '/'+ FileName) then
  begin
    rs := TResourceStream.Create(hInstance, ResourceName, RT_RCDATA);
    try
      fs := TFileStream.Create(GetCurrentDir + '/' + FileName, fmCreate);
      try
        rs.SaveToStream(fs);
      finally
        fs.Free;
      end;
    finally
      rs.Free;
    end;
  end;
end;

procedure ExtractDataBase;
begin
  ExtractResource('softgym_db', 'database.db3');
  ExtractResource('sqlite_dll', 'sqlite3.dll');
end;

procedure TDMConnZeosLib.ConnSQliteBeforeConnect(Sender: TObject);
begin
  (Sender as TZConnection).Database := GetCurrentDir +'\database.db3';
  (Sender as TZConnection).LibraryLocation := GetCurrentDir +'\sqlite3.dll';
end;

procedure TDMConnZeosLib.DataModuleCreate(Sender: TObject);
begin
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
end;

procedure TDMConnZeosLib.DataModuleDestroy(Sender: TObject);
begin
  IniFile.Free;
end;

procedure TDMConnZeosLib.qryAlunoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('InseridoEm').AsDateTime := Now;
    DataSet.FieldByName('InseridoPor').AsInteger := 1;
  end;

  if DataSet.State = dsEdit then
  begin
    DataSet.FieldByName('ModificadoEm').AsDateTime := Now;
    DataSet.FieldByName('ModificadoPor').AsInteger := 1;
  end
end;

procedure TDMConnZeosLib.qryAlunoDataNascimentoSetText(Sender: TField;
  const Text: string);
begin
  if Text = '  /  /    ' then
    Sender.Clear
  else
    Sender.Value := Text;
end;

end.
