unit uModel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Rtti, Typinfo, db, ADODB,
{$IFDEF VER220}
  Dialogs;
{$ELSE}
  Vcl.Dialogs, FMX.Dialogs;
{$ENDIF}
  Const
    RETURN_VALUE='RETURN_VALUE';

  type
  TCustomBaseModel=class;

  TCustomClassField=Class
  private
    Fowner : TCustomBaseModel;
    FValue : Variant;
  public
    Constructor Create(AOwner : TCustomBaseModel);
    function FieldName(sName : string):TCustomClassField;
    function AsString:string;
    function AsAnsiString:Ansistring;
    function AsExtended:Extended;
    function AsDateTime:TDatetime;
    function AsInteger:integer;
    function AsVariant:Variant;
  End;

  TCustomBaseModel=class
  private
    FCustomerField : TCustomClassField;
    function GetFieldValue(S : string;var V : TValue):Boolean;
  public
    Constructor Create;
    Destructor Destroy;override;
    procedure CopyModel(V : TCustomBaseModel);
    procedure Clear;virtual;
    function FieldValue(sFieldName : string):Variant;
    property Field : TCustomClassField read FCustomerField;
  end;

  TCustomModel=class(TCustomBaseModel)
  private
    FFieldList : TStringList;
    procedure CheckField;
  public
    Constructor Create;
    Destructor Destroy;override;
    property FieldList : TStringList read FFieldList;
  end;

  TModelInfo = record
    //PassingChar  : Char;
    StartPosi    : integer;
    IgnoreChar   : Char;
  end;

  TBaseModel=class(TCustomBaseModel)
  private
    ModelInfo : TModelInfo;
    function GetFieldName(Const V : string; var R : string; RetrunValueCheck : boolean=True):boolean;
  protected
  public
    Constructor Create(Const IgnoreChar : Char; StartPosi : integer=1);overload;
    Constructor Create;overload;
    Constructor Create(DS : TDataSet);overload;
    function  IsFieldExists(V : string; DS : TDataSet):boolean;
    Procedure GetFieldList(V : TStrings);
    procedure SetModelInfo(DS : TDataSet);
    procedure SetParaModelInfo(para : TParameters);
    procedure SetOutputParaModelInfo(para : TParameters);
    property pModelInfo : TModelInfo read ModelInfo write ModelInfo;
  end;

implementation

{ TBaseModel }

constructor TBaseModel.Create(Const IgnoreChar : Char; StartPosi : integer);
begin
  inherited Create;
  if StartPosi < 1 then
    ModelInfo.StartPosi   := 1
  else
    ModelInfo.StartPosi   := StartPosi;
  ModelInfo.IgnoreChar  := UpperCase(IgnoreChar)[1];
end;

constructor TBaseModel.Create;
begin
  inherited Create;
  ModelInfo.StartPosi   := 1;
  ModelInfo.IgnoreChar  := #0;
end;

constructor TBaseModel.Create(DS: TDataSet);
begin
  Create;
  if Assigned(DS) then
    SetModelInfo(DS);
end;

procedure TBaseModel.GetFieldList(V: TStrings);
var
  MyContext : TRttiContext;
  MyField   : TRttiField;
  MyVal     : TValue;
begin
  if Assigned(V) then begin
    for MyField in MyContext.GetType(ClassType).GetFields do begin
        MyVal   := MyField.GetValue(Self);
        V.Add(format('<%s> : <%s> : <%s>', [MyField.Name, MyVal.TypeInfo^.name,
                    GetEnumName(TypeInfo(TTypeKind), Ord(MyVal.TypeInfo^.Kind))]));
    end;
  end;
end;

function TBaseModel.GetFieldName(Const V: string; var R : string; RetrunValueCheck : boolean): boolean;
var
  C : Char;
begin
  R := '';
  C := UpperCase(Copy(V, 1, 1))[1];
  Result := (ModelInfo.IgnoreChar <> C);
  if not Result then Exit;
  if RetrunValueCheck then
    Result := RETURN_VALUE<>Uppercase(V);

  if Result then
    if ModelInfo.StartPosi<2 then
      R := V
    else
    begin
      R := Copy(V, ModelInfo.StartPosi)
    end;
end;

function TBaseModel.IsFieldExists(V: string; DS: TDataSet): boolean;
var
  i : integer;
begin
  Result := False;
  for i := 0 to  DS.Fields.Count-1 do begin
    if Uppercase(DS.Fields[i].FieldName)=UpperCase(V) then
    begin
      Result := True;
      break;
    end;
  end;
end;

procedure TBaseModel.SetModelInfo(DS: TDataSet);
var
  MyContext : TRttiContext;
  MyField   : TRttiField;
  MyVal     : TValue;
  sFieldName : string;
