unit MBRTUObjItf;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     MBDefine;

type
  IMBMasterItf = interface
  ['{3341B9CB-0F8D-4B05-8F09-2B8958B9C45E}']
   procedure ProcessBitRegChangesPackage(AFunction : Byte; AStartAddr : Word; AQantity : Word; AData : array of Byte);
   procedure ProcessWordRegChangesPackage(AFunction : Byte; AStartAddr : Word; AQantity : Word; AData : array of Word);
   procedure Process4314ResultPackage(AFunction: Byte; ASubFunction: Byte; AData : array of Byte; ADataLen : Word);
   procedure SendEvent(EvType : TMBDispEventEnum; Code1  : Cardinal = 0; Code2  : Cardinal = 0);
  end;

implementation

end.

