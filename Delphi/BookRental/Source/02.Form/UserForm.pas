unit UserForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.DBCtrls, Vcl.WinXCalendars, Vcl.Mask, Vcl.Grids, Vcl.DBGrids;

type
  TfrmUser = class(TForm)
    pnlContent: TPanel;
    pnlHeader: TPanel;
    lblCaption: TLabel;
    btnAdd: TButton;
    btnClose: TButton;
    pnlGrid: TPanel;
    pnlInput: TPanel;
    sp: TSplitter;
    pnlGridHeader: TPanel;
    gridList: TDBGrid;
    lblSearch: TLabel;
    edtSearch: TEdit;
    chkSearchName: TCheckBox;
    chkSearchPhone: TCheckBox;
    lblName: TLabel;
    lblBirth: TLabel;
    edtName: TDBEdit;
    dpBirth: TCalendarPicker;
    grpSex: TDBRadioGroup;
    lblPhone: TLabel;
    edtPhone: TDBEdit;
    lblMail: TLabel;
    edtMail: TDBEdit;
    GroupBox1: TGroupBox;
    btnLoadImage: TButton;
    btnClearImage: TButton;
    imgUser: TImage;
    dlgLoadImage: TOpenDialog;
    btnDelete: TButton;
    btnCancel: TButton;
    btnSave: TButton;
    dsUser: TDataSource;
    procedure btnLoadImageClick(Sender: TObject);
    procedure btnClearImageClick(Sender: TObject);
    procedure dsUserDataChange(Sender: TObject; Field: TField);
    procedure dpBirthCloseUp(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure dsUserStateChange(Sender: TObject);
    procedure edtNameExit(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function DuplicatedUser: Boolean;
  public
    { Public declarations }
  end;

var
  frmUser: TfrmUser;

implementation

uses
  DataAccessModule, CommonFunctions;

{$R *.dfm}

procedure TfrmUser.btnAddClick(Sender: TObject);
begin
  dmDataAccess.qryUser.Append;
  edtName.SetFocus;
end;

procedure TfrmUser.btnCancelClick(Sender: TObject);
begin
  dmDataAccess.qryUser.Cancel;
end;

procedure TfrmUser.btnClearImageClick(Sender: TObject);
var
  Field: TField;
begin
  imgUser.Picture.Assign(nil);
  Field := dmDataAccess.qryUser.FieldByName('USER_IMAGE');
  if dmDataAccess.qryUser.State <> dsEdit then
    dmDataAccess.qryUser.Edit;
  Field.Assign(nil);
end;

procedure TfrmUser.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmUser.btnDeleteClick(Sender: TObject);
var
  RentCount: Integer;
  Name, msg: string;
  OutYN: String;
begin

  RentCount := dmDataAccess.qryUser.FieldByName('USER_RENT_COUNT').AsInteger;
  Name := dmDataAccess.qryUser.FieldByName('USER_NAME').AsString;
  OutYN := dmDataAccess.qryUser.FieldByName('USER_OUT_YN').AsString;

  if OutYN = 'Y' then
  begin
    ShowMessage('이미 탈퇴한 회원입니다.');
    exit;
  end;

  if RentCount > 0 then
  begin
    ShowMessage(Format('현재 대여중인 도서가 %d 권 있습니다. 반납후 탈퇴가 가능합니다.', [RentCount]));
    exit;
  end;
  msg := Format('정말로 [%s]님의 탈퇴 처리하시겠습니까?', [Name]);
  if MessageDlg(msg, mtInformation, [mbYes, mbNo], 0) = mrNo then
    exit;

  if dmDataAccess.qryUser.State <> dsEdit then
    dmDataAccess.qryUser.Edit;
  dmDataAccess.qryUser.FieldByName('USER_OUT_YN').AsString := 'Y';
  dmDataAccess.qryUser.FieldByName('USER_OUT_DATE').AsDateTime := NOW;
  dmDataAccess.qryUser.Post;
  dmDataAccess.qryUser.Refresh;

end;

procedure TfrmUser.btnLoadImageClick(Sender: TObject);
var
  Field: TField;
begin
  if dlgLoadImage.Execute then
  begin
    LoadImageFromFile(imgUser, dlgLoadImage.FileName);

    Field := dmDataAccess.qryUser.FieldByName('USER_IMAGE');
    SaveImageToBlobField(imgUser, Field as TBlobField);
  end;

end;

procedure TfrmUser.btnSaveClick(Sender: TObject);
begin
  if edtName.Text = '' then
  begin
    ShowMessage('이름을 입력하세요');
    edtName.SetFocus;
  end;

  if dpBirth.IsEmpty then
  begin
    ShowMessage('생년월일을 입력하세요');
    dpBirth.SetFocus;
    exit;
  end;
  dmDataAccess.qryUser.Post;
  dmDataAccess.qryUser.Refresh;
end;

procedure TfrmUser.dpBirthCloseUp(Sender: TObject);
var
  Field: TField;
begin
  Field := dmDataAccess.qryUser.FieldByName('USER_BIRTH');
  if Field.AsDateTime <> dpBirth.date then
  begin
    if dmDataAccess.qryUser.State = dsBrowse then
    begin
      if dmDataAccess.qryUser.RecNo > 0 then
        dmDataAccess.qryUser.Edit
      else
        dmDataAccess.qryUser.Append;
    end;
    if dpBirth.IsEmpty then
      Field.Assign(nil)
    else
      Field.AsDateTime := dpBirth.date;
  end;
  DuplicatedUser;

end;

procedure TfrmUser.dsUserDataChange(Sender: TObject; Field: TField);
var
  LField: TField;
begin
  if dmDataAccess.qryUser.State = dsEdit then
    exit;
  LField := dmDataAccess.qryUser.FieldByName('USER_IMAGE');
  LoadImageFromBlobField(imgUser, LField as TBlobField);

  LField := dmDataAccess.qryUser.FieldByName('USER_BIRTH');
  if LField.AsDateTime = 0 then
    dpBirth.IsEmpty := True
  else
    dpBirth.date := LField.AsDateTime;
end;

procedure TfrmUser.dsUserStateChange(Sender: TObject);
var
  State: TDataSetState;

begin
  State := dmDataAccess.qryUser.State;

  btnAdd.Enabled := (State = dsBrowse);
  btnSave.Enabled := (State <> dsBrowse);
  btnDelete.Enabled := (State = dsBrowse);
  btnCancel.Enabled := (State <> dsBrowse);
end;

function TfrmUser.DuplicatedUser: Boolean;
var
  seq: Integer;
  Name: String;
  Birth: TDateTime;
begin
  seq := dmDataAccess.qryUser.FieldByName('USER_SEQ').AsInteger;
  name := dmDataAccess.qryUser.FieldByName('USER_NAME').AsString;
  Birth := dmDataAccess.qryUser.FieldByName('USER_BIRTH').AsDateTime;
  if (name = '') or (Birth = 0) then
    exit;

  if dmDataAccess.DuplicatedUser(seq, name, Birth) then
    ShowMessage('이미 등록된 회원입니다.(이름과 생년월일이 중복됩니다.');

end;

procedure TfrmUser.edtNameExit(Sender: TObject);
begin
  DuplicatedUser;
end;

procedure TfrmUser.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Filter: string;
begin
  Filter := '';
  if edtSearch.Text <> '' then
  begin
    if chkSearchName.Checked then
      Filter := Format('USER_NAME like ''%%%s%%''', [edtSearch.Text]);
    if chkSearchPhone.Checked then
    begin
      if Filter <> '' then
        Filter := Filter + ' or ';
      Filter := Filter + Format('USER_PHONE like ''%%%s%%''', [edtSearch.Text]);
    end;

  end;
  dmDataAccess.qryUser.Filter := Filter;
  dmDataAccess.qryUser.Filtered := (Filter <> '');

end;

end.
