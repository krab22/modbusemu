unit ExceptionsTypes;

{$mode objfpc}{$H+}

interface

uses SysUtils;

const
  ERR_BASE_PORT_ERROR                        = 50000;
  ERR_UNKNOWN                                = 59999;
  ERR_PORT_NOT_ASSIGNED                      = 50001;
  ERR_REQUEST_NOT_ASSIGNED                   = 50002;
  ERR_PORT_PARAM_NOT_ASSIGNED                = 50003;
  ERR_REQUEST_DATA_NOT_ASSIGNED              = 50004;
  ERR_RESIVE_PROC_NOT_ASSIGNED               = 50005;
  ERR_RESIVE_DATA_TIMEOUT                    = 50006;
  ERR_PORT_DATA_WRITE_TIMEOUT                = 50007;
  ERR_ITF_PORT_PARAM_TYPE                    = 50008;
  ERR_PORT_NOT_ACTIVE                        = 50009;
  ERR_CHANN_PARAM_NOT_ASSIGNED               = 50010;
  ERR_CHANNEL_ISNT_FOUND                     = 50011;
  ERR_PORT_PARITY_ERROR                      = 4;
  ERR_PORT_OPERATION_ABORTED                 = 995;
  DEV_ERROR_COMMAND_NOT_ASSIGNED             = 50012;
  DEV_LOAD_PARAM_XML_NOT_ASSIGN              = 50013;
  DEV_SAVE_PARAM_XML_NOT_ASSIGN              = 50014;
  ERR_DEVICE_NOT_ASSIGNED                    = 50015;
  ERR_CHANNEL_LIST_NOT_ASSIGNED              = 50016;
  ERR_XML_LOAD                               = 50017;
  ERR_XML_LOAD_DEV_TYPE                      = 50018;
  ERR_XML_LOAD_DEV_FNC_NOT_ASSIGN            = 50019;
  ERR_XML_LOAD_OUT_RANGE_ADDR                = 50020;
  ERR_XML_LOAD_OUT_RANGE_QUANT               = 50021;
  ERR_CHANN_PARAM_INVALID                    = 50022;
  ERR_PORT_PARAM_INVALID                     = 50023;
  ERR_ITF_PORT_PARAM_NOT_ASSIGN              = 50024;
  ERR_ITF_PORT_PARAM_INVALID                 = 50025;
  ERR_COMMAND_DEV_ITF_NOT_INIT               = 50026;
  ERR_COMMAND_SRV_PROT_NOT_MB_PROT           = 50027;
  ERR_COMMAND_MB_DEV_NOT_SET                 = 50028;
  ERR_COMMAND_CHANNEL_LIST_NOT_SET           = 50029;
  ERR_COMMAND_CHANNEL_LIST_IS_EMPTY          = 50030;
  ERR_MODBUS                                 = 50031;
  ERR_COMMAND_MB_DEV_NUM_NOT_SET             = 50032;
  ERR_COMMAND_IS_ANOVER_DEVICE               = 50033;
  ERR_CHANNEL_IS_NOT_ACTIVE                  = 50034;
  ERR_PROT_LOAD_PARAM_XML_NOT_ASSIGN         = 50035;
  ERR_PROT_DOES_NOT_SUPPORT_THIS_CMD         = 50036;
  ERR_CLASS_NOT_IMPLEMENTED                  = 50037;
  ERR_CMS_FILE_NOT_FOUND                     = 50038;
  ERR_CMS_LOAD_ERR_GET_CONF_PATH             = 50039;
  ERR_CMS_LOAD_ERR_CODE_PAGE                 = 50040;
  ERR_CMS_LOAD_ERR_ROOT_NAME                 = 50041;
  ERR_CMS_LOAD_ERR_HOST_LIST_NOT_FOUND       = 50042;
  ERR_CMS_LOAD_ERR_HOST_LIST_IS_EMPTY        = 50043;
  ERR_CMS_LOAD_ERR_IP_LIST_IS_EMPTY          = 50044;
  ERR_CMS_LOAD_ERR_HOST_TEG_NOT_FOUND        = 50045;
  ERR_CMS_LOAD_ERR_IDCS_TEG_NOT_FOUND        = 50046;
  ERR_CMS_LOAD_ERR_PROT_LIST_NOT_FOUND       = 50047;
  ERR_CMS_LOAD_ERR_SVR_PROT_LIST_NOT_FOUND   = 50048;
  ERR_CMS_LOAD_ERR_RMT_PROT_LIST_NOT_FOUND   = 50049;
  ERR_CMS_LOAD_ERR_CHAN_LIST_NOT_FOUND       = 50050;
  ERR_CMS_LOAD_ERR_SVR_CHAN_LIST_NOT_FOUND   = 50051;
  ERR_CMS_LOAD_ERR_RMT_CHAN_LIST_NOT_FOUND   = 50052;
  ERR_CMS_LOAD_ERR_SVR_DEV_LIST_NOT_FOUND    = 50053;
  ERR_CMS_LOAD_ERR_RMT_DEV_LIST_NOT_FOUND    = 50054;
  ERR_CMS_LOAD_ERR_MODULE_LIST_NOT_FOUND     = 50055;
  ERR_CMS_LOAD_ERR_RSMODBUSRTU_NOT_FOUND     = 50056;
  ERR_PROT_ID_MISSING                        = 50057;
  ERR_PROT_ID_REFERS_ANOTHER_PROT            = 50058;
  ERR_DEVICE_PARAM_INVALID                   = 50059;
  ERR_PROT_TYPE_IS_INCORRECT                 = 50060;
  ERR_PROT_NOT_SUPPORT                       = 50061;
  ERR_CMS_BAD_ID                             = 50062;
  ERR_PORT_DATA_WRITE                        = 50063;
  ERR_PORT_DATA_WAIT                         = 50064;
  ERR_PORT_DATA_READ                         = 50065;
  ERR_SYS_GET_MEM                            = 50066;
  ERR_RESIVE_DATA_NULL                       = 50067;
  ERR_OBJECT_NOT_ASSIGNED                    = 50068;
  ERR_OBJECT_PARAM_INVALID                   = 50070;
  ERR_OBJECT_LIST_NOT_ASSIGNED               = 50071;
  ERR_OBJECT_LIST_PARAM_INVALID              = 50072;
  ERR_XML_LOAD_OUT_RANGE_ID                  = 50073;

  ERR_MB_ERR_CUSTOM                          = 60000;
  ERR_MB_ILLEGAL_FUNCTION                    = 60001;
  ERR_MB_ILLEGAL_DATA_ADDRESS                = 60002;
  ERR_MB_ILLEGAL_DATA_VALUE                  = 60003;
  ERR_MB_SLAVE_DEVICE_FAILURE                = 60004;
  ERR_MB_ACKNOWLEDGE                         = 60005;
  ERR_MB_SLAVE_DEVICE_BUSY                   = 60006;
  ERR_MB_MEMORY_PARITY_ERROR                 = 60008;
  ERR_MB_GATWAY_PATH_UNAVAILABLE             = 60010;
  ERR_MB_GATWAY_TARGET_DEVICE_FAILED_RESPOND = 60011;
  ERR_MASTER_BUFF_NOT_ASSIGNET               = 60012;
  ERR_MASTER_GET_MEMORY                      = 60013;
  ERR_MASTER_CRC                             = 60014;
  ERR_MASTER_WORD_READ                       = 60015;
  ERR_MASTER_PACK_LEN                        = 60016;
  ERR_MASTER_QUANTITY                        = 60017;
  ERR_MASTER_DEVICE_ADDRESS                  = 60018;
  ERR_OUT_OF_RANGE                           = 60019;
  ERR_MASTER_FIFO_COUNT                      = 60020;
  ERR_MASTER_MEI                             = 60021;
  ERR_MASTER_RDIC                            = 60022;
  ERR_MASTER_MOREFOLLOWS                     = 60023;
  ERR_MASTER_FUNCTION_CODE                   = 60024;
  ERR_MASTER_F72_CHKRKEY                     = 60025;
  ERR_MASTER_F72_QUANTITY                    = 60026;
  ERR_MASTER_F72_CRC                         = 60027;

  ER_SLAVE_ANSVER_TIMEOUT                    = 90000;
  ER_SLAVE_ANSVER_NODATA                     = 90001;
  ER_SLAVE_ANSVER_READDATA                   = 90002;
  ER_SLAVE_ANSVER_WRITEDATA                  = 90003;
  ER_SLAVE_CONNECT_BROKEN                    = 90004;
  ER_SLAVE_SENT_NOT_FULL                     = 90005;

