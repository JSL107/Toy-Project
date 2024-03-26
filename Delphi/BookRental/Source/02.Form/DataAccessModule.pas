unit DataAccessModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmDataAccess = class(TDataModule)
    conBookRental: TFDConnection;
    qryBook: TFDQuery;
    qryBookBOOK_SEQ: TFDAutoIncField;
    qryBookBOOK_TITLE: TStringField;
    qryBookBOOK_ISBN: TStringField;
    qryBookBOOK_AUTHOR: TStringField;
    qryBookBOOK_PRICE: TIntegerField;
    qryBookBOOK_LINK: TStringField;
    qryBookBOOK_RENT_YN: TStringField;
    qryBookBOOK_IMAGE: TBlobField;
    qryBookBOOK_DESCRIPTION: TBlobField;
    qryBookBook_RENT: TStringField;
    qryDuplicatedBook: TFDQuery;
    qryUser: TFDQuery;
    qryUserUSER_SEQ: TFDAutoIncField;
    qryUserUSER_NAME: TStringField;
    qryUserUSER_BIRTH: TDateField;
    qryUserUSER_SEX: TStringField;
    qryUserUSER_PHONE: TStringField;
    qryUserUSER_MAIL: TStringField;
    qryUserUSER_IMAGE: TBlobField;
    qryUserUSER_REG_DATE: TDateField;
    qryUserUSER_OUT_YN: TStringField;
    qryUserUSER_OUT_DATE: TDateField;
    qryUserUSER_RENT_COUNT: TIntegerField;
    qryUserUSER_SEX_STR: TStringField;
    qryUserUSER_OUT: TStringField;
    qryDuplicatedUser: TFDQuery;
    qryRent: TFDQuery;
    qryRentBook: TFDQuery;
    qryRentUser: TFDQuery;
    dsRent: TDataSource;
    usRent: TFDUpdateSQL;
    qryRentuser_name: TStringField;
    qryRentbook_title: TStringField;
    qryRentRENT_SEQ: TFDAutoIncField;
    qryRentUSER_SEQ: TIntegerField;
    qryRentBOOK_SEQ: TIntegerField;
    qryRentRENT_DATE: TDateField;
    qryRentRENT_RETURN_DATE: TDateField;
    qryRentRENT_RETURN_YN: TStringField;
    qryRentRent_Return: TStringField;
    qryFindUser: TFDQuery;
    qryFindUserUSER_SEQ: TFDAutoIncField;
    qryFindUserUSER_NAME: TStringField;
    qryFindUserUSER_BIRTH: TDateField;
    qryFindUserUSER_SEX: TStringField;
    qryFindUserUSER_PHONE: TStringField;
    qryFindUserUSER_MAIL: TStringField;
    qryFindUserUSER_IMAGE: TBlobField;
    qryFindUserUSER_REG_DATE: TDateField;
    qryFindUserUSER_OUT_YN: TStringField;
    qryFindUserUSER_OUT_DATE: TDateField;
    qryFindUserUSER_RENT_COUNT: TIntegerField;
    qryFindUserUSER_SEX_STR: TStringField;
    qryFindBook: TFDQuery;
    qryFindBookBOOK_SEQ: TFDAutoIncField;
    qryFindBookBOOK_TITLE: TStringField;
    qryFindBookBOOK_ISBN: TStringField;
    qryFindBookBOOK_AUTHOR: TStringField;
    qryFindBookBOOK_PRICE: TIntegerField;
    qryFindBookBOOK_LINK: TStringField;
    qryFindBookBOOK_RENT_YN: TStringField;
    qryFindBookBOOK_IMAGE: TBlobField;
    qryFindBookBOOK_DESCRIPTION: TMemoField;
    qryUpdateBookState: TFDQuery;
    qryUpdateUserRentCount: TFDQuery;
    procedure qryBookCalcFields(DataSet: TDataSet);
    procedure qryUserCalcFields(DataSet: TDataSet);
    procedure qryRentCalcFields(DataSet: TDataSet);
    procedure qryFindUserCalcFields(DataSet: TDataSet);
    {procedure conBookRentalBeforeConnect(Sender: TObject);}
  private
    { Private declarations }
  public
    { Public declarations }
    function DuplicatedISBN(Aseq, AISBN: String): Boolean;
    function DuplicatedUser(Aseq: Integer; AName: String;
      ABirth: TDateTime): Boolean;
    procedure ExcuteRent(AUserseq, Abookseq: Integer; ARentYN: Boolean);

  end;

var
  dmDataAccess: TdmDataAccess;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses System.StrUtils, System.IOUtils;

