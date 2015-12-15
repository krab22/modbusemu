unit MBEmuLoaderClasses;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, syncobjs,
     MBDeviceClasses,
     DeviceView,
     LoggerItf,
     ChennelRSClasses, ChennelTCPClasses,
     NativeXml;

type

  { TMBEmuLoader }

  TMBEmuLoader = class(TObjectLogged)
   private
    FDevList         : TStrings;
    FDevArray        : PDeviceArray;
    FDevFormArray    : PDevFormArray;
    FChannelList     : TStrings;
    FCSection        : TCriticalSection;
    FOnDevChangeProc : TNotifyEvent;
    procedure SaveChannels(AChannelsNode : TXmlNode);
    procedure SaveChannelRS(AChannelsNode : TXmlNode;AChannel : TChennelRS; ADescr : String);
    procedure SaveChannelTCP(AChannelsNode : TXmlNode;AChannel : TChennelTCP; ADescr : String);

    procedure SaveDevices(ADevicesNode : TXmlNode);
   public
    constructor Create(ADevList         : TStrings;
                       ADevArray        : PDeviceArray;
                       ADevFormArray    : PDevFormArray;
                       AChannelList     : TStrings;
                       ACSection        : TCriticalSection;
                       AOnDevChangeProc : TNotifyEvent); virtual;
    destructor  Destroy; override;

    procedure SaveConfig(AFileName : String);
    procedure LoadConfig(AFileName : String);
  end;

implementation

uses ExceptionsTypes,
     {$IFDEF WINDOWS}
     LazFileUtils,
     LazUTF8,
     {$ENDIF}
     MBEmuXMLConst,
     COMPortParamTypes;

{ TMBEmuLoader }

constructor TMBEmuLoader.Create(ADevList         : TStrings;
                                ADevArray        : PDeviceArray;
                                ADevFormArray    : PDevFormArray;
                                AChannelList     : TStrings;
                                ACSection        : TCriticalSection;
                                AOnDevChangeProc : TNotifyEvent);
begin
  FDevList         := ADevList;
  FDevArray        := ADevArray;
  FDevFormArray    := ADevFormArray;
  FChannelList     := AChannelList;
  FCSection        := ACSection;
  FOnDevChangeProc := AOnDevChangeProc;
end;

destructor TMBEmuLoader.Destroy;
begin
  inherited Destroy;
end;

procedure TMBEmuLoader.SaveConfig(AFileName : String);
var TempDoc  : TNativeXml;
    TempNode : TXmlNode;
begin
  if AFileName = '' then raise Exception.Create('Не задано имя файла для сохранения');
  TempDoc := TNativeXml.Create(nil);
  try
   TempDoc.ExternalEncoding := seUTF8;
   TempDoc.XmlFormat := xfReadable;
   TempDoc.Root.Name := csNodeRoot;

   TempNode := TempDoc.Root.NodeNew(csNodeChannels);
   SaveChannels(TempNode);

   TempNode := TempDoc.Root.NodeNew(csNodeDevices);
   SaveDevices(TempNode);

   TempDoc.SaveToFile({$IFDEF UNIX}AFileName{$ELSE}UTF8ToSys(AFileName){$ENDIF});
  finally
   FreeAndNil(TempDoc);
  end;
end;

procedure TMBEmuLoader.LoadConfig(AFileName : String);
begin

end;

procedure TMBEmuLoader.SaveChannels(AChannelsNode : TXmlNode);
var TempChannel : TObject;
    i, Count    : Integer;
begin
  Count := FChannelList.Count-1;
  for i := 0 to Count do
   begin
    TempChannel := FChannelList.Objects[i];
    if TempChannel.ClassType = TChennelRS then SaveChannelRS(AChannelsNode,TChennelRS(TempChannel),FChannelList.Strings[i]);
    if TempChannel.ClassType = TChennelTCP then SaveChannelTCP(AChannelsNode,TChennelTCP(TempChannel),FChannelList.Strings[i]);
   end;
end;

procedure TMBEmuLoader.SaveChannelRS(AChannelsNode : TXmlNode; AChannel : TChennelRS; ADescr : String);
var TempNode    : TXmlNode;
begin
  TempNode := AChannelsNode.NodeNew(csNodeChannel);
  TempNode.AttributeAdd(csAttrName,AChannel.Name);
  TempNode.AttributeAdd(csAttrType,csTypeRS);
  TempNode.AttributeAdd(csAttrDescr,ADescr);
  {$IFDEF UNIX}
  if AChannel.PortPrefix = pptLinux then TempNode.AttributeAdd(csAttrPref,cCOMPrefixPathLinux);
  if AChannel.PortPrefix = pptOther then
   begin
    TempNode.AttributeAdd(csAttrPref,cCOMPrefixPathLinuxOther);
    TempNode.AttributeAdd(csAttrPrefOther,AChannel.PortPrefixOther);
   end;
  {$ELSE}
   if AChannel.PortPrefix = pptWindows then TempNode.AttributeAdd(csAttrPref,cCOMPrefixPathWindows);
  {$ENDIF}
  TempNode.AttributeAdd(csAttrPort, IntToStr(AChannel.PortNum));
  TempNode.AttributeAdd(csAttrBauRate, GetBaudRateStrFromID(AChannel.BaudRate));
  TempNode.AttributeAdd(csAttrByteSize, ComPortDataBitsNames[AChannel.ByteSize]);
  TempNode.AttributeAdd(csAttrParity, GetParityIDStrFromValue(AChannel.Parity));
  TempNode.AttributeAdd(csAttrStopBit, GetStopBitsIDStrFromValue1(AChannel.StopBits));
end;

procedure TMBEmuLoader.SaveChannelTCP(AChannelsNode : TXmlNode; AChannel : TChennelTCP; ADescr : String);
var TempNode    : TXmlNode;
begin
  TempNode := AChannelsNode.NodeNew(csNodeChannel);
  TempNode.AttributeAdd(csAttrName,AChannel.Name);
  TempNode.AttributeAdd(csAttrType,csTypeTCP);
  TempNode.AttributeAdd(csAttrDescr,ADescr);
  TempNode.AttributeAdd(csAttrAddres,AChannel.BindAddress);
  TempNode.AttributeAdd(csAttrPort,IntToStr(AChannel.Port));
end;

procedure TMBEmuLoader.SaveDevices(ADevicesNode : TXmlNode);
var TempNode   : TXmlNode;
    TempAttr   : TsdAttribute;
    TempDevice : TMBDevice;
begin

end;

end.

