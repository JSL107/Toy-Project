object frmFindUser: TfrmFindUser
  Left = 0
  Top = 0
  Caption = #54924#50896' '#44160#49353
  ClientHeight = 321
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 41
    Align = alTop
    TabOrder = 0
    object lblSearch: TLabel
      Left = 16
      Top = 14
      Width = 22
      Height = 13
      Caption = #44160#49353
    end
    object edtSearch: TEdit
      Left = 53
      Top = 11
      Width = 121
      Height = 21
      TabOrder = 0
      OnKeyUp = edtSearchKeyUp
    end
    object chkSearchName: TCheckBox
      Left = 189
      Top = 13
      Width = 97
      Height = 17
      Caption = #51060#47492
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object pnlBotton: TPanel
    Left = 0
    Top = 280
    Width = 527
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      527
      41)
    object btnSelect: TButton
      Left = 345
      Top = 6
      Width = 74
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #49440#53469
      ModalResult = 1
      TabOrder = 0
      OnClick = btnSelectClick
    end
    object btnClose: TButton
      Left = 441
      Top = 8
      Width = 74
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #45803#44592
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCloseClick
    end
  end
  object grdList: TDBGrid
    Left = 0
    Top = 41
    Width = 527
    Height = 239
    Align = alClient
    DataSource = dsFindUser
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyUp = grdListKeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'USER_NAME'
        Title.Caption = #51060#47492
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_PHONE'
        Title.Caption = #50672#46973#52376
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_BIRTH'
        Title.Caption = #49373#45380#50900#51068
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_SEX_STR'
        Title.Caption = #49457#48324
        Visible = True
      end>
  end
  object dsFindUser: TDataSource
    DataSet = dmDataAccess.qryFindUser
    Left = 256
    Top = 168
  end
end
