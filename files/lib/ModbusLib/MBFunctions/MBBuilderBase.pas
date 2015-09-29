unit MBBuilderBase;

{$mode objfpc}{$H+}

interface

uses Classes,
     MBInterfaces, MBDefine;

type
  TBuilderEventType = (betBuild, betRead);

  TBuilderPacketBase = class(TInterfacedObject, IBuilderPacket)
   protected
    FLenPacket     : WORD;
    FPacket        : Pointer;
    FBuilderType   : TBuilderTypeEnum;
    FOnPacketBuild : TNotifyEvent;
    FOnPacketRead  : TNotifyEvent;
    function  GetPacket       : Pointer; virtual; stdcall; abstract;
    function  GetPacketLen    : WORD; virtual; stdcall; abstract;
    function  GetResponseSize : WORD; virtual; stdcall; abstract;
    function  GetBuilderType  : TBuilderTypeEnum; stdcall;
   public
    constructor Create; virtual;
    procedure Build; virtual; abstract;
    property BuilderType   : TBuilderTypeEnum read GetBuilderType;
    property LenPacket     : WORD read GetPacketLen;
    property Packet        : Pointer read GetPacket;
    property OnPacketBuild : TNotifyEvent read FOnPacketBuild write FOnPacketBuild;
    property OnPacketRead  : TNotifyEvent read FOnPacketRead write FOnPacketRead;
  end;

  TBuilderPacketClass = class of TBuilderPacketBase;

implementation

{ TBuilderPacketBase }

constructor TBuilderPacketBase.Create;
begin
  FLenPacket := 0;
  FPacket    := nil;
  FBuilderType   := btUnknown;
  FOnPacketBuild := nil;
  FOnPacketRead  := nil;
end;

function TBuilderPacketBase.GetBuilderType: TBuilderTypeEnum; stdcall;
begin
  Result := FBuilderType;
end;

end.
