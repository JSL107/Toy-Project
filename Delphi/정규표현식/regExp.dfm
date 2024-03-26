object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 416
  ClientWidth = 501
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblKo: TLabel
    Left = 88
    Top = 96
    Width = 59
    Height = 13
    Caption = 'Only Korean'
  end
  object lblEn: TLabel
    Left = 88
    Top = 135
    Width = 58
    Height = 13
    Caption = 'Only English'
  end
  object lblNum: TLabel
    Left = 88
    Top = 176
    Width = 62
    Height = 13
    Caption = 'Only Number'
  end
  object lblSp: TLabel
    Left = 88
    Top = 216
    Width = 95
    Height = 13
    Caption = 'Only Special Symbol'
  end
  object lblLen: TLabel
    Left = 88
    Top = 264
    Width = 86
    Height = 13
    Caption = 'Constraint Length'
  end
  object edtKo: TEdit
    Left = 193
    Top = 93
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtEn: TEdit
    Left = 193
    Top = 132
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtNu: TEdit
    Left = 193
    Top = 173
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object edtSS: TEdit
    Left = 193
    Top = 213
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object edtLen: TEdit
    Left = 193
    Top = 261
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object btnKo: TButton
    Left = 344
    Top = 91
    Width = 75
    Height = 25
    Caption = 'check'
    TabOrder = 0
    OnClick = btnKoClick
  end
  object btnEn: TButton
    Left = 344
    Top = 130
    Width = 75
    Height = 25
    Caption = 'check'
    TabOrder = 2
    OnClick = btnEnClick
  end
  object btnNu: TButton
    Left = 344
    Top = 171
    Width = 75
    Height = 25
    Caption = 'check'
    TabOrder = 4
    OnClick = btnNuClick
  end
  object btnSS: TButton
    Left = 344
    Top = 211
    Width = 75
    Height = 25
    Caption = 'check'
    TabOrder = 6
    OnClick = btnSSClick
  end
  object btnLen: TButton
    Left = 344
    Top = 259
    Width = 75
    Height = 25
    Caption = 'check'
    TabOrder = 8
    OnClick = btnLenClick
  end
end
