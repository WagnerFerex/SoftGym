unit module.aluno.entity;

interface

type
  TALUNO = class
  private
    FLogradouro: string;
    FObservacao: string;
    FBairro: string;
    FEmail: string;
    FDataNascimento: Variant;
    FUf: string;
    FCpf: string;
    FCep: integer;
    FNumero: string;
    FMunicipio: string;
    FComplemento: string;
    FReferencia: string;
    FNome: string;
    FTelefone: string;
  public
    _Id: Integer;
    property CodigoAluno: Integer read _Id write _Id;
    property Nome: string read FNome write FNome;
    property DataNascimento: Variant read FDataNascimento write FDataNascimento;
    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
    property Cpf: string read FCpf write FCpf;
    property Observacao: string read FObservacao write FObservacao;
    property Cep: integer read FCep write FCep;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Bairro: string read FBairro write FBairro;
    property Municipio: string read FMunicipio write FMunicipio;
    property Uf: string read FUf write FUf;
    property Numero: string read FNumero write FNumero;
    property Complemento: string read FComplemento write FComplemento;
    property Referencia: string read FReferencia write FReferencia;
    constructor Create; overload;
    constructor Create(
      ACodigoAluno: Integer;
      ANome: string;
      ADataNascimento: Variant;
      ATelefone: string;
      AEmail: string;
      ACpf: string;
      Observacao: string;
      ACep: Integer;
      ALogradouro: string;
      ABairro: string;
      AMunicipio: string;
      AUf: string;
      ANumero: string;
      AComplemento: string;
      AReferencia: string
    ); overload;
  end;

implementation


{ TALUNO }

constructor TALUNO.Create(ACodigoAluno: Integer; ANome: string;
  ADataNascimento: Variant; ATelefone, AEmail, ACpf, Observacao: string;
  ACep: Integer; ALogradouro, ABairro, AMunicipio, AUf, ANumero, AComplemento,
  AReferencia: string);
begin
  CodigoAluno := ACodigoAluno;
  Nome := ANome;
  DataNascimento := ADataNascimento;
  Telefone := ATelefone;
  Email := AEmail;
  Cpf := ACpf;
  Observacao := Observacao;
  Cep := ACep;
  Logradouro := ALogradouro;
  Bairro := ABairro;
  Municipio := AMunicipio;
  Uf := AUf;
  Numero := ANumero;
  Complemento := AComplemento;
  Referencia := AReferencia;
end;

constructor TALUNO.Create;
begin

end;

end.
