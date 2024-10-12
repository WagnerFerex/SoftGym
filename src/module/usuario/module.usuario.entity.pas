unit module.usuario.entity;

interface

type
  TUSUARIO = class
  private
    FLogin: string;
    FNome: string;
    FSenha: string;
  public
    _id: Integer;
    property CodigoUsuario: Integer read _id write _id;
    property Nome: string read FNome write FNome;
    property Login: string read FLogin write FLogin;
    property Senha: string read FSenha write FSenha;
  end;

implementation

{ TUSUARIO }


end.
