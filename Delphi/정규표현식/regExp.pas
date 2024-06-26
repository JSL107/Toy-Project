unit regExp;

interface

uses
  {선언부}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  // 정규표현식을 사용하기 위해서는 선언부에 System.RegularExpressions 을 적어줘야한다.
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.RegularExpressions;

type
  TForm1 = class(TForm)
    lblKo: TLabel;
    lblEn: TLabel;
    lblNum: TLabel;
    lblSp: TLabel;
    lblLen: TLabel;
    edtKo: TEdit;
    edtEn: TEdit;
    edtNu: TEdit;
    edtSS: TEdit;
    edtLen: TEdit;
    btnKo: TButton;
    btnEn: TButton;
    btnNu: TButton;
    btnSS: TButton;
    btnLen: TButton;
    procedure btnKoClick(Sender: TObject);
    procedure btnEnClick(Sender: TObject);
    procedure btnNuClick(Sender: TObject);
    procedure btnSSClick(Sender: TObject);
    procedure btnLenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{ 구현부 }

{$R *.dfm}

procedure TForm1.btnEnClick(Sender: TObject);
const
  EnPattern: String = '[A-Z]|[a-z]';
var
  str: String;
  temp: boolean;

begin
  str := edtEn.Text;
  temp := TRegEx.IsMatch(str, EnPattern);
  if temp then
  begin
    showMessage('correct');
  end
  else
  begin
    showMessage('incorrect');
  end;

end;

procedure TForm1.btnKoClick(Sender: TObject);
const
  KoPattern: String = '[가-힣]|[ㄱ-ㅎㅏ-ㅣ]';
var
  str: String;
  temp: boolean;

begin
  str := edtKo.Text;
  temp := TRegEx.IsMatch(str, KoPattern);
  if temp then
  begin
    showMessage('correct');
  end
  else
  begin
    showMessage('incorrect');
  end;

end;

const
  LenPattern: string = '[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]^.{0,10}$';

var
  str: String;
  temp: boolean;

begin
  str := edtLen.Text;
  temp := TRegEx.IsMatch(str, LenPattern);
  if temp then
  begin
    showMessage('correct');
  end
  else
  begin
    showMessage('incorrect');
  end;

end;

procedure TForm1.btnNuClick(Sender: TObject);
const
  NumPattern: String = '[0-9]';
var
  str: String;
  temp: boolean;

begin
  str := edtNu.Text;
  temp := TRegEx.IsMatch(str, NumPattern);
  if temp then
  begin
    showMessage('correct');
  end
  else
  begin
    showMessage('incorrect');
  end;

end;

procedure TForm1.btnSSClick(Sender: TObject);
const
  SpcPattern: string = '[^a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]';
var
  str: String;
  temp: boolean;

begin
  str := edtSS.Text;
  temp := TRegEx.IsMatch(str, SpcPattern);
  if temp then
  begin
    showMessage('correct');
  end
  else
  begin
    showMessage('incorrect');
  end;

end;

end.
