object fSignUp: TfSignUp
  Left = 0
  Top = 0
  Caption = #54924#50896#44032#51077
  ClientHeight = 207
  ClientWidth = 502
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
    Left = 67
    Top = 67
    Width = 11
    Height = 13
    Caption = 'ID'
  end
  object Label2: TLabel
    Left = 67
    Top = 96
    Width = 16
    Height = 13
    Caption = 'PW'
  end
  object Label3: TLabel
    Left = 67
    Top = 123
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label4: TLabel
    Left = 67
    Top = 150
    Width = 20
    Height = 13
    Caption = 'AGE'
  end
  object edtID: TEdit
    Left = 104
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 0
    TextHint = 'ID'
  end
  object edtPW: TEdit
    Left = 104
    Top = 93
    Width = 121
    Height = 21
    TabOrder = 2
    TextHint = 'PW'
  end
  object btnJoin: TButton
    Left = 323
    Top = 91
    Width = 75
    Height = 25
    Caption = 'JOIN'
    TabOrder = 1
    OnClick = btnJoinClick
  end
  object edtName: TEdit
    Left = 104
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 3
    TextHint = 'Name'
  end
  object edtAge: TEdit
    Left = 104
    Top = 147
    Width = 121
    Height = 21
    TabOrder = 4
    TextHint = 'Age'
  end
end