begin
  for MyField in MyContext.GetType(ClassType).GetFields do begin
    if GetFieldName(MyField.Name, sFieldName) then begin
      MyVal   := MyField.GetValue(Self);
      if MyVal.TypeInfo^.Kind in [tkChar, tkWChar, tkString, tkUString, tkInteger, tkInt64, tkFloat, tkEnumeration] then begin
        if NOT DS.FieldByName(sFieldName).IsNull then begin
          case MyVal.TypeInfo^.Kind of
          tkChar, tkWChar    :
          begin
            if DS.FieldByName(sFieldName).AsString <> '' then
              MyVal:= DS.FieldByName(sFieldName).AsString[1]
            else MyVal := #0;
          end;
          tkString, tkUString :
              MyVal:= DS.FieldByName(sFieldName).AsString;
          tKInteger, tkInt64 :
              MyVal := DS.FieldByName(sFieldName).AsInteger;
          tkFloat :
            begin
              MyVal := DS.FieldByName(sFieldName).AsExtended;
            end;
          tkEnumeration :
            begin
              if MyVal.IsType<Boolean> then
                MyVal := DS.FieldByName(sFieldName).AsBoolean
              else Continue;
            end;
          end;
          MyField.SetValue(Self, MyVal);
        end;
      end;
    end;
  end;
end;

procedure TBaseModel.SetOutputParaModelInfo(para: TParameters);
var
  i : integer;
  MyContext : TRttiContext;
  MyField   : TRttiField;
  MyVal     : TValue;
  sParaName  : string;
  sFieldName : string;
begin
  for i := 0 to para.Count-1 do begin
    if para[i].Direction in [pdInputOutput, pdOutput, pdReturnValue] then  begin
      sParaName := Copy(para[i].Name, 2);
      for MyField in MyContext.GetType(ClassType).GetFields do begin
        if GetFieldName(MyField.Name, sFieldName, False) then begin
          if Uppercase(sFieldName)=Uppercase(sParaName) then begin
            MyVal   := MyField.GetValue(Self);
            if MyVal.TypeInfo^.Kind in [tkChar, tkWChar, tkString, tkUString, tkInteger, tkInt64, tkFloat, tkEnumeration] then begin
              if Para[i].Value=null then break;

              case MyVal.TypeInfo^.Kind of
              tkChar, tkWChar     :
                begin
                  if String(para[i].Value) <> '' then
                    MyVal := String(para[i].Value)[1]
                  else MyVal := #0;
                end;
              tkString, tkUString :
                begin
                  Myval := String(para[i].Value);
                end;
              tKInteger, tKInt64 :
                begin
                  Myval := integer(para[i].Value);
                end;
              tkFloat :
                begin
                  Myval := Extended(para[i].Value);
                end;
              tkEnumeration :
                begin
                  if MyVal.IsType<Boolean> then
                    MyVal := Boolean(para[i].Value)
                  else Continue;
                end;
              end;
              MyField.SetValue(Self, MyVal);
            end;
            break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TBaseModel.SetParaModelInfo(para: TParameters);
const
  _Datetime='TDateTime';
var
  MyContext : TRttiContext;
  MyField   : TRttiField;
  MyVal     : TValue;
  sFieldName : string;
  V          : Variant;
  function ExistsPara(V : string):boolean;
  var
    i : integer;
  begin
    Result := False;
    for i := 0 to para.Count-1 do begin
      if Uppercase(Copy(para[i].Name, 2))=Uppercase(V) then begin
        Result := True;
        break;
      end;
    end;
  end;
begin
  for MyField in MyContext.GetType(ClassType).GetFields do begin
    if GetFieldName(MyField.Name, sFieldName) then begin
      if ExistsPara(sFieldName) then begin
        MyVal   := MyField.GetValue(Self);
        if MyVal.TypeInfo^.Kind in [tkChar, tkWChar, tkString, tkUString, tkInteger, tkInt64, tkFloat, tkEnumeration] then begin
          case MyVal.TypeInfo^.Kind of
          tkChar, tkWChar :
            begin
              if MyVal.AsString = '' then V := Null else V := Trim(MyVal.AsString);
            end;
          tkEnumeration :
            begin
              if MyVal.IsType<Boolean> then
                V := MyVal.AsBoolean else V := Null;
            end;
          tkFloat :
              begin
                if MyVal.TypeInfo^.Name=_Datetime then begin
                  if MyVal.AsExtended=0 then V := Null
                  else V := MyVal.AsExtended;
                end else V := MyVal.AsExtended;
              end;
          else
            V := MyVal.AsVariant;
          end;
          para.ParamByName('@'+sFieldName).Value := V;
        end;
      end;
    end;
  end;
end;

{ TCustomBaseModel }

procedure TCustomBaseModel.Clear;
var
  MyContext : TRttiContext;
  MyField   : TRttiField;
  MyVal     : TValue;
