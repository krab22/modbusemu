unit LogResStrings;

{$mode objfpc}{$H+}

interface

// при добавлении строк НЕЗАБУДЬ!!! добавить эти строки в *.inc.po.en

resourcestring
  rsLogFileType   = '- Файловый';
  rsLogSteramType = '- Потоковый';
  rsUnknownType   = 'не определен';
  rsHeader        = '%s (Тип данных лога %s)';

  rsFileReopen    = 'Перезапуск лога.';
  rsFileClose     = 'Остановка ведения лога.';
  rsGenCurFile1   = 'Новый файл не создан.';

  rsErrDirCreate  = 'Не удается создать каталог (%s) для хранения логов.';

  rsDebug       = 'Debug';
  rsInfo        = 'Info';
  rsWarning     = 'Warning';
  rsError       = 'Error';
  rsUnknownHost = 'unknown_host'; //< Имя компьютера извлечь не удалось.
  rsUnknownApp  = 'unknown_app';  //< Имя приложения извлечь не удалось.
  rsStartLog    = 'Create log file';
  rsCloseLog    = 'Close log file';
  rsStopLog     = 'Stop logging thread';

implementation

end.

