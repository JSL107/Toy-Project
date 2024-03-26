unit BookForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmBook = class(TForm)
    pnlHeader: TPanel;
    pnlContent: TPanel;
    pnlMain: TPanel;
    pnlInput: TPanel;
    pnlMainHeader: TPanel;
    gridBook: TDBGrid;
    lblCaption: TLabel;
    btnAdd: TButton;
    btnClose: TButton;
    lblSearch: TLabel;
    edtSearch: TEdit;
    chkSearchTitle: TCheckBox;
    chkSearchAuthor: TCheckBox;
    Label1: TLabel;
    edtTitle: TDBEdit;
    Splitter1: TSplitter;
    Label2: TLabel;
    edtISBN: TDBEdit;
    Label3: TLabel;
    edtAuthor: TDBEdit;
    Label4: TLabel;
    edtPrice: TDBEdit;
    edtLink: TDBEdit;
    GroupBox1: TGroupBox;
    btnImageAddClear: TButton;
    btnImageLoad: TButton;
    Label5: TLabel;
    mmoDescription: TDBMemo;
    btnDelete: TButton;
    btnSave: TButton;
    btnCancel: TButton;
    imgBook: TImage;
    dsBook: TDataSource;
    dlgLoadImage: TOpenDialog;
    lblLink: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnImageLoadClick(Sender: TObject);
    procedure btnImageAddClearClick(Sender: TObject);
    procedure dsBookDataChange(Sender: TObject; Field: TField);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure dsBookStateChange(Sender: TObject);
    procedure edtISBNExit(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblLinkClick(Sender: TObject);
    // procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBook: TfrmBook;

implementation

uses

  DataAccessModule,
  CommonFunctions,
  Winapi.ShellAPI;

{$R *.dfm}

procedure TfrmBook.btnAddClick(Sender: TObject);
begin
  dmDataAccess.qryBook.Append;
  edtTitle.SetFocus;
end;

procedure TfrmBook.btnCancelClick(Sender: TObject);
begin
  dmDataAccess.qryBook.Cancel;
end;

procedure TfrmBook.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmBook.btnDeleteClick(Sender: TObject);
var
  RentYN, Title: String;
begin
  RentYN := dmDataAccess.qryBook.FieldByName('BOOK_RENT_YN').AsString;
  if RentYN = 'Y' then
  begin
    ShowMessage('대여 중인 도서는 삭제 할 수 없습니다.');
    exit;
  end;

  Title := dmDataAccess.qryBook.FieldByName('BOOK_TITLE').AsString;
  if MessageDlg(Format('[%s] 도서를 삭제하시겠습니까?', [Title]), mtInformation,
    [mbYes, mbNo], 0) = mrNo then
    exit;

  dmDataAccess.qryBook.Delete;
end;

procedure TfrmBook.btnImageAddClearClick(Sender: TObject);
var
  Field: TField;
begin
  imgBook.Picture.Assign(nil);
  Field := dmDataAccess.qryBook.FieldByName('BOOK_IMAGE');
  if dmDataAccess.qryBook.State <> dsEdit then
    dmDataAccess.qryBook.Edit;
  Field.Assign(nil);
end;

procedure TfrmBook.btnImageLoadClick(Sender: TObject);
var
  Field: TField;
begin
  if dlgLoadImage.Execute then
  begin
    // 이미지 컨트롤에 사진 가져오기
    LoadImageFromFile(imgBook, dlgLoadImage.FileName);
    // Field에 BookImage 필드를 저장하고
    Field := dmDataAccess.qryBook.FieldByName('BOOK_IMAGE');
    // imgBook에있는 BlobField로 가져오는데 TBlobField로 가져오겠다.
    SaveImageToBlobField(imgBook, Field as TBlobField);
  end;
end;

procedure TfrmBook.btnSaveClick(Sender: TObject);
begin
  if edtTitle.Text = '' then
  begin
    ShowMessage('제목을 입력하세요.');
    edtTitle.SetFocus;
    exit;
  end;

  if edtAuthor.Text = '' then
  begin
    ShowMessage('저자를 입력하세요.');
    edtTitle.SetFocus;
    exit;
  end;

  dmDataAccess.qryBook.Post;
  dmDataAccess.qryBook.Refresh;
end;

procedure TfrmBook.dsBookDataChange(Sender: TObject; Field: TField);
var
  LField: TField;
begin
  // 2. 수정할 때는 아래 코드가 실행되지 않도록(빠져나가도록) 하기 위한 코드
  if dmDataAccess.qryBook.State = dsEdit then
    exit;
  // 1. 실제 데이터가 변경될때는해당 if가 처리되지만
  LField := dmDataAccess.qryBook.FieldByName('BOOK_IMAGE');
  if LField is TBlobField then
    // LField => TBlobField 으로 캐스팅
    LoadImageFromBlobField(imgBook, LField as TBlobField);
end;

procedure TfrmBook.dsBookStateChange(Sender: TObject);
var
  State: TDataSetState;
begin
  State := dmDataAccess.qryBook.State;
  // dsBrowse : 조회하는 과정에선 가능하다
  btnAdd.Enabled := (State = dsBrowse);
  btnSave.Enabled := (State <> dsBrowse);
  btnCancel.Enabled := (State <> dsBrowse);
  // 데이터가 0보다 클때
  btnDelete.Enabled := (State = dsBrowse) and
    (dmDataAccess.qryBook.RecordCount > 0);

end;

procedure TfrmBook.edtISBNExit(Sender: TObject);
var
  Seq, ISBN: String;
begin
  Seq := dmDataAccess.qryBook.FieldByName('BOOK_SEQ').AsString;
  ISBN := dmDataAccess.qryBook.FieldByName('BOOK_ISBN').AsString;
  if dmDataAccess.qryBook.State = dsBrowse then
    exit;

  if dmDataAccess.DuplicatedISBN(Seq, ISBN) then
  begin
    ShowMessage('이미 등록된 도서입니다. ISBN 중복');
    edtISBN.Text := '';
    edtISBN.SetFocus;
  end;
end;

procedure TfrmBook.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Filter: String;
begin
  Filter := '';

  if edtSearch.Text <> '' then
  // 필터 생성 구문
  begin
    if chkSearchTitle.Checked then
      // Book_title like'' %%%s%%''' : book_title like %s%
      // 특수 문자를 두개 찍으면 하나로 인식 됨
      Filter := Format('Book_title like''%%%s%%''', [edtSearch.Text]);
    if chkSearchAuthor.Checked then
    begin
      if Filter <> '' then
        Filter := Filter + ' or ';
      Filter := Filter + Format('Book_author like ''%%%s%%''',
        [edtSearch.Text]);
    end;

  end;
  // 필터값이 들어가 있을 경우 필터에 맞는 것들만 조회
  dmDataAccess.qryBook.Filter := Filter;
  // 필터를 수행할 지 여부를 정해줌
  dmDataAccess.qryBook.Filtered := (Filter <> '');
end;

procedure TfrmBook.lblLinkClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(edtLink.Text), nil, nil, SW_SHOW);
end;

end.
