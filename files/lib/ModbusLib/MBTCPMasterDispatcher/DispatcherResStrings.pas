unit DispatcherResStrings;

{$mode objfpc}{$H+}

interface

resourcestring
  rsECreateReader = 'TMBSlavePollingItem.CreateMBTCPReader: Функция %d не поддерживается в данный момент.';
  rsEAllocPackage = 'TMBSlavePollingItem.AllocRequestPackege: Функция %d не поддерживается в данный момент.';
  rsDispThread    = 'Поток диспетчера соединений';
  rsEDispThread1  = 'Соединение с сервером %s разорвано. Пауза до попытки восстановления %g сек.';
  rsEDispThread2  = 'Не удалось восстановить соединение с сервером %s';
  rsEDispThread3  = 'Ошибка отправки запроса: %u';
  rsEDispThread4  = 'Ответ не пришел';
  rsEDispThread5  = 'Ответ нулевой длинны';
  rsEDispThread6  = 'Разбор сообщения. Исключение: %s';
  rsEDispThread7  = 'Исключение: %s';
  rsDispESSOM     = 'Диспетчер соединений ЭССО-М';
  rsDispESSOM1    = 'Соединение с сервером %s:%d установлено.';
  rsDispESSOM2    = 'Соединение с сервером %s:%d разорвано';
  rsDispESSOM3    = 'Сокет: %s:%d Ошибка: %d - %s';
  rsEDestroy1     = 'TDispatcherModbusDevice.Destroy';
  rsEDestroy2     = 'Ошибка отказа от подписки: %s';
  rsEPBRCPack1    = 'ProcessBitRegChangesPackage';
  rsEPBRCPack2    = 'Не совпадает номер устройства в пакете обновления. Устройство: %d. Пакет: %d';
  rsEPBRCPack3    = 'Количество переменных в воновлении и запросе не совпадает. Запрос: %d. Пакет: %d';
  rsEPBRCPack4    = 'Установка значения регистров: %s';
  rsEPBRCPack6    = 'Номер функции не соответствует типу пакета. Функция: %d';
  rsEPWRCPack1    = 'ProcessWordRegChangesPackage';
  rsESetCoilValue    = 'SetCoilValue';
  rsESetDiscretValue = 'SetDiscretValue';
  rsESetHoldingValue = 'SetHoldingValue';
  rsESetInputValue   = 'SetInputValue';
  rsEItfDisp     = 'Нет интерфейса диспетчера. Значение изменено в модели.';
  rsEItfDisp1    = 'Не задан интерфейс диспетчера';

  rsSetThread    = 'Поток записи значений Modbus';
  rsESetThread1  = 'Отправлены не все данные.';
  rsESetThread2  = 'Получение ответа. Ошибка получения данных: %u';
  rsESetThread3  = 'Получение ответа. Ошибка выделения памяти';
  rsESetThread4  = 'Разбор ответа. Пришел пакет с идентификатором другой транзакции.';
  rsESetThread5  = 'Разбор ответа. Ошибка записи регистра';
  rsESetThread6  = 'Execute error: %s';
  rsESetThread7  = 'InitThread error: %s';
  rsESetThread8  = 'CloseThread error: %s';
  rsESetThread9  = 'Сокет: %s:%d Ошибка: %d - %s';


implementation

end.

