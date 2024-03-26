unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList;

type
  TfrmMain = class(TForm)
    tbMainMenu: TToolBar;
    pnlLayout: TPanel;
    btnMenuRent: TToolButton;
    btnMenuBook: TToolButton;
    btnMenuUser: TToolButton;
    ToolButton4: TToolButton;
    btnMenuCloser: TToolButton;
    ilToolbar: TImageList;
    procedure btnMenuCloserClick(Sender: TObject);
    procedure btnMenuBookClick(Sender: TObject);
    procedure btnMenuUserClick(Sender: TObject);
    procedure btnMenuRentClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  // 구현부에서 불러와주면 BookForm에 있는 전역변수를 사용 가능해진다.
  BookForm, UserForm, RentForm;

{$R *.dfm}

procedure TfrmMain.btnMenuBookClick(Sender: TObject);
begin
  // self : MainForm을 의미
  // 도서 버튼을 여러번 누르는 것을 방지하기 위하여 할당 되어 있지 않을 때에만 생성할 수 있도록 처리해준다.
  if not Assigned(frmBook) then
    frmBook := TfrmBook.Create(self);
  // book폼의 부모를 pnlLayout에 띄워주기 위해
  frmBook.Parent := pnlLayout;
  // 테두리 삭제
  frmBook.BorderStyle := bsNone;
  frmBook.Align := alClient;
  frmBook.Show;
end;

procedure TfrmMain.btnMenuCloserClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnMenuRentClick(Sender: TObject);
begin
  if not Assigned(frmRent) then
    frmRent := TfrmRent.Create(self);
  frmRent.Parent := pnlLayout;
  frmRent.BorderStyle := bsNone;
  frmRent.Align := alClient;
  frmRent.Show;

end;

procedure TfrmMain.btnMenuUserClick(Sender: TObject);
begin
  if not Assigned(frmUser) then
    frmUser := TfrmUser.Create(self);
  frmUser.Parent := pnlLayout;
  frmUser.BorderStyle := bsNone;
  frmUser.Align := alClient;
  frmUser.Show;
end;

end.
