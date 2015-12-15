unit MBEmuXMLConst;

{$mode objfpc}{$H+}

interface

const
  csNodeRoot     = 'modbusemu';
  csNodeChannels = 'channels';
  csNodeChannel  = 'channel';
  csNodeDevices  = 'devices';
  csNodeDevice   = 'device';

  csAttrType     = 'type';
  csAttrName     = 'name';
  csAttrDescr    = 'descr';
  csAttrAddres   = 'adress';
  csAttrPort     = 'port';
  csAttrPref     = 'prefix';
  csAttrPrefOther= 'prefother';
  csAttrBauRate  = 'baudrate';
  csAttrByteSize = 'bytesize';
  csAttrParity   = 'parity';
  csAttrStopBit  = 'stopbit';

  csTypeRS       = 'RS';
  csTypeTCP      = 'TCP';

implementation

end.

