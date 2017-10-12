unit ExceptionsResStrings;

{$mode objfpc}{$H+}

interface

// при добавлении строк НЕЗАБУДЬ!!! добавить эти строки в *.inc.po.en

resourcestring

  errEmptyParam                              = 'Не задан объект для постановки в очередь.';
{  rsXMLTagDNameHost                          = 'Хост';
  rsXMLTagDNameHostList                      = 'Список хостов';
  rsXMLTagDNameIDCS                          = 'Подсистема сбора информации';
  rsXMLTagDNameProtocolList                  = 'Список протоколов';
  rsXMLTagDNameServerProtocolList            = 'Список серверных протоколов';
  rsXMLTagDNameRemoutProtocolList            = 'Список удаленных протоколов';
  rsXMLTagDNameProtocol                      = 'Протокол';
  rsXMLTagDNameServerProtocol                = 'Серверный протокол';
  rsXMLTagDNameRemoutProtocol                = 'Удаленный протокол';
  rsXMLTagDNameDeviceList                    = 'Список устройств';
  rsXMLTagDNameServerDeviceList              = 'Список серверных устройств';
  rsXMLTagDNameRemoutDeviceList              = 'Список удаленных устройств';
  rsXMLTagDNameDevice                        = 'Устройство';
  rsXMLTagDNameServerDevice                  = 'Серверное устройство';
  rsXMLTagDNameRemoutDevice                  = 'Удаленное устройство';
  rsXMLTagDNameChannelList                   = 'Список каналов';
  rsXMLTagDNameServerChannelList             = 'Список серверных каналов';
  rsXMLTagDNameRemoutChannelList             = 'Список удаленных каналов';
  rsXMLTagDNameChannel                       = 'Канал';
  rsXMLTagDNameServerChannel                 = 'Серверный канал';
  rsXMLTagDNameRemoutChannel                 = 'Удаленный канал';
  rsXMLTagDNameModuleList                    = 'Список модулей';
  rsXMLTagDNameModule                        = 'Модуль';

  rsXMLRangeDescrSrvProt                     = 'ServerProtocolIDRange';
  rsXMLRangeDescrRemProt                     = 'RemoutProtocolIDRange';
  rsXMLRangeDescrSrvChanTCP                  = 'ServerChannelTCPIDRange';
  rsXMLRangeDescrRemChanTCP                  = 'RemoutChannelTCPIDRange';
  rsXMLRangeDescrSrvChanRTU                  = 'ServerChannelRTUIDRange';
  rsXMLRangeDescrRemChanRTU                  = 'RemoutChannelRTUIDRange';
  rsXMLRangeDescrSrvDev                      = 'ServerDeviceIDRange';
  rsXMLRangeDescrRemDev                      = 'RemoutDeviceIDRange';
  rsXMLRangeDescrModules                     = 'ModulesIDRange';
  rsXMLRSModbusRTUDescr                      = 'RSModbusRTU';
  rsXMLRangeDescrHost                        = 'HostIDRange';}

  rsNoError                                  = 'Нет ошибки.';
  rsErrUnknown                               = 'Неизвестная ошибка';
  rsErrPortCustom                            = 'Ошибка порта';
  rsErrRequestNotAssigned                    = 'Запрос не определен.';
  rsErrPortNotAssigned                       = 'Интерфейсный порт не определен.';
  rsErrPortParNotAssigned                    = 'Параметры порта не заданы.';
  rsErrPortParInvalid                        = 'Ошибка в параметрах порта.';
  rsErrRequestDataNotAssigned                = 'Не удалось получить данные из запроса.';
  rsErrResiveProcNotAssigned                 = 'Не установлена процедура возврата данных в интерфейсном порту.';
  rsErrItfPortParamType                      = 'Класс параметров порта не соответствует требуемому';
  rsErrItfPortParamNotAssigned               = 'Не заданы параметры интерфейсного порта.';
  rsErrItfPortParamInvalid                   = 'Ошибка в параметрах интерфейсного порта.';
  rsErrPortNotActive                         = 'Порт не открыт.';
  rsErrChannelParamNotAssiged                = 'Параметры канала не заданы.';
  rsErrChannelParamInvalid                   = 'Ошибка в параметрах канала.';
  rsErrChannelIsntFound                      = 'Запрашиваемый канал не найден';
  rsErrResiveDataTimeout                     = 'Таймаут ожидания ответа устройства.';
  rsErrResiveDataNull                        = 'Пришел ответ нулевой длины.';
  rsErrPortDataWriteTimeout                  = 'Не удалось записать данные в порт.';
  rsErrPortDataWrite                         = 'Ошибка записи данных в порт';
  rsErrPortDataWait                          = 'Ошибка ожидания данных';
  rsErrPortDataRead                          = 'Ошибка чтения данных';
  rsErrPortParityError                       = 'Ошибка паритета.';
  rsDevErrorCommand                          = 'Ошибка выполнения команды. %s';
  rsDevErrorCommandNotAssigned               = 'Команда не задана.';
  rsErrDeviceParamInvalid                    = 'Ошибка в параметрах устройства.';

  rsDevLoadParamXMLNotAssign                 = 'Не задан узел XML для загрузки параметров устройства.';
  rsDevSaveParamXMLNotAssign                 = 'Не задан узел XML для сохранения параметров устройства.';
  rsPortOperationAborted                     = 'Операция ввода/вывода была прервана из-за завершения потока команд или по запросу приложения.';
  rsDeviceNotAssigned                        = 'Не задано устройство для мониторинга.';
  rsChannelListNotAssigned                   = 'Не задан список каналов для осуществления мониторинга.';

  rsXMLLoadError                             = 'Ошибка загрузки устройства';
  rsXMLLoadDevTypeError                      = 'Тип устройства не соответствует типу указанному в параметрах.';
  rsXMLLoadDevFuncNotAssign                  = 'В конфигурации не заданы функции поддерживаемые устройством.';

  rsXMLLoadOutOfRangeID                      = 'Не задан идентификатор диапазона адресов.';
  rsXMLLoadOutOfRangeOfAddr                  = 'Выход за пределы допустимого диапазона адресов.';
  rsXMLLoadOutOfRangeOfReg                   = 'Выход за пределы допустимого диапазона количества регистров.';

  rsCommandDevItfNotInit                     = 'Команда не инициализирована интерфейсом устройства.';
  rsCommandSrvProtNotMBProt                  = 'Установленный протокол не поддерживает серверный Modbus протокол.';

  rsCommandMBDevNotSet                       = 'Не задан объект Modbus устройства.';
  rsCommandChannelListNotSet                 = 'Не задан список каналов до удаленных устройств.';
  rsCommandChannelListIsEmpty                = 'Список каналов для доступа к удаленному устройству пуст.';

  rsModbusError                              = 'Ошибка Modbus';
  rsCommandMBDevNumNotSet                    = 'Не задан номер устройства для команды.';
  rsCommandIsAnotherDevice                   = 'Команда предназначается другому устройству.';

  rsProtLoadParamXMLNotAssign                = 'Не задан узел XML для загрузки параметров протокола.';
  rsProtDoesNotSupportThisCmd                = 'Протокол не поддерживает данный тип команд.';
  rsProtIDMissing                            = 'В параметрах отсутствует идентификатор протокола.';
  rsProtIDRefersAnotherProtocol              = 'Идентификатор относится к другому протоколу.';
  rsProtTypeIsIncorrect                      = 'Тип протокола задан неверно.';
  rsProtNotSupport                           = 'Протокол не поддерживается.';

  rsChannelIsNotActive                       = 'Канал не открыт.';

  rsClassNotImplemented                      = 'Класс не реализован';

  rsCMSFileNotFound                          = 'Файл %s не найден.';
  rsCMSBadID                                 = 'Идентификатор выходит за допустимый диапазон.';
  rsCMSBadID1                                = 'Идентификатор хоста(%d) должен находиться в диапазоне от %d до %d';
  rsCMSFileNotFound1                         = 'Файл не найден.';
  rsCMSLoad                                  = 'Загрузка конфигурации';
  rsCMSLoadErrorGetConfPath                  = 'Не удалось получить путь к файлу конфигурации системы.';
  rsCMSLoadErrorCodePageF                    = 'Кодовая страница конфигурации (%s) не соответствует требуемой - %s';
  rsCMSLoadErrorCodePage                     = 'Кодовая страница конфигурации не соответствует требуемой.';
  rsCMSLoadErrorRootNameF                    = 'Корневой тег %s не соответствует требуемому %s';
  rsCMSLoadErrorRootName                     = 'Корневой тег не соответствует требуемому.';
  rsCMSLoadErrorHostListNotFound             = 'Не найден тег списка хостов.';
  rsCMSLoadErrorHostListIsEmpty              = 'Список хстов пуст.';
  rsCMSLoadErrorIPListIsEmpty                = 'Список хстов пуст.';
  rsCMSLoadErrorHostTegNotFound              = 'Не найден тег хоста для данного устройства.';
  rsCMSLoadErrorIDCSTegNotFound              = 'Тег подсистемы сбора первичной информации(IDCS) отсутствует.';
  rsCMSLoadErrorProtListNotFound             = 'Отсутствует тег списка протоколов.';
  rsCMSLoadErrorSvrProtListNotFound          = 'Отсутствует список ServerProtocolList.';
  rsCMSLoadErrorRmtProtListNotFound          = 'Отсутствует список RemoteProtocolList.';
  rsCMSLoadErrorChanListNotFound             = 'Отсутствует тег списка каналов.';
  rsCMSLoadErrorSvrChanListNotFound          = 'Отсутствует список ServerChannelList.';
  rsCMSLoadErrorRmtChanListNotFound          = 'Отсутствует список RemoteChannelList.';
  rsCMSLoadErrorSvrDevListNotFound           = 'Отсутствует список ServerDeviceList.';
  rsCMSLoadErrorRmtDevListNotFound           = 'Отсутствует список RemoteDeviceList.';
  rsCMSLoadErrorModuleListNotFound           = 'Отсутствует список ModuleList.';
  rsCMSLoadErrorRSModbusRTUNotFound          = 'Отсутствует конфигурация модуля RSModbusRTU.';
  rsSysGetMem                                = 'Ошибка выделения памяти';

  rsObjectNotAssigned                        = 'Не задан узел XML для загрузки параметров объекта наблюдения';
  rsErrObjectParamInvalid                    = 'Ошибка в параметрах объекта наблюдения';

  rsObjectListNotAssigned                    = 'Не задан узел XML для загрузки параметров списка объектов наблюдения';
  rsErrObjectListParamInvalid                = 'Ошибка в параметрах списка объектов наблюдения';

  RS_MB_ERR_CUSTOM                           = 'Ошибка Modbus: %s';
  RS_MB_ILLEGAL_FUNCTION                     = 'Недопустимый тип функции, полученных в запросе.';
  RS_MB_ILLEGAL_DATA_ADDRESS                 = 'Недопустимый адрес данных, полученный в запросе.';
  RS_MB_ILLEGAL_DATA_VALUE                   = 'Недопустимые значения, полученные в поле данных запроса.';
  RS_MB_SLAVE_DEVICE_FAILURE                 = 'Неустранимая ошибка при обработке устройством полученного запроса.';
  RS_MB_ACKNOWLEDGE                          = 'Запрос принят. Выполняется длительная операция.';
  RS_MB_SLAVE_DEVICE_BUSY                    = 'Устройство занято. Повторите запрос позже.';
  RS_MB_MEMORY_PARITY_ERROR                  = 'При чтении файла обнаружена ошибка четности памяти.';
  RS_MB_GATWAY_PATH_UNAVAILABLE              = 'Ошибка маршрутизации.';
  RS_MB_GATWAY_TARGET_DEVICE_FAILED_RESPOND  = 'Запрашиваемое устройство не ответило.';
  RS_MB_UNINSPACTED                          = 'Нераспознанная ошибка.';

  RS_MASTER_BUFF_NOT_ASSIGNET                = 'Передан пустой буфер.';
  RS_MASTER_GET_MEMORY                       = 'Системная ошибка.  Код ошибки: %d. - %s';
  RS_MASTER_CRC                              = 'Ошибка расчета CRC16 полученного пакета.';

  RS_MASTER_WORD_READ                        = 'Передано нечетное количество байт.';
  RS_MASTER_F3_LEN                           = 'Неверная длина пакета.';
  RS_MASTER_QUANTITY                         = 'Количество записанных регистров превышает допустимое.';
  RS_MASTER_DEVICE_ADDRESS                   = 'Пакет предназначен другому устройству.';
  RS_MASTER_FIFO_COUNT                       = 'Количество FIFO регистров превышает допустимое.';
  RS_MASTER_MEI                              = 'Функция 43. Данный MEI не поддерживается.';
  RS_MASTER_RDIC                             = 'Данный код чтения устройства не реализован.';
  RS_MASTER_MOREFOLLOWS                      = 'Недопустимое значение MoreFollows.';

  RS_MASTER_FUNCTION_CODE                    = 'Неверный код функции в ответном сообщении.';

  RS_MASTER_F72_CHKRKEY                      = 'Ключ переданный в ответе не соответствует ожидаемому.';
  RS_MASTER_F72_QUANTITY                     = 'Количество регистров в ответе выходит за допустимый диапазон.';
  RS_MASTER_F72_CRC                          = 'Ошибка CRC блока данных.';

  rsExceptXmlNotAssigned                     = 'Объект XML документа не задан.';
  rsExceptXlmNoNode                          = '%s Тег %s отсутствует в документе';
  rsExceptXlmNoAttr                          = '%s Тег %s. Отсутствует обязательный атрибут %s';
  rsExceptSyetemType                         = '%s Данный компилятор раcсчитан на тип системы %s. В конфигурационном файле содержится иной тип - %s';
  rsExceptSessionID                          = 'Идентификатор сессии не задан';
  rsExceptXMLAttrVal                         = '%s Тег %s. Атрибут %s имеет недопустимое значение %s';

  rsExceptAddDevAlreadyExists                = 'Устройство с адресом %d уже существует.';
  rsExceptNeitherFunctioIsNotSet             = 'Ни одна функция не установлена';


implementation

end.

