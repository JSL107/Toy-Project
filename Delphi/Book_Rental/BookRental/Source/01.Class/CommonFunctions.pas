unit CommonFunctions;

interface

uses
  Data.DB, System.Classes, Vcl.Graphics,
  Vcl.ExtCtrls;

// �̹��� ���ϰ��(AFileName)�� �̹���(AImage) �ε�
procedure LoadImageFromFile(AImage: TImage; AFileName: string);

// Blob�ʵ忡�� �̹���(AImage) �ε�
procedure LoadImageFromBlobField(AImage: TImage; ABlobField: TBlobField);

// Blob�ʵ�� �̹��� ����
procedure SaveImageToBlobField(AImage: TImage; ABlobField: TBlobField);


implementation

uses
  System.IOUtils, System.SysUtils;

procedure LoadImageFromFile(AImage: TImage; AFileName: string);
var
  wic: TWICImage; // Microsoft Windows Imaging Component
                  // �پ��� ������ �̹��� �ε尡��
begin
  if not TFile.Exists(AFileName) then
    Exit;

  AImage.Picture.Assign(nil);
  wic := TWICImage.Create;
  try
    wic.LoadFromFile(AFileName);
    AImage.Picture.Assign(wic);
  finally
    wic.Free;
  end;
end;

procedure LoadImageFromBlobField(AImage: TImage; ABlobField: TBlobField);
var
  wic: TWICImage; // Microsoft Windows Imaging Component
  Stream: TMemoryStream;
begin
  AImage.Picture.Assign(nil);

  if ABlobField.BlobSize = 0 then
    Exit;

  Stream := TMemoryStream.Create;
  wic := TWICImage.Create;
  try
    ABlobField.SaveToStream(Stream);
    if Stream.Size > 0 then
    begin
      try
        wic.LoadFromStream(Stream);
        AImage.Picture.Assign(wic);
      except
      end;
    end;
  finally
    Stream.Free;
    wic.Free;
  end;
end;

procedure SaveImageToBlobField(AImage: TImage; ABlobField: TBlobField);
var
  wic: TWICImage; // Microsoft Windows Imaging Component
  Stream: TMemoryStream;
begin
  wic := TWICImage.Create;
  Stream := TMemoryStream.Create;
  try
    wic.Assign(AImage.Picture);
    wic.SaveToStream(Stream);
    if ABlobField.DataSet.State = dsBrowse then
      if ABlobField.DataSet.RecNo > 0 then
        ABlobField.DataSet.Edit
      else
        ABlobField.DataSet.Append;

    ABlobField.LoadFromStream(Stream);
  finally
    Stream.Free;
    wic.Free;
  end;
end;

end.
