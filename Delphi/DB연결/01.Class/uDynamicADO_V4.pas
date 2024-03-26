{
//Written 2009.12.
          2013.01. Model 추가
만든이 : K.y.h
용도   : Ado 이용한 DB 간단한 MSSQL Handleing......
 //2011.4.4 자동 Connection 관리 추가
}

unit uDynamicADO_V4;

interface

uses
  DB, ADODB, Messages, SysUtils, Variants, Classes,
{$IFDEF VER220}
  forms, StdCtrls, Grids, Dialogs,
{$ELSE}
  Vcl.Forms, Vcl.StdCtrls, FMX.Grid, Vcl.Grids, Vcl.Dialogs, FMX.Dialogs,
{$ENDIF}
  Contnrs, Windows, ComObj, ActiveX, SyncObjs, uModel, Generics.Collections, Generics.defaults, Typinfo;

type
  TErr_Int = (TErrMessage = -1, TNoErr = 0);

type
  DyDBException = class(Exception);
  //DB 연결정보

  TDBinfo = record
    sDBServerIP: string;
    sDBServerIP2: string;
    sDBName: string;
    sDBUser: string;
    sDBPass: string;
    nDBPort: integer;
    nDBport2: integer;
  end;
  //DB 필드구조

  TFieldData = class
    sFieldName: string;
    Feildtyps: TFieldType;
    ParameterDirections: TParameterDirection;
    nPrecision: integer;
    nLength: integer;
    nORDINAL_POSITION: integer;
  end;

  TFieldDataCompare = class(TComparer<TFieldData>);

  //스토어프로시져 파라미터값
  TColumData = class
    sSpName: string;
    FieldList: TObjectList<TFieldData>;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TDBStoredProc = class(TADOStoredProc)
  public
    destructor Destroy; override;
  end;

  TCustomDBStoredProc = class(TDBStoredProc)
  public
    procedure ExecProc;
  end;

  TDBQuery = class(TADOQuery)
  public
    destructor Destroy; override;
  end;

  TDBCMD = class(TADOCommand)
  public
    destructor Destroy; override;
  end;

  TDynamicMSSQL = class;

  {$WARNINGS OFF}
  TDynamicMSSQL = class(TComponent)
  private
    FErrMsg: string;
    sDBServerIP: string;
    sDBServerIP2: string;
    sDBName: string;
    sDBUser: string;
    sDBPass: string;
    nDBPort: integer;
    nDBPort2: integer;
    ColumList: TObjectList;
    bActive: Boolean;
    fConnectionTimeout: integer;
    FAutoDisConnect: boolean;
    FCS: TCriticalSection;
    //
    FUserID: string;
    FLocalIP: string;
    FCheckLogger: boolean;
    FLogerProcList: TStringList;
    FLogSave: boolean;
    FConnDrv: Integer;
    //
    function GetDBServerIP: string;
    function GetDBServerIP2: string;
    function GetDBName: string;
    function GetDBUser: string;
    function GetDBPass: string;
    function GetDBPort: integer;
    function GetDBPort2: integer;
    function GetConnectString: string;
    function GetConnected: boolean;
    function GetDBinfo: TDBinfo;
    function ExistsSpColum(Value: string): TColumData;
    function GetActive: Boolean;
    function GetConnectionTimeout: Integer;
    procedure SetDBServerIP(Value: string);
    procedure SetDBServerIP2(Value: string);
    procedure SetDBName(Value: string);
    procedure SetDBUser(Value: string);
    procedure SetDBPass(Value: string);
    procedure SetDBinfo(Value: TDBinfo);
    procedure SetDBPort(Value: Integer);
    procedure SetDBPort2(Value: Integer);
    procedure SetConnectionTimeout(Value: Integer);
    procedure SetParameters(Adosp: TADOStoredProc; Data: array of const);
    function StrToNumFieldType(Value: string): TFieldType;
    procedure SetErrMsg(V: string);
    procedure SetConnect(Value: boolean);
    function GetCommandTimeOut: integer;
    procedure SetCommandTimeOut(v: integer);
    procedure init;
    procedure SetCustomConnection(V: TCustomADODataSet);
    procedure CheckError(V: TCustomADODataSet);
    //
    procedure SetUserID(V: string);
    procedure WriteLogger(V: TADOStoredProc); overload;
    procedure WriteLogger(V: string); overload;
    procedure ADD_DBHISLogger(sAGENTID, sCUSTNO, sPEERIP, sCMDNM, sCMD: string;
      nRECORDCOUNT: Integer; sCALLERID, sCALLERNAME : string);
    procedure CheckLogger(V: TADOStoredProc);
  protected
    AdoCon: TADOConnection;
  public
    constructor Create; overload; virtual;
    constructor Create(sServer1: string; nPort1: integer; sServer2: string; nPort2: integer; sServiceName, sUser, sPass: string); overload; virtual;
    destructor Destroy; override;
    function SP_Execute(const sSp_Name: string; Data: array of const): TDBStoredProc; overload;
    function SP_Execute(const sSp_Name: string; Data: array of const; var DBSP: TDBStoredProc): boolean; overload;
    function SP_Execute(const sSp_Name: string; Model: TBaseModel; var DBSP: TDBStoredProc): boolean; overload;
    function SP_Execute(const sSp_Name: string; Model: TBaseModel): boolean; overload;
    function SP_ExecuteCmd(const sSp_Name: string; Data: array of const): Boolean; overload;
    function SP_ExecuteCmd(const sSp_Name: string; Data: array of const; var DBproc: TDBStoredProc): Boolean; overload;
    function SP_ExecuteCmd(const sSp_Name: string; Model: TBaseModel; var DBproc: TDBStoredProc): Boolean; overload;
    function SP_ExecuteCmd(const sSp_Name: string; Model: TBaseModel): Boolean; overload;
    function SP_ExecuteOpenRecord(const sSp_Name: string; Data: array of const): TDBStoredProc; overload;
    function SP_ExecuteOpenRecord(const sSp_Name: string; Data: array of const; var DBSP: TDBStoredProc): boolean; overload;
    function SP_ExecuteOpenRecord(const sSp_Name: string; Model: TBaseModel; var DBSP: TDBStoredProc): boolean; overload;
    function SP_GetStoredproc(const sSp_Name: string): TDBStoredProc;
    function ExecuteCmd(StrValue: string): boolean; overload;
    function ExecuteCmd(Formatstring: string; Data: array of const): boolean; overload;
    function ExecuteOpen(SqlQry: string): TDBQuery; overload;
    function ExecuteOpen(Formatstring: string; Data: array of const): TDBQuery; overload;
    function GetMakeQuery: TDBQuery;
    function Sp_GetColum(AdoSP: TADOStoredProc; SP_Name: string): Boolean;
    function CreateExecuteString(AdoSP: TADOStoredProc): string;
    procedure DBWriteLog(S: string);
    procedure Connect;
    procedure DisConnect;
    function GetLoadColumList(SpName: string): TColumData;
    function BeginTran: boolean;
    function Commit: boolean;
    function Rollback: boolean;
    function GetMakeCmd: TDBCMD;
    function GetErrMsg: string;
    function GetLastError(var Desc: string): Integer;
  published
    property DBServer: string read GetDBServerIP write SetDBServerIP;
    property DBServer2: string read GetDBServerIP2 write SetDBServerIP2;
    property DBName: string read GetDBName write SetDBName;
    property DBUser: string read GetDBUser write SetDBUser;
    property DBPass: string read GetDBPass write SetDBPass;
    property DBPort: integer read GetDBPort write SetDBPort;
    property DBPort2: integer read GetDBPort2 write SetDBPort2;
    property SettingDBinfo: TDBinfo read GetDBinfo write SetDBinfo;
    property Connected: boolean read GetConnected write SetConnect;
    property Active: boolean read GetActive;
    property ConnectionTimeout: Integer read GetConnectionTimeout write SetConnectionTimeout;
    property ErrMsg: string read GetErrMsg write SetErrMsg;
    property AutoDisConnect: boolean read FAutoDisConnect write FAutoDisConnect;
    property CommandTimeOut: integer read GetCommandTimeOut write SetCommandTimeOut;
    property Connectstring: string read GetConnectString;
    //
    property UserID: string read FUserID write SetUserID;
    property LocalIP: string read FLocalIP write FLocalIP;
    property LogSave: boolean read FLogSave write FLogSave;
    property ConnDrv: Integer read FConnDrv write FConnDrv;
  end;
  {$WARNINGS ON}

