object frmUser: TfrmUser
  Left = 0
  Top = 0
  Caption = #54924#50896' '#44288#47532
  ClientHeight = 593
  ClientWidth = 1081
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
    Width = 1081
    Height = 552
    Align = alClient
    TabOrder = 1
    ExplicitLeft = -8
    ExplicitTop = 47
    object sp: TSplitter
      Left = 725
      Top = 1
      Height = 550
      Align = alRight
      ExplicitLeft = 168
      ExplicitTop = 224
      ExplicitHeight = 100
    end
    object pnlInput: TPanel
      Left = 728
      Top = 1
      Width = 352
      Height = 550
      Align = alRight
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      ExplicitLeft = 730
      ExplicitTop = 0
      DesignSize = (
        352
        550)
      object lblName: TLabel
        Left = 29
        Top = 15
        Width = 22
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = #51060#47492
      end
      object lblBirth: TLabel
        Left = 29
        Top = 66
        Width = 44
        Height = 14
        Anchors = [akLeft, akTop, akRight]
        Caption = #49373#45380#50900#51068
      end
      object lblPhone: TLabel
        Left = 29
        Top = 180
        Width = 44
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = #51204#54868#48264#54840
      end
      object lblMail: TLabel
        Left = 29
        Top = 228
        Width = 44
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = #47700#51068#51452#49548
      end
      object edtName: TDBEdit
        Left = 29
        Top = 34
        Width = 127
        Height = 21
        DataField = 'USER_NAME'
        DataSource = dsUser
        TabOrder = 0
        OnExit = edtNameExit
      end
      object dpBirth: TCalendarPicker
        Left = 29
        Top = 82
        Width = 129
        Height = 33
        CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
        CalendarHeaderInfo.DaysOfWeekFont.Height = -13
        CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
        CalendarHeaderInfo.DaysOfWeekFont.Style = []
        CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.Font.Color = clWindowText
        CalendarHeaderInfo.Font.Height = -20
        CalendarHeaderInfo.Font.Name = 'Segoe UI'
        CalendarHeaderInfo.Font.Style = []
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        OnCloseUp = dpBirthCloseUp
        ParentFont = False
        TabOrder = 2
        TextHint = 'select a date'
      end
      object grpSex: TDBRadioGroup
        Left = 29
        Top = 127
        Width = 129
        Height = 47
        Caption = #49457#48324
        Columns = 2
        DataField = 'USER_SEX'
        DataSource = dsUser
        Items.Strings = (
          #45224
          #50668)
        TabOrder = 3
        Values.Strings = (
          'M'
          'F')
      end
      object edtPhone: TDBEdit
        Left = 29
        Top = 199
        Width = 129
        Height = 22
        DataField = 'USER_PHONE'
        DataSource = dsUser
        TabOrder = 4
      end
      object edtMail: TDBEdit
        Left = 29
        Top = 247
        Width = 129
        Height = 22
        DataField = 'USER_MAIL'
        DataSource = dsUser
        TabOrder = 7
      end
      object GroupBox1: TGroupBox
        Left = 176
        Top = 34
        Width = 145
        Height = 205
        Anchors = [akTop, akRight]
        TabOrder = 1
        DesignSize = (
          145
          205)
        object imgUser: TImage
          Left = 0
          Top = 0
          Width = 144
          Height = 203
          Anchors = [akTop, akRight]
          Proportional = True
          Stretch = True
        end
      end
      object btnLoadImage: TButton
        Left = 254
        Top = 245
        Width = 68
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #48520#47084#50724#44592
        TabOrder = 6
        OnClick = btnLoadImageClick
      end
      object btnClearImage: TButton
        Left = 176
        Top = 245
        Width = 73
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #52488#44592#54868
        TabOrder = 5
        OnClick = btnClearImageClick
      end
      object btnDelete: TButton
        Left = 32
        Top = 312
        Width = 75
        Height = 26
        Caption = #54924#50896' '#53448#53748
        TabOrder = 8
        OnClick = btnDeleteClick
      end
      object btnCancel: TButton
        Left = 247
        Top = 312
        Width = 75
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #52712#49548
        TabOrder = 10
        OnClick = btnCancelClick
      end
      object btnSave: TButton
        Left = 168
        Top = 312
        Width = 73
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #51200#51109
        TabOrder = 9
        OnClick = btnSaveClick
      end
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 1
      Width = 724
      Height = 550
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 16
      ExplicitTop = 25
      ExplicitWidth = 1079
      object pnlGridHeader: TPanel
        Left = 1
        Top = 1
        Width = 722
        Height = 41
        Align = alTop
        TabOrder = 0
        ExplicitLeft = -4
        ExplicitTop = -5
        object lblSearch: TLabel
          Left = 14
          Top = 14
          Width = 22
          Height = 13
          Caption = #44160#49353
        end
        object edtSearch: TEdit
          Left = 73
          Top = 11
          Width = 133
          Height = 22
          TabOrder = 0
          OnKeyUp = edtSearchKeyUp
        end
        object chkSearchName: TCheckBox
          Left = 224
          Top = 13
          Width = 46
          Height = 18
          Caption = #51060#47492
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object chkSearchPhone: TCheckBox
          Left = 279
          Top = 13
          Width = 66
          Height = 17
          Caption = #51204#54868#48264#54840
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
      object gridList: TDBGrid
        Left = 1
        Top = 42
        Width = 722
        Height = 507
        Align = alClient
        DataSource = dsUser
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
            FieldName = 'USER_NAME'
            Title.Caption = #51060#47492
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = []
            Width = 100
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
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_PHONE'
            Title.Caption = #51204#54868#48264#54840
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_MAIL'
            Title.Caption = #47700#51068#51452#49548
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_REG_DATE'
            Title.Caption = #46321#47197#51068#49884
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_OUT'
            Title.Caption = #53448#53748#50668#48512
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_OUT_DATE'
            Title.Caption = #53448#53748#51068#49884
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_RENT_COUNT'
            Title.Caption = #45824#50668#44428#49688
            Visible = True
          end>
      end
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1081
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 185
    DesignSize = (
      1081
      41)
    object lblCaption: TLabel
      Left = 16
      Top = 8
      Width = 54
      Height = 23
      Caption = #54924#50896' '#44288#47532
      Color = clBackground
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = #45208#45588#49552#44544#50472' '#44552#51008#48372#54868
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object btnAdd: TButton
      Left = 885
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #49888#44508' '#46321#47197
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnClose: TButton
      Left = 966
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #45803#44592
      TabOrder = 1
      OnClick = btnCloseClick
    end
  end
  object dlgLoadImage: TOpenDialog
    Left = 968
    Top = 160
  end
  object dsUser: TDataSource
    DataSet = dmDataAccess.qryUser
    OnStateChange = dsUserStateChange
    OnDataChange = dsUserDataChange
    Left = 536
    Top = 304
  end
end
