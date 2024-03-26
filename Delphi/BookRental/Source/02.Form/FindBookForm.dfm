object frmFindBook: TfrmFindBook
  Left = 0
  Top = 0
  Caption = #46020#49436' '#44160#49353
  ClientHeight = 231
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
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 505
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
    object chkSearchTitle: TCheckBox
      Left = 189
      Top = 13
      Width = 50
      Height = 17
      Caption = #51228#47785
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkSearchAuthor: TCheckBox
      Left = 245
      Top = 13
      Width = 97
      Height = 17
      Caption = #51200#51088
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object pnlBotton: TPanel
    Left = 0
    Top = 190
    Width = 505
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      505
      41)
    object btnSelect: TButton
      Left = 323
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
      Left = 419
      Top = 8
      Width = 74
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #45803#44592
      ModalResult = 2
      TabOrder = 1
    end
  end
  object grdList: TDBGrid
    Left = 0
    Top = 41
    Width = 505
    Height = 149
    Align = alClient
    DataSource = dsFindBook
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
        FieldName = 'BOOK_TITLE'
        Title.Caption = #51228#47785
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BOOK_AUTHOR'
        Title.Caption = #51200#51088
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BOOK_PRICE'
        Title.Caption = #44032#44201
        Visible = True
      end>
  end
  object dsFindBook: TDataSource
    DataSet = dmDataAccess.qryFindBook
    Left = 232
    Top = 120
  end
end
