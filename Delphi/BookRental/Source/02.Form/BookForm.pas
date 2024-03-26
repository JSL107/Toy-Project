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
    ShowMessage('�뿩 ���� ������ ���� �� �� �����ϴ�.');
    exit;
  end;

  Title := dmDataAccess.qryBook.FieldByName('BOOK_TITLE').AsString;
  if MessageDlg(Format('[%s] ������ �����Ͻðڽ��ϱ�?', [Title]), mtInformation,
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
    // �̹��� ��Ʈ�ѿ� ���� ��������
    LoadImageFromFile(imgBook, dlgLoadImage.FileName);
    // Field�� BookImage �ʵ带 �����ϰ�
    Field := dmDataAccess.qryBook.FieldByName('BOOK_IMAGE');
    // imgBook���ִ� BlobField�� �������µ� TBlobField�� �������ڴ�.
    SaveImageToBlobField(imgBook, Field as TBlobField);
  end;
end;

procedure TfrmBook.btnSaveClick(Sender: TObject);
begin
  if edtTitle.Text = '' then
  begin
    ShowMessage('������ �Է��ϼ���.');
    edtTitle.SetFocus;
    exit;
  end;

  if edtAuthor.Text = '' then
  begin
    ShowMessage('���ڸ� �Է��ϼ���.');
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
  // 2. ������ ���� �Ʒ� �ڵ尡 ������� �ʵ���(������������) �ϱ� ���� �ڵ�
  if dmDataAccess.qryBook.State = dsEdit then
    exit;
  // 1. ���� �����Ͱ� ����ɶ����ش� if�� ó��������
  LField := dmDataAccess.qryBook.FieldByName('BOOK_IMAGE');
  if LField is TBlobField then
    // LField => TBlobField ���� ĳ����
    LoadImageFromBlobField(imgBook, LField as TBlobField);
end;

procedure TfrmBook.dsBookStateChange(Sender: TObject);
var
  State: TDataSetState;
begin
  State := dmDataAccess.qryBook.State;
  // dsBrowse : ��ȸ�ϴ� �������� �����ϴ�
  btnAdd.Enabled := (State = dsBrowse);
  btnSave.Enabled := (State <> dsBrowse);
  btnCancel.Enabled := (State <> dsBrowse);
  // �����Ͱ� 0���� Ŭ��
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
    ShowMessage('�̹� ��ϵ� �����Դϴ�. ISBN �ߺ�');
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
  // ���� ���� ����
  begin
    if chkSearchTitle.Checked then
      // Book_title like'' %%%s%%''' : book_title like %s%
      // Ư�� ���ڸ� �ΰ� ������ �ϳ��� �ν� ��
      Filter := Format('Book_title like''%%%s%%''', [edtSearch.Text]);
    if chkSearchAuthor.Checked then
    begin
      if Filter <> '' then
        Filter := Filter + ' or ';
      Filter := Filter + Format('Book_author like ''%%%s%%''',
        [edtSearch.Text]);
    end;

  end;
  // ���Ͱ��� �� ���� ��� ���Ϳ� �´� �͵鸸 ��ȸ
  dmDataAccess.qryBook.Filter := Filter;
  // ���͸� ������ �� ���θ� ������
  dmDataAccess.qryBook.Filtered := (Filter <> '');
end;

procedure TfrmBook.lblLinkClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(edtLink.Text), nil, nil, SW_SHOW);
end;

end.