{.$Define ParaFieldChecking}

implementation

procedure TDynamicMSSQL.SetCommandTimeOut(v: integer);
begin
  AdoCon.CommandTimeout := v;
end;

procedure TDynamicMSSQL.SetConnect(Value: boolean);
begin
  if GetConnected <> Value then
  begin
    case Value of
      True:
        begin
          if DBServer = '' then
            Exit;
          CoInitialize(nil);
          AdoCon.ConnectionString := GetConnectString;
          AdoCon.LoginPrompt := False;
          AdoCon.ConnectionTimeout := FConnectionTimeout;
          try
            AdoCon.Connected := True;
          except
            on eDB: EDatabaseError do
            begin
              FErrMsg := eDB.Message;
              DBWriteLog('DataBaseError:' + ErrMsg);
            end;
            on e: exception do
            begin
              FErrMsg := e.Message;
              DBWriteLog('DataBaseError2:' + ErrMsg);
            end;
          end;
        end;
      False:
        begin
          if AdoCon.Connected then
          begin
            try
              try
                while AdoCon.InTransaction do
                  AdoCon.RollbackTrans;
              except
                on e: exception do
                begin
                  FErrMsg := e.Message;
                  DBWriteLog('DisConnect->' + ErrMsg);
                end;
              end;
              AdoCon.Close;
            finally
              CoUninitialize;
            end;
          end;
        end;
    end;
  end;
end;

function TDynamicMSSQL.SP_Execute(const sSp_Name: string; Data: array of const): TDBStoredProc;
begin
  Result := TDBStoredProc.Create(Self);
  Result.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(Result);
  try
    if Sp_GetColum(Result, sSp_Name) then
    begin
      SetParameters(Result, Data);
      Result.Prepared := True;
      {$IFDEF DEBUG}
      DBWriteLog(CreateExecuteString(Result));
      {$ENDIF}
      WriteLogger(Result);
      init;
      Result.ExecProc;
      Result.Prepared := False;
      CheckError(Result);
    end;
  except
    on e: Exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog(FErrMsg);
      DBWriteLog(CreateExecuteString(Result));
      FreeAndNil(Result);
    end;
  end;
  if FErrMsg <> '' then
    raise DyDBException.Create(format('실행오류->%s, %s', [sSp_Name, FErrMsg]));
end;

function TDynamicMSSQL.SP_Execute(const sSp_Name: string; Data: array of const; var DBSP: TDBStoredProc): boolean;
begin
  Result := False;
  DBSP := TDBStoredProc.Create(Self);
  DBSP.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(DBSP);
  try
    if Sp_GetColum(DBSP, sSp_Name) then
    begin
      SetParameters(DBSP, Data);
      DBSP.Prepared := True;
      {$IFDEF DEBUG}
      DBWriteLog(CreateExecuteString(DBSP));
      {$ENDIF}
      WriteLogger(DBSP);
      init;
      DBSP.ExecProc;
      DBSP.Prepared := False;
      CheckError(DBSP);
      Result := True;
    end;
  except
    on e: Exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog(FErrMsg);
      DBWriteLog(CreateExecuteString(DBSP));
    end;
  end;
  if not Result then
    FreeAndNil(DBSP);

  if FErrMsg <> '' then
    raise DyDBException.Create(format('실행오류->%s, %s', [sSp_Name, FErrMsg]));
end;

function TDynamicMSSQL.SP_Execute(const sSp_Name: string; Model: TBaseModel; var DBSP: TDBStoredProc): boolean;
begin
  Result := False;
  DBSP := TDBStoredProc.Create(Self);
  DBSP.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(DBSP);
  try
    if Sp_GetColum(DBSP, sSp_Name) then
    begin
      Model.SetParaModelInfo(DBSP.Parameters);
      DBSP.Prepared := True;
      {$IFDEF DEBUG}
      DBWriteLog(CreateExecuteString(DBSP));
      {$ENDIF}
      WriteLogger(DBSP);
      init;
      DBSP.ExecProc;
      Model.SetOutputParaModelInfo(DBSP.Parameters);
      DBSP.Prepared := False;
      CheckError(DBSP);
      Result := True;
    end;
  except
    on e: Exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog(FErrMsg);
      DBWriteLog(CreateExecuteString(DBSP));
    end;
  end;
  if not Result then
    FreeAndNil(DBSP);
  if FErrMsg <> '' then
    raise DyDBException.Create(format('실행오류->%s, %s', [sSp_Name, FErrMsg]));
end;

function TDynamicMSSQL.SP_Execute(const sSp_Name: string; Model: TBaseModel): boolean;
var
  DBSP: TDBStoredProc;
