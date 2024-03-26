unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls,
  System.Win.ComObj;

type
  TForm1 = class(TForm)
    edtText: TEdit;
    btnOpen: TButton;
    btnClose: TButton;
    procedure btnOpenClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  var
    Excel_App, Excel_Book, Excel_Sheet: Variant;
    i: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  Close;
  // 엑셀 앱 종료
  Excel_App.quit;

  Excel_Sheet := unAssigned;
  Excel_Book := unAssigned;
  Excel_App := unAssigned;
end;

procedure TForm1.btnOpenClick(Sender: TObject);
Const
  xlNone = -4142;
  xlDiagonalDown = 5;
  xlDiagonalUp = 6;
  xlEdgeLeft = 7;
  xlEdgeTop = 8;
  xlEdgeBottom = 9;
  xlEdgeRight = 10;
  // 해당 구역에 얇은선
  xlContinuous = 1;
  //
  xlThin = 2;
  // 굵은선
  xlThick = 4;
  xlAutomatic = -4105;

begin
  Excel_App := CreateOleObject('Excel.Application');

  // 엑셀 프로그램 표시 (True Or False)
  Excel_App.Visible := True;

  // 변경내용을 저장하시겠습니까? 창 숨기기
  Excel_App.DisplayAlerts := False;

  // 워크북 추가
  Excel_Book := Excel_App.WorkBooks.add;

  // 워크시트 추가 맨앞에 새로 만들어짐
  // Excel_Book.sheets.add;



  // 기존 파일 열기
  // Excel_Book := Excel_App.workbooks.Open('C:\Users\IJS\Desktop\Portfolio\ConnectToExcel\test.xlsx');

  // 작업할 엑셀시트 지정[1] : 첫번째, [2] : 두번째
  Excel_Sheet := Excel_Book.WorkSheets[1];

  // [행,열] , Range로 계산하게 되면 그 다음행 계산시 한줄 내려감
  // '=x()'엑셀에서 사용하는 공식을 이용함
  Excel_Sheet.cells[3, 4].Value := '=Sum(B1:C2)';

  // 시트 이름 변경
  Excel_Sheet.Name := 'zz';

  // 해당 시트의 셀에1행 1열에 3삽입
  Excel_Sheet.cells[1, 1].Value := '3';

  // 해당 시트의 범위에 특성 수식을 계산 후  삽입
  Excel_Sheet.Range['B1', 'C2'].Value := '=3*3';
  // 해당 시트의 범위에 특성 수식을 문자로 삽입
  // Excel_Sheet.Range['B1', 'C2'].value := '''=3*3';

  // 선그리기
  // 왼쪽 -> 오른쪽 빗금
  // Excel_Sheet.Range['D5:D6'].Borders[xlDiagonalDown].LineStyle := xlContinuous;
  // 오른쪽 -> 왼쪽 빗금
  // Excel_Sheet.Range['D5:F6'].Borders[xlDiagonalUp].LineStyle := xlContinuous;

  // 범위 왼쪽에 줄 생김
  // Excel_Sheet.Range['D5:F6'].Borders[xlEdgeLeft].LineStyle := xlContinuous;
  // 범위 윗줄에 줄생김
  // Excel_Sheet.Range['D5:F6'].Borders[xlEdgeTop].LineStyle := xlContinuous;
  // 범위 아래에 줄생김
  // Excel_Sheet.Range['F5:G7'].Borders[xlEdgeBottom].LineStyle := xlContinuous;
  // Excel_Sheet.Range['E5:H6'].Borders[xlEdgeBottom].Weight := xlThick;
  // Excel_Sheet.Range['F5:I6'].Borders[xlEdgeBottom].ColorIndex := xlAutomatic;
  // Excel_Sheet.Range['E5:H6'].Borders[xlEdgeBottom].Weight := xlThick;
  // Excel_Sheet.Range['G5:J6'].Borders[xlEdgeRight].LineStyle := xlContinuous;

  // 활성화된 엑셀 다른이름으로 저장
  { Excel_App.ActiveWorkBook.saveas
    ('C:\Users\IJS\Desktop\Portfolio\ConnectToExcel\test2.xlsx'); }

end;

end.