type

  ECustomException = class(Exception)
   protected
    FErrorCode: Cardinal;
   public
    constructor Create(const Msg: String = ''); reintroduce; virtual;
    property ErrorCode : Cardinal read FErrorCode;
  end;

  ERequestNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EPortNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EPortWriteError = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EPortWaitError = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EPortReadError = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EPortParamNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EPortParamInvalid = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  ERequestDataNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EResiveProcNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EErrItfPortParamType = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EItfPortParamNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EItfPortParamInvalid = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EPortNotActive = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EChannelParamNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EChannelParamInvalid = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EChannelIsntFound = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EDevCommandNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EDevLoadParamXMLNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EDevSaveParamXMLNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EDeviceNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EDeviceParamInvalid = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EObjectNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EObjectParamInvalid = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EObjectListNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EObjectListParamInvalid = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EChannelListNotAssigned = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EXMLLoadDevTypeError = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EXMLLoadDevFuncNotAssign = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EXMLLoadOutOfRangeID = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EXMLLoadOutOfRangeOfAddr = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EXMLLoadOutOfRangeOfReg = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EXMLLoad = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  ECommandDevItfNotInit = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  ECommandSrvProtNotMBProt = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  ECommandMBDevNotSet = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  ECommandChannelListNotSet = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  ECommandChannelListIsEmpty = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EModbusError = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  ECommandMBDevNumNotSet = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  ECommandIsAnotherDevice = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EChannelIsNotActive = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EProtLoadParamXMLNotAssign = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EProtDoesNotSupportThisCmd = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EProtIDMissing = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EProtIDRefersAnotherProt = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EProtTypeIsIncorrect = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EProtNotSupport = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  EClassNotImplemented = class(ECustomException)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadError = class(ECustomException); // для облегчения обработки ошибок загрузки

  ECMSFileNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorGetConfPath = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorCodePage = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
   constructor CreateFMT(const RequeridCodePage : String;  ExistingCodePage : String); virtual;
  end;

  ECMSLoadErrorRootName = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
   constructor CreateFMT(const RequeridRootName : String;  ExistingRootName : String); virtual;
  end;

  ECMSLoadErrorHostListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSBadID = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorHostListIsEmpty = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorIPListIsEmpty = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorHostTegNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorIDCSTegNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorProtListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorSvrProtListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorRmtProtListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorChanListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorSvrChanListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorRmtChanListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorSvrDevListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorRmtDevListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorModuleListNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;

  ECMSLoadErrorRSModbusRTUNotFound = class(ECMSLoadError)
   constructor Create(const Msg: String = ''); override;
  end;


  ECustomModbusException = class(Exception)
  protected
    FErrorCode: Cardinal;
  public
   constructor Create(const Msg: String = ''); reintroduce; virtual;
   property ErrorCode : Cardinal read FErrorCode;
  end;
  // Исключение: Недопустимый адрес данных, полученный в запросе.
  EMBIllegalDataAddress = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Недопустимый тип функции, полученный в запросе.
  EMBIllegalFunction = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Недопустимые значения, полученные в поле данных запроса.
  EMBIllegalDataValues = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Неустранимая ошибка при обработке устройством полученного запроса.
  EMBSlaveDeviceFailure = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Запрос принят. Выполняется длительная операция.
  EMBAcknowlege = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Устройство занято. Повторите запрос позже.
  EMBSlaveDeviceBusy = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: При чтении файла обнаружена ошибка четности памяти.
  EMBMemoryParityError = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Ошибка маршрутизации.
  EMBGetwayPathUnavailable = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Запрашиваемое устройство не ответило.
  EMBGetwayTargetDeviceFailedRespond = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Нераспознанная ошибка.
  EMBUninspacted = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Ключь переданный в ответе не соответствует ожидаемому.
  EMBF72ChkRKey = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Количество регистров в ответе выходит за допустимый дапазон.
  EMBF72Quantity = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Ошибка CRC блока данных.
  EMBF72CRC = class(ECustomModbusException)
   constructor Create(const Msg: String = ''); override;
  end;
  // Исключение: Ключь переданный в ответе не соответствует ожидаемому.
  EMBF110ChkWKey = EMBF72ChkRKey;
  // Исключение: Количество регистров в ответе выходит за допустимый дапазон.
  EMBF110Quantity = EMBF72Quantity;


  EXmlNotAssigned = class(Exception)
   public
    constructor Create(AClassName : String);
  end;

  EXmlNoNode = class(Exception)
   public
    constructor Create(AClassName, ANodeName : String);
  end;

  EXmlAttribute = class(Exception)
   public
    constructor Create(AClassName, ANodeName, AAttrName : String);
  end;

  EEssoMSystemType = class(Exception)
   public
    constructor Create(AClassName, ASystemType, AXMLType : String);
  end;

  EEssoMSessionID = class(Exception)
   public
    constructor Create(AClassName : String);
  end;

  EXmlAttributeValue = class(Exception)
   public
    constructor Create(AClassName, ANodeName, AAttrName, AValue : String);
  end;

  { EAddDevAlreadyExists }

  EAddDevAlreadyExists = class(Exception)
   public
    constructor Create(ADevNum : Byte);
  end;

  { ENeitherFunctioIsNotSet }

  ENeitherFunctioIsNotSet = class(Exception)
   public
    constructor Create;
  end;

  ERespToLarge   = Exception; // Response message too large to transport
  ENameNotFound  = Exception; // The name of the requested object was not found
  EDtNotMatch    = Exception; // A data type in the request did not match the data type in the SNMP agent
  ESetReadOnly   = Exception; // The SNMP manager attempted to set a read-only parameter
  EGeneralError  = Exception; // General Error (some error other than the ones listed above)
  ENoAcces       = Exception; // попытка выполнить set над недоступной переменной. Атрибут переменной ACCESS имеет значение not-accessable
  EWrongType     = Exception; // неверный тип переменной в set
  EWrongLen      = Exception; // неверная длинна переменной в команде set. Переменная ограниченной длинны - string
  EWrongEcod     = Exception; // неверная кодировка переменной в команде set. например в строке
  EWrongValue    = Exception; // переменной присвоено значение которое она не понимает.
  ENoCreation    = Exception; // попытка установить несуществующую переменную
  EInconsValue   = Exception; // целостность переменной MIB нарушена и она не принимает запросы set
  EResUnavail    = Exception; // для выполнения set не хватает ресурсов системы
  ECcommitFiled  = Exception; // общее сообщение для всех остальных ошибок set
  EUndoFiled     = Exception; // команда set не выполнена, и агент не смог отменить все предыдущие операции
  EAutorizError  = Exception; // указан неправильный пароль
  ENotWritable   = Exception; // переменная не может принимать занчение на запись, хотя должна
  EInconsName    = Exception; // неудачная попытка установить значение-целостность переменной нарушена


  function ErrorToStr(Error : Cardinal): String;
  function GetMBErrorString(Error : Cardinal) : String;

