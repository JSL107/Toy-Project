object dmDataAccess: TdmDataAccess
  OldCreateOrder = False
  Height = 469
  Width = 665
  object conBookRental: TFDConnection
    Params.Strings = (
      'User_Name=localhost'
      'Password=1234'
      'ApplicationName=Enterprise/Architect/Ultimate'
      'Workstation=DESKTOP-LF7RKS0'
      'DATABASE=StudyDB'
      'MARS=yes'
      'ConnectionDef=MSSQL_Demo')
    Connected = True
    Left = 280
    Top = 152
  end
  object qryBook: TFDQuery
    Active = True
    OnCalcFields = qryBookCalcFields
    Connection = conBookRental
    UpdateOptions.AutoIncFields = 'BOOK_SEQ'
    SQL.Strings = (
      'SELECT * FROM BOOK')
    Left = 112
    Top = 88
    object qryBookBOOK_SEQ: TFDAutoIncField
      FieldName = 'BOOK_SEQ'
      Origin = 'BOOK_SEQ'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryBookBOOK_TITLE: TStringField
      FieldName = 'BOOK_TITLE'
      Origin = 'BOOK_TITLE'
      Required = True
      Size = 100
    end
    object qryBookBOOK_ISBN: TStringField
      FieldName = 'BOOK_ISBN'
      Origin = 'BOOK_ISBN'
      FixedChar = True
      Size = 13
    end
    object qryBookBOOK_AUTHOR: TStringField
      FieldName = 'BOOK_AUTHOR'
      Origin = 'BOOK_AUTHOR'
      Required = True
      Size = 30
    end
    object qryBookBOOK_PRICE: TIntegerField
      FieldName = 'BOOK_PRICE'
      Origin = 'BOOK_PRICE'
      DisplayFormat = '#,##0'
    end
    object qryBookBOOK_LINK: TStringField
      FieldName = 'BOOK_LINK'
      Origin = 'BOOK_LINK'
      Size = 255
    end
    object qryBookBOOK_RENT_YN: TStringField
      FieldName = 'BOOK_RENT_YN'
      Origin = 'BOOK_RENT_YN'
      FixedChar = True
      Size = 1
    end
    object qryBookBOOK_IMAGE: TBlobField
      FieldName = 'BOOK_IMAGE'
      Origin = 'BOOK_IMAGE'
      Size = 2147483647
    end
    object qryBookBOOK_DESCRIPTION: TBlobField
      FieldName = 'BOOK_DESCRIPTION'
      Origin = 'BOOK_DESCRIPTION'
      Size = 2147483647
    end
    object qryBookBook_RENT: TStringField
      FieldKind = fkCalculated
      FieldName = 'Book_RENT'
      Calculated = True
    end
  end
  object qryDuplicatedBook: TFDQuery
    Active = True
    Connection = conBookRental
    SQL.Strings = (
      'SELECT BOOK_SEQ FROM BOOK WHERE BOOK_ISBN = :ISBN')
    Left = 112
    Top = 160
    ParamData = <
      item
        Name = 'ISBN'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryUser: TFDQuery
    Active = True
    OnCalcFields = qryUserCalcFields
    Connection = conBookRental
    UpdateOptions.AutoIncFields = 'USER_SEQ'
    SQL.Strings = (
      'select * from users')
    Left = 560
    Top = 304
    object qryUserUSER_SEQ: TFDAutoIncField
      FieldName = 'USER_SEQ'
      Origin = 'USER_SEQ'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryUserUSER_NAME: TStringField
      FieldName = 'USER_NAME'
      Origin = 'USER_NAME'
      Required = True
      Size = 30
    end
    object qryUserUSER_BIRTH: TDateField
      FieldName = 'USER_BIRTH'
      Origin = 'USER_BIRTH'
    end
    object qryUserUSER_SEX: TStringField
      FieldName = 'USER_SEX'
      Origin = 'USER_SEX'
      FixedChar = True
      Size = 1
    end
    object qryUserUSER_PHONE: TStringField
      FieldName = 'USER_PHONE'
      Origin = 'USER_PHONE'
      Size = 15
    end
    object qryUserUSER_MAIL: TStringField
      FieldName = 'USER_MAIL'
      Origin = 'USER_MAIL'
      Size = 255
    end
    object qryUserUSER_IMAGE: TBlobField
      FieldName = 'USER_IMAGE'
      Origin = 'USER_IMAGE'
      Size = 2147483647
    end
    object qryUserUSER_REG_DATE: TDateField
      FieldName = 'USER_REG_DATE'
      Origin = 'USER_REG_DATE'
    end
    object qryUserUSER_OUT_YN: TStringField
      FieldName = 'USER_OUT_YN'
      Origin = 'USER_OUT_YN'
      FixedChar = True
      Size = 1
    end
    object qryUserUSER_OUT_DATE: TDateField
      FieldName = 'USER_OUT_DATE'
      Origin = 'USER_OUT_DATE'
    end
    object qryUserUSER_RENT_COUNT: TIntegerField
      FieldName = 'USER_RENT_COUNT'
      Origin = 'USER_RENT_COUNT'
    end
    object qryUserUSER_SEX_STR: TStringField
      FieldKind = fkCalculated
      FieldName = 'USER_SEX_STR'
      Calculated = True
    end
    object qryUserUSER_OUT: TStringField
      FieldKind = fkCalculated
      FieldName = 'USER_OUT'
      Calculated = True
    end
  end
  object qryDuplicatedUser: TFDQuery
    Active = True
    Connection = conBookRental
    SQL.Strings = (
      'select User_seq from users'
      'where user_name = :NAME and user_birth = :BIRTH;')
    Left = 560
    Top = 352
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'BIRTH'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryRent: TFDQuery
    Active = True
    OnCalcFields = qryRentCalcFields
    Connection = conBookRental
    UpdateOptions.AutoIncFields = 'RENT_SEQ'
    UpdateObject = usRent
    SQL.Strings = (
      
        'select users.user_name, book.book_title, rent.* from rent, book,' +
        ' users'
      'where rent.book_seq = book.book_seq and'
      'rent.user_seq = users.user_Seq')
    Left = 96
    Top = 280
    object qryRentuser_name: TStringField
      FieldName = 'user_name'
      Origin = 'user_name'
      ReadOnly = True
      Size = 30
    end
    object qryRentbook_title: TStringField
      FieldName = 'book_title'
      Origin = 'book_title'
      ReadOnly = True
      Size = 100
    end
    object qryRentRENT_SEQ: TFDAutoIncField
      FieldName = 'RENT_SEQ'
      Origin = 'RENT_SEQ'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryRentUSER_SEQ: TIntegerField
      FieldName = 'USER_SEQ'
      Origin = 'USER_SEQ'
      Required = True
    end
    object qryRentBOOK_SEQ: TIntegerField
      FieldName = 'BOOK_SEQ'
      Origin = 'BOOK_SEQ'
      Required = True
    end
    object qryRentRENT_DATE: TDateField
      FieldName = 'RENT_DATE'
      Origin = 'RENT_DATE'
    end
    object qryRentRENT_RETURN_DATE: TDateField
      FieldName = 'RENT_RETURN_DATE'
      Origin = 'RENT_RETURN_DATE'
    end
    object qryRentRENT_RETURN_YN: TStringField
      FieldName = 'RENT_RETURN_YN'
      Origin = 'RENT_RETURN_YN'
      FixedChar = True
      Size = 1
    end
    object qryRentRent_Return: TStringField
      FieldKind = fkCalculated
      FieldName = 'Rent_Return'
      Calculated = True
    end
  end
  object qryRentBook: TFDQuery
    Active = True
    IndexFieldNames = 'BOOK_SEQ'
    MasterSource = dsRent
    MasterFields = 'BOOK_SEQ'
    Connection = conBookRental
    SQL.Strings = (
      'select * from book')
    Left = 96
    Top = 328
  end
  object qryRentUser: TFDQuery
    Active = True
    IndexFieldNames = 'USER_SEQ'
    MasterSource = dsRent
    MasterFields = 'USER_SEQ'
    Connection = conBookRental
    SQL.Strings = (
      'select * from users;')
    Left = 96
    Top = 376
  end
  object dsRent: TDataSource
    DataSet = qryRent
    Left = 48
    Top = 336
  end
  object usRent: TFDUpdateSQL
    Connection = conBookRental
    InsertSQL.Strings = (
      'INSERT INTO STUDYDB..rent'
      '(USER_SEQ, BOOK_SEQ, RENT_DATE, RENT_RETURN_DATE, '
      '  RENT_RETURN_YN)'
      
        'VALUES (:NEW_USER_SEQ, :NEW_BOOK_SEQ, :NEW_RENT_DATE, :NEW_RENT_' +
        'RETURN_DATE, '
      '  :NEW_RENT_RETURN_YN);'
      'SELECT SCOPE_IDENTITY() AS RENT_SEQ')
    ModifySQL.Strings = (
      'UPDATE STUDYDB..rent'
      
        'SET USER_SEQ = :NEW_USER_SEQ, BOOK_SEQ = :NEW_BOOK_SEQ, RENT_DAT' +
        'E = :NEW_RENT_DATE, '
      
        '  RENT_RETURN_DATE = :NEW_RENT_RETURN_DATE, RENT_RETURN_YN = :NE' +
        'W_RENT_RETURN_YN'
      'WHERE RENT_SEQ = :OLD_RENT_SEQ;'
      'SELECT RENT_SEQ'
      'FROM STUDYDB..rent'
      'WHERE RENT_SEQ = :NEW_RENT_SEQ')
    DeleteSQL.Strings = (
      'DELETE FROM STUDYDB..rent'
      'WHERE RENT_SEQ = :OLD_RENT_SEQ')
    FetchRowSQL.Strings = (
      
        'SELECT RENT_SEQ, USER_SEQ, BOOK_SEQ, RENT_DATE, RENT_RETURN_DATE' +
        ', RENT_RETURN_YN'
      'FROM STUDYDB..rent'
      'WHERE RENT_SEQ = :OLD_RENT_SEQ')
    Left = 344
    Top = 152
  end
  object qryFindUser: TFDQuery
    Active = True
    OnCalcFields = qryFindUserCalcFields
    Connection = conBookRental
    SQL.Strings = (
      'select * from users')
    Left = 552
    Top = 72
    object qryFindUserUSER_SEQ: TFDAutoIncField
      FieldName = 'USER_SEQ'
      Origin = 'USER_SEQ'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryFindUserUSER_NAME: TStringField
      FieldName = 'USER_NAME'
      Origin = 'USER_NAME'
      Required = True
      Size = 30
    end
    object qryFindUserUSER_BIRTH: TDateField
      FieldName = 'USER_BIRTH'
      Origin = 'USER_BIRTH'
    end
    object qryFindUserUSER_SEX: TStringField
      FieldName = 'USER_SEX'
      Origin = 'USER_SEX'
      FixedChar = True
      Size = 1
    end
    object qryFindUserUSER_PHONE: TStringField
      FieldName = 'USER_PHONE'
      Origin = 'USER_PHONE'
      Size = 15
    end
    object qryFindUserUSER_MAIL: TStringField
      FieldName = 'USER_MAIL'
      Origin = 'USER_MAIL'
      Size = 255
    end
    object qryFindUserUSER_IMAGE: TBlobField
      FieldName = 'USER_IMAGE'
      Origin = 'USER_IMAGE'
      Size = 2147483647
    end
    object qryFindUserUSER_REG_DATE: TDateField
      FieldName = 'USER_REG_DATE'
      Origin = 'USER_REG_DATE'
    end
    object qryFindUserUSER_OUT_YN: TStringField
      FieldName = 'USER_OUT_YN'
      Origin = 'USER_OUT_YN'
      FixedChar = True
      Size = 1
    end
    object qryFindUserUSER_OUT_DATE: TDateField
      FieldName = 'USER_OUT_DATE'
      Origin = 'USER_OUT_DATE'
    end
    object qryFindUserUSER_RENT_COUNT: TIntegerField
      FieldName = 'USER_RENT_COUNT'
      Origin = 'USER_RENT_COUNT'
    end
    object qryFindUserUSER_SEX_STR: TStringField
      FieldKind = fkCalculated
      FieldName = 'USER_SEX_STR'
      Calculated = True
    end
  end
  object qryFindBook: TFDQuery
    Active = True
    Connection = conBookRental
    SQL.Strings = (
      'select * from book'
      'where book_rent_yn = '#39'N'#39)
    Left = 552
    Top = 136
    object qryFindBookBOOK_SEQ: TFDAutoIncField
      FieldName = 'BOOK_SEQ'
      Origin = 'BOOK_SEQ'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryFindBookBOOK_TITLE: TStringField
      FieldName = 'BOOK_TITLE'
      Origin = 'BOOK_TITLE'
      Required = True
      Size = 100
    end
    object qryFindBookBOOK_ISBN: TStringField
      FieldName = 'BOOK_ISBN'
      Origin = 'BOOK_ISBN'
      FixedChar = True
      Size = 13
    end
    object qryFindBookBOOK_AUTHOR: TStringField
      FieldName = 'BOOK_AUTHOR'
      Origin = 'BOOK_AUTHOR'
      Required = True
      Size = 30
    end
    object qryFindBookBOOK_PRICE: TIntegerField
      FieldName = 'BOOK_PRICE'
      Origin = 'BOOK_PRICE'
      DisplayFormat = '#,##0'
    end
    object qryFindBookBOOK_LINK: TStringField
      FieldName = 'BOOK_LINK'
      Origin = 'BOOK_LINK'
      Size = 255
    end
    object qryFindBookBOOK_RENT_YN: TStringField
      FieldName = 'BOOK_RENT_YN'
      Origin = 'BOOK_RENT_YN'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qryFindBookBOOK_IMAGE: TBlobField
      FieldName = 'BOOK_IMAGE'
      Origin = 'BOOK_IMAGE'
      Size = 2147483647
    end
    object qryFindBookBOOK_DESCRIPTION: TMemoField
      FieldName = 'BOOK_DESCRIPTION'
      Origin = 'BOOK_DESCRIPTION'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object qryUpdateBookState: TFDQuery
    Connection = conBookRental
    SQL.Strings = (
      'update book set'
      'book_rent_yn = :RENT_YN'
      'where book_seq = :SEQ')
    Left = 232
    Top = 296
    ParamData = <
      item
        Name = 'RENT_YN'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SEQ'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryUpdateUserRentCount: TFDQuery
    Connection = conBookRental
    SQL.Strings = (
      'UPDATE USERS SET '
      
        'USER_RENT_COUNT = (SELECT COUNT(*) FROM RENT WHERE USER_SEQ = :S' +
        'EQ AND RENT_RETURN_YN = '#39'N'#39')'
      'WHERE USER_SEQ = :SEQ')
    Left = 416
    Top = 264
    ParamData = <
      item
        Name = 'SEQ'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
