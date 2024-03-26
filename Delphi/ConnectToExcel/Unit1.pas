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
  // ���� �� ����
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
  // �ش� ������ ������
  xlContinuous = 1;
  //
  xlThin = 2;
  // ������
  xlThick = 4;
  xlAutomatic = -4105;

begin
  Excel_App := CreateOleObject('Excel.Application');

  // ���� ���α׷� ǥ�� (True Or False)
  Excel_App.Visible := True;

  // ���泻���� �����Ͻðڽ��ϱ�? â �����
  Excel_App.DisplayAlerts := False;

  // ��ũ�� �߰�
  Excel_Book := Excel_App.WorkBooks.add;

  // ��ũ��Ʈ �߰� �Ǿտ� ���� �������
  // Excel_Book.sheets.add;



  // ���� ���� ����
  // Excel_Book := Excel_App.workbooks.Open('C:\Users\IJS\Desktop\Portfolio\ConnectToExcel\test.xlsx');

  // �۾��� ������Ʈ ����[1] : ù��°, [2] : �ι�°
  Excel_Sheet := Excel_Book.WorkSheets[1];

  // [��,��] , Range�� ����ϰ� �Ǹ� �� ������ ���� ���� ������
  // '=x()'�������� ����ϴ� ������ �̿���
  Excel_Sheet.cells[3, 4].Value := '=Sum(B1:C2)';

  // ��Ʈ �̸� ����
  Excel_Sheet.Name := 'zz';

  // �ش� ��Ʈ�� ����1�� 1���� 3����
  Excel_Sheet.cells[1, 1].Value := '3';

  // �ش� ��Ʈ�� ������ Ư�� ������ ��� ��  ����
  Excel_Sheet.Range['B1', 'C2'].Value := '=3*3';
  // �ش� ��Ʈ�� ������ Ư�� ������ ���ڷ� ����
  // Excel_Sheet.Range['B1', 'C2'].value := '''=3*3';

  // ���׸���
  // ���� -> ������ ����
  // Excel_Sheet.Range['D5:D6'].Borders[xlDiagonalDown].LineStyle := xlContinuous;
  // ������ -> ���� ����
  // Excel_Sheet.Range['D5:F6'].Borders[xlDiagonalUp].LineStyle := xlContinuous;

  // ���� ���ʿ� �� ����
  // Excel_Sheet.Range['D5:F6'].Borders[xlEdgeLeft].LineStyle := xlContinuous;
  // ���� ���ٿ� �ٻ���
  // Excel_Sheet.Range['D5:F6'].Borders[xlEdgeTop].LineStyle := xlContinuous;
  // ���� �Ʒ��� �ٻ���
  // Excel_Sheet.Range['F5:G7'].Borders[xlEdgeBottom].LineStyle := xlContinuous;
  // Excel_Sheet.Range['E5:H6'].Borders[xlEdgeBottom].Weight := xlThick;
  // Excel_Sheet.Range['F5:I6'].Borders[xlEdgeBottom].ColorIndex := xlAutomatic;
  // Excel_Sheet.Range['E5:H6'].Borders[xlEdgeBottom].Weight := xlThick;
  // Excel_Sheet.Range['G5:J6'].Borders[xlEdgeRight].LineStyle := xlContinuous;

  // Ȱ��ȭ�� ���� �ٸ��̸����� ����
  { Excel_App.ActiveWorkBook.saveas
    ('C:\Users\IJS\Desktop\Portfolio\ConnectToExcel\test2.xlsx'); }

end;

end.
