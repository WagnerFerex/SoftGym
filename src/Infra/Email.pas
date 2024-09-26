unit Email;

interface
uses
  IdSMTP,
  IdSSLOpenSSL,
  IdMessage,
  IdText,
  IdAttachmentFile,
  IdExplicitTLSClientServerBase,
  StdCtrls,
  SysUtils,
  Dialogs,
  Classes,
  IniFiles,
  Forms;

type
  IEmail = interface
    ['{212C9172-D02B-4471-B259-5E0AAF386DE8}']
    function FromAddress(AValue: string): IEmail;
    function FromName(AValue: string): IEmail;
    function ReplyToAddress(AValue: string): IEmail;
    function RecipientsAddress(AValue: string): IEmail;
    function Subject(AValue: string): IEmail;
    function AddBody(AValue: string): IEmail;
    function Attachment(AValue: string): IEmail;
    function Send: IEmail;
  end;

  TConfigEmail = record
    Port: Integer;
    Password: string;
    Host: string;
    Username: string;
    Name: string;
  end;

  TEmail = class(TInterfacedObject, IEmail)
  private
    FFromAddress: string;
    FFromName: string;
    FReplyToAddress: string;
    FRecipientsAddress: string;
    FBody: TStringList;
    FSubject: string;
    FAttachment: string;
    FIdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
    FIdSMTP: TIdSMTP;
    FIdMessage: TIdMessage;
    FIdText: TIdText;
    procedure SetMailParams;
    procedure SetMailBody;
    procedure SetMailAttachment;
  public
    constructor Create(Port: Integer; Host, UserName, Password: string);
    destructor Destroy(); override;
    class function New(Port: Integer; Host, UserName, Password: string): IEmail; overload;
    class function New(): IEmail; overload;
    function FromAddress(AValue: string): IEmail;
    function FromName(AValue: string): IEmail;
    function ReplyToAddress(AValue: string): IEmail;
    function RecipientsAddress(AValue: string): IEmail;
    function Subject(AValue: string): IEmail;
    function AddBody(AValue: string): IEmail;
    function Attachment(AValue: string): IEmail;
    function Send: IEmail;
  end;

implementation

{ TUtils4DeMail }

function TEmail.Attachment(AValue: string): IEmail;
begin
  Result := Self;
  FAttachment := AValue;
end;

function TEmail.AddBody(AValue: string): IEmail;
begin
  Result := Self;
  FBody.Append(AValue);
end;

constructor TEmail.Create(Port: Integer; Host, UserName,
  Password: string);
begin
  FIdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdSMTP := TIdSMTP.Create(nil);
  FIdMessage := TIdMessage.Create(nil);
  FBody := TStringLIst.Create;
  FFromAddress := UserName;

  FIdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
  FIdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

  FIdSMTP.IOHandler := FIdSSLIOHandlerSocket;
  FIdSMTP.UseTLS := utUseImplicitTLS;
  FIdSMTP.AuthType := satDefault;
  FIdSMTP.Port := Port;
  FIdSMTP.Host := Host;
  FIdSMTP.UserName := UserName;
  FIdSMTP.Password := Password;
end;

destructor TEmail.Destroy;
begin
  FreeAndNil(FIdSSLIOHandlerSocket);
  FreeAndNil(FIdSMTP);
  FreeAndNil(FIdMessage);

  inherited;
end;

function TEmail.FromAddress(AValue: string): IEmail;
begin
  Result := Self;
  FFromAddress := AValue;
end;

function TEmail.FromName(AValue: string): IEmail;
begin
  Result := Self;
  FFromName := AValue;
end;

function GetConfig: TConfigEmail;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    if (not IniFile.ValueExists('EMAIL', 'PORTA')) or
      (not IniFile.ValueExists('EMAIL', 'HOST')) or
      (not IniFile.ValueExists('EMAIL', 'USUARIO')) or
      (not IniFile.ValueExists('EMAIL', 'SENHA')) then
      raise Exception.Create('Configurações de Email não foram definidas.');

    Result.Port := IniFile.ReadInteger('EMAIL', 'PORTA', 0);
    Result.Host := IniFile.ReadString('EMAIL', 'HOST', '');
    Result.Username := IniFile.ReadString('EMAIL', 'USUARIO', '');
    Result.Password := IniFile.ReadString('EMAIL', 'SENHA', '');
  finally
    IniFile.Free;
  end;
end;

class function TEmail.New: IEmail;
begin
  with GetConfig do
  begin
    Result := Self.Create(Port, Host, Username, Password);
  end;
end;

class function TEmail.New(Port: Integer; Host, UserName,
  Password: string): IEmail;
begin
  Result := Self.Create(Port, Host, UserName, Password);
end;

function TEmail.RecipientsAddress(AValue: string): IEmail;
begin
  Result := Self;
  FRecipientsAddress := AValue;
end;

function TEmail.ReplyToAddress(AValue: string): IEmail;
begin
  Result := Self;
  FReplyToAddress := AValue;
end;

function TEmail.Send: IEmail;
begin
  Result := Self;
  SetMailParams;
  SetMailBody;
  SetMailAttachment;

  FIdSMTP.Connect;
  try
    FIdSMTP.Authenticate;
    FIdSMTP.Send(FIdMessage);
  finally
    FIdSMTP.Disconnect;
    UnLoadOpenSSLLibrary;
  end;
end;

procedure TEmail.SetMailAttachment;
begin
  if FileExists(FAttachment) then
    TIdAttachmentFile.Create(FIdMessage.MessageParts, FAttachment);
end;

procedure TEmail.SetMailBody;
begin
  if Trim(FBody.Text) = '' then
    raise Exception.Create('Corpo da Mensagem Vazio');

  FIdText := TIdText.Create(FIdMessage.MessageParts);
  FIdText.Body.Assign(FBody);
  FIdText.ContentType := 'text/html; charset=utf-8';
end;

procedure TEmail.SetMailParams;
begin
  if Trim(FRecipientsAddress) = '' then
    raise Exception.Create('Sem destinatario.');

  if Trim(FSubject) = '' then
    raise Exception.Create('Sem assunto.');

  FIdMessage.From.Address := FFromAddress;
  FIdMessage.From.Name := FFromName;
  FIdMessage.ReplyTo.EMailAddresses := FReplyToAddress;
  FIdMessage.Recipients.Add.Text := FRecipientsAddress;
  FIdMessage.Subject := FSubject;
  FIdMessage.Encoding := meMIME;
end;

function TEmail.Subject(AValue: string): IEmail;
begin
  Result := Self;
  FSubject := AValue;
end;

end.
