unit MBInterfaces;

{$mode objfpc}{$H+}

interface

uses Classes,
     MBDefine;
type

  // интерфейс построителя пакетов для запросов
  IBuilderPacket = interface
  ['{A74194AF-D598-4E18-8971-5860E388F800}']
    function  GetPacket       : Pointer; stdcall;
    function  GetPacketLen    : WORD; stdcall;
    function  GetResponseSize : WORD; stdcall;
    function  GetBuilderType  : TBuilderTypeEnum; stdcall;
    procedure Build;
  end;

  IBuilderRTUPacket = interface(IBuilderPacket)
  ['{83D25490-1597-4FF5-BF0C-DBD23765C48C}']
    function  GetDeviceID     : Byte; stdcall;
    function  GetFunctionCode : Byte; stdcall;
    procedure SetQuantity(const Value: Word); stdcall;
    procedure SetStartingAddress(const Value: Word); stdcall;
    procedure SetDeviceAddress(const Value: Byte); stdcall;
  end;

  IBuilderTCPPacket = interface(IBuilderRTUPacket)
  ['{4B6F4A0F-57EC-4CB7-A8EE-68CBDF6AB629}']
    procedure SetTransactionID(const Value: Word); stdcall;
    procedure SetProtocolID(const Value: Word); stdcall;
    function  GetTransactionID : Word; stdcall;
    function  GetProtocolID    : Word; stdcall;
    function  GetLen           : Word; stdcall;
  end;

  IBuilderTCPAnswerPacket = interface(IBuilderTCPPacket)
  ['{53F7A8F6-601F-4FEC-9DCE-D1C4B5279CA6}']
   procedure SetFunctionNumber(const Value : TMBFunctionsEnum); stdcall;
  end;

  IBuilderTCPErrorAnswer = interface(IBuilderTCPAnswerPacket)
  ['{37D63058-D21B-4D79-835F-374CB2AE9943}']
   procedure SetErrorCode(const Value : Byte); stdcall;
  end;

  IBuilderTCPBitAnswerPacket =interface(IBuilderTCPAnswerPacket)
  ['{860760C9-607D-4C76-8BDA-85D6DFC4CD34}']
    procedure SetBitData(const BitList : TBits); stdcall;
  end;

  IBuilderTCPWordAnswerPacket =interface(IBuilderTCPAnswerPacket)
  ['{2980A565-30F2-426B-889D-444FA2234CB9}']
    procedure SetWordData(const WordList : TWordRegsValues); stdcall;
  end;

  // интерфейс для записи  результатов чтения из порта
  IReaderPacket = interface
  ['{DB48AE37-11BC-4780-9BAB-DBFEA4473533}']
   function  GetReaderType : TReaderTypeEnum; stdcall;
   procedure Response(Buff : Pointer; BuffSize : Cardinal); stdcall;
   function  GetRegisterCount: Word; stdcall;
   function  GetLastErrorCode : Cardinal; stdcall;
  end;

  IReaderRTUPacket = interface(IReaderPacket)
  ['{CCC7943E-4EEC-49CB-8906-2DF66B34970C}']
   function  GetDeviceAddress  : Byte; stdcall;
   function  GetFunctionCode   : Byte; stdcall;
  end;

  IReaderTCPPacket = interface(IReaderRTUPacket)
  ['{29D26628-B03A-4B74-8DFC-7DBBDB898A65}']
    function  GetTransactionID : Word; stdcall;
    function  GetProtocolID    : Word; stdcall;
    function  GetLen           : Word; stdcall;
  end;

  // интерфейс Modbus тразакции
  IMBTransactions = interface
  ['{57933433-6E71-4CC8-9565-3C2C4ED5CF68}']
   function GetReaderItf  : IReaderPacket; stdcall;
   function GetBuilderItf : IBuilderPacket; stdcall;
  end;

  // интерфейс для чтения входящих серверных запросов
  IMBReuqestReader = interface
  ['{E2CECDE0-1ABF-465B-B4AA-977D66F4B6F2}']
    function  GetReaderType    : TReaderTypeEnum; stdcall;
    function  GetDeviceAddress : Byte; stdcall;
    function  GetFunctionCode  : Byte; stdcall;
    function  GetErrorCode     : Cardinal; stdcall;
    function  GetMessage       : String; stdcall;
    function  GetPacketData(out DataSize : Cardinal): Pointer; stdcall;
    procedure RequestRead(Packet : Pointer; PacketSize : Cardinal); stdcall;
  end;

  IMBRTUReuqestReader = interface(IMBReuqestReader)
  ['{EA3A1437-5B1F-4925-90A0-8E41A6F40BE1}']
   function GetPacketCRC : Word; stdcall;
  end;

  IMBTCPReuqestReader = interface(IMBReuqestReader)
  ['{ABC31F6E-0DE1-4828-B113-A59B0F76F83B}']
   function  GetTransactionID : Word; stdcall;
   function  GetProtocolID    : Word; stdcall;
   function  GetLen           : Word; stdcall;
  end;

implementation

end.