begin
  for MyField in MyContext.GetType(ClassType).GetFields do begin
    MyVal   := MyField.GetValue(Self);
    if MyVal.TypeInfo^.Kind in [tkChar, tkWChar, tkString, tkUString, tkInteger, tkInt64, tkFloat, tkEnumeration] then begin
        case MyVal.TypeInfo^.Kind of
        tkChar, tkWChar    :
            MyVal:= #0;
        tkString, tkUString :
            MyVal:= '';
        tKInteger, tkInt64 :
            MyVal := 0;
        tkFloat :
          begin
            MyVal := 0;
          end;
        tkEnumeration :
          begin
            if MyVal.IsType<Boolean> then
              MyVal := False else Continue;
          end;
        end;
        MyField.SetValue(Self, MyVal);
    end;
  end;
end;

procedure TCustomBaseModel.CopyModel(V: TCustomBaseModel);
var
  MyContext : TRttiContext;
  MyField   : TRttiField;
  Dest, Source : TValue;
begin
  for MyField in MyContext.GetType(ClassType).GetFields do begin
    Dest := MyField.GetValue(Self);
    if Dest.TypeInfo^.Kind in [tkChar, tkWChar, tkString, tkUString, tkInteger, tkInt64, tkFloat, tkEnumeration] then begin
      if V.GetFieldValue(MyField.Name, Source) then begin
        if Source.TypeInfo^.Kind=Dest.TypeInfo^.Kind then begin
          Dest := Source;
          MyField.SetValue(Self, Dest);
        end;
      end;
    end;
  end;
end;

constructor TCustomBaseModel.Create;
begin
  FCustomerField := TCustomClassField.Create(Self);
end;

destructor TCustomBaseModel.Destroy;
begin
  FCustomerField.Free;
  inherited;
end;

function TCustomBaseModel.FieldValue(sFieldName: string): Variant;
var
  MyContext : TRttiContext;
  MyField   : TRttiField;
  Source : TValue;
begin
  Result := null;
  for MyField in MyContext.GetType(ClassType).GetFields do begin
    if MyField.Name=sFieldName then begin
      Source := MyField.GetValue(Self);
      if Source.TypeInfo^.Kind in [tkChar, tkWChar, tkString, tkUString, tkInteger, tkInt64, tkFloat, tkEnumeration] then begin
        Result := Source.AsVariant;
      end;
      break;
    end;
  end;
end;

function TCustomBaseModel.GetFieldValue(S: string; var V: TValue): Boolean;
var
  MyContext : TRttiContext;
  MyField   : TRttiField;
begin
  Result := False;
  for MyField in MyContext.GetType(ClassType).GetFields do begin
    if Uppercase(MyField.Name)=Uppercase(S) then begin
      V   := MyField.GetValue(Self);
      Result := True;
      break;
    end;
  end;
end;

{ TCustomClassField }

function TCustomClassField.AsAnsiString: Ansistring;
begin
  Result := Ansistring(AsString);
end;

function TCustomClassField.AsDateTime: TDatetime;
begin
  if VarIsNull(FValue) then
    Result := 0
  else
    Result := VarToDateTime(FValue);
end;

function TCustomClassField.AsExtended: Extended;
begin
  if VarIsNull(FValue) then
    Result := 0
  else
    Result := FValue;
end;

function TCustomClassField.AsInteger: integer;
begin
  if VarIsNull(FValue) then
    Result := 0
  else
    Result := FValue;
end;

function TCustomClassField.AsString: string;
begin
   if VarIsNull(FValue) then
    Result := ''
  else
    Result := FValue;
end;

function TCustomClassField.AsVariant: Variant;
begin
  Result := FValue;
end;

constructor TCustomClassField.Create(AOwner: TCustomBaseModel);
begin
  FOwner := AOwner;
  FValue := null;
end;

function TCustomClassField.FieldName(sName: string): TCustomClassField;
begin
  FValue := Fowner.FieldValue(sName);
  Result := Self;
end;

{ TCustomModel }

procedure TCustomModel.CheckField;
var
  MyContext : TRttiContext;
  MyField   : TRttiField;
  V         : TValue;
begin
  FFieldList.Clear;
  for MyField in MyContext.GetType(ClassType).GetFields do begin
    V := MyField.GetValue(Self);
    if V.TypeInfo^.Kind in [tkChar, tkWChar, tkString, tkUString, tkInteger, tkInt64, tkFloat, tkEnumeration] then begin
      FFieldList.Add(MyField.Name)
    end;
  end;
end;

constructor TCustomModel.Create;
begin
  inherited;
  FFieldList := TStringList.Create;
  CheckField;
end;

destructor TCustomModel.Destroy;
begin
  FFieldList.Free;
  inherited;
end;

end.
