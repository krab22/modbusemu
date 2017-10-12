unit LogConst;

{$mode objfpc}{$H+}

interface

const
  logExtension   = 'csv';     //< Расширение файла журнала.
  msgDelimiter   = ';';       //< Разделитель параметров в сообщении журнала.
  msgEOL         = #13#10;    //< Признак конца строки.
  defFileLogPrx  = 'filelog'; //< Префикс файла лога
  defFileLogExt  = '.log';    //< Расширение файла лога
  defFileMaxSize = 1048576;   //< Максимальный размер лог-файла по умолчанию.

implementation

end.