implementation

uses ExceptionsResStrings;

function GetMBErrorString(Error : Cardinal) : String;
begin
 case Error of
  ERR_MB_ILLEGAL_FUNCTION                     : Result:=RS_MB_ILLEGAL_FUNCTION;
  ERR_MB_ILLEGAL_DATA_ADDRESS                 : Result:=RS_MB_ILLEGAL_DATA_ADDRESS;
  ERR_MB_ILLEGAL_DATA_VALUE                   : Result:=RS_MB_ILLEGAL_DATA_VALUE;
  ERR_MB_SLAVE_DEVICE_FAILURE                 : Result:=RS_MB_SLAVE_DEVICE_FAILURE;
  ERR_MB_ACKNOWLEDGE                          : Result:=RS_MB_ACKNOWLEDGE;
  ERR_MB_SLAVE_DEVICE_BUSY                    : Result:=RS_MB_SLAVE_DEVICE_BUSY;
  ERR_MB_MEMORY_PARITY_ERROR                  : Result:=RS_MB_MEMORY_PARITY_ERROR;
  ERR_MB_GATWAY_PATH_UNAVAILABLE              : Result:=RS_MB_GATWAY_PATH_UNAVAILABLE;
  ERR_MB_GATWAY_TARGET_DEVICE_FAILED_RESPOND  : Result:=RS_MB_GATWAY_TARGET_DEVICE_FAILED_RESPOND;
  ERR_MASTER_BUFF_NOT_ASSIGNET                : Result:=RS_MASTER_BUFF_NOT_ASSIGNET;
  ERR_MASTER_GET_MEMORY                       : Result:=RS_MASTER_GET_MEMORY;
  ERR_MASTER_CRC                              : Result:=RS_MASTER_CRC;
  ERR_MASTER_WORD_READ                        : Result:=RS_MASTER_WORD_READ;
  ERR_MASTER_PACK_LEN                         : Result:=RS_MASTER_F3_LEN;
  ERR_MASTER_QUANTITY                         : Result:=RS_MASTER_QUANTITY;
  ERR_MASTER_DEVICE_ADDRESS                   : Result:=RS_MASTER_DEVICE_ADDRESS;
  ERR_MASTER_FIFO_COUNT                       : Result:=RS_MASTER_FIFO_COUNT;
  ERR_MASTER_MEI                              : Result:=RS_MASTER_MEI;
  ERR_MASTER_RDIC                             : Result:=RS_MASTER_RDIC;
  ERR_MASTER_MOREFOLLOWS                      : Result:=RS_MASTER_MOREFOLLOWS;
  ERR_MASTER_FUNCTION_CODE                    : Result:=RS_MASTER_FUNCTION_CODE;
  ERR_MASTER_F72_CHKRKEY                      : Result:=RS_MASTER_F72_CHKRKEY;
  ERR_MASTER_F72_QUANTITY                     : Result:=RS_MASTER_F72_QUANTITY;
  ERR_MASTER_F72_CRC                          : Result:=RS_MASTER_F72_CRC;
 else
  Result:=RS_MB_UNINSPACTED;
 end;
end;

