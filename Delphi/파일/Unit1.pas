unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, ScSFTPClient,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer, IdCmdTCPServer,
  IdExplicitTLSClientServerBase, IdFTPServer;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    O1: TMenuItem;
    O2: TMenuItem;
    Open1: TMenuItem;
    T1: TMenuItem;
    IdFTPServer1: TIdFTPServer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
