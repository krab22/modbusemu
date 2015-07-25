{
$Author: npcprom\fomin_k $
$Date: 2013-10-15 16:24:14 +0600 (Tue, 15 Oct 2013) $
$Rev: 424 $
}
unit LogConst;

{$mode objfpc}{$H+}

interface

resourcestring
  rsDebug       = 'Debug';
  rsInfo        = 'Info';
  rsWarning     = 'Warning';
  rsError       = 'Error';
  rsUnknownHost = 'unknown_host'; //< Имя компьютера извлечь не удалось.
  rsUnknownApp  = 'unknown_app';  //< Имя приложения извлечь не удалось.

const
  logExtension = 'csv';  //< Расширение файла журнала.
  msgDelimiter = ';';    //< Разделитель параметров в сообщении журнала.
  msgEOL       = #13#10; //< Признак конца строки.

implementation

end.