function ErrorToStr(Error : Cardinal): String;
begin
  case Error of
   0                                        : Result := rsNoError;
   ERR_BASE_PORT_ERROR                      : Result := rsErrPortCustom;
   ERR_PORT_NOT_ASSIGNED                    : Result := rsErrPortNotAssigned;
   ERR_REQUEST_NOT_ASSIGNED                 : Result := rsErrRequestNotAssigned;
   ERR_PORT_PARAM_NOT_ASSIGNED              : Result := rsErrPortParNotAssigned;
   ERR_PORT_PARAM_INVALID                   : Result := rsErrPortParInvalid;
   ERR_REQUEST_DATA_NOT_ASSIGNED            : Result := rsErrRequestDataNotAssigned;
   ERR_RESIVE_PROC_NOT_ASSIGNED             : Result := rsErrResiveProcNotAssigned;
   ERR_RESIVE_DATA_TIMEOUT                  : Result := rsErrResiveDataTimeout;
   ERR_PORT_DATA_WRITE_TIMEOUT              : Result := rsErrPortDataWriteTimeout;
   ERR_PORT_DATA_WRITE                      : Result := rsErrPortDataWrite;
   ERR_PORT_DATA_WAIT                       : Result := rsErrPortDataWait;
   ERR_PORT_DATA_READ                       : Result := rsErrPortDataRead;
   ERR_ITF_PORT_PARAM_TYPE                  : Result := rsErrItfPortParamType;
   ERR_ITF_PORT_PARAM_NOT_ASSIGN            : Result := rsErrItfPortParamNotAssigned;
   ERR_ITF_PORT_PARAM_INVALID               : Result := rsErrItfPortParamInvalid;
   ERR_PORT_NOT_ACTIVE                      : Result := rsErrPortNotActive;
   ERR_CHANN_PARAM_NOT_ASSIGNED             : Result := rsErrChannelParamNotAssiged;
   ERR_CHANN_PARAM_INVALID                  : Result := rsErrChannelParamInvalid;
   ERR_CHANNEL_ISNT_FOUND                   : Result := rsErrChannelIsntFound;
   ERR_PORT_PARITY_ERROR                    : Result := rsErrPortParityError;
   DEV_ERROR_COMMAND_NOT_ASSIGNED           : Result := Format(rsDevErrorCommand,[rsDevErrorCommandNotAssigned]);
   DEV_LOAD_PARAM_XML_NOT_ASSIGN            : Result := rsDevLoadParamXMLNotAssign;
   DEV_SAVE_PARAM_XML_NOT_ASSIGN            : Result := rsDevSaveParamXMLNotAssign;
   ERR_PORT_OPERATION_ABORTED               : Result := rsPortOperationAborted;
   ERR_DEVICE_NOT_ASSIGNED                  : Result := rsDeviceNotAssigned;
   ERR_CHANNEL_LIST_NOT_ASSIGNED            : Result := rsChannelListNotAssigned;
   ERR_XML_LOAD                             : Result := rsXMLLoadError;
   ERR_XML_LOAD_DEV_TYPE                    : Result := rsXMLLoadDevTypeError;
   ERR_XML_LOAD_DEV_FNC_NOT_ASSIGN          : Result := rsXMLLoadDevFuncNotAssign;
   ERR_XML_LOAD_OUT_RANGE_ADDR              : Result := rsXMLLoadOutOfRangeOfAddr;
   ERR_XML_LOAD_OUT_RANGE_QUANT             : Result := rsXMLLoadOutOfRangeOfReg;
   ERR_UNKNOWN                              : Result := rsErrUnknown;
   ERR_COMMAND_DEV_ITF_NOT_INIT             : Result := rsCommandDevItfNotInit;
   ERR_COMMAND_SRV_PROT_NOT_MB_PROT         : Result := rsCommandSrvProtNotMBProt;
   ERR_CHANNEL_IS_NOT_ACTIVE                : Result := rsChannelIsNotActive;
   ERR_PROT_LOAD_PARAM_XML_NOT_ASSIGN       : Result := rsProtLoadParamXMLNotAssign;
   ERR_PROT_DOES_NOT_SUPPORT_THIS_CMD       : Result := rsProtDoesNotSupportThisCmd;
   ERR_CLASS_NOT_IMPLEMENTED                : Result := rsClassNotImplemented;
   ERR_CMS_FILE_NOT_FOUND                   : Result := rsCMSFileNotFound;
   ERR_CMS_BAD_ID                           : Result := rsCMSBadID;
   ERR_CMS_LOAD_ERR_GET_CONF_PATH           : Result := Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorGetConfPath]);
   ERR_CMS_LOAD_ERR_CODE_PAGE               : Result := rsCMSLoadErrorCodePage;
   ERR_CMS_LOAD_ERR_ROOT_NAME               : Result := rsCMSLoadErrorRootName;
   ERR_CMS_LOAD_ERR_HOST_LIST_NOT_FOUND     : Result := rsCMSLoadErrorHostListNotFound;
   ERR_CMS_LOAD_ERR_HOST_LIST_IS_EMPTY      : Result := rsCMSLoadErrorHostListIsEmpty;
   ERR_CMS_LOAD_ERR_IP_LIST_IS_EMPTY        : Result := rsCMSLoadErrorIPListIsEmpty;
   ERR_CMS_LOAD_ERR_HOST_TEG_NOT_FOUND      : Result := rsCMSLoadErrorHostTegNotFound;
   ERR_CMS_LOAD_ERR_IDCS_TEG_NOT_FOUND      : Result := rsCMSLoadErrorIDCSTegNotFound;
   ERR_CMS_LOAD_ERR_PROT_LIST_NOT_FOUND     : Result := rsCMSLoadErrorProtListNotFound;
   ERR_CMS_LOAD_ERR_SVR_PROT_LIST_NOT_FOUND : Result := rsCMSLoadErrorSvrProtListNotFound;
   ERR_CMS_LOAD_ERR_RMT_PROT_LIST_NOT_FOUND : Result := rsCMSLoadErrorRMTProtListNotFound;
   ERR_CMS_LOAD_ERR_CHAN_LIST_NOT_FOUND     : Result := rsCMSLoadErrorChanListNotFound;
   ERR_CMS_LOAD_ERR_SVR_CHAN_LIST_NOT_FOUND : Result := rsCMSLoadErrorSvrChanListNotFound;
   ERR_CMS_LOAD_ERR_RMT_CHAN_LIST_NOT_FOUND : Result := rsCMSLoadErrorRmtChanListNotFound;
   ERR_CMS_LOAD_ERR_SVR_DEV_LIST_NOT_FOUND  : Result := rsCMSLoadErrorSvrDevListNotFound;
   ERR_CMS_LOAD_ERR_RMT_DEV_LIST_NOT_FOUND  : Result := rsCMSLoadErrorRmtDevListNotFound;
   ERR_CMS_LOAD_ERR_MODULE_LIST_NOT_FOUND   : Result := rsCMSLoadErrorModuleListNotFound;
   ERR_CMS_LOAD_ERR_RSMODBUSRTU_NOT_FOUND   : Result := rsCMSLoadErrorRSModbusRTUNotFound;
   ERR_PROT_ID_MISSING                      : Result := rsProtIDMissing;
   ERR_PROT_ID_REFERS_ANOTHER_PROT          : Result := rsProtIDRefersAnotherProtocol;
   ERR_DEVICE_PARAM_INVALID                 : Result := rsErrDeviceParamInvalid;
   ERR_PROT_TYPE_IS_INCORRECT               : Result := rsProtTypeIsIncorrect;
   ERR_PROT_NOT_SUPPORT                     : Result := rsProtNotSupport;
   ERR_SYS_GET_MEM                          : Result := rsSysGetMem;
   ERR_RESIVE_DATA_NULL                     : Result := rsErrResiveDataNull;
   ERR_OBJECT_NOT_ASSIGNED                  : Result := rsObjectNotAssigned;
   ERR_OBJECT_PARAM_INVALID                 : Result := rsErrObjectParamInvalid;
   ERR_OBJECT_LIST_NOT_ASSIGNED             : Result := rsObjectListNotAssigned;
   ERR_OBJECT_LIST_PARAM_INVALID            : Result := rsErrObjectListParamInvalid;
   ERR_XML_LOAD_OUT_RANGE_ID                : Result := rsXMLLoadOutOfRangeID;
  else
   if Error > ERR_MB_ERR_CUSTOM then Result := GetMBErrorString(Error)
    else Result := rsErrUnknown;
  end;
