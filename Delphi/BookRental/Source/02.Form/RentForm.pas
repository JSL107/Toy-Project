unit RentForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmRent = class(TForm)
    pnlContent: TPanel;
    pnlHeader: TPanel;
    lblCaption: TLabel;
    btnClose: TButton;
    btnAdd: TButton;
    pnlInput: TPanel;
    pnlGrid: TPanel;
    sp: TSplitter;
    pnlGridHeader: TPanel;
    gridList: TDBGrid;
    lblSearch: TLabel;
    edtSearch: TEdit;
    chkSearchBook: TCheckBox;
    chkSearchUser: TCheckBox;
    grpUser: TGroupBox;
    GroupBox2: TGroupBox;
    btnFindUser: TButton;
    imgUser: TImage;
    lblName: TLabel;
    lblBirth: TLabel;
    lblPhone: TLabel;
    edtUserName: TDBEdit;
    edtUserBirth: TDBEdit;
    edtUserPhone: TDBEdit;
    imgBook: TImage;
    btnFindBook: TButton;
    edtBookTitle: TDBEdit;
    edtBookAuthor: TDBEdit;
    edtBookPrice: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnRent: TButton;
    btnReturn: TButton;
    btnCancel: TButton;
    dsRent: TDataSource;
    dsRentUser: TDataSource;
    dsRentBook: TDataSource;
    procedure dsRentBookDataChange(Sender: TObject; Field: TField);
    procedure dsRentUserDataChange(Sender: TObject; Field: TField);
    procedure btnFindUserClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnFindBookClick(Sender: TObject);
    procedure dsRentStateChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnRentClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRent: TfrmRent;

implementation

uses
  DataAccessModule, CommonFunctions, FindUserForm, FindBookForm;

{$R *.dfm}

procedure TfrmRent.btnAddClick(Sender: TObject);
begin
  dmDataAccess.qryRent.Append;
end;

procedure TfrmRent.btnCancelClick(Sender: TObject);
begin
  dmDataAccess.qryRent.Cancel;
end;

procedure TfrmRent.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRent.btnFindBookClick(Sender: TObject);
begin
  frmFindBook := TfrmFindBook.create(nil);
  try
    // show로 창을 띄우면 메인폼과는 별개로 창이 뜨게 되고
    // showmodal로 창을 띄우면 서브폼형태로 열리며 서브폼이 닫히기 전까지는 메인폼을 동작할 수 없음
    frmFindBook.ShowModal;

    if dmDataAccess.qryRent.State <> dsEdit then
      dmDataAccess.qryRent.Edit;

    dmDataAccess.qryRent.FieldByName('BOOK_SEQ').AsInteger :=
      frmFindBook.SelectedSeq;
    // ShowMessage(frmFindUser.SelectedSeq.ToString);
  finally
    frmFindUser.Free;
  end;
end;

procedure TfrmRent.btnFindUserClick(Sender: TObject);
begin
  // showmodal로 모달창을 띄워줄 것이므로 nil로 생성
  frmFindUser := TfrmFindUser.create(nil);
  try
    // show로 창을 띄우면 메인폼과는 별개로 창이 뜨게 되고
    // showmodal로 창을 띄우면 서브폼형태로 열리며 서브폼이 닫히기 전까지는 메인폼을 동작할 수 없음
    frmFindUser.ShowModal;

    if dmDataAccess.qryRent.State <> dsEdit then
      dmDataAccess.qryRent.Edit;

    dmDataAccess.qryRent.FieldByName('USER_SEQ').AsInteger :=
      frmFindUser.SelectedSeq;
    // ShowMessage(frmFindUser.SelectedSeq.ToString);
  finally
    frmFindUser.Free;
  end;
end;

procedure TfrmRent.btnRentClick(Sender: TObject);
var
  UserSeq, BookSeq: Integer;
begin
  UserSeq := dmDataAccess.qryRent.FieldByName('User_SEQ').AsInteger;
  BookSeq := dmDataAccess.qryRent.FieldByName('BOOK_SEQ').AsInteger;
  dmDataAccess.ExcuteRent(UserSeq, BookSeq, True);
end;

procedure TfrmRent.btnReturnClick(Sender: TObject);
var
  UserSeq, BookSeq: Integer;
begin
  UserSeq := dmDataAccess.qryRent.FieldByName('User_SEQ').AsInteger;
  BookSeq := dmDataAccess.qryRent.FieldByName('BOOK_SEQ').AsInteger;
  dmDataAccess.ExcuteRent(UserSeq, BookSeq, False);
end;

procedure TfrmRent.dsRentBookDataChange(Sender: TObject; Field: TField);
var
  LField: TField;
begin
  if dmDataAccess.qryRentBook.State <> dsBrowse then
    exit;
  LField := dmDataAccess.qryRentBook.FieldByName('BOOK_IMAGE');

  LoadImageFromBlobField(imgBook, LField as TBlobField)
end;

procedure TfrmRent.dsRentStateChange(Sender: TObject);
var
  State: TDataSetState;
begin
  //
  State := dmDataAccess.qryRent.State;
  btnAdd.Enabled := (State = dsBrowse);
  btnRent.Enabled := (State <> dsBrowse);
  btnReturn.Enabled := (State = dsBrowse);
  btnCancel.Enabled := (State <> dsBrowse);

  btnFindUser.Enabled := (State <> dsBrowse);
  btnFindBook.Enabled := (State <> dsBrowse);

end;

procedure TfrmRent.dsRentUserDataChange(Sender: TObject; Field: TField);
var
  LField: TField;
begin
  if dmDataAccess.qryRentUser.State <> dsBrowse then
    exit;
  LField := dmDataAccess.qryRentUser.FieldByName('USER_IMAGE');

  LoadImageFromBlobField(imgUser, LField as TBlobField)
end;

procedure TfrmRent.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Filter: String;
begin
  Filter := '';
  if edtSearch.Text <> '' then
  begin
    if chkSearchBook.Checked then
    begin
      Filter := Format('BOOK_TITLE like ''%%%s%%''', [edtSearch.Text]);
      if chkSearchUser.Checked then
      begin
        if Filter <> '' then
          Filter := Format('User_name like ''%%%s%%''', [edtSearch.Text]);
      end;
    end;
  end;
  dmDataAccess.qryRent.Filter := Filter;
  dmDataAccess.qryRent.Filtered := (Filter <> '');
end;

end.
