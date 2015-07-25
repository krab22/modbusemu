{
$Author: npcprom\fomin_k $
$Date: 2014-01-22 14:37:04 +0600 (Wed, 22 Jan 2014) $
$Rev: 253 $
}
unit MBResourceString;

{$mode objfpc}{$H+}

interface

resourcestring
 ErrOutOfRange       = 'Выход за диапазон допустимых адресов.';
 ErrOutofChar        = 'Недопустимый символ в строке.';
 ErrIncompatibleType = 'Несовместимый тип данных.';
 ErrReadOnly         = 'Регистр предназначен только для чтения.';
 ErrInterNotValue    = 'Не задано одно из значений для инициализации интерпретатора.';
 ErrInterNotInit     = 'Интерпретатор не инициализирован данными.';
 ErrCS               = 'Ошибка контрольной суммы.';
 ErrData             = 'Ошибка инициализации данных.';

 rsSPErrorString     = '0 = Ошибка теста памяти.'#13'1 = Съем датчика.'#13'2 = Обрыв датчика.';

 rsDigitalValue      = 'значение : %d.';
 rsSPMasterSlave     = 'Основной'#13'Дублирующий';
 rsSPInfoString      = 'Нет диагностики'#13'Диагностика'#13'Температура';
 rsSPCounter         = 'Изменен счетчик осей. Значение : ';
 rsSPTemperature     = 'Температура : ';
 rsSPMZD             = 'Металл в зоне датчика.';
 rsSPNoneState       = 'Неопределенное состояние.';
 rsNoNameFlag        = 'Неопределенный флаг.';
 rsNoNameFlagValue   = '%s. Значение : %d';
 rsNoNameStrFlagValue = '%s значение : %s';

implementation

end.