end;

{ ENeitherFunctioIsNotSet }

constructor ENeitherFunctioIsNotSet.Create;
begin
  Message := rsExceptNeitherFunctioIsNotSet;
end;

{ EAddDevAlreadyExists }

constructor EAddDevAlreadyExists.Create(ADevNum : Byte);
begin
  Message := Format(rsExceptAddDevAlreadyExists,[ADevNum]);
end;

{ EXmlAttributeValue }

constructor EXmlAttributeValue.Create(AClassName, ANodeName, AAttrName, AValue : String);
begin
  Message := Format(rsExceptXMLAttrVal,[AClassName,ANodeName,AAttrName,AValue]);
end;

{ EEssoMSessionID }

constructor EEssoMSessionID.Create(AClassName : String);
begin
  Message := Format('%s %s',[AClassName,rsExceptSessionID]);
end;

{ EXmlAttribute }

constructor EXmlAttribute.Create(AClassName, ANodeName, AAttrName : String);
begin
  Message := Format(rsExceptXlmNoAttr,[AClassName,ANodeName,AAttrName]);
end;

{ EEssoMSystemType }

constructor EEssoMSystemType.Create(AClassName, ASystemType, AXMLType : String);
begin
  Message := Format(rsExceptSyetemType,[AClassName,ASystemType,AXMLType]);
end;

{ EXmlNoNode }

constructor EXmlNoNode.Create(AClassName, ANodeName : String);
begin
  Message := Format(rsExceptXlmNoNode,[AClassName,ANodeName]);
end;

{ EXmlNotAssigned }

constructor EXmlNotAssigned.Create(AClassName : String);
begin
  Message := Format('%s %s',[AClassName,rsExceptXmlNotAssigned]);
end;

{ EXMLLoadOutOfRangeID }

constructor EXMLLoadOutOfRangeID.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsXMLLoadOutOfRangeID)
  else inherited Create(Format('%s: %s',[rsXMLLoadOutOfRangeID,Msg]));
  FErrorCode:= ERR_XML_LOAD_OUT_RANGE_ID;
end;

{ EObjectListParamInvalid }

constructor EObjectListParamInvalid.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsErrObjectListParamInvalid)
  else inherited Create(Format('%s: %s',[rsErrObjectListParamInvalid,Msg]));
  FErrorCode:= ERR_OBJECT_LIST_PARAM_INVALID;
end;

{ EObjectListNotAssigned }

constructor EObjectListNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsObjectListNotAssigned)
  else inherited Create(Format('%s: %s',[rsObjectListNotAssigned,Msg]));
  FErrorCode:= ERR_OBJECT_LIST_NOT_ASSIGNED;
end;

{ EObjectParamInvalid }

constructor EObjectParamInvalid.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsErrObjectParamInvalid)
  else inherited Create(Format('%s: %s',[rsErrObjectParamInvalid,Msg]));
  FErrorCode:= ERR_OBJECT_PARAM_INVALID;
end;

{ EObjectNotAssigned }

constructor EObjectNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsObjectNotAssigned)
  else inherited Create(Format('%s: %s',[rsObjectNotAssigned,Msg]));
  FErrorCode:= ERR_OBJECT_NOT_ASSIGNED;
end;

{ EPortReadError }

constructor EPortReadError.Create(const Msg : String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrPortDataRead]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_PORT_DATA_READ;
end;

{ EPortWaitError }

constructor EPortWaitError.Create(const Msg : String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrPortDataWait]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_PORT_DATA_WAIT;
end;

{ EPortWriteError }

constructor EPortWriteError.Create(const Msg : String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrPortDataWrite]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_PORT_DATA_WRITE;
end;

{ ECustomPortException }

constructor ECustomException.Create(const Msg: String);
begin
  if Msg='' then inherited Create(rsErrPortCustom)
   else inherited Create(Msg);
  FErrorCode:= ERR_BASE_PORT_ERROR;
end;

{ ERequestNotAssigned }

constructor ERequestNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrRequestNotAssigned]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_REQUEST_NOT_ASSIGNED;
end;

{ EPortNotAssigned }

constructor EPortNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrPortNotAssigned]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_PORT_NOT_ASSIGNED;
end;

