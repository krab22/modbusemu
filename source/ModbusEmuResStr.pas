unit ModbusEmuResStr;

{$mode objfpc}{$H+}

interface

resourcestring

 rsAddChennel               = 'Добавление канала';
 rsAddChennel1              = 'Добавлен канал: %s';
 rsAddChennel2              = 'Добавить сетевой канал';
 rsAddChennel3              = 'Добавить';
 rsAddChennel4              = 'Добавить последовательный канал';

 rsEditChennel1             = 'Изменение сетевого канала';
 rsEditChennel2             = 'Сохранить';
 rsEditChennel3             = 'Канал %s изменен';
 rsEditChennel4             = 'Изменение последовательного канала';

 rsDelChannel1              = 'Удаление канала. Не выбран канал для удаления.';
 rsDelChannel2              = 'Удаление канала';
 rsDelChannel3              = 'Удален канал: %s';

 rsEditChennel              = 'Изменение канала. Не выбран канал для изменения.';

 rsOpenChennel1             = 'Открытие канала. Не выбран канал для открытия.';
 rsOpenChennel2             = 'Открытие канала';
 rsOpenChennel3             = 'Открыт канал: %s';
 rsOpenChennel4             = 'Не удалось открыть канал: %s';
 rsOpenChennel5             = 'Ошибка сокета: %d - %s';
 rsOpenChennel6             = 'Ошибка клиента(%s:%d): %d';
 rsOpenChennel7             = 'Серверный сокет %s:%d открыт';

 rsCloseChennel1            = 'Закрытие канала. Не выбран канал для закрытия.';
 rsCloseChennel2            = 'Закрытие канала';
 rsCloseChennel3            = 'Не удалось закрыть канал: %s';
 rsCloseChennel4            = 'Закрыли канал канал: %s';
 rsCloseChennel5            = 'Серверный сокет %s:%d закрыт';

 rsOpenChennelAll1          = 'Открытие всех каналов';
 rsOpenChennelAll2          = 'Все каналы открыты';

 rsCloseChennelAll1         = 'Закрытие всех каналов';
 rsCloseChennelAll2         = 'Все каналы закрыты';

 rsDelChennelAll1           = 'Удаление всех каналов';
 rsDelChennelAll2           = 'Все каналы удалены';

 rsDevAdd1                  = 'Ошибка ввода номера устройства. Вами введен некорректный номер устройства - %s'#10'Номер должен быть числом от 1 до 255';
 rsDevAdd2                  = 'Устройство: %d';

 rsChanRS1                  = 'Поток RS канала';
 rsChanTCP1                 = 'Поток TCP канала';

 rsChanThreadIni            = 'Инициализация. Ошибка: %s';
 rsChanThreadClose          = 'Финализация. Ошибка: %s';

 rsOnClientReceiveDataProc1 = 'Клиент: %s:%d. Ошибка разбора пакета: %s';
 rsOnClientReceiveDataProc2 = 'Клиент: %s:%d. Ошибка получения устройства: %s';
 rsOnClientReceiveDataProc3 = 'Клиент: %s:%d. Запрашивается несуществующее устройство - %d';
 rsOnClientReceiveDataProc4 = 'Клиент: %s:%d. Запрашиваемая функция(%d) не поддерживается устройством %d';

 rsSendErrorMsg1            = 'Клиент: %s:%d. Ошибка отправки пответа: %d';

 rsResponseF1_1             = 'Клиент: %s:%d. Ошибка получения значений Coil регистров(%d:%d:%d): %s';
 rsResponseF1_2             = 'Клиент: %s:%d. Read Coils. Не удалось отправить ответ на запрос.';
 rsResponseF1_3             = 'Клиент: %s:%d. Read Coils. Отправили ответ на запрос клиента.';

 rsResponseF2_1             = 'Клиент: %s:%d. Ошибка получения значений Discrete регистров(%d:%d:%d): %s';
 rsResponseF2_2             = 'Клиент: %s:%d. Read Discrete. Не удалось отправить ответ на запрос.';
 rsResponseF2_3             = 'Клиент: %s:%d. Read Discrete. Отправили ответ на запрос клиента.';

 rsResponseF3_1             = 'Клиент: %s:%d. Ошибка получения значений Holding регистров(%d:%d:%d): %s';
 rsResponseF3_2             = 'Клиент: %s:%d. Read Holding. Не удалось отправить ответ на запрос.';
 rsResponseF3_3             = 'Клиент: %s:%d. Read Holding. Отправили ответ на запрос клиента.';

 rsResponseF4_1             = 'Клиент: %s:%d. Ошибка получения значений Input регистров(%d:%d:%d): %s';
 rsResponseF4_2             = 'Клиент: %s:%d. Read Input. Не удалось отправить ответ на запрос.';
 rsResponseF4_3             = 'Клиент: %s:%d. Read Input. Отправили ответ на запрос клиента.';

 rsResponseF5_1             = 'Клиент: %s:%d. Ошибка записи значений Coil регистров(%d:%d:%d): %s';
 rsResponseF5_2             = 'Клиент: %s:%d. Write Coils. Не удалось отправить ответ на запрос.';
 rsResponseF5_3             = 'Клиент: %s:%d. Write Coils. Отправили ответ на запрос клиента.';

 rsResponseF6_1             = 'Клиент: %s:%d. Ошибка записи значений Input регистров(%d:%d:%d): %s';
 rsResponseF6_2             = 'Клиент: %s:%d. Write Input. Не удалось отправить ответ на запрос.';
 rsResponseF6_3             = 'Клиент: %s:%d. Write Input. Отправили ответ на запрос клиента.';

 rsResponseF15_1            = 'Клиент: %s:%d. Попытка вызова нереализованной функции 15';
 rsResponseF16_1            = 'Клиент: %s:%d. Попытка вызова нереализованной функции 16';
 rsResponseF17_1            = 'Клиент: %s:%d. Попытка вызова нереализованной функции 17';

 rsClientConnect1           = 'Канал: %s:%d. Присоеденился клиент: %s:%d';

 rsClientDisconnect1        = 'Канал: %s:%d. Отсоеденился клиент: %s:%d';

 rsFrmAddTCPChannel1        = 'Добавление сетевого канала';
 rsFrmAddTCPChannel2        = 'Все поля должны быть заполнены.';
 rsFrmAddTCPChannel3        = 'Ошибка во введенном адресе: %s';
 rsFrmAddTCPChannel4        = 'Вы совершили ошибку при вводе адреса канала: %s. Должен быть введен корректный IP-адрес.';
 rsFrmAddTCPChannel5        = 'Ошибка во введенном номере порта: %s';
 rsFrmAddTCPChannel6        = 'Вы совершили ошибку при вводе номере порта канала: %s. Должен быть введен корректный номер порта в диапазоне от 1 до 65535.';
 rsFrmAddTCPChannel7        = 'Канал с указанными параметрами (%s:%s:%s) уже существует.';
 rsFrmAddTCPChannel8        = 'Добавили сетевой канал: %s:%s:%d';
 rsFrmAddTCPChannel9        = 'При добавлении канала произошла ошибка: %s';

 rsOnServerReadProc1        = 'Ошибка чтения из порта: %d - %s';
 rsOnServerReadProc2        = 'Ошибка разбора пакета: %s';
 rsOnServerReadProc3        = 'Порт №%d. Ошибка получения устройства: %s';
 rsOnServerReadProc4        = 'Порт №%d. Запрашивается несуществующее устройство - %d';
 rsOnServerReadProc5        = 'Порт %d. Запрашиваемая функция(%d) не поддерживается устройством %d';

 rsMBObj                    = 'ResponseF1';
 rsMBObj1                   = 'ResponseF2';
 rsMBObj2                   = 'SendErrorMsg';

 rsMBError1                 = 'Порт %d. Ошибка получения значений Coil регистров(%d:%d:%d): %s';
 rsMBError2                 = 'Ошибка отправки ответа';
 rsMBError3                 = 'Порт %d. Ошибка получения значений Discret регистров(%d:%d:%d): %s';
 rsMBError4                 = 'Ошибка записи пакета в порт.';
 rsMBError5                 = 'Признак нестандартного префикса установлен, а сам префикс не задан.';


implementation

end.

