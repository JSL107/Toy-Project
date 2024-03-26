program Project2;

uses
  Vcl.Forms,
  DBConnect in 'DBConnect.pas' {Form1},
  uDynamicADO_V4 in '01.Class\uDynamicADO_V4.pas',
  uModel in '01.Class\uModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