begin
  Result := False;
  DBSP := TDBStoredProc.Create(Self);
  try
    DBSP.CommandTimeout := AdoCon.CommandTimeout;
    SetCustomConnection(DBSP);
    try
      if Sp_GetColum(DBSP, sSp_Name) then
      begin
        Model.SetParaModelInfo(DBSP.Parameters);
        DBSP.Prepared := True;
        {$IFDEF DEBUG}
        DBWriteLog(CreateExecuteString(DBSP));
        {$ENDIF}
        WriteLogger(DBSP);
        init;
        DBSP.ExecProc;
        Model.SetOutputParaModelInfo(DBSP.Parameters);
        DBSP.Prepared := False;
        CheckError(DBSP);
        Result := True;
      end;

    except
      on e: Exception do
      begin
        FErrMsg := e.Message;
        DBWriteLog(FErrMsg);
        DBWriteLog(CreateExecuteString(DBSP));
      end;
    end;
  finally
    FreeAndNil(DBSP);
  end;
  if FErrMsg <> '' then
    raise DyDBException.Create(format('실행오류->%s, %s', [sSp_Name, FErrMsg]));
end;

function TDynamicMSSQL.SP_ExecuteCmd(const sSp_Name: string; Model: TBaseModel; var DBproc: TDBStoredProc): Boolean;
begin
  Result := False;
  DBproc := TDBStoredProc.Create(Self);
  DBproc.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(DBproc);
  try
    if Sp_GetColum(DBproc, sSp_Name) then
    begin
      Model.SetParaModelInfo(DBproc.Parameters);
      DBproc.Prepared := True;
       {$IFDEF DEBUG}
      DBWriteLog(CreateExecuteString(DBproc));
       {$ENDIF}
      WriteLogger(DBproc);
      init;
      DBproc.ExecProc;
      Model.SetOutputParaModelInfo(DBproc.Parameters);
      CheckError(DBproc);
      Result := True;
    end;
  except
    on e: Exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog(FErrMsg);
      DBWriteLog(CreateExecuteString(DBproc));
      FreeAndNil(DBproc);
    end;
  end;
end;

function TDynamicMSSQL.SP_ExecuteCmd(const sSp_Name: string; Model: TBaseModel): Boolean;
var
  DBProc: TDBStoredProc;
begin
  try
    Result := False;
    DBProc := TDBStoredProc.Create(Self);
    DBProc.CommandTimeout := AdoCon.CommandTimeout;
    SetCustomConnection(DBProc);
    try
      if Sp_GetColum(DBProc, sSp_Name) then
      begin
        Model.SetParaModelInfo(DBProc.Parameters);
        DBProc.Prepared := True;
        {$IFDEF DEBUG}
        DBWriteLog(CreateExecuteString(DBProc));
        {$ENDIF}
        WriteLogger(DBProc);
        init;
        DBProc.ExecProc;
        Model.SetOutputParaModelInfo(DBProc.Parameters);
        CheckError(DBProc);
        Result := True;
      end;
    except
      on e: Exception do
      begin
        FErrMsg := e.Message;
        DBWriteLog(FErrMsg);
        DBWriteLog(CreateExecuteString(DBProc));
      end;
    end;
  finally
    FreeAndNil(DBProc);
  end;
end;

function TDynamicMSSQL.SP_ExecuteCmd(const sSp_Name: string; Data: array of const; var DBproc: TDBStoredProc): Boolean;
begin
  Result := False;
  DBproc := TDBStoredProc.Create(Self);
  DBproc.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(DBproc);
  try
    if Sp_GetColum(DBproc, sSp_Name) then
    begin
      SetParameters(DBproc, Data);
      DBproc.Prepared := True;
      {$IFDEF DEBUG}
      DBWriteLog(CreateExecuteString(DBproc));
      {$ENDIF}
      WriteLogger(DBproc);
      init;
      DBproc.ExecProc;
      CheckError(DBproc);
      Result := True;
    end;
  except
    on e: Exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog(FErrMsg);
      DBWriteLog(CreateExecuteString(DBproc));
      FreeAndNil(DBproc);
    end;
  end;
end;

function TDynamicMSSQL.SP_ExecuteOpenRecord(const sSp_Name: string; Data: array of const; var DBSP: TDBStoredProc): boolean;
begin
  Result := False;
  DBSP := TDBStoredProc.Create(Self);
  DBSP.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(DBSP);
  try
    if Sp_GetColum(DBSP, sSp_Name) then
    begin
      SetParameters(DBSP, Data);
      DBSP.Prepared := True;
      {$IFDEF DEBUG}
      DBWriteLog(CreateExecuteString(DBSP));
      {$ENDIF}
      init;
      DBSP.open;
      CheckLogger(DBSP);
      DBSP.Prepared := False;
      CheckError(DBSP);
      Result := True;
    end;
  except
    on e: Exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog('1:' + FErrMsg);
    end;
  end;
  if not Result then
    FreeAndNil(DBSP);
  if FErrMsg <> '' then
    raise DyDBException.Create(format('실행오류 !->%s, %s', [sSp_Name, FErrMsg]));
end;

function TDynamicMSSQL.SP_ExecuteOpenRecord(const sSp_Name: string; Model: TBaseModel; var DBSP: TDBStoredProc): boolean;
begin
  Result := False;
  DBSP := TDBStoredProc.Create(Self);
  DBSP.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(DBSP);
  try
    if Sp_GetColum(DBSP, sSp_Name) then
    begin
      Model.SetParaModelInfo(DBSP.Parameters);
      DBSP.Prepared := True;
      {$IFDEF DEBUG}
      DBWriteLog(CreateExecuteString(DBSP));
      {$ENDIF}
      init;
      DBSP.open;
      CheckLogger(DBSP);
      Model.SetOutputParaModelInfo(DBSP.Parameters);
      DBSP.Prepared := False;
      CheckError(DBSP);
      Result := True;
    end;
  except
    on e: Exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog('1:' + FErrMsg);
    end;
  end;
  if not Result then
    FreeAndNil(DBSP);
  if FErrMsg <> '' then
    raise DyDBException.Create(format('실행오류 !->%s, %s', [sSp_Name, FErrMsg]));
end;

function TDynamicMSSQL.SP_ExecuteOpenRecord(const sSp_Name: string; Data: array of const): TDBStoredProc;
begin
  Result := TDBStoredProc.Create(Self);
  Result.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(Result);
  try
    if Sp_GetColum(Result, sSp_Name) then
    begin
      SetParameters(Result, Data);
      Result.Prepared := True;
      {$IFDEF DEBUG}
      DBWriteLog(CreateExecuteString(Result));
      {$ENDIF}
      init;
      Result.open;
      CheckLogger(Result);
      Result.Prepared := False;
      CheckError(Result);
    end;
  except
    on e: Exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog('1:' + FErrMsg);
      FreeAndNil(Result);
    end;
  end;
  if FErrMsg <> '' then
    raise DyDBException.Create(format('실행오류 !->%s, %s', [sSp_Name, FErrMsg]));
end;

function TDynamicMSSQL.Sp_GetColum(AdoSP: TADOStoredProc; SP_Name: string): Boolean;
var
  ColumData: TColumData;
  i: integer;