{ EPortParamNotAssigned }

constructor EPortParamNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrPortParNotAssigned]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_PORT_PARAM_NOT_ASSIGNED;
end;

{ ERequestDataNotAssigned }

constructor ERequestDataNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrRequestDataNotAssigned]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_REQUEST_DATA_NOT_ASSIGNED;
end;

{ EResiveProcNotAssigned }

constructor EResiveProcNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrResiveProcNotAssigned]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_RESIVE_PROC_NOT_ASSIGNED;
end;

{ EErrItfPortParamType }

constructor EErrItfPortParamType.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrItfPortParamType]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_ITF_PORT_PARAM_TYPE;
end;

{ EPortNotActive }

constructor EPortNotActive.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrPortNotActive]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_PORT_NOT_ACTIVE;
end;

{ EChannelParamNotAssigned }

constructor EChannelParamNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrChannelParamNotAssiged]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_CHANN_PARAM_NOT_ASSIGNED;
end;

{ EChannelIsntFound }

constructor EChannelIsntFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format('%s : %s',[Message,rsErrChannelIsntFound]))
  else inherited Create(Format('%s: %s',[Message,Msg]));
  FErrorCode:= ERR_CHANNEL_ISNT_FOUND;
end;

{ EDevCommandNotAssigned }

constructor EDevCommandNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(Format(rsDevErrorCommand,[rsDevErrorCommandNotAssigned]))
  else inherited Create(Format(rsDevErrorCommand+': %s',[rsDevErrorCommandNotAssigned,Msg]));
  FErrorCode:= DEV_ERROR_COMMAND_NOT_ASSIGNED;
end;

{ EDevLoadParamXMLNotAssigned }

constructor EDevLoadParamXMLNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsDevLoadParamXMLNotAssign)
  else inherited Create(Format('%s: %s',[rsDevLoadParamXMLNotAssign,Msg]));
  FErrorCode:= DEV_LOAD_PARAM_XML_NOT_ASSIGN;
end;

{ EDevSaveParamXMLNotAssigned }

constructor EDevSaveParamXMLNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsDevSaveParamXMLNotAssign)
  else inherited Create(Format('%s: %s',[rsDevSaveParamXMLNotAssign,Msg]));
  FErrorCode:= DEV_SAVE_PARAM_XML_NOT_ASSIGN;
end;

{ EDeviceNotAssigned }

constructor EDeviceNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsDeviceNotAssigned)
  else inherited Create(Format('%s: %s',[rsDeviceNotAssigned,Msg]));
  FErrorCode:= ERR_DEVICE_NOT_ASSIGNED;
end;

{ EChannelListNotAssigned }

constructor EChannelListNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsChannelListNotAssigned)
  else inherited Create(Format('%s: %s',[rsChannelListNotAssigned,Msg]));
  FErrorCode:= ERR_CHANNEL_LIST_NOT_ASSIGNED;
end;

{ EXMLLoadDevTypeError }

constructor EXMLLoadDevTypeError.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsXMLLoadDevTypeError)
  else inherited Create(Format('%s: %s',[rsXMLLoadDevTypeError,Msg]));
  FErrorCode:= ERR_XML_LOAD_DEV_TYPE;
end;

{ EXMLLoadDevFuncNotAssign }

constructor EXMLLoadDevFuncNotAssign.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsXMLLoadDevFuncNotAssign)
  else inherited Create(Format('%s: %s',[rsXMLLoadDevFuncNotAssign,Msg]));
  FErrorCode:= ERR_XML_LOAD_DEV_FNC_NOT_ASSIGN;
end;

{ EXMLLoadOutOfRangeOfAddr }

constructor EXMLLoadOutOfRangeOfAddr.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsXMLLoadOutOfRangeOfAddr)
  else inherited Create(Format('%s: %s',[rsXMLLoadOutOfRangeOfAddr,Msg]));
  FErrorCode:= ERR_XML_LOAD_OUT_RANGE_ADDR;
end;

{ EXMLLoadOutOfRangeOfReg }

constructor EXMLLoadOutOfRangeOfReg.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsXMLLoadOutOfRangeOfReg)
  else inherited Create(Format('%s: %s',[rsXMLLoadOutOfRangeOfReg,Msg]));
  FErrorCode:= ERR_XML_LOAD_OUT_RANGE_QUANT;
end;

{ EXMLLoad }

constructor EXMLLoad.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsXMLLoadError)
  else inherited Create(Format('%s: %s',[rsXMLLoadError,Msg]));
  FErrorCode:= ERR_XML_LOAD;
end;

{ EChannelParamInvalid }

constructor EChannelParamInvalid.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsErrChannelParamInvalid)
  else inherited Create(Format('%s: %s',[rsErrChannelParamInvalid,Msg]));
  FErrorCode:= ERR_CHANN_PARAM_INVALID;
end;

{ EPortParamInvalid }

constructor EPortParamInvalid.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsErrPortParInvalid)
  else inherited Create(Format('%s: %s',[rsErrPortParInvalid,Msg]));
  FErrorCode:= ERR_PORT_PARAM_INVALID;
end;

{ EItfPortParamNotAssigned }

constructor EItfPortParamNotAssigned.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsErrItfPortParamNotAssigned)
  else inherited Create(Format('%s: %s',[rsErrItfPortParamNotAssigned,Msg]));
  FErrorCode:= ERR_ITF_PORT_PARAM_NOT_ASSIGN;
end;

{ EItfPortParamInvalid }

constructor EItfPortParamInvalid.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsErrItfPortParamInvalid)
  else inherited Create(Format('%s: %s',[rsErrItfPortParamInvalid,Msg]));
  FErrorCode:= ERR_ITF_PORT_PARAM_INVALID;
end;

{ ECommandDevItfNotInit }

constructor ECommandDevItfNotInit.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCommandDevItfNotInit)
  else inherited Create(Format('%s: %s',[rsCommandDevItfNotInit,Msg]));
  FErrorCode:= ERR_COMMAND_DEV_ITF_NOT_INIT;
end;

{ ECommandSrvProtNotMBProt }

constructor ECommandSrvProtNotMBProt.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCommandSrvProtNotMBProt)
  else inherited Create(Format('%s: %s',[rsCommandSrvProtNotMBProt,Msg]));
  FErrorCode:= ERR_COMMAND_SRV_PROT_NOT_MB_PROT;
