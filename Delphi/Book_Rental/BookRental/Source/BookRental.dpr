program BookRental;





{$R *.dres}

uses
  Vcl.Forms,
  CommonFunctions in '01.Class\CommonFunctions.pas',
  BookForm in '02.Form\BookForm.pas' {frmBook},
  DataAccessModule in '02.Form\DataAccessModule.pas' {dmDataAccess: TDataModule},
  MainForm in '02.Form\MainForm.pas' {frmMain},
  UserForm in '02.Form\UserForm.pas' {frmUser},
  RentForm in '02.Form\RentForm.pas' {frmRent},
  FindUserForm in '02.Form\FindUserForm.pas' {frmFindUser},
  FindBookForm in '02.Form\FindBookForm.pas' {frmFindBook};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDataAccess, dmDataAccess);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