begin
  Result := False;
  ColumData := ExistsSpColum(SP_Name);
  if ColumData = nil then
    ColumData := GetLoadColumList(SP_Name);

  if Assigned(ColumData) then
  begin
    ColumData.FieldList.Sort;
    AdoSP.Prepared := False;
    AdoSP.ProcedureName := SP_Name;
    AdoSP.Parameters.Clear;
    {$ifdef ParaFieldChecking}
    DBWriteLog(format('StoredProcName [%s]', [SP_Name]));
    {$endif}
    for i := 0 to ColumData.FieldList.Count - 1 do
    begin
      with ColumData.FieldList.Items[i] do
      begin
        {$ifdef ParaFieldChecking}
        DBWriteLog(format('[Param]:%d/%d [Name]:%s [type]:%s', [i, nORDINAL_POSITION, sFieldName, GetEnumname(Typeinfo(TFieldType),
          ord(Feildtyps))]));
        {$endif}
        AdoSP.Parameters.CreateParameter(sFieldName, Feildtyps, ParameterDirections, nLength, Null);
        AdoSP.Parameters.ParamByName(sFieldName).Precision := nPrecision;
      end;
    end;
    Result := True;
  end;
end;

function TDynamicMSSQL.SP_GetStoredproc(const sSp_Name: string): TDBStoredProc;
label
  EndRtn;
begin
  init;
  Result := TCustomDBStoredProc.Create(Self);
  Result.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(Result);
  try
    Sp_GetColum(Result, sSp_Name);
  except
    on e: Exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog('1:' + FErrMsg);
      FreeAndNil(Result);
    end;
  end;
  if FErrMsg <> '' then
    raise DyDBException.Create(format('Execute Error !->%s', [FErrMsg]));
end;

procedure TDynamicMSSQL.DBWriteLog(S: string);
var
  F: TextFile;
  sLogFile: string;
begin
   {$IFNDEF DEBUG}
  if not FLogSave then
    Exit;
   {$ENDIF}
  sLogFile := ExtractFilePath(ParamStr(0)) + '\Log\' + FormatDateTime('YYYYMMDD', now) + '_DBEVENT.log';
  //----------------------------------------------------------------------------
  // Log디렉토리가 있는지 검사
  if not DirectoryExists(ExtractFilePath(ParamStr(0)) + '\Log') then
    ForceDirectories(ExtractFilePath(ParamStr(0)) + '\Log');
  //----------------------------------------------------------------------------
  // Log파일 생성
  {$I-}
  try
    try
      AssignFile(F, sLogFile);
      if FileExists(sLogFile) then
        Append(F)
      else if not FileExists(sLogFile) then
        Rewrite(F);
      S := FormatDateTime('HH:NN:SS', now) + '->' + S;
      Writeln(F, S);
    finally
      CloseFile(F);
    end;
  except
    on e: Exception do
      FErrMsg := FErrMsg + #13#10 + e.Message;
  end;
  {$I+}
end;

constructor TDynamicMSSQL.Create;
begin
  inherited Create(nil);
  FCS := TCriticalSection.Create;
  FAutoDisConnect := True;
  AdoCon := TAdoConnection.Create(Self);
  AdoCon.LoginPrompt := False;
  AdoCon.CommandTimeout := 120;
  bActive := False;
  ColumList := TObjectList.Create;
  FConnDrv := 0;
  SetConnectionTimeout(60);
  FLogerProcList := TStringList.Create;
end;

destructor TDynamicMSSQL.Destroy;
begin
  if Connected then
    DisConnect;
  ColumList.Clear;
  ColumList.Free;
  ColumList := nil;
  FreeAndNil(AdoCon);
  FCS.Free;
  FLogerProcList.Free;
  inherited Destroy;
end;

function TDynamicMSSQL.GetConnectString: string;
var
  constr: string;
begin
  if sDBServerIP2 <> '' then  // 이중화 여부
  begin
    case FConnDrv of
      0, 1:   // SQL Server Native Client
        begin
          constr := 'Provider=SQLNCLI10.1;Password=%s;User ID=%s;Initial Catalog=%s;Data Source=%s, %d;' + 'Failover Partner=%s, %d;';
        end;
      2:      //  Microsoft OLE DB Driver SQL Server (MSOLEDBSQL)
        begin
          constr := 'Provider=MSOLEDBSQL.1;Password=%s;User ID=%s;Initial Catalog=%s;Data Source=%s, %d;' + 'Failover Partner=%s, %d;';
        end;
    end;
    Result := Format(constr, [sDBPass, sDBUser, sDBName, sDBServerIP, nDBPort, sDBServerIP2, nDBPort2]);
  end
  else
  begin
    case FConnDrv of
      0:      // Microsoft OLE DB Provider for SQL Server (SQLOLEDB)
        begin
          constr := 'Provider=SQLOLEDB.1;Password=%s;User ID=%s;' + 'Initial Catalog=%s;Data Source=%s, %d;';
        end;
      1:      // SQL Server Native Client
        begin
          constr := 'Provider=SQLNCLI10.1;Password=%s;User ID=%s;' + 'Initial Catalog=%s;Data Source=%s, %d;';
        end;
      2:      //  Microsoft OLE DB Driver SQL Server (MSOLEDBSQL)
        begin
          constr := 'Provider=MSOLEDBSQL.1;Password=%s;User ID=%s;' + 'Initial Catalog=%s;Data Source=%s, %d;';
        end;
    end;
    Result := Format(constr, [sDBPass, sDBUser, sDBName, sDBServerIP, nDBPort]);
  end;
end;

function TDynamicMSSQL.GetDBName: string;
begin
  Result := sDBName;
end;

function TDynamicMSSQL.GetDBPass: string;
begin
  Result := sDBPass;
end;

function TDynamicMSSQL.GetDBServerIP: string;
begin
  Result := sDBServerIP;
end;

function TDynamicMSSQL.GetDBServerIP2: string;
begin
  Result := sDBServerIP2;
end;

function TDynamicMSSQL.GetDBUser: string;
begin
  Result := sDBUser;
end;

function TDynamicMSSQL.GetErrMsg: string;
begin
  Result := FErrMsg;
  FErrMsg := '';
end;

procedure TDynamicMSSQL.SetDBName(Value: string);
begin
  sDBName := Value;
end;

procedure TDynamicMSSQL.SetDBPass(Value: string);
begin
  sDBPass := Value;
end;

procedure TDynamicMSSQL.SetDBServerIP(Value: string);
begin
  sDBServerIP := Value;
end;

procedure TDynamicMSSQL.SetDBServerIP2(Value: string);
begin
  sDBServerIP2 := Value;
end;

procedure TDynamicMSSQL.SetDBUser(Value: string);
begin
  sDBUser := Value;
end;

function TDynamicMSSQL.GetCommandTimeOut: integer;
begin
  Result := AdoCon.CommandTimeout;
