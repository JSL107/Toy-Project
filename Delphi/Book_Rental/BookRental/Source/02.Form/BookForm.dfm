object frmBook: TfrmBook
  Left = 0
  Top = 0
  Caption = #46020#49436#44288#47532' '#54868#47732
  ClientHeight = 569
  ClientWidth = 1237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1237
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1237
      41)
    object lblCaption: TLabel
      Left = 32
      Top = 14
      Width = 48
      Height = 13
      Caption = #46020#49436' '#44288#47532
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Vivaldi'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnAdd: TButton
      Left = 1065
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #52628#44032
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnClose: TButton
      Left = 1146
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #45803#44592
      TabOrder = 1
      OnClick = btnCloseClick
    end
  end
  object pnlContent: TPanel
    Left = 0
    Top = 41
    Width = 1237
    Height = 528
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 854
      Top = 1
      Width = 0
      Height = 526
      Align = alRight
      ExplicitLeft = 841
    end
    object pnlMain: TPanel
      Left = 1
      Top = 1
      Width = 853
      Height = 526
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 839
      object gridBook: TDBGrid
        Left = 1
        Top = 42
        Width = 851
        Height = 483
        Align = alClient
        DataSource = dsBook
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #45208#45588#49552#44544#50472' '#45796#54665#52404
        Font.Style = []
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'BOOK_TITLE'
            Font.Charset = HANGEUL_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = #45208#45588#49552#44544#50472' '#45796#54665#52404
            Font.Style = []
            Title.Caption = #51228#47785
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BOOK_AUTHOR'
            Title.Caption = #51200#51088
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BOOK_PRICE'
            Title.Caption = #44032#44201
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Book_RENT'
            Title.Caption = #45824#50668#50668#48512
            Width = 60
            Visible = True
          end>
      end
      object pnlMainHeader: TPanel
        Left = 1
        Top = 1
        Width = 851
        Height = 41
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 837
        object lblSearch: TLabel
          Left = 30
          Top = 14
          Width = 22
          Height = 13
          Caption = #44160#49353
        end
        object edtSearch: TEdit
          Left = 71
          Top = 11
          Width = 121
          Height = 21
          TabOrder = 0
          OnKeyUp = edtSearchKeyUp
        end
        object chkSearchTitle: TCheckBox
          Left = 198
          Top = 13
          Width = 97
          Height = 17
          Caption = #51228#47785
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object chkSearchAuthor: TCheckBox
          Left = 283
          Top = 13
          Width = 97
          Height = 17
          Caption = #51200#51088
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
    end
    object pnlInput: TPanel
      Left = 854
      Top = 1
      Width = 382
      Height = 526
      Align = alRight
      Anchors = [akTop, akRight]
      TabOrder = 1
      ExplicitLeft = 855
      DesignSize = (
        382
        526)
      object Label1: TLabel
        Left = 6
        Top = 15
        Width = 22
        Height = 13
        Caption = #51228#47785
      end
      object Label2: TLabel
        Left = 6
        Top = 63
        Width = 23
        Height = 13
        Caption = 'ISBN'
      end
      object Label3: TLabel
        Left = 6
        Top = 111
        Width = 22
        Height = 13
        Caption = #51200#51088
      end
      object Label4: TLabel
        Left = 6
        Top = 159
        Width = 22
        Height = 13
        Caption = #44032#44201
      end
      object TLabel
        Left = 6
        Top = 207
        Width = 22
        Height = 13
        Caption = #47553#53356
      end
      object Label5: TLabel
        Left = 144
        Top = 253
        Width = 22
        Height = 13
        Caption = #49444#47749
      end
      object lblLink: TLabel
        Left = 156
        Top = 207
        Width = 44
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #48148#47196#44032#44592
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        OnClick = lblLinkClick
        ExplicitLeft = 169
      end
      object edtTitle: TDBEdit
        Left = 5
        Top = 36
        Width = 249
        Height = 21
        DataField = 'BOOK_TITLE'
        DataSource = dsBook
        TabOrder = 1
      end
      object edtISBN: TDBEdit
        Left = 6
        Top = 82
        Width = 195
        Height = 21
        DataField = 'BOOK_ISBN'
        DataSource = dsBook
        TabOrder = 2
        OnExit = edtISBNExit
      end
      object edtAuthor: TDBEdit
        Left = 6
        Top = 130
        Width = 195
        Height = 21
        DataField = 'BOOK_AUTHOR'
        DataSource = dsBook
        TabOrder = 3
      end
      object edtPrice: TDBEdit
        Left = 6
        Top = 178
        Width = 195
        Height = 21
        DataField = 'BOOK_PRICE'
        DataSource = dsBook
        TabOrder = 4
      end
      object edtLink: TDBEdit
        Left = 6
        Top = 226
        Width = 196
        Height = 21
        DataField = 'BOOK_LINK'
        DataSource = dsBook
        TabOrder = 7
      end
      object GroupBox1: TGroupBox
        Left = 260
        Top = 31
        Width = 114
        Height = 185
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        ExplicitWidth = 127
        object imgBook: TImage
          Left = 2
          Top = 15
          Width = 110
          Height = 168
          Align = alClient
          Anchors = [akLeft, akTop, akRight]
          Proportional = True
          Stretch = True
          ExplicitLeft = 1
          ExplicitTop = 17
          ExplicitWidth = 123
        end
      end
      object btnImageAddClear: TButton
        Left = 246
        Top = 222
        Width = 61
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #52488#44592#54868
        TabOrder = 5
        OnClick = btnImageAddClearClick
        ExplicitLeft = 259
      end
      object btnImageLoad: TButton
        Left = 313
        Top = 222
        Width = 66
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #48520#47084#50724#44592
        TabOrder = 6
        OnClick = btnImageLoadClick
        ExplicitLeft = 326
      end
      object mmoDescription: TDBMemo
        Left = 6
        Top = 272
        Width = 361
        Height = 215
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataField = 'BOOK_DESCRIPTION'
        DataSource = dsBook
        ScrollBars = ssVertical
        TabOrder = 8
        ExplicitWidth = 374
      end
      object btnDelete: TButton
        Left = 6
        Top = 493
        Width = 148
        Height = 25
        Anchors = [akLeft, akRight, akBottom]
        Caption = #49325#51228
        TabOrder = 9
        OnClick = btnDeleteClick
        ExplicitWidth = 161
      end
      object btnSave: TButton
        Left = 211
        Top = 493
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #51200#51109
        TabOrder = 10
        OnClick = btnSaveClick
        ExplicitLeft = 224
      end
      object btnCancel: TButton
        Left = 292
        Top = 493
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #52712#49548
        TabOrder = 11
        OnClick = btnCancelClick
        ExplicitLeft = 305
      end
    end
  end
  object dsBook: TDataSource
    DataSet = dmDataAccess.qryBook
    OnStateChange = dsBookStateChange
    OnDataChange = dsBookDataChange
    Left = 145
    Top = 242
  end
  object dlgLoadImage: TOpenDialog
    FileName = 'C:\Users\IJS\Desktop\Book_Rental\BookRental\Resources\user.png'
    Left = 1152
    Top = 161
  end
end
