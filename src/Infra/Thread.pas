unit Thread;

interface

uses
  Classes, SysUtils;

type
  TMyThread = class(TThread)
  protected
    FProc: TProc;
    procedure Execute; override;
  public
    class function CreateAnonymousThread(AProc: TProc): TThread;
    procedure Proc(AProc: TProc);
  end;

implementation

{ TMyThread }

class function TMyThread.CreateAnonymousThread(AProc: TProc): TThread;
var
  FMyThread: TMyThread;
begin
  FMyThread := TMyThread.Create(True);
  FMyThread.Proc(AProc);
  FMyThread.FreeOnTerminate := True;

  Result := FMyThread;
end;

procedure TMyThread.Execute;
begin
  if Assigned(FProc) then
    FProc;

  inherited;
end;

procedure TMyThread.Proc(AProc: TProc);
begin
  FProc := AProc;
end;

end.
