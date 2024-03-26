object frmRent: TfrmRent
  Left = 0
  Top = 0
  Caption = #46020#49436' '#45824#50668' '#54868#47732
  ClientHeight = 620
  ClientWidth = 1093
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlContent: TPanel
    Left = 0
    Top = 41
    Width = 785
    Height = 579
    Align = alClient
    TabOrder = 1
    object sp: TSplitter
      Left = 781
      Top = 1
      Height = 577
      Align = alRight
      ExplicitLeft = 88
      ExplicitTop = -32
      ExplicitHeight = 100
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 1
      Width = 780
      Height = 577
      Align = alClient
      TabOrder = 0
      object pnlGridHeader: TPanel
        Left = 1
        Top = 1
        Width = 778
        Height = 41
        Align = alTop
        TabOrder = 0
        object lblSearch: TLabel
          Left = 14
          Top = 14
          Width = 22
          Height = 13
          Caption = #44160#49353
        end
        object chkSearchBook: TCheckBox
          Left = 215
          Top = 13
          Width = 97
          Height = 17
          Caption = #46020#49436' '#51228#47785
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object chkSearchUser: TCheckBox
          Left = 318
          Top = 13
          Width = 97
          Height = 17
          Caption = #54924#50896#47749
          TabOrder = 2
        end
        object edtSearch: TEdit
          Left = 65
          Top = 11
          Width = 121
          Height = 21
          TabOrder = 0
          OnKeyUp = edtSearchKeyUp
        end
      end
      object gridList: TDBGrid
        Left = 1
        Top = 42
        Width = 778
        Height = 534
        Align = alClient
        DataSource = dsRent
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'user_name'
            Title.Caption = #51060#47492
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'book_title'
            Title.Caption = #46020#49436#51228#47785
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RENT_DATE'
            Title.Caption = #45824#50668#51068#51088
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RENT_RETURN_DATE'
            Title.Caption = #48152#45225#50696#51221#51068
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Rent_Return'
            Title.Caption = #45824#50668#50668#48512
            Visible = True
          end>
      end
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1093
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1093
      41)
    object lblCaption: TLabel
      Left = 16
      Top = 14
      Width = 47
      Height = 13
      Caption = #46020#49436' '#45824#50668
    end
    object btnClose: TButton
      Left = 1001
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #45803#44592
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object btnAdd: TButton
      Left = 920
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #49352' '#45824#52636
      TabOrder = 0
      OnClick = btnAddClick
    end
  end
  object pnlInput: TPanel
    Left = 785
    Top = 41
    Width = 308
    Height = 579
    Align = alRight
    TabOrder = 2
    DesignSize = (
      308
      579)
    object grpUser: TGroupBox
      Left = 23
      Top = 43
      Width = 262
      Height = 224
      Anchors = [akLeft, akTop, akRight]
      Caption = #54924#50896#51221#48372
      TabOrder = 0
      DesignSize = (
        262
        224)
      object imgUser: TImage
        Left = 16
        Top = 58
        Width = 89
        Height = 132
        Proportional = True
        Stretch = True
      end
      object lblName: TLabel
        Left = 120
        Top = 58
        Width = 22
        Height = 13
        Caption = #51060#47492
      end
      object lblBirth: TLabel
        Left = 120
        Top = 104
        Width = 44
        Height = 13
        Caption = #49373#45380#50900#51068
      end
      object lblPhone: TLabel
        Left = 124
        Top = 150
        Width = 33
        Height = 13
        Caption = #50672#46973#52376
      end
      object btnFindUser: TButton
        Left = 16
        Top = 27
        Width = 233
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        Caption = #54924#50896' '#44160#49353
        TabOrder = 0
        OnClick = btnFindUserClick
      end
      object edtUserName: TDBEdit
        Left = 120
        Top = 77
        Width = 129
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'USER_NAME'
        DataSource = dsRentUser
        TabOrder = 1
      end
      object edtUserBirth: TDBEdit
        Left = 120
        Top = 123
        Width = 129
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'USER_BIRTH'
        DataSource = dsRentUser
        TabOrder = 2
      end
      object edtUserPhone: TDBEdit
        Left = 120
        Top = 169
        Width = 129
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'USER_PHONE'
        DataSource = dsRentUser
        TabOrder = 3
      end
    end
    object GroupBox2: TGroupBox
      Left = 23
      Top = 288
      Width = 262
      Height = 257
      Anchors = [akLeft, akTop, akRight]
      Caption = #46020#49436#51221#48372
      TabOrder = 1
      DesignSize = (
        262
        257)
      object imgBook: TImage
        Left = 24
        Top = 66
        Width = 89
        Height = 132
        Proportional = True
        Stretch = True
      end
      object Label1: TLabel
        Left = 132
        Top = 158
        Width = 22
        Height = 13
        Caption = #44032#44201
      end
      object Label2: TLabel
        Left = 128
        Top = 112
        Width = 22
        Height = 13
        Caption = #51200#51088
      end
      object Label3: TLabel
        Left = 128
        Top = 66
        Width = 22
        Height = 13
        Caption = #51228#47785
      end
      object btnFindBook: TButton
        Left = 24
        Top = 35
        Width = 225
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        Caption = #46020#49436' '#44160#49353
        TabOrder = 0
        OnClick = btnFindBookClick
      end
      object edtBookTitle: TDBEdit
        Left = 128
        Top = 85
        Width = 125
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'BOOK_TITLE'
        DataSource = dsRentBook
        TabOrder = 1
      end
      object edtBookAuthor: TDBEdit
        Left = 128
        Top = 131
        Width = 125
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'BOOK_AUTHOR'
        DataSource = dsRentBook
        TabOrder = 2
      end
      object edtBookPrice: TDBEdit
        Left = 128
        Top = 177
        Width = 125
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'BOOK_PRICE'
        DataSource = dsRentBook
        TabOrder = 3
      end
      object btnRent: TButton
        Left = 3
        Top = 216
        Width = 75
        Height = 25
        Caption = #45824#52636
        TabOrder = 4
        OnClick = btnRentClick
      end
      object btnReturn: TButton
        Left = 85
        Top = 216
        Width = 75
        Height = 25
        Caption = #48152#45225
        TabOrder = 5
        OnClick = btnReturnClick
      end
      object btnCancel: TButton
        Left = 178
        Top = 216
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #52712#49548
        TabOrder = 6
        OnClick = btnCancelClick
      end
    end
  end
  object dsRent: TDataSource
    DataSet = dmDataAccess.qryRent
    OnStateChange = dsRentStateChange
    Left = 496
    Top = 304
  end
  object dsRentUser: TDataSource
    DataSet = dmDataAccess.qryRentUser
    OnDataChange = dsRentUserDataChange
    Left = 872
    Top = 204
  end
  object dsRentBook: TDataSource
    DataSet = dmDataAccess.qryRentBook
    OnDataChange = dsRentBookDataChange
    Left = 880
    Top = 448
  end
end
