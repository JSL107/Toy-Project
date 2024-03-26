object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 223
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 27
    Height = 13
    Caption = 'DB ID'
  end
  object Label2: TLabel
    Left = 8
    Top = 84
    Width = 22
    Height = 13
    Caption = 'IPv4'
  end
  object Label3: TLabel
    Left = 8
    Top = 120
    Width = 43
    Height = 13
    Caption = 'DB Name'
  end
  object Label4: TLabel
    Left = 8
    Top = 160
    Width = 32
    Height = 13
    Caption = 'DB PW'
  end
  object Label5: TLabel
    Left = 8
    Top = 48
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Button1: TButton
    Left = 384
    Top = 79
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 2
    OnClick = btnConnectClick
  end
  object edtID: TEdit
    Left = 57
    Top = 5
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object edtIP: TEdit
    Left = 57
    Top = 81
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '127.0.0.1'
  end
  object edtName: TEdit
    Left = 57
    Top = 117
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'TestDB'
  end
  object edtPW: TEdit
    Left = 57
    Top = 157
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '1234'
  end
  object edtPort: TEdit
    Left = 57
    Top = 45
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1433'
  end
end
