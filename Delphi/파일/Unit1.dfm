object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 464
    object O1: TMenuItem
      Caption = 'Option'
      object O2: TMenuItem
        Caption = 'Open'
      end
      object Open1: TMenuItem
        Caption = 'Close'
      end
      object T1: TMenuItem
        Caption = 'Transfer'
      end
    end
  end
  object IdFTPServer1: TIdFTPServer
    Bindings = <>
    CommandHandlers = <>
    ExceptionReply.Code = '500'
    ExceptionReply.Text.Strings = (
      'Unknown Internal Error')
    Greeting.Code = '220'
    Greeting.Text.Strings = (
      'Indy FTP Server ready.')
    HelpReply.Code = ''
    MaxConnectionReply.Code = '300'
    MaxConnectionReply.Text.Strings = (
      'Too many connections. Try again later.')
    ReplyTexts = <>
    ReplyUnknownCommand.Code = '500'
    ReplyUnknownCommand.Text.Strings = (
      'Unknown Command')
    AnonymousAccounts.Strings = (
      'anonymous'
      'ftp'
      'guest')
    SITECommands = <>
    MLSDFacts = []
    ReplyUnknownSITCommand.Code = '500'
    ReplyUnknownSITCommand.Text.Strings = (
      'Invalid SITE command.')
    Left = 384
    Top = 152
  end
end
