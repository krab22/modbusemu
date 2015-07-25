unit SocketResStrings;

{$mode objfpc}{$H+}

interface

resourcestring
  rsServerSocketName     = 'Сервер';
  rsClientConnectionName = 'Клиентское соединение';

  rsNameErrEventGeneral    = 'Сокет. Общие ошибки(eeGeneral)';
  rsNameErrEventSend       = 'Сокет. Ошибки отсылки данных(eeSend)';
  rsNameErrEventReceive    = 'Сокет. Ошибки приема данных(eeReceive)';
  rsNameErrEventConnect    = 'Сокет. Ошибки при соединении(eeConnect)';
  rsNameErrEventDisconnect = 'Сокет. Ошибки при разъединении(eeDisconnect)';
  rsNameErrEventAccept     = 'Сокет. Ошибки accept';
  rsNameErrEventLookup     = 'Сокет. Ошибки lookup';
  rsNameErrEventSelect     = 'Сокет. Ошибки select';
  rsNameErrEventBind       = 'Сокет. Ошибки связывания(eeBind)';
  rsNameErrEventSocket     = 'Сокет. Ошибки сокета(eeSocket)';
  rsNameErrEventNone       = 'Сокет. Не известные ошибки(eeNone)';

  rsErrorCode  = 'Код ошибки: %d';

  rsNameSocketEventLookup     = 'Сокет. (Lookup)';
  rsNameSocketEventConnecting = 'Сокет. Установка соединения (Connecting)';
  rsNameSocketEventConnect    = 'Сокет. Установка соединения (Connect)';
  rsNameSocketEventDisconnect = 'Сокет. Разрыв соединения (Disconnect)';
  rsNameSocketEventListen     = 'Сокет. Ожидание подключения (Listen)';
  rsNameSocketEventAccept     = 'Сокет. Подтверждение подключения (Accept)';
  rsNameSocketEventWrite      = 'Сокет. Запись данных (Write)';
  rsNameSocketEventRead       = 'Сокет. Чтение данных (Read)';
  rsNameSocketEventSelect     = 'Сокет. Получение состояния (Select)';
  rsNameSocketEventBind       = 'Сокет. Связываение (Bind)';

implementation

end.

