object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 497
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edtText: TEdit
    Left = 32
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btnOpen: TButton
    Left = 192
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    OnClick = btnOpenClick
  end
  object btnClose: TButton
    Left = 192
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = btnCloseClick
  end
end
