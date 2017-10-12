unit DispatcherResStrings;

{$mode objfpc}{$H+}

interface

// при добавлении строк НЕЗАБУДЬ!!! добавить эти строки в *.inc.po.en

resourcestring
  rsECreateReader    = 'Функция %d не поддерживается в данный момент.';
  rsEAllocPackage    = 'Функция %d не поддерживается в данный момент.';
  rsDispThread       = 'Поток диспетчера соединений';
  rsEDispThread1     = 'Соединение с сервером %s разорвано. Пауза до попытки восстановления %d ms.';
  rsEDispThread2     = 'Не удалось восстановить соединение с сервером %s';
  rsEDispThread3     = 'Ошибка отправки запроса: %u';
  rsEDispThread4     = 'Не пришел ответ на запрос: %d::%d::%d';
  rsEDispThread5     = 'Ответ нулевой длины';
  rsEDispThread6     = 'Разбор сообщения. Исключение: %s';
  rsEDispThread7     = 'Исключение: %s';
  rsDispESSOM        = 'Диспетчер соединений';
  rsDispESSOM1       = 'Соединение с сервером %s:%d установлено.';
  rsDispESSOM2       = 'Соединение с сервером %s:%d разорвано';
  rsDispESSOM3       = 'Сокет: %s:%d Ошибка: %d - %s';
  rsEDestroy1        = 'TDispatcherModbusDevice.Destroy';
  rsEDestroy2        = 'Ошибка отказа от подписки: %s';
  rsEPBRCPack1       = 'ProcessBitRegChangesPackage';
  rsEPBRCPack2       = 'Не совпадает номер устройства в пакете обновления. Устройство: %d. Пакет: %d';
  rsEPBRCPack3       = 'Количество переменных в обновлении и запросе не совпадает. Запрос: %d. Пакет: %d';
  rsEPBRCPack4       = 'Установка значения регистров: %s';
  rsEPBRCPack6       = 'Номер функции не соответствует типу пакета. Функция: %d';
  rsEPBRCPack7       = 'Ошибка отсылки данных типа Boolean: %s';
  rsEPWRCPack1       = 'ProcessWordRegChangesPackage';
  rsEPWRCPack2       = 'Ошибка отсылки данных типа Word: %s';
  rsESetCoilValue    = 'SetCoilValue';
  rsESetDiscretValue = 'SetDiscretValue';
  rsESetHoldingValue = 'SetHoldingValue';
  rsESetInputValue   = 'SetInputValue';
  rsEItfDisp         = 'Нет интерфейса диспетчера. Значение изменено в модели.';
  rsEItfDisp1        = 'Не задан интерфейс диспетчера';

  rsSetThread        = 'Поток записи значений Modbus';
  rsESetThread1      = 'Отправлены не все данные.';
  rsESetThread2      = 'Получение ответа. Ошибка получения данных: %u';
  rsESetThread3      = 'Получение ответа. Ошибка выделения памяти';
  rsESetThread4      = 'Разбор ответа. Пришел пакет с идентификатором другой транзакции.';
  rsESetThread5      = 'Разбор ответа. Ошибка записи регистра';
  rsESetThread6      = 'Execute error: %s';
  rsESetThread7      = 'InitThread error: %s';
  rsESetThread8      = 'CloseThread error: %s';
  rsESetThread9      = 'Сокет: %s:%d Ошибка: %d - %s';

  rsSetCoilValue1    = 'При записи значения регистра %d возникло исключение: %s';
  rsSetCoilValue2    = 'Не удалось записать значение регистра %d';

  rsSetDiskretValue1 = 'Modbus Discret-регистры являются регистрами только для чтения.';

  rsSetHoldingValue1 = 'Modbus Holding-регистры являются регистрами только для чтения.';

  rsSetCoilValue11   = 'Интерфейс устройства не задан.';
  rsSetCoilValue12   = 'Поток отправки данных не активен.';

  rsDevDebug2        = 'ARegStart: %d ARegQuantity: %d';
  rsDevDebug3        = 'SendEvent';
  rsDevDebug4        = 'ID: %s. Устройство: %d. Code1: %d. Code2: %d Connect.';
  rsDevDebug5        = 'ID: %s. Устройство: %d. Code1: %d. Code2: %d Disconnect.';
  rsDevDebug6        = 'ID: %s. Устройство: %d. Code1: %d. Code2: %d Receive.';
  rsDevDebug7        = 'ID: %s. Устройство: %d. Code1: %d. Code2: %d Send.';
  rsDevDebug8        = 'ID: %s. Устройство: %d. Code1: %d. Code2: %d MBError.';
  rsDevDebug9        = 'ID: %s. Устройство: %d. Code1: %d. Code2: %d SocketError.';

  rsDevDebug10       = 'Discret. Добавлена единица опроса: %d::%d::%d';
  rsDevDebug12       = 'Coil. Добавлена единица опроса: %d::%d::%d';
  rsDevDebug13       = 'Holding. Добавлена единица опроса: %d::%d::%d';
  rsDevDebug14       = 'Input. Добавлена единица опроса: %d::%d::%d';

  rsDevDebug16       = 'Добавлено устройство: %d';

  rsDevExcept1       = '%s';
  rsDevExcept2       = '%s';

  rsDevice1          = 'Discret registers - StartAddress.';
  rsDevice2          = 'Discret registers.';
  rsDevice3          = 'Discret registers - Quantity.';
  rsDevice4          = 'Discret registers.';
  rsDevice5          = 'Coil registers.';
  rsDevice6          = 'Input registers.';
  rsDevice7          = 'Holding registers.';

implementation

end.

