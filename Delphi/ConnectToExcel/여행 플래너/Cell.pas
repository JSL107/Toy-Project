unit Cell;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls;

type
  TForm3 = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
  private
    FCol, FRow: Integer;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

end.