end;

{ ECommandMBDevNotSet }

constructor ECommandMBDevNotSet.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCommandMBDevNotSet)
  else inherited Create(Format('%s: %s',[rsCommandMBDevNotSet,Msg]));
  FErrorCode:= ERR_COMMAND_MB_DEV_NOT_SET;
end;

{ ECommandChannelListNotSet }

constructor ECommandChannelListNotSet.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCommandChannelListNotSet)
  else inherited Create(Format('%s: %s',[rsCommandChannelListNotSet,Msg]));
  FErrorCode:= ERR_COMMAND_CHANNEL_LIST_NOT_SET;
end;

{ ECommandChannelListIsEmpty }

constructor ECommandChannelListIsEmpty.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCommandChannelListIsEmpty)
  else inherited Create(Format('%s: %s',[rsCommandChannelListIsEmpty,Msg]));
  FErrorCode:= ERR_COMMAND_CHANNEL_LIST_IS_EMPTY;
end;

{ EModbusError }

constructor EModbusError.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsModbusError)
  else inherited Create(Format('%s: %s',[rsModbusError,Msg]));
  FErrorCode:= ERR_MODBUS;
end;

{ ECommandMBDevNumNotSet }

constructor ECommandMBDevNumNotSet.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCommandMBDevNumNotSet)
  else inherited Create(Format('%s: %s',[rsCommandMBDevNumNotSet,Msg]));
  FErrorCode:= ERR_COMMAND_MB_DEV_NUM_NOT_SET;
end;

{ ECommandIsAnotherDevice }

constructor ECommandIsAnotherDevice.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCommandIsAnotherDevice)
  else inherited Create(Format('%s: %s',[rsCommandIsAnotherDevice,Msg]));
  FErrorCode:= ERR_COMMAND_IS_ANOVER_DEVICE;
end;

{ EChannelIsNotActive }

constructor EChannelIsNotActive.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsChannelIsNotActive)
  else inherited Create(Format('%s: %s',[rsChannelIsNotActive,Msg]));
  FErrorCode:= ERR_CHANNEL_IS_NOT_ACTIVE;
end;

{ EProtLoadParamXMLNotAssign }

constructor EProtLoadParamXMLNotAssign.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsProtLoadParamXMLNotAssign)
  else inherited Create(Format('%s: %s',[rsProtLoadParamXMLNotAssign,Msg]));
  FErrorCode:= ERR_PROT_LOAD_PARAM_XML_NOT_ASSIGN;
end;

{ EProtDoesNotSupportThisCmd }

constructor EProtDoesNotSupportThisCmd.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsProtDoesNotSupportThisCmd)
  else inherited Create(Format('%s: %s',[rsProtDoesNotSupportThisCmd,Msg]));
  FErrorCode:= ERR_PROT_DOES_NOT_SUPPORT_THIS_CMD;
end;

{ EClassNotImplemented }

constructor EClassNotImplemented.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsClassNotImplemented)
  else inherited Create(Format('%s: %s',[rsClassNotImplemented,Msg]));
  FErrorCode:= ERR_CLASS_NOT_IMPLEMENTED;
end;

{ ECMSFileNotFound }

constructor ECMSFileNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCMSFileNotFound1)
  else inherited Create(Format(rsCMSFileNotFound,[Msg]));
  FErrorCode:= ERR_CMS_FILE_NOT_FOUND;
end;

{ ECMSLoadErroGetConfPath }

constructor ECMSLoadErrorGetConfPath.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s: %s',[rsCMSLoad,rsCMSLoadErrorGetConfPath]))
  else inherited Create(Format('%s: %s - %s',[rsCMSLoad,rsCMSLoadErrorGetConfPath,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_GET_CONF_PATH;
end;

{ ECMSLoadErroCodePage }

constructor ECMSLoadErrorCodePage.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCMSLoadErrorCodePage)
  else inherited Create(Format('%s: %s',[rsCMSLoadErrorCodePage,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_CODE_PAGE;
end;

constructor ECMSLoadErrorCodePage.CreateFMT(const RequeridCodePage: String; ExistingCodePage: String);
begin
  inherited Create(Format('%s: %s',[rsCMSLoad,Format(rsCMSLoadErrorCodePageF,[RequeridCodePage,ExistingCodePage])]));
  FErrorCode:= ERR_CMS_LOAD_ERR_CODE_PAGE;
end;

{ ECMSLoadErroRootName }

constructor ECMSLoadErrorRootName.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCMSLoadErrorRootName)
  else inherited Create(Format('%s: %s',[rsCMSLoadErrorRootName,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_ROOT_NAME;
end;

constructor ECMSLoadErrorRootName.CreateFMT(const RequeridRootName: String; ExistingRootName: String);
begin
  inherited Create(Format('%s: %s',[rsCMSLoad,Format(rsCMSLoadErrorRootNameF,[RequeridRootName,ExistingRootName])]));
  FErrorCode:= ERR_CMS_LOAD_ERR_ROOT_NAME;
end;

{ ECMSLoadErroHostListNotFound }

constructor ECMSLoadErrorHostListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorHostListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorHostListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_HOST_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorHostListIsEmpty }

constructor ECMSLoadErrorHostListIsEmpty.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorHostListIsEmpty]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorHostListIsEmpty,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_HOST_LIST_IS_EMPTY;
end;

{ ECMSLoadErrorIPListIsEmpty }

constructor ECMSLoadErrorIPListIsEmpty.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorIPListIsEmpty]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorIPListIsEmpty,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_IP_LIST_IS_EMPTY;
end;

{ ECMSLoadErrorHostTegNotFound }

constructor ECMSLoadErrorHostTegNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorHostTegNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorHostTegNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_HOST_TEG_NOT_FOUND;
end;

{ ECMSLoadErrorIDCSTegNotFound }

constructor ECMSLoadErrorIDCSTegNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorIDCSTegNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorIDCSTegNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_IDCS_TEG_NOT_FOUND;
end;

{ ECMSLoadErrorProtListNotFound }

constructor ECMSLoadErrorProtListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorProtListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorProtListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_PROT_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorSvrProtListNotFound }

constructor ECMSLoadErrorSvrProtListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorSvrProtListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorSvrProtListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_SVR_PROT_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorRmtProtListNotFound }

constructor ECMSLoadErrorRmtProtListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorRmtProtListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorRmtProtListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_RMT_PROT_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorChanListNotFound }

constructor ECMSLoadErrorChanListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorChanListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorChanListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_CHAN_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorSvrChanListNotFound }

constructor ECMSLoadErrorSvrChanListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorSvrChanListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorSvrChanListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_SVR_CHAN_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorRmtChanListNotFound }

constructor ECMSLoadErrorRmtChanListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorRmtChanListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorRmtChanListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_RMT_CHAN_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorSvrDevListNotFound }

constructor ECMSLoadErrorSvrDevListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorSvrDevListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorSvrDevListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_SVR_DEV_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorRmtDevListNotFound }

constructor ECMSLoadErrorRmtDevListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorRmtDevListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorRmtDevListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_RMT_DEV_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorModuleListNotFound }

constructor ECMSLoadErrorModuleListNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorModuleListNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorModuleListNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_MODULE_LIST_NOT_FOUND;
end;

{ ECMSLoadErrorRSModbusRTUNotFound }

constructor ECMSLoadErrorRSModbusRTUNotFound.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create( Format('%s. %s',[rsCMSLoad,rsCMSLoadErrorRSModbusRTUNotFound]))
  else inherited Create(Format('%s. %s - %s',[rsCMSLoad,rsCMSLoadErrorRSModbusRTUNotFound,Msg]));
  FErrorCode:= ERR_CMS_LOAD_ERR_RSMODBUSRTU_NOT_FOUND;
end;

{ EProtIDMissing }

constructor EProtIDMissing.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsProtIDMissing)
  else inherited Create(Format('%s: %s',[rsProtIDMissing,Msg]));
  FErrorCode:= ERR_PROT_ID_MISSING;
end;

{ EProtIDRefersAnotherProt }

constructor EProtIDRefersAnotherProt.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsProtIDRefersAnotherProtocol)
  else inherited Create(Format('%s: %s',[rsProtIDRefersAnotherProtocol,Msg]));
  FErrorCode:= ERR_PROT_ID_REFERS_ANOTHER_PROT;
end;

{ EDeviceParamInvalid }

constructor EDeviceParamInvalid.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsErrDeviceParamInvalid)
  else inherited Create(Format('%s: %s',[rsErrDeviceParamInvalid,Msg]));
  FErrorCode:= ERR_DEVICE_PARAM_INVALID;
end;

{ EProtTypeIsIncorrect }

constructor EProtTypeIsIncorrect.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsProtTypeIsIncorrect)
  else inherited Create(Format('%s: %s',[rsProtTypeIsIncorrect,Msg]));
  FErrorCode:= ERR_PROT_TYPE_IS_INCORRECT;
end;

{ EProtNotSupport }

constructor EProtNotSupport.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsProtNotSupport)
  else inherited Create(Format('%s: %s',[rsProtNotSupport,Msg]));
  FErrorCode:= ERR_PROT_NOT_SUPPORT;
end;

{ ECMSBadID }

constructor ECMSBadID.Create(const Msg: String);
begin
  if Msg = '' then  inherited Create(rsCMSBadID)
  else inherited Create(Format('%s: %s',[rsCMSBadID,Msg]));
  FErrorCode:= ERR_CMS_BAD_ID;
end;

{ ECustomModbusException }

constructor ECustomModbusException.Create(const Msg: String);
begin
  if Msg=''then inherited Create(Format(RS_MB_ERR_CUSTOM,['']))
   else inherited Create(Msg);
  FErrorCode:= ERR_MB_ERR_CUSTOM;
end;

{ EMBIllegalDataAddress }

constructor EMBIllegalDataAddress.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_ILLEGAL_DATA_ADDRESS])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MB_ILLEGAL_DATA_ADDRESS;
end;

{ EMBIllegalFunction }

constructor EMBIllegalFunction.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_ILLEGAL_FUNCTION])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MB_ILLEGAL_FUNCTION;
end;

{ EMBIllegalDataValues }

constructor EMBIllegalDataValues.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_ILLEGAL_DATA_VALUE])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MB_ILLEGAL_DATA_VALUE;
end;

{ EMBSlaveDeviceFailure }

constructor EMBSlaveDeviceFailure.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_SLAVE_DEVICE_FAILURE])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MB_SLAVE_DEVICE_FAILURE;
end;

{ EMBAcknowlege }

constructor EMBAcknowlege.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_ACKNOWLEDGE])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MB_ACKNOWLEDGE;
end;

{ EMBSlaveDeviceBusy }

constructor EMBSlaveDeviceBusy.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_SLAVE_DEVICE_BUSY])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MB_SLAVE_DEVICE_BUSY;
end;

{ EMBMemoryParityError }

constructor EMBMemoryParityError.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_MEMORY_PARITY_ERROR])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MB_MEMORY_PARITY_ERROR;
end;

{ EMBGetwayPathUnavailable }

constructor EMBGetwayPathUnavailable.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_GATWAY_PATH_UNAVAILABLE])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MB_GATWAY_PATH_UNAVAILABLE;
end;

{ EMBGetwayTargetDeviceFailedRespond }

constructor EMBGetwayTargetDeviceFailedRespond.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_GATWAY_TARGET_DEVICE_FAILED_RESPOND])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MB_GATWAY_TARGET_DEVICE_FAILED_RESPOND;
end;

{ EMBUninspacted }

constructor EMBUninspacted.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MB_UNINSPACTED])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= MaxLongint;
end;

{ EMBF72ChkRKey }

constructor EMBF72ChkRKey.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MASTER_F72_CHKRKEY])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MASTER_F72_CHKRKEY;
end;

{ EMBF72Quantity }

constructor EMBF72Quantity.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MASTER_F72_QUANTITY])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MASTER_F72_QUANTITY;
end;

{ EMBF72CRC }

constructor EMBF72CRC.Create(const Msg: String);
begin
  inherited Create;
  if Msg = '' then  Message:=Format(RS_MB_ERR_CUSTOM,[RS_MASTER_F72_CRC])
  else Message:=Format(RS_MB_ERR_CUSTOM,[Msg]);
  FErrorCode:= ERR_MASTER_F72_CRC;
end;

end.
