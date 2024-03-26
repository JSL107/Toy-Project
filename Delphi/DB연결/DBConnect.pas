unit DBConnect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uDynamicADO_V4;

type
  TForm1 = class(TForm)
    Button1: TButton;
    edtID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtIP: TEdit;
    edtName: TEdit;
    Label4: TLabel;
    edtPW: TEdit;
    Label5: TLabel;
    edtPort: TEdit;
    procedure btnConnectClick(Sender: TObject);
  private
    { Private declarations }
    FMSDB: TDynamicMSSQL;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{ TForm1 }

{ TForm1 }

procedure TForm1.btnConnectClick(Sender: TObject);
begin
  FMSDB := TDynamicMSSQL.Create;
  if MessageDlg('DB Connect?', mtInformation, mbYesNo, 0) = mrYes then
  begin
    try
      FMSDB.DBServer := edtIP.Text;
      FMSDB.DBPort := StrToInt(edtPort.Text);
      FMSDB.DBName := edtName.Text;
      FMSDB.DBUser := edtID.Text;
      FMSDB.DBPass := edtPW.Text;

      FMSDB.Connect;

      if FMSDB.Connected then
      begin
        ShowMessage('Complete');
      end
      else
      begin
        ShowMessage('Fail');
      end;

    finally
      FMSDB.Free;
    end;
  end;

  ///
end;

end.