end;

function TDynamicMSSQL.GetConnected: boolean;
begin
  Result := AdoCon.Connected;
end;

function TDynamicMSSQL.GetDBinfo: TDBinfo;
begin
  Result.sDBServerIP := sDBServerIP;
  Result.sDBServerIP2 := sDBServerIP2;
  Result.sDBName := sDBName;
  Result.sDBUser := sDBUser;
  Result.sDBPass := sDBPass;
  Result.nDBPort := nDBPort;
  Result.nDBPort2 := nDBPort2;
end;

procedure TDynamicMSSQL.SetDBinfo(Value: TDBinfo);
begin
  sDBServerIP := Value.sDBServerIP;
  sDBServerIP2 := Value.sDBServerIP2;
  sDBName := Value.sDBName;
  sDBUser := Value.sDBUser;
  sDBPass := Value.sDBPass;
  nDBPort := Value.nDBPort;
  nDBPort2 := Value.nDBPort2;
end;

constructor TDynamicMSSQL.Create(sServer1: string; nPort1: integer; sServer2: string; nPort2: integer; sServiceName, sUser, sPass: string);
begin
  Create;
  Self.sDBServerIP := sServer1;
  Self.sDBServerIP2 := sServer2;
  Self.sDBName := sServiceName;
  Self.sDBUser := sUser;
  Self.sDBPass := sPass;
  Self.nDBPort := nPort1;
  Self.nDBPort2 := nPort2;
end;

function TDynamicMSSQL.CreateExecuteString(AdoSP: TADOStoredProc): string;
var
  i: integer;
  sTmp, FullString: string;
