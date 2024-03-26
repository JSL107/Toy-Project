program Project1;

uses
  Vcl.Forms,
  SignUp in '..\SignUp.pas' {fSignUp},
  uDynamicADO_V4 in '01.Class\uDynamicADO_V4.pas',
  uModel in '01.Class\uModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfSignUp, fSignUp);
  Application.Run;
end.
