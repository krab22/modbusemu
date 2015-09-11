unit ModbusEmuResStr;

{$mode objfpc}{$H+}

interface

resourcestring
 rsAddChennel  = 'Добавление канала';
 rsAddChennel1 = 'Добавлен канал: %s';

 rsDelChannel1 = 'Удаление канала. Не выбран канал для удаления.';
 rsDelChannel2 = 'Удаление канала';
 rsDelChannel3 = 'Удален канал: %s';

 rsOpenChennel1 = 'Открытие канала. Не выбран канал для открытия.';
 rsOpenChennel2 = 'Открытие канала';
 rsOpenChennel3 = 'Открыт канал: %s';
 rsOpenChennel4 = 'Не удалось открыть канал: %s';

 rsCloseChennel1 = 'Закрытие канала. Не выбран канал для закрытия.';
 rsCloseChennel2 = 'Закрытие канала';
 rsCloseChennel3 = 'Не удалось закрыть канал: %s';
 rsCloseChennel4 = 'Закрыли канал канал: %s';

 rsOpenChennelAll1 = 'Открытие всех каналов';
 rsOpenChennelAll2 = 'Все каналы открыты';

 rsCloseChennelAll1 = 'Закрытие всех каналов';
 rsCloseChennelAll2 = 'Все каналы закрыты';

 rsDelChennelAll1 = 'Удаление всех каналов';
 rsDelChennelAll2 = 'Все каналы удалены';

 rsDevAdd1 = 'Ошибка ввода номера устройства. Вами введен некорректный номер устройства - %s'#10'Номер должен быть числом от 1 до 255';
 rsDevAdd2 = 'Устройство: %d';

 rsChanRS1  = 'Поток RS канала';
 rsChanTCP1 = 'Поток TCP канала';

 rsChanThreadIni   = 'Инициализация. Ошибка: %s';
 rsChanThreadClose = 'Финализация. Ошибка: %s';



implementation

end.