begin
  Result := '';
  try
    try
      FullString := 'Exec ' + AdoSP.ProcedureName + ' ';
      for i := 1 to AdoSP.Parameters.Count - 1 do
      begin
        case AdoSP.Parameters.Items[i].DataType of
          ftLargeint, ftSmallint, ftInteger:
            begin
              if AdoSP.Parameters.Items[i].Value = null then
                sTmp := Format(' %s,', ['Null'])
              else
                sTmp := Format(' %s,', [IntToStr(AdoSP.Parameters.Items[i].Value)]);
            end;
          ftFloat:
            begin
              if AdoSP.Parameters.Items[i].Value = null then
                sTmp := Format(' %s,', ['Null'])
              else
                sTmp := Format(' %s,', [FloatToStr(AdoSP.Parameters.Items[i].Value)]);
            end;
          ftMemo, ftString:
            begin
              if AdoSP.Parameters.Items[i].Value = null then
                sTmp := Format(' %s,', ['Null'])
              else
                sTmp := Format(' ''' + '%s' + ''',', [AdoSP.Parameters.Items[i].Value]);
            end;
          ftDateTime:
            begin
              if AdoSP.Parameters.Items[i].Value = null then
                sTmp := Format(' %s,', ['Null'])
              else
                sTmp := ' ''' + Formatdatetime('yyyy-mm-dd hh:nn:ss', AdoSP.Parameters.Items[i].Value) + ''',';
            end;
          ftDate:
            begin
              if AdoSP.Parameters.Items[i].Value = null then
                sTmp := Format(' %s,', ['Null'])
              else
                sTmp := ' ''' + Formatdatetime('yyyy-mm-dd', AdoSP.Parameters.Items[i].Value) + ''',';
            end;
          ftBoolean:
            begin
              if AdoSP.Parameters.Items[i].Value = null then
                sTmp := Format(' %s,', ['Null'])
              else
              begin
                if AdoSP.Parameters.Items[i].Value = True then
                  sTmp := Format(' %d,', [1])
                else
                  sTmp := Format(' %d,', [0]);
              end
            end;
          ftUnknown:
            begin
              sTmp := Format(' %s,', ['Null']);
            end
        else
          begin
            if AdoSP.Parameters.Items[i].Value = null then
              sTmp := Format(' %s,', ['Null'])
            else
              sTmp := Format(' ''' + '%s' + ''',', [AdoSP.Parameters.Items[i].Value]);
          end;
        end;
        FullString := FullString + sTmp;
      end;
      Delete(FullString, Length(FullString), 1);
    finally
      Result := FullString;
    end;
  except
    on e: Exception do
      DBWriteLog(e.Message);
  end;

end;

function TDynamicMSSQL.GetLastError(var Desc: string): Integer;
var
  nidx: integer;
begin
  Result := 0;
  if Assigned(AdoCon) then
  begin
    nidx := AdoCon.Errors.Count - 1;
    if nidx >= 0 then
    begin
      Result := AdoCon.Errors.Item[nidx].Number;
      Desc := AdoCon.Errors.Item[nidx].Description;
    end;
  end;

end;

function TDynamicMSSQL.GetLoadColumList(SpName: string): TColumData;
var
  ColumSp: TADOStoredProc;
  FieldData: TFieldData;
  i: integer;
begin
  Result := nil;

  if FLogerProcList.Count = 0 then
  begin
    with TADOQuery.Create(Self) do
    begin
      try
        try
          ConnectionString := GetConnectString;
          SQL.Add('SELECT PROCNM FROM DB_ACCESS_INF');
          Open;
          while not Eof do
          begin
            FLogerProcList.Add(UpperCase(Fields[0].AsString));
            Next;
          end;
        except
        end;
      finally
        Free;
      end;
    end;
  end;

  for i := ColumList.Count - 1 downto 0 do
  begin
    if TColumData(ColumList.Items[i]).sSpName = SpName then
    begin
      ColumList.Delete(i);
      Break;
    end;
  end;
  ColumSp := TADOStoredProc.Create(Self);
  ColumSp.ConnectionString := GetConnectString;
  ColumSp.Prepared := False;
  ColumSp.ProcedureName := 'sp_procedure_params_rowset';
  ColumSp.Parameters.Clear;
  ColumSp.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, Null);
  ColumSp.Parameters.CreateParameter('@procedure_name', ftWideString, pdInput, 128, SpName);
  ColumSp.Parameters.CreateParameter('@group_number', ftinteger, pdInput, 0, 1);
  ColumSp.Parameters.CreateParameter('@procedure_schema', ftWideString, pdInput, 128, Null);
  ColumSp.Parameters.CreateParameter('@parameter_name', ftWideString, pdInput, 128, Null);

  try
    try
      ColumSp.Prepared := True;
      ColumSp.Open;

      if ColumSp.RecordCount > 0 then
      begin

        Result := TColumData.Create;
        Result.sSpName := SpName;
        ColumList.Add(Result);
        while not ColumSp.Eof do
        begin
          FieldData := TFieldData.Create;
          with FieldData do
          begin
            sFieldName := ColumSp.FieldByName('PARAMETER_NAME').asstring;
            Feildtyps := StrToNumFieldType(ColumSp.FieldByName('TYPE_NAME').asString);

            case ColumSp.FieldByName('PARAMETER_TYPE').asinteger of
              1:
                ParameterDirections := pdInput;
              2:
                ParameterDirections := pdInputOutput;
              3:
                ParameterDirections := pdOutput;
              4:
                ParameterDirections := pdReturnValue;
            else
              ParameterDirections := pdUnknown;
            end;

            if not ColumSp.FieldByName('CHARACTER_MAXIMUM_LENGTH').IsNull then
              nLength := ColumSp.FieldByName('CHARACTER_MAXIMUM_LENGTH').AsInteger
            else
              nLength := 0;

            if not ColumSp.FieldByName('NUMERIC_PRECISION').IsNull then
              nPrecision := ColumSp.FieldByName('NUMERIC_PRECISION').AsInteger
            else
              nPrecision := 0;
            FieldData.nORDINAL_POSITION := ColumSp.FieldByName('ORDINAL_POSITION').AsInteger;
            Result.FieldList.Add(FieldData);
          end;

          ColumSp.Next;
        end;
      end
      else
        raise DyDBException.Create(format('Sp Not Found Error->[%s]', [SpName]));

      ColumSp.Close;
      ColumSp.Prepared := False;
    finally
      FreeAndNil(ColumSp);
    end;
  except
    on e: exception do
    begin
      DBWriteLog(e.Message);
      raise;
    end;
  end;
end;

{ TColumData }

constructor TColumData.Create;
begin
  FieldList := TObjectList<TFieldData>.Create(TFieldDataCompare.Construct(
    function(const L, R: TFieldData): integer
    begin
      if L.nORDINAL_POSITION > R.nORDINAL_POSITION then
        Result := 1
      else if L.nORDINAL_POSITION < R.nORDINAL_POSITION then
        Result := -1
      else
        Result := 0;
    end));
end;

destructor TColumData.Destroy;
begin
  FieldList.Clear;
  FreeAndNil(FieldList);
  inherited Destroy;
end;

function TDynamicMSSQL.ExistsSpColum(Value: string): TColumData;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ColumList.Count - 1 do
  begin
    if TColumData(ColumList.Items[i]).sSpName = Value then
    begin
      Result := TColumData(ColumList.Items[i]);
      Break;
    end;
  end;
end;

function TDynamicMSSQL.GetActive: Boolean;
begin
  Result := bActive;
end;

procedure TDynamicMSSQL.SetDBPort(Value: Integer);
begin
  if Value = 0 then
    nDBPort := 1433
  else
    nDBPort := Value;
end;

procedure TDynamicMSSQL.SetDBPort2(Value: Integer);
begin
  if Value = 0 then
    nDBPort2 := 1433
  else
    nDBPort2 := Value;
end;

function TDynamicMSSQL.GetDBPort: integer;
begin
  Result := nDBPort;
end;

function TDynamicMSSQL.GetDBPort2: integer;
begin
  Result := nDBPort2;
end;

procedure TDynamicMSSQL.DisConnect;
begin
  SetConnect(False);
end;

function TDynamicMSSQL.ExecuteCmd(StrValue: string): boolean;
var
  AdoCmd: TADOCommand;
begin
  Result := False;
  WriteLogger(StrValue);
  init;
  AdoCmd := TADOCommand.Create(Self);
  case AdoCon.InTransaction of
    True:
      AdoCmd.Connection := AdoCon;
    False:
      AdoCmd.ConnectionString := GetConnectString;
  end;
  try
    try
      AdoCmd.CommandText := StrValue;
      AdoCmd.Prepared := True;
      AdoCmd.Execute;
      if AdoCmd.Connection = AdoCon then
        if AdoCon.Errors.Count > 0 then
          raise Exception.Create(AdoCon.Errors.Item[AdoCon.Errors.Count - 1].Description);
      Result := True;
      AdoCmd.Prepared := False;
    finally
      FreeAndNil(AdoCmd);
    end;
  except
    on e: exception do
    begin
      DBWriteLog(e.Message);
      DBWriteLog(StrValue);
    end;
  end;
end;

procedure TDynamicMSSQL.SetParameters(Adosp: TADOStoredProc; Data: array of const);
var
  i: integer;
begin

  for i := 0 to High(Data) do
    if Adosp.Parameters.Count - 1 >= i + 1 then
      case Data[i].VType of
        vtInteger:
          Adosp.Parameters.Items[i + 1].Value := Data[i].VInteger;
        vtBoolean:
          Adosp.Parameters.Items[i + 1].Value := Data[i].VBoolean;
        vtChar:
          Adosp.Parameters.Items[i + 1].Value := Data[i].VChar;
        vtExtended:
          Adosp.Parameters.Items[i + 1].Value := Data[i].VExtended^;
        vtString:
          Adosp.Parameters.Items[i + 1].Value := Data[i].VString^;
        vtWideString:
          Adosp.Parameters.Items[i + 1].Value := string(Data[i].VWideString);
        vtAnsiString:
          Adosp.Parameters.Items[i + 1].Value := string(Data[i].VAnsiString);
        vtVariant:
          Adosp.Parameters.Items[i + 1].Value := Data[i].VVariant^;
        vtInt64:
          Adosp.Parameters.Items[i + 1].Value := Data[i].VInt64^;
        vtCurrency:
          Adosp.Parameters.Items[i + 1].Value := Data[i].VCurrency^;
        vtWideChar:
          Adosp.Parameters.Items[i + 1].Value := Data[i].VWideChar;
        {$IFDEF UNICODE}
        vtUnicodeString:
          Adosp.Parameters.Items[i + 1].Value := Unicodestring(Data[i].vUnicodeString);
        {$ELSE}
        vtUnicodeString:
          Adosp.Parameters.Items[i + 1].Value := string(Data[i].vUnicodeString);
        {$ENDIF}
      end;
end;

procedure TDynamicMSSQL.SetUserID(V: string);
begin
  FCheckLogger := V <> EmptyStr;
  if FCheckLogger then
    FUserID := V;
end;

function TDynamicMSSQL.ExecuteOpen(SqlQry: string): TDBQuery;
begin
  WriteLogger(SqlQry);
  init;
  Result := TDBQuery.Create(Self);
  Result.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(Result);
  try
    Result.SQL.Text := SqlQry;
    Result.Prepared := True;
    Result.Open;
    CheckError(Result);
  except
    on e: exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog(FErrMsg);
      FreeAndNil(Result);
    end;
  end;

  if FErrMsg <> '' then
    raise DyDBException.Create(format('Execute Error !->%s', [FErrMsg]));
end;

function TDynamicMSSQL.ExecuteOpen(Formatstring: string; Data: array of const): TDBQuery;
begin
  WriteLogger(Format(Formatstring, Data));
  init;
  Result := TDBQuery.Create(Self);
  Result.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(Result);
  try
    Result.SQL.Text := Format(Formatstring, Data);
    Result.Prepared := True;
    Result.Open;
    CheckError(Result);
  except
    on e: exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog(FErrMsg);
      FreeAndNil(Result);
    end;
  end;

  if FErrMsg <> '' then
    raise DyDBException.Create(format('Execute Error !->%s', [FErrMsg]));
end;

function TDynamicMSSQL.ExecuteCmd(Formatstring: string; Data: array of const): boolean;
var
  AdoCmd: TADOCommand;
  sTmp: string;
begin
  Result := False;
  sTmp := Format(Formatstring, Data);
  WriteLogger(sTmp);
  init;
  AdoCmd := TADOCommand.Create(Self);
  case AdoCon.InTransaction of
    True:
      AdoCmd.Connection := AdoCon;
    False:
      AdoCmd.ConnectionString := GetConnectString;
  end;
  AdoCmd.CommandTimeout := AdoCon.CommandTimeout;
  try
    try
      AdoCmd.CommandText := sTmp;
      AdoCmd.Prepared := True;
      AdoCmd.Execute;
      if AdoCmd.Connection = AdoCon then
        if AdoCon.Errors.Count > 0 then
          raise Exception.Create(AdoCon.Errors.Item[AdoCon.Errors.Count - 1].Description);
      Result := True;
      AdoCmd.Prepared := False;
    finally
      FreeAndNil(AdoCmd);
    end;
  except
    on e: exception do
    begin
      FErrMsg := e.Message;
      DBWriteLog(FErrMsg);
      DBWriteLog(sTmp);
    end;
  end;
end;

{$HINTS OFF}
procedure TDynamicMSSQL.ADD_DBHISLogger(sAGENTID, sCUSTNO, sPEERIP, sCMDNM,
  sCMD: string; nRECORDCOUNT: Integer; sCALLERID, sCALLERNAME: string);
const
  _USP_ADD_DBS_HIS = 'USP_ADD_DBS_HIS';
var
  AdoSP: TDBStoredProc;
begin
  if FCheckLogger then
  begin
    init;
    AdoSP := TDBStoredProc.Create(Self);
    SetCustomConnection(AdoSP);
    AdoSP.CommandTimeout := AdoCon.CommandTimeout;

    try
      try
        AdoSP.ProcedureName := _USP_ADD_DBS_HIS;
        AdoSP.Parameters.Clear;
        AdoSP.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, Null);
        AdoSP.Parameters.CreateParameter('@AGENTID', ftString, pdInput, 10, sAGENTID);
        AdoSP.Parameters.CreateParameter('@CUSTNO', ftString, pdInput, 20, sCUSTNO);
        AdoSP.Parameters.CreateParameter('@PEERIP', ftString, pdInput, 20, sPEERIP);
        AdoSP.Parameters.CreateParameter('@CMDNM', ftString, pdInput, 50, sCMDNM);
        AdoSP.Parameters.CreateParameter('@CMD', ftString, pdInput, 4000, sCMD);
        AdoSP.Parameters.CreateParameter('@RECORDCOUNT', ftInteger, pdInput, 0, nRECORDCOUNT);
        AdoSP.Parameters.CreateParameter('@CALLERID', ftString, pdInput, 10, sCALLERID);
        AdoSP.Parameters.CreateParameter('@CALLERNAME', ftString, pdInput, 30, sCALLERNAME);
        AdoSP.Prepared := True;
        AdoSP.ExecProc;
      except
        on e: Exception do
        begin
          FErrMsg := e.Message;
          DBWriteLog(FErrMsg);
        end;
      end;
    finally
      FreeAndNil(AdoSP);
    end;
  end;
end;

function TDynamicMSSQL.BeginTran: boolean;
begin
  Result := False;
  try
    Connect;
    if Connected then
    begin
      AdoCon.BeginTrans;
      Result := True;
    end
    else
      raise Exception.Create('Connection Error');
  except
    on e: Exception do
    begin
      FErrMsg := E.Message;
      DBWriteLog(FErrMsg);
      raise;
    end;
  end;
end;
{$HINTS ON}

procedure TDynamicMSSQL.CheckError(V: TCustomADODataSet);
begin
  if V.Connection = AdoCon then
  begin
    if AdoCon.Errors.Count > 0 then
    begin
      raise Exception.Create(AdoCon.Errors.Item[AdoCon.Errors.Count - 1].Description);
    end;
  end;
end;

procedure TDynamicMSSQL.CheckLogger(V: TADOStoredProc);
const
  _CUSTNO = 'CUSTNO';
  _AGENTID = 'AGENTID';
  _NAME = 'NAME';
var
  i: Integer;
  sCustID, sCALLERID, sCALLERNAME : string;
begin
  sCustID := '';
  sCALLERID := '';
  sCALLERNAME := '';

  if FLogerProcList.IndexOf(UpperCase(V.ProcedureName)) > -1 then
  begin
    if V.RecordCount = 1 then
    begin
      for i := 0 to V.FieldCount - 1 do
      begin
        if UpperCase(V.Fields[i].FieldName) = _CUSTNO then
        begin
          sCustID := V.Fields[i].AsString;
        end;

        if UpperCase(V.Fields[i].FieldName) = _AGENTID then
        begin
          sCALLERID := V.Fields[i].AsString;
        end;

        if UpperCase(V.Fields[i].FieldName) = _NAME then
        begin
          sCALLERNAME := V.Fields[i].AsString;
        end;
      end;
    end;

    ADD_DBHISLogger(FUserID
                   ,sCustID
                   ,FLocalIP
                   ,V.ProcedureName
                   ,CreateExecuteString(V)
                   ,V.RecordCount
                   ,sCALLERID
                   ,sCALLERNAME);
  end
  else
    WriteLogger(V);
end;

{$HINTS OFF}
function TDynamicMSSQL.Commit: boolean;
begin
  Result := False;
  try
    if AdoCon.InTransaction then
      AdoCon.CommitTrans;
    Result := True;
  except
    on e: Exception do
    begin
      FErrMsg := E.Message;
      DBWriteLog(FErrMsg);
      raise;
    end;
  end;
end;
{$HINTS ON}

function TDynamicMSSQL.Rollback: boolean;
begin
  Result := False;
  try
    if AdoCon.InTransaction then
      AdoCon.RollbackTrans;
    Result := True;
  except
    on e: Exception do
    begin
      FErrMsg := E.Message;
      DBWriteLog(FErrMsg);
    end;
  end;
end;

function TDynamicMSSQL.GetConnectionTimeout: Integer;
begin
  Result := FConnectionTimeout;
end;

procedure TDynamicMSSQL.SetConnectionTimeout(Value: Integer);
begin
  FConnectionTimeout := Value;
end;

procedure TDynamicMSSQL.SetCustomConnection(V: TCustomADODataSet);
begin
  case GetConnected of
    True:
      begin
        V.Connection := AdoCon;
      end;
    False:
      begin
        V.ConnectionString := GetConnectString;
      end;
  end;
end;

function TDynamicMSSQL.StrToNumFieldType(Value: string): TFieldType;
begin
  if Value = 'bigint' then
    Result := ftLargeint
  else if Value = 'binary' then
    Result := ftVarBytes
  else if Value = 'bit' then
    Result := ftboolean//ftBytes
  else if Value = 'char' then
    Result := ftString
  else if Value = 'datetime' then
    Result := ftDateTime
  else if Value = 'decimal' then
    Result := ftBCD
  else if Value = 'float' then
    Result := ftFloat
  else if Value = 'image' then
    Result := ftVarBytes
  else if Value = 'int' then
    Result := ftInteger
  else if Value = 'Money' then
    Result := ftBCD
  else if Value = 'nchar' then
    Result := ftWideString
  else if Value = 'ntext' then
    Result := ftWideString
  else if Value = 'numeric' then
    Result := ftBCD
  else if Value = 'nvarchar' then
    Result := ftWideString
  else if Value = 'real' then
    Result := ftFloat
  else if Value = 'smalldatetime' then
    Result := ftDateTime
  else if Value = 'smallint' then
    Result := ftSmallint
  else if Value = 'smallmoney' then
    Result := ftBCD
  else if Value = 'sql_variant' then
    Result := ftVariant
  else if Value = 'text' then
    Result := ftString
  else if Value = 'timestamp' then
    Result := ftVarBytes
  else if Value = 'tinyint' then
    Result := ftWord
  else if Value = 'uniqueidentelse ifier' then
    Result := ftGuid
  else if Value = 'varbinary' then
    Result := ftVarBytes
  else if Value = 'varchar' then
    Result := ftString
  else if Value = 'xml' then
    Result := ftWideString
  else
    Result := ftUnknown;
end;

procedure TDynamicMSSQL.WriteLogger(V: string);
const
  _USP_WRITELOG = 'USP_WRITELOG';
var
  AdoSP: TDBStoredProc;
begin
  if FCheckLogger then
  begin
    init;
    AdoSP := TDBStoredProc.Create(Self);
    SetCustomConnection(AdoSP);
    AdoSP.CommandTimeout := AdoCon.CommandTimeout;
    try
      try
        AdoSP.ProcedureName := _USP_WRITELOG;
        AdoSP.Parameters.Clear;
        AdoSP.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, Null);
        AdoSP.Parameters.CreateParameter('@LOGDATA', ftString, pdInput, 5000, V);
        AdoSP.Prepared := True;
        AdoSP.ExecProc;
      except
        on e: Exception do
        begin
          FErrMsg := e.Message;
          DBWriteLog(FErrMsg);
        end;
      end;
    finally
      FreeAndNil(AdoSP);
    end;
  end;
end;

procedure TDynamicMSSQL.WriteLogger(V: TADOStoredProc);
var
  Data: string;
begin
  Data := Format('[USER:%s][IP:%s][ExecuteCMD:%s]', [FUSERID, FLocalIP, CreateExecuteString(V)]);
  WriteLogger(Data);
end;

function TDynamicMSSQL.SP_ExecuteCmd(const sSp_Name: string; Data: array of const): Boolean;
var
  AdoSP: TDBStoredProc;
begin
  Result := False;
  AdoSP := TDBStoredProc.Create(Self);
  SetCustomConnection(AdoSP);
  AdoSP.CommandTimeout := AdoCon.CommandTimeout;
  try
    try
      if Sp_GetColum(AdoSP, sSp_Name) then
      begin
        SetParameters(AdoSP, Data);
        AdoSP.Prepared := True;
       {$IFDEF DEBUG}
        DBWriteLog(CreateExecuteString(AdoSP));
       {$ENDIF}
        WriteLogger(AdoSP);
        init;
        AdoSP.ExecProc;
        CheckError(AdoSP);
        Result := True;
      end;
    except
      on e: Exception do
      begin
        FErrMsg := e.Message;
        DBWriteLog(FErrMsg);
  //         DBWriteLog('TDynamicMSSQL.SP_ExecuteCmd' + FErrMsg);
        DBWriteLog(CreateExecuteString(AdoSP));
      end;
    end;
  finally
    FreeAndNil(AdoSP);
  end;
end;

procedure TDynamicMSSQL.SetErrMsg(V: string);
begin
  FErrMsg := V;
end;

function TDynamicMSSQL.GetMakeQuery: TDBQuery;
begin
  Result := TDBQuery.Create(Self);
  Result.CommandTimeout := AdoCon.CommandTimeout;
  SetCustomConnection(Result);
end;

procedure TDynamicMSSQL.init;
const
  ADOCONERROR = -2147467259; //
var
  i: integer;
begin
  FErrMsg := '';
  FCS.Acquire;
  try
    if Connected then
    begin //DB 연결 오류 발생했을 시 체크해서 재연결 한다.
      if AdoCon.Errors.Count > 0 then
      begin
        for i := 0 to AdoCon.Errors.Count - 1 do
        begin
          if AdoCon.Errors.Item[i].Number = ADOCONERROR then
          begin
            SetConnect(False);
            SetConnect(True);
            Break;
          end;
        end;
        AdoCon.Errors.Clear;
      end;
    end;
  finally
    FCS.Release;
  end;
end;

function TDynamicMSSQL.GetMakeCmd: TDBCMD;
begin
  Result := TDBCMD.Create(Self);
  Result.CommandTimeout := AdoCon.CommandTimeout;
  case AdoCon.InTransaction of
    True:
      Result.Connection := AdoCon;
    False:
      Result.ConnectionString := GetConnectString;
  end;
end;

procedure TDynamicMSSQL.Connect;
begin
  SetConnect(True);
end;

{ TDBQuery }

destructor TDBQuery.Destroy;
begin
  if Prepared then
    Prepared := False;
  if Active then
    Close;
  inherited Destroy;
end;

{ TDBStoredProc }

destructor TDBStoredProc.Destroy;
begin
  if Prepared then
    Prepared := False;
  if Active then
    Close;
  inherited Destroy;
end;

{ TDBCMD }

destructor TDBCMD.Destroy;
begin
  if Prepared then
    Prepared := False;
  inherited Destroy;
end;

{ TCustomDBStoredProc }

procedure TCustomDBStoredProc.ExecProc;
begin
  try
    inherited ExecProc;
  except
    on e: exception do
    begin
      if Assigned(Owner) then
        if Owner is TDynamicMSSQL then
          TDynamicMSSQL(Owner).CreateExecuteString(Self);
      raise;
    end;
  end;
end;

end.
