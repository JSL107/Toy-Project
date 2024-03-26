unit FindUserForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmFindUser = class(TForm)
    pnlHeader: TPanel;
    pnlBotton: TPanel;
    grdList: TDBGrid;
    lblSearch: TLabel;
    edtSearch: TEdit;
    chkSearchName: TCheckBox;
    btnSelect: TButton;
    btnClose: TButton;
    dsFindUser: TDataSource;
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure grdListKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    Fselectedseq: Integer;
    { Private declarations }

  public
    { Public declarations }
    property SelectedSeq: Integer read Fselectedseq;
  end;

var
  frmFindUser: TfrmFindUser;

implementation

uses
  DataAccessModule;

{$R *.dfm}

procedure TfrmFindUser.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmFindUser.btnSelectClick(Sender: TObject);
begin
  Fselectedseq := dmDataAccess.qryFindUser.FieldByName('User_SEQ').AsInteger;
end;

procedure TfrmFindUser.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  temp, Filter: String;

begin
  Filter := '';
  temp := edtSearch.Text;
  if temp <> '' then
  begin
    if chkSearchName.Checked then
      Filter := Format('user_name like ''%%%s%%''', [temp]);
  end;
  dmDataAccess.qryFindUser.Filter := Filter;
  dmDataAccess.qryFindUser.Filtered := (Filter <> '');

  if Key in [VK_down, VK_RETURN] then
    grdList.SetFocus;

end;

procedure TfrmFindUser.grdListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key in [VK_RETURN] then
    btnSelect.Click;
end;

end.
