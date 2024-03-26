unit SignUp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uDynamicADO_V4;

type
  TfSignUp = class(TForm)
    edtID: TEdit;
    edtPW: TEdit;
    btnJoin: TButton;
    edtName: TEdit;
    edtAge: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnJoinClick(Sender: TObject);
  private
    { Private declarations }
    FMSDB: TDynamicMSSQL;
  public
    { Public declarations }
  end;

var
  fSignUp: TfSignUp;

implementation

{$R *.dfm}

procedure TfSignUp.btnJoinClick(Sender: TObject);
var
  db: TDBStoredProc;
  id, pw, name: string;
  age: Integer;
begin
  FMSDB := TDynamicMSSQL.Create;
  id := edtID.Text;
  pw := edtPW.Text;
  age := StrToInt(edtAge.Text);
  name := edtName.Text;

  if (id <> '') and (pw <> '') and (age <> null) and (name <> '') then
  begin
    if MessageDlg('Sign Up?', mtInformation, mbYesNo, 0) = mrYes then
    begin
      try
        FMSDB.DBServer := '127.0.0.1';
        FMSDB.DBPort := 1433;
        FMSDB.DBName := 'TestDB';
        FMSDB.DBUser := 'localhost';
        FMSDB.DBPass := '1234';

        // insert 프로시저를 이용할때 SP_OpenRecord를 이용하면 오류가 나기 때문에 단순한 Execute를 이용한다.
        db := FMSDB.SP_Execute('SIGNUP_PROCEDURE', [id, pw, age, name]);
        if Assigned(db) then
        begin
          ShowMessage('success insert data');
        end
        else
        begin
          ShowMessage('db connect fail');
        end;
      finally
        FMSDB.Free;
      end;
    end;
  end
  else
  begin
    ShowMessage('everything blank is not allowed');
  end;

end;

end.
