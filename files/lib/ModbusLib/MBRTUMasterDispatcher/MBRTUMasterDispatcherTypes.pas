unit MBRTUMasterDispatcherTypes;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     COMPortParamTypes;

type

  TMBPacket     = array of Byte;
  PMBPacket     = ^TMBPacket;

  TMBWordPacket = array of Word;
  PMBWordPacket = ^TMBWordPacket;

  TMBDispPortParam = record
   PortNum    : Byte;
   PortPrefix : String;
   BaudRate   : TComPortBaudRate;
   DataBits   : TComPortDataBits;
   StopBits   : TComPortStopBits;
   Parity     : TComPortParity;
  end;
  PMBDispPortParam = ^TMBDispPortParam;

implementation

end.

