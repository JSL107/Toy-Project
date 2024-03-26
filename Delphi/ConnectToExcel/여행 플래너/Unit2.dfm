object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = #50668#54665#44228#54925#54364
  ClientHeight = 581
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlClient: TPanel
    Left = 0
    Top = 41
    Width = 809
    Height = 455
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object excelGrid: TAdvStringGrid
      Left = 1
      Top = 1
      Width = 807
      Height = 453
      Cursor = crDefault
      Align = alClient
      ColCount = 10
      DefaultColAlignment = taCenter
      DrawingStyle = gdsClassic
      FixedColor = clWhite
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goFixedRowDefAlign]
      ScrollBars = ssBoth
      TabOrder = 0
      OnKeyUp = excelGridKeyUp
      HoverRowCells = [hcNormal, hcSelected]
      OnEditCellDone = excelGridEditCellDone
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = 4474440
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Tahoma'
      ActiveCellFont.Style = [fsBold]
      ActiveCellColor = 11565130
      ActiveCellColorTo = 11565130
      BorderColor = 11250603
      ControlLook.FixedGradientFrom = clWhite
      ControlLook.FixedGradientTo = clWhite
      ControlLook.FixedGradientMirrorFrom = clWhite
      ControlLook.FixedGradientMirrorTo = clWhite
      ControlLook.FixedGradientHoverFrom = clGray
      ControlLook.FixedGradientHoverTo = clWhite
      ControlLook.FixedGradientHoverMirrorFrom = clWhite
      ControlLook.FixedGradientHoverMirrorTo = clWhite
      ControlLook.FixedGradientHoverBorder = 11645361
      ControlLook.FixedGradientDownFrom = clWhite
      ControlLook.FixedGradientDownTo = clWhite
      ControlLook.FixedGradientDownMirrorFrom = clWhite
      ControlLook.FixedGradientDownMirrorTo = clWhite
      ControlLook.FixedGradientDownBorder = 11250603
      ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
      ControlLook.DropDownHeader.Font.Color = clWindowText
      ControlLook.DropDownHeader.Font.Height = -11
      ControlLook.DropDownHeader.Font.Name = 'Tahoma'
      ControlLook.DropDownHeader.Font.Style = []
      ControlLook.DropDownHeader.Visible = True
      ControlLook.DropDownHeader.Buttons = <>
      ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
      ControlLook.DropDownFooter.Font.Color = clWindowText
      ControlLook.DropDownFooter.Font.Height = -11
      ControlLook.DropDownFooter.Font.Name = 'Tahoma'
      ControlLook.DropDownFooter.Font.Style = []
      ControlLook.DropDownFooter.Visible = True
      ControlLook.DropDownFooter.Buttons = <>
      DefaultAlignment = taCenter
      Filter = <>
      FilterDropDown.Font.Charset = DEFAULT_CHARSET
      FilterDropDown.Font.Color = clWindowText
      FilterDropDown.Font.Height = -11
      FilterDropDown.Font.Name = 'Tahoma'
      FilterDropDown.Font.Style = []
      FilterDropDown.TextChecked = 'Checked'
      FilterDropDown.TextUnChecked = 'Unchecked'
      FilterDropDownClear = '(All)'
      FilterEdit.TypeNames.Strings = (
        'Starts with'
        'Ends with'
        'Contains'
        'Not contains'
        'Equal'
        'Not equal'
        'Larger than'
        'Smaller than'
        'Clear')
      FixedRowHeight = 22
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      FloatFormat = '%.2f'
      HoverButtons.Buttons = <>
      HoverButtons.Position = hbLeftFromColumnLeft
      HTMLSettings.ImageFolder = 'images'
      HTMLSettings.ImageBaseName = 'img'
      Look = glCustom
      PrintSettings.DateFormat = 'dd/mm/yyyy'
      PrintSettings.Font.Charset = HANGEUL_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -13
      PrintSettings.Font.Name = #45208#45588#49552#44544#50472' '#44256#46357' '#50500#45768#44256' '#44256#46377
      PrintSettings.Font.Style = []
      PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
      PrintSettings.FixedFont.Color = clWindowText
      PrintSettings.FixedFont.Height = -11
      PrintSettings.FixedFont.Name = 'Tahoma'
      PrintSettings.FixedFont.Style = []
      PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -11
      PrintSettings.HeaderFont.Name = 'Tahoma'
      PrintSettings.HeaderFont.Style = []
      PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -11
      PrintSettings.FooterFont.Name = 'Tahoma'
      PrintSettings.FooterFont.Style = []
      PrintSettings.PageNumSep = '/'
      SearchFooter.ColorTo = clWhite
      SearchFooter.FindNextCaption = 'Find &next'
      SearchFooter.FindPrevCaption = 'Find &previous'
      SearchFooter.Font.Charset = DEFAULT_CHARSET
      SearchFooter.Font.Color = clWindowText
      SearchFooter.Font.Height = -11
      SearchFooter.Font.Name = 'Tahoma'
      SearchFooter.Font.Style = []
      SearchFooter.HighLightCaption = 'Highlight'
      SearchFooter.HintClose = 'Close'
      SearchFooter.HintFindNext = 'Find next occurrence'
      SearchFooter.HintFindPrev = 'Find previous occurrence'
      SearchFooter.HintHighlight = 'Highlight occurrences'
      SearchFooter.MatchCaseCaption = 'Match case'
      SearchFooter.ResultFormat = '(%d of %d)'
      SelectionColor = 13744549
      SelectionTextColor = clWindowText
      SortSettings.DefaultFormat = ssAutomatic
      SortSettings.HeaderColor = clWhite
      SortSettings.HeaderColorTo = clWhite
      SortSettings.HeaderMirrorColor = clWhite
      SortSettings.HeaderMirrorColorTo = clWhite
      Version = '8.5.5.2'
      ExplicitLeft = 0
      ExplicitTop = 10
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 809
    Height = 41
    Align = alTop
    TabOrder = 0
    object lblTitle: TLabel
      Left = 344
      Top = 0
      Width = 97
      Height = 31
      Caption = #50668#54665#54540#47000#45320
      Font.Charset = HANGEUL_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = #45208#45588#49552#44544#50472' '#45796#54665#52404
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 496
    Width = 809
    Height = 85
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      809
      85)
    object btnOpen: TButton
      Left = 24
      Top = 14
      Width = 75
      Height = 25
      Caption = #48520#47084#50724#44592
      TabOrder = 0
      OnClick = btnOpenClick
    end
    object btnClose: TButton
      Left = 718
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #45803#44592
      TabOrder = 2
      OnClick = btnCloseClick
    end
    object btnSave: TButton
      Left = 637
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #51200#51109#54616#44592
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnAddToDo: TButton
      Left = 24
      Top = 45
      Width = 93
      Height = 25
      Caption = #51068#51221' '#52628#44032#54616#44592
      TabOrder = 3
      OnClick = btnAddToDoClick
    end
    object btnAddDate: TButton
      Left = 123
      Top = 46
      Width = 91
      Height = 25
      Caption = #51068#49688' '#52628#44032#54616#44592
      TabOrder = 4
    end
  end
end
