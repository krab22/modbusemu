{
$Author: npcprom\fomin_k $
$Date: 2014-04-21 08:42:52 +0600 (Mon, 21 Apr 2014) $
$Rev: 263 $
}
unit MBReaderBase;

{$mode objfpc}{$H+}

interface

uses Classes,
     MBInterfaces, MBDefine;

type
   

   TReaderBase = class(TInterfacedObject, IReaderPacket)
    protected
     FErrorCode      : Cardinal;
     FMessage        : String;
     FReaderType     : TReaderTypeEnum;
     FOnError        : TNotifyEvent;
     FOnReadEnd      : TNotifyEvent;
     FOnReadStart    : TNotifyEvent;
     procedure Notify(EventType : TReadPacketEventType ;AMessage : String = ''); virtual; stdcall; abstract;
     function  GetRegisterCount: Word; virtual; stdcall; abstract;
     function  GetReaderType : TReaderTypeEnum; stdcall;
    public
     constructor Create; virtual;
     procedure Response(Buff : Pointer; BuffSize : Cardinal); virtual; stdcall; abstract;
     function  GetLastErrorCode : Cardinal; virtual; stdcall;
     property ReadderType            : TReaderTypeEnum read GetReaderType;
     property ErrorCode              : Cardinal read FErrorCode;
     property EventMessage           : String read FMessage;
     property OnResponseError        : TNotifyEvent read FOnError write FOnError;
     property OnResponseReadEnd      : TNotifyEvent read FOnReadEnd write FOnReadEnd;
     property OnResponseReadStart    : TNotifyEvent read FOnReadStart write FOnReadStart;
   end;

   TReaderClass = class of TReaderBase;

implementation

{ TReaderBase }

constructor TReaderBase.Create;
begin
  FErrorCode  := 0;
  FMessage    := '';
  FReaderType := rtUnknown;
  FOnError    := nil;
  FOnReadEnd  := nil;
  FOnReadStart:= nil;
end;

function TReaderBase.GetLastErrorCode: Cardinal; stdcall;
begin
  Result:=FErrorCode;
end;

function TReaderBase.GetReaderType: TReaderTypeEnum; stdcall;
begin
  Result := FReaderType;
end;

end.