{procedure TdmDataAccess.conBookRentalBeforeConnect(Sender: TObject);
var
Path :String;

begin
   // ����� �����ϱ�
    Path := TPath.GetFullPath('..\');
    Path := TPath.Combine(Path, 'DB');
    // ���� ������ ���̽� ������ �ִ°� ���� ��θ� �������ش�
    Path := TPath.Combine(Path,'BOOK_RENTAL_');
end;}

function TdmDataAccess.DuplicatedISBN(Aseq, AISBN: String): Boolean;
begin
  Result := False;
  qryDuplicatedBook.Close;
  qryDuplicatedBook.ParamByName('ISBN').asString := AISBN;
  qryDuplicatedBook.Open;
  { ���� �Է����� ���ڵ尡 1�� �̻��̰ų� ���� �Է��ϰ� �ִ� isbn�� ���� isbn�� �ٸ���� }
  if (qryDuplicatedBook.RecordCount > 0) and
    (qryDuplicatedBook.Fields[0].asString <> Aseq) then
    Result := True;

end;

function TdmDataAccess.DuplicatedUser(Aseq: Integer; AName: String;
  ABirth: TDateTime): Boolean;
begin
  Result := False;
  qryDuplicatedUser.Close;
  qryDuplicatedUser.ParamByName('NAME').asString := AName;
  qryDuplicatedUser.ParamByName('BIRTH').AsDateTime := ABirth;
  qryDuplicatedUser.Open;

  if (qryDuplicatedUser.RecordCount > 0) and
    (qryDuplicatedUser.Fields[0].AsInteger <> Aseq) then
    Result := True;
end;

procedure TdmDataAccess.ExcuteRent(AUserseq, Abookseq: Integer;
  ARentYN: Boolean);
begin
  // �뿩���� ������Ʈ - �뿩��, �뿩����, ��ȯ�� ����
  if ARentYN then
  begin
    // ����
    qryRent.FieldByName('RENT_DATE').AsDateTime := Now;
    qryRent.FieldByName('RENT_RETURN_DATE').AsDateTime := Now + 20;
    qryRent.FieldByName('RENT_RETURN_YN').asString := 'N';
  end
  else
  begin
    // �ݳ�
    if qryRent.State <> dsEdit then
      qryRent.Edit;
    qryRent.FieldByName('RENT_RETURN_DATE').AsDateTime := Now + 20;
    qryRent.FieldByName('RENT_RETURN_YN').asString := 'Y';
  end;
  qryRent.Post;
  qryRent.Refresh;

  // ���� ������Ʈ- �������� ����
  qryUpdateBookState.ParamByName('RENT_YN').asString :=
    IfThen(ARentYN, 'Y', 'N');
  qryUpdateBookState.ParamByName('seq').AsInteger := Abookseq;
  qryUpdateBookState.ExecSQL;

  // ȸ�� ������Ʈ- ȸ���� �����뿩 �Ǽ� ����
  qryUpdateUserRentCount.ParamByName('SEQ').AsInteger := AUserseq;
  qryUpdateUserRentCount.ExecSQL;

  qryBook.Refresh;
  qryUser.Refresh;
end;

procedure TdmDataAccess.qryBookCalcFields(DataSet: TDataSet);

var
  RentYN: String;
begin
  RentYN := qryBook.FieldByName('BOOK_RENT_YN').asString;
  if RentYN = 'Y' then
    qryBook.FieldByName('BOOK_RENT').asString := '�뿩����'
  else
    qryBook.FieldByName('BOOK_RENT').asString := '�뿩 ����';

end;

procedure TdmDataAccess.qryFindUserCalcFields(DataSet: TDataSet);
begin
  if qryFindUserUSER_SEX.asString = 'M' then
    qryFindUserUSER_SEX_STR.asString := '����'
  else
    qryFindUserUSER_SEX_STR.asString := '����';
end;

procedure TdmDataAccess.qryRentCalcFields(DataSet: TDataSet);
begin
  if qryRentRENT_RETURN_YN.asString = 'Y' then
    qryRentRent_Return.asString := '�ݳ�'
  else
    qryRentRent_Return.asString := '�뿩';
end;

procedure TdmDataAccess.qryUserCalcFields(DataSet: TDataSet);
begin
  // ���� ������ M�̶���ʵ忡 ���ڶ�� ���
  if qryUser.FieldByName('USER_SEX').asString = 'M' then
    qryUser.FieldByName('USER_SEX_STR').asString := '����'
  else
    qryUser.FieldByName('USER_SEX_STR').asString := '����';

  if qryUserUSER_OUT_YN.asString = 'Y' then
    qryUserUSER_OUT.asString := 'Ż��'
  else
    qryUserUSER_OUT.asString := 'ȸ��';

end;

end.
