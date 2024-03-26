unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  Vcl.ExtCtrls, Vcl.OleCtrls, System.Win.ComObj, Vcl.StdCtrls, tmsAdvGridExcel,
  AdvUtil, AdvObj, BaseGrid, AdvGrid, System.RegularExpressions;

const
  ExcelToGrid = 1;
  GridToGrid = 2;
  GridToExcel = 3;

type
  TfrmMain = class(TForm)
    pnlClient: TPanel;
    pnlHeader: TPanel;
    pnlBottom: TPanel;
    btnOpen: TButton;
    btnClose: TButton;
    btnSave: TButton;
    lblTitle: TLabel;
    excelGrid: TAdvStringGrid;
    btnAddToDo: TButton;
    btnAddDate: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddToDoClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure excelGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
//    procedure excelGridEditChange(Sender: TObject; ACol, ARow: Integer;Value: string);
    procedure excelGridEditCellDone(Sender: TObject; ACol, ARow: Integer);
  private
    { Private declarations }
    currentRow, currentCol: Integer;
    ExcelApp, ExcelBook, ExcelSheet: Variant;
    ExcelRowCount, ExcelColCount: Integer;

    visited: array of array of boolean;

    textValue: string;
    cRow, cCol: Integer;
    function CellManufacture(sType: Integer; col: Integer; Value: string): string;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function TfrmMain.CellManufacture(sType, col: Integer; Value: string): string;
const
  Pattern: string = '[\:]';
var
  valueDatetime: TDatetime;
begin
  Result := '';
  case col of
    1:
      case sType of
        ExcelToGrid:
          if (Value <> '') then
          begin
//        valueDatetime := StrToDateTime(Value);
            Result := FormatDateTime('HH:mm', StrToFloat(Value));

          end;
        GridToGrid:
          if (Value <> '') then
          begin
            Result := Copy(Value, 1, 2) + ':' + Copy(Value, 3, 2);
          end;
      end;

    5:
      if (Value <> '') then
      begin
        Value := TRegEx.Replace(Value, '[\,]', '');
        Result := FormatCurr('#,##0', StrToCurr(Value));
      end;

  else
    Result := Value;
  end;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  // ���� �� ����
  if not VarIsEmpty(ExcelApp) then
  begin
    ExcelApp.quit;
    ExcelBook := unAssigned;
    ExcelSheet := unAssigned;
    ExcelApp := unAssigned;
  end;
  visited := nil;

  close;
end;

procedure TfrmMain.btnOpenClick(Sender: TObject);
var
  I, J: Integer;
  OpenDialog1: TOpenDialog;
  errMessage: string;
  vList: Variant;
  temp: boolean;
begin
  // ���� �ҷ����� â ����� �ڵ�
  OpenDialog1 := TOpenDialog.Create(nil);
  with OpenDialog1 do
  begin
    Title := '���� ��ȹ �ҷ�����';
    Filter := '��������(*.xls, *.xlsx)|*.xls; *.xlsx';
    Options := [ofOverWritePrompt, ofFileMustExist, ofHideReadOnly];

    if Execute then
    begin
      try
        ExcelApp := CreateOLEObject('Excel.Application');
        ExcelApp.Visible := true;
        ExcelApp.DisplayAlerts := False;
        ExcelBook := ExcelApp.WorkBooks.Open(FileName);
        ExcelBook := ExcelApp.WorkBooks.item[1]; // ��ũ ��Ʈ ����

        ExcelSheet := ExcelBook.Worksheets.item[1];

        ExcelRowCount := ExcelSheet.UsedRange.Rows.count;
        ExcelColCount := ExcelSheet.UsedRange.Columns.count;
        excelGrid.RowCount := ExcelSheet.UsedRange.Rows.count;
        excelGrid.ColCount := ExcelSheet.UsedRange.Columns.count;

        // 2���� ���� �迭 ���� ����
        SetLength(visited, excelGrid.RowCount);
        for I := 0 to excelGrid.ColCount do
          SetLength(visited[I], excelGrid.ColCount);

        // ��Ʈ���׸��忡 Ÿ��Ʋ �ο�
        for I := 0 to ExcelColCount do
        begin
          excelGrid.Cells[I, 0] := vartostr(ExcelSheet.Cells[1, I + 1]);
        end;

        // ��Ʈ���׸��忡 �Ѹ���
        for I := 1 to ExcelRowCount do
          for J := 0 to ExcelColCount do
            excelGrid.Cells[J, I] := vartostr(ExcelSheet.Cells[I + 1, J + 1]);
        for I := 1 to ExcelRowCount do
        begin
          excelGrid.Cells[5, I] := CellManufacture(ExcelToGrid, 5, excelGrid.Cells[5, I]);
          excelGrid.Cells[1, I] := CellManufacture(ExcelToGrid, 1, excelGrid.Cells[1, I]);

        end;

      except
        errMessage := '';
        errMessage := errMessage + '���� �ε� �� ������ �߻��Ͽ����ϴ�.';
        errMessage := errMessage + #13#10#13#10;
        errMessage := errMessage + '��������';
        errMessage := errMessage + #13#10#13#10;
        errMessage := errMessage + '1. ���� ��Ʈ���� ''Sheet1'' ���� Ȯ�����ּ���';
        errMessage := errMessage + #13#10;
        errMessage := errMessage + '2. ������ ��ġ�Ǿ��ִ��� Ȯ�����ּ���.';
        showMessage(errMessage);
        Exit;
      end;
    end;

  end;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
var
  I, J, row, col: Integer;
  value: TDateTime;
begin

  if not VarIsEmpty(ExcelApp) then
  begin
    for row := 2 to excelGrid.RowCount do
    begin
      for col := 1 to excelGrid.ColCount do
      begin
        if col = 2 then
        begin
          value := StrToDateTime(excelGrid.Cells[1, row - 1]);
          ExcelSheet.Cells[row, col].value := value;
        end
        else
        begin
          ExcelSheet.Cells[row, col].value := excelGrid.Cells[col - 1, row - 1];
        end;

      end;
    end;

    { ����Ǿ����� ������Ʈ }

  end;

end;

procedure TfrmMain.excelGridEditCellDone(Sender: TObject; ACol, ARow: Integer);
begin
  visited[ACol, ARow] := true;
  cCol := ACol;
  cRow := ARow;
  excelGrid.Cells[cCol, cRow] := CellManufacture(GridToGrid, cCol, excelGrid.Cells[cCol, cRow]);
end;
//
//procedure TfrmMain.excelGridEditChange(Sender: TObject; ACol, ARow: Integer;
//  Value: string);
//var
//  OldText: String;
//begin
//  visited[ACol, ARow] := true;
//end;

procedure TfrmMain.excelGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  row, col: Integer;
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    with excelGrid do
      if col < ColCount - 1 then { ���� column }
        col := col + 1
      else if row < RowCount - 1 then { ���� Row }
      begin
        row := row + 1;
        col := 1;
      end
      else
      begin { Grid�� ���̸� Top���� }
        row := 1;
        col := 1;
      end;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not VarIsEmpty(ExcelApp) then
    ExcelApp.quit;

  visited := nil;

end;

procedure TfrmMain.btnAddToDoClick(Sender: TObject);
begin
  excelGrid.AddRow;
end;

end.

