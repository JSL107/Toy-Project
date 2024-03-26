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
  // �����ο��� �ҷ����ָ� BookForm�� �ִ� ���������� ��� ����������.
  BookForm, UserForm, RentForm;

{$R *.dfm}

procedure TfrmMain.btnMenuBookClick(Sender: TObject);
begin
  // self : MainForm�� �ǹ�
  // ���� ��ư�� ������ ������ ���� �����ϱ� ���Ͽ� �Ҵ� �Ǿ� ���� ���� ������ ������ �� �ֵ��� ó�����ش�.
  if not Assigned(frmBook) then
    frmBook := TfrmBook.Create(self);
  // book���� �θ� pnlLayout�� ����ֱ� ����
  frmBook.Parent := pnlLayout;
  // �׵θ� ����
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
