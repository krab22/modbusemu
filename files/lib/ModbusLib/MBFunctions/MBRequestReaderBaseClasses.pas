unit MBRequestReaderBaseClasses;

{$mode objfpc}{$H+}

interface

uses Classes,
     MBInterfaces,MBDefine;

type
  TMBRequestReaderBase = class(TInterfacedObject,IMBReuqestReader)
   protected
    FPacket         : Pointer;
    FPacketSize     : Cardinal;
    FReaderType     : TReaderTypeEnum;
    FDeviceAddress  : Byte;
    FFunctionCode   : Byte;
    FErrorCode      : Cardinal;
    FMessage        : String;
    FOnError        : TNotifyEvent;
    FOnReadEnd      : TNotifyEvent;
    FOnReadStart    : TNotifyEvent;

    function  GetReaderType    : TReaderTypeEnum; stdcall;
    function  GetDeviceAddress : Byte; stdcall;
    function  GetFunctionCode  : Byte; stdcall;
    function  GetErrorCode     : Cardinal; stdcall;
    function  GetMessage       : String; stdcall;

    procedure Notify(EventType : TReadPacketEventType ;AMessage : String = ''); virtual;
    procedure FreePacket; virtual;
    procedure CopyPacket(Buff : Pointer; BuffSize : Cardinal);
  public
    constructor Create; virtual;
    destructor  Destroy; override;
    function  GetPacketData(out DataSize : Cardinal): Pointer; virtual; stdcall; abstract;
    procedure RequestRead(Packet : Pointer; PacketSize : Cardinal); virtual; stdcall; abstract;

    property ReaderType    : TReaderTypeEnum read GetReaderType;
    property DeviceAddress : Byte read GetDeviceAddress;
    property FunctionCode  : Byte read GetFunctionCode;
    property ErrorCode     : Cardinal read GetErrorCode;
    property MBMessage     : String read GetMessage;
    property OnError       : TNotifyEvent read FOnError write FOnError;
    property OnReadEnd     : TNotifyEvent read FOnReadEnd write FOnReadEnd;
    property OnReadStart   : TNotifyEvent read FOnReadStart write FOnReadStart;
  end;

implementation

uses SysUtils;

{ TMBRequestReaderBase }

constructor TMBRequestReaderBase.Create;
begin
  inherited;
  FPacket        := nil;
  FPacketSize    := 0;
  FReaderType    := rtUnknown;
  FDeviceAddress := 0;
  FFunctionCode  := 0;
  FErrorCode     := 0;
  FMessage       := '';
end;

destructor TMBRequestReaderBase.Destroy;
begin
  FreePacket;
  inherited;
end;

procedure TMBRequestReaderBase.CopyPacket(Buff: Pointer; BuffSize: Cardinal);
begin
  if FPacket<>nil then FreePacket;
  FPacket     := AllocMem(BuffSize);
  FPacketSize := BuffSize;
  Move(Buff^,FPacket^,BuffSize);
end;

procedure TMBRequestReaderBase.FreePacket;
begin
  if FPacket = nil then Exit;
  FreeMem(FPacket);
  FPacket         := nil;
  FPacketSize     := 0;
  FDeviceAddress  := 0;
  FFunctionCode   := 0;
  FErrorCode      := 0;
  FMessage        := '';
end;

function TMBRequestReaderBase.GetDeviceAddress: Byte; stdcall;
begin
  Result := FDeviceAddress;
end;

function TMBRequestReaderBase.GetErrorCode: Cardinal; stdcall;
begin
  Result := FErrorCode;
end;

function TMBRequestReaderBase.GetFunctionCode: Byte; stdcall;
begin
  Result := FFunctionCode;
end;

function TMBRequestReaderBase.GetMessage: String; stdcall;
begin
  Result := FMessage;
end;

function TMBRequestReaderBase.GetReaderType: TReaderTypeEnum; stdcall;
begin
  Result := FReaderType;
end;

procedure TMBRequestReaderBase.Notify(EventType: TReadPacketEventType; AMessage: String);
begin
  case EventType of
   rpError     : begin
                  FMessage:=AMessage;
                  if Assigned(FOnError) then FOnError(Self);
                 end;
   rpEndRead   : begin
                  if Assigned(FOnReadEnd) then FOnReadEnd(Self);
                 end;
   rpStartRead : begin
                  if Assigned(FOnReadStart) then FOnReadStart(Self);
                 end;
  end;
end;

end.
 
