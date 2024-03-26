unit FindBookForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmFindBook = class(TForm)
    pnlHeader: TPanel;
    lblSearch: TLabel;
    edtSearch: TEdit;
    chkSearchTitle: TCheckBox;
    pnlBotton: TPanel;
    btnSelect: TButton;
    btnClose: TButton;
    grdList: TDBGrid;
    dsFindBook: TDataSource;
    chkSearchAuthor: TCheckBox;
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdListKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSelectClick(Sender: TObject);
  private
    Fselectedseq: Integer;
    { Private declarations }

  public
    { Public declarations }
    property SelectedSeq: Integer read Fselectedseq;
  end;

var
  frmFindBook: TfrmFindBook;

implementation

uses
  DataAccessModule;

{$R *.dfm}

procedure TfrmFindBook.btnSelectClick(Sender: TObject);
begin
  Fselectedseq := dmDataAccess.qryFindBook.FieldByName('Book_SEQ').AsInteger;
end;

procedure TfrmFindBook.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  temp, Filter: String;

begin
  Filter := '';
  temp := edtSearch.Text;
  if temp <> '' then
  begin
    if chkSearchTitle.Checked then
      Filter := Format('book_title like ''%%%s%%''', [temp]);
    if chkSearchAuthor.Checked then
    begin
      if Filter <> '' then
        Filter := Filter + ' or ';
      Filter := Filter + Format('Book_author like ''%%%s%%''', [temp]);
    end;

  end;
  dmDataAccess.qryFindBook.Filter := Filter;
  dmDataAccess.qryFindBook.Filtered := (Filter <> '');

  if Key in [VK_down, VK_RETURN] then
    grdList.SetFocus;

end;

procedure TfrmFindBook.grdListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key in [VK_RETURN] then
    btnSelect.Click;
end;

end.
