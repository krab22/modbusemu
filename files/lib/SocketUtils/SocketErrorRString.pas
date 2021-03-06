unit SocketErrorRString;

interface

// при добавлении строк НЕЗАБУДЬ!!! добавить эти строки в *.inc.po.en

resourcestring
  rsMiscSocketErrEvent1  = 'Неизвестное событие.';
  rsMiscSocketErrEvent2  = 'Общее.';
  rsMiscSocketErrEvent3  = 'Посылка данных.';
  rsMiscSocketErrEvent4  = 'Прием данных.';
  rsMiscSocketErrEvent5  = 'Соединение.';
  rsMiscSocketErrEvent6  = 'Отсоединение.';
  rsMiscSocketErrEvent7  = 'Подтверждение.';
  rsMiscSocketErrEvent8  = 'Поиск.';

  rsUNKNOWN_ERR                = 'Ошибка: %d - %s';

// взято с http://msdn.microsoft.com/en-us/library/ms740668(VS.85).aspx

  rsWSA_INVALID_HANDLE         = 'Specified event object handle is invalid.';
  rsWSA_NOT_ENOUGH_MEMORY      = 'Insufficient memory available.';
  rsWSA_INVALID_PARAMETER      = 'One or more parameters are invalid.';
  rsWSA_OPERATION_ABORTED      = 'Overlapped operation aborted.';
  rsWSA_IO_INCOMPLETE          = 'Overlapped I/O event object not in signaled state.';
  rsWSA_IO_PENDING             = 'Overlapped operations will complete later.';
  rsWSAEINTR                   = 'Interrupted function call.';
  rsWSAEBADF                   = 'File handle is not valid.';
  rsWSAEACCES                  = 'Permission denied.';
  rsWSAEFAULT                  = 'Bad address.';
  rsWSAEINVAL                  = 'Invalid argument.';
  rsWSAEMFILE                  = 'Too many open files.';
  rsWSAEWOULDBLOCK             = 'Resource temporarily unavailable.';
  rsWSAEINPROGRESS             = 'Operation now in progress.';
  rsWSAEALREADY                = 'Operation already in progress.';
  rsWSAENOTSOCK                = 'Socket operation on nonsocket.';
  rsWSAEDESTADDRREQ            = 'Destination address required.';
  rsWSAEMSGSIZE                = 'Message too long.';
  rsWSAEPROTOTYPE              = 'Protocol wrong type for socket.';
  rsWSAENOPROTOOPT             = 'Bad protocol option.';
  rsWSAEPROTONOSUPPORT         = 'Protocol not supported.';
  rsWSAESOCKTNOSUPPORT         = 'Socket type not supported.';
  rsWSAEOPNOTSUPP              = 'Operation not supported.';
  rsWSAEPFNOSUPPORT            = 'Protocol family not supported.';
  rsWSAEAFNOSUPPORT            = 'Address family not supported by protocol family.';
  rsWSAEADDRINUSE              = 'Address already in use.';
  rsWSAEADDRNOTAVAIL           = 'Cannot assign requested address.';
  rsWSAENETDOWN                = 'Network is down.';
  rsWSAENETUNREACH             = 'Network is unreachable.';
  rsWSAENETRESET               = 'Network dropped connection on reset.';
  rsWSAECONNABORTED            = 'Software caused connection abort.';
  rsWSAECONNRESET              = 'Connection reset by peer.';
  rsWSAENOBUFS                 = 'No buffer space available.';
  rsWSAEISCONN                 = 'Socket is already connected.';
  rsWSAENOTCONN                = 'Socket is not connected.';
  rsWSAESHUTDOWN               = 'Cannot send after socket shutdown.';
  rsWSAETOOMANYREFS            = 'Too many references.';
  rsWSAETIMEDOUT               = 'Connection timed out.';
  rsWSAECONNREFUSED            = 'Connection refused.';
  rsWSAELOOP                   = 'Cannot translate name.';
  rsWSAENAMETOOLONG            = 'Name too long.';
  rsWSAEHOSTDOWN               = 'Host is down.';
  rsWSAEHOSTUNREACH            = 'No route to host.';
  rsWSAENOTEMPTY               = 'Directory not empty.';
  rsWSAEPROCLIM                = 'Too many processes.';
  rsWSAEUSERS                  = 'User quota exceeded.';
  rsWSAEDQUOT                  = 'Disk quota exceeded.';
  rsWSAESTALE                  = 'Stale file handle reference.';
  rsWSAEREMOTE                 = 'Item is remote.';
  rsWSASYSNOTREADY             = 'Network subsystem is unavailable.';
  rsWSAVERNOTSUPPORTED         = 'Winsock.dll version out of range.';
  rsWSANOTINITIALISED          = 'Successful WSAStartup not yet performed.';
  rsWSAEDISCON                 = 'Graceful shutdown in progress.';
  rsWSAENOMORE                 = 'No more results.';
  rsWSAECANCELLED              = 'Call has been canceled.';
  rsWSAEINVALIDPROCTABLE       = 'Procedure call table is invalid.';
  rsWSAEINVALIDPROVIDER        = 'Service provider is invalid.';
  rsWSAEPROVIDERFAILEDINIT     = 'Service provider failed to initialize.';
  rsWSASYSCALLFAILURE          = 'System call failure.';
  rsWSASERVICE_NOT_FOUND       = 'Service not found.';
  rsWSATYPE_NOT_FOUND          = 'Class type not found.';
  rsWSA_E_NO_MORE              = 'No more results.';
  rsWSA_E_CANCELLED            = 'Call was canceled.';
  rsWSAEREFUSED                = 'Database query was refused.';
  rsWSAHOST_NOT_FOUND          = 'Host not found.';
  rsWSATRY_AGAIN               = 'Nonauthoritative host not found.';
  rsWSANO_RECOVERY             = 'This is a nonrecoverable error.';
  rsWSANO_DATA                 = 'Valid name, no data record of requested type.';
  rsWSA_QOS_RECEIVERS          = 'QOS receivers.';
  rsWSA_QOS_SENDERS            = 'QOS senders.';
  rsWSA_QOS_NO_SENDERS         = 'No QOS senders.';
  rsWSA_QOS_NO_RECEIVERS       = 'QOS no receivers.';
  rsWSA_QOS_REQUEST_CONFIRMED  = 'QOS request confirmed.';
  rsWSA_QOS_ADMISSION_FAILURE  = 'QOS admission error.';
  rsWSA_QOS_POLICY_FAILURE     = 'QOS policy failure.';
  rsWSA_QOS_BAD_STYLE          = 'QOS bad style.';
  rsWSA_QOS_BAD_OBJECT         = 'QOS bad object.';
  rsWSA_QOS_TRAFFIC_CTRL_ERROR = 'QOS traffic control error.';
  rsWSA_QOS_GENERIC_ERROR      = 'QOS generic error.';
  rsWSA_QOS_ESERVICETYPE       = 'QOS service type error.';
  rsWSA_QOS_EFLOWSPEC          = 'QOS flowspec error.';
  rsWSA_QOS_EPROVSPECBUF       = 'Invalid QOS provider buffer.';
  rsWSA_QOS_EFILTERSTYLE       = 'Invalid QOS filter style.';
  rsWSA_QOS_EFILTERTYPE        = 'Invalid QOS filter type.';
  rsWSA_QOS_EFILTERCOUNT       = 'Incorrect QOS filter count.';
  rsWSA_QOS_EOBJLENGTH         = 'Invalid QOS object length.';
  rsWSA_QOS_EFLOWCOUNT         = 'Incorrect QOS flow count.';
  rsWSA_QOS_EUNKOWNPSOBJ       = 'Unrecognized QOS object.';
  rsWSA_QOS_EPOLICYOBJ         = 'Invalid QOS policy object.';
  rsWSA_QOS_EFLOWDESC          = 'Invalid QOS flow descriptor.';
  rsWSA_QOS_EPSFLOWSPEC        = 'Invalid QOS provider-specific flowspec.';
  rsWSA_QOS_EPSFILTERSPEC      = 'Invalid QOS provider-specific filterspec.';
  rsWSA_QOS_ESDMODEOBJ         = 'Invalid QOS shape discard mode object.';
  rsWSA_QOS_ESHAPERATEOBJ      = 'Invalid QOS shaping rate object.';
  rsWSA_QOS_RESERVED_PETYPE    = 'Reserved policy QOS element type.';

{$IFDEF WINDOWS}
  rsLongWSA_INVALID_HANDLE         = 'An application attempts to use an event object, but the specified handle is not valid. Note that this error is returned by the operating system, so the error number may change in future releases of Microsoft Windows.';
  rsLongWSA_NOT_ENOUGH_MEMORY      = 'A application used a Windows Sockets function that directly maps to a Windows function. The Windows function is indicating a lack of required memory resources. Note that this error is returned by the operating system, so the error number may change in future releases of Microsoft Windows.';
  rsLongWSA_INVALID_PARAMETER      = 'An application used a Windows Sockets function which directly maps to a Windows function. The Windows function is indicating a problem with one or more parameters. Note that this error is returned by the operating system, so the error number may change in future releases of Microsoft Windows.';
  rsLongWSA_OPERATION_ABORTED      = 'An overlapped operation was canceled due to the closure of the socket, or the execution of the SIO_FLUSH command in WSAIoctl. Note that this error is returned by the operating system, so the error number may change in future releases of Microsoft Windows.';
  rsLongWSA_IO_INCOMPLETE          = 'The application has tried to determine the status of an overlapped operation which is not yet completed. Applications that use WSAGetOverlappedResult (with the fWait flag set to FALSE) in a polling mode to determine when an overlapped operation has completed, get this error code until the operation is complete. Note that this error is returned by the operating system, so the error number may change in future releases of Microsoft Windows.';
  rsLongWSA_IO_PENDING             = 'The application has initiated an overlapped operation that cannot be completed immediately. A completion indication will be given later when the operation has been completed. Note that this error is returned by the operating system, so the error number may change in future releases of Microsoft Windows.';
  rsLongWSAEINTR                   = 'A blocking operation was interrupted by a call to WSACancelBlockingCall.';
  rsLongWSAEBADF                   = 'The file handle supplied is not valid.';
  rsLongWSAEACCES                  = 'An attempt was made to access a socket in a way forbidden by its access permissions. An example is using a broadcast address for sendto without broadcast permission being set using setsockopt(SO_BROADCAST).'#13#10+
                                     'Another possible reason for the WSAEACCES error is that when the bind function is called (on Windows NT 4.0 with SP4 and later), another application, service, or kernel mode driver is bound to the same address with exclusive access. Such exclusive access is a new feature of Windows NT 4.0 with SP4 and later, and is implemented by using the SO_EXCLUSIVEADDRUSE option.';
  rsLongWSAEFAULT                  = 'The system detected an invalid pointer address in attempting to use a pointer argument of a call. This error occurs if an application passes an invalid pointer value, or if the length of the buffer is too small. For instance, if the length of an argument, which is a sockaddr structure, is smaller than the sizeof(sockaddr).';
  rsLongWSAEINVAL                  = 'Some invalid argument was supplied (for example, specifying an invalid level to the setsockopt function). In some instances, it also refers to the current state of the socket—for instance, calling accept on a socket that is not listening.';
  rsLongWSAEMFILE                  = 'Too many open sockets. Each implementation may have a maximum number of socket handles available, either globally, per process, or per thread.';
  rsLongWSAEWOULDBLOCK             = 'This error is returned from operations on nonblocking sockets that cannot be completed immediately, for example recv when no data is queued to be read from the socket. It is a nonfatal error, and the operation should be retried later. It is normal for WSAEWOULDBLOCK to be reported as the result from calling connect on a nonblocking SOCK_STREAM socket, since some time must elapse for the connection to be established.';
  rsLongWSAEINPROGRESS             = 'A blocking operation is currently executing. Windows Sockets only allows a single blocking operation—per- task or thread—to be outstanding, and if any other function call is made (whether or not it references that or any other socket) the function fails with the WSAEINPROGRESS error.';
  rsLongWSAEALREADY                = 'An operation was attempted on a nonblocking socket with an operation already in progress—that is, calling connect a second time on a nonblocking socket that is already connecting, or canceling an asynchronous request (WSAAsyncGetXbyY) that has already been canceled or completed.';
  rsLongWSAENOTSOCK                = 'An operation was attempted on something that is not a socket. Either the socket handle parameter did not reference a valid socket, or for select, a member of an fd_set was not valid.';
  rsLongWSAEDESTADDRREQ            = 'A required address was omitted from an operation on a socket. For example, this error is returned if sendto is called with the remote address of ADDR_ANY.';
  rsLongWSAEMSGSIZE                = 'A message sent on a datagram socket was larger than the internal message buffer or some other network limit, or the buffer used to receive a datagram was smaller than the datagram itself.';
  rsLongWSAEPROTOTYPE              = 'A protocol was specified in the socket function call that does not support the semantics of the socket type requested. For example, the ARPA Internet UDP protocol cannot be specified with a socket type of SOCK_STREAM.';
  rsLongWSAENOPROTOOPT             = 'An unknown, invalid or unsupported option or level was specified in a getsockopt or setsockopt call.';
  rsLongWSAEPROTONOSUPPORT         = 'The requested protocol has not been configured into the system, or no implementation for it exists. For example, a socket call requests a SOCK_DGRAM socket, but specifies a stream protocol.';
  rsLongWSAESOCKTNOSUPPORT         = 'The support for the specified socket type does not exist in this address family. For example, the optional type SOCK_RAW might be selected in a socket call, and the implementation does not support SOCK_RAW sockets at all.';
  rsLongWSAEOPNOTSUPP              = 'The attempted operation is not supported for the type of object referenced. Usually this occurs when a socket descriptor to a socket that cannot support this operation is trying to accept a connection on a datagram socket.';
  rsLongWSAEPFNOSUPPORT            = 'The protocol family has not been configured into the system or no implementation for it exists. This message has a slightly different meaning from WSAEAFNOSUPPORT. However, it is interchangeable in most cases, and all Windows Sockets functions that return one of these messages also specify WSAEAFNOSUPPORT.';
  rsLongWSAEAFNOSUPPORT            = 'An address incompatible with the requested protocol was used. All sockets are created with an associated address family (that is, AF_INET for Internet Protocols) and a generic protocol type (that is, SOCK_STREAM). This error is returned if an incorrect protocol is explicitly requested in the socket call, or if an address of the wrong family is used for a socket, for example, in sendto.';
  rsLongWSAEADDRINUSE              = 'Typically, only one usage of each socket address (protocol/IP address/port) is permitted. This error occurs if an application attempts to bind a socket to an IP address/port that has already been used for an existing socket, or a socket that was not closed properly, or one that is still in the process of closing. For server applications that need to bind multiple sockets to the same port number, consider using setsockopt (SO_REUSEADDR). Client applications usually need not call bind at all—connect chooses an unused port automatically. When bind is called with a wildcard address (involving ADDR_ANY), a WSAEADDRINUSE error could be delayed until the specific address is committed. This could happen with a call to another function later, including connect, listen, WSAConnect, or WSAJoinLeaf.';
  rsLongWSAEADDRNOTAVAIL           = 'The requested address is not valid in its context. This normally results from an attempt to bind to an address that is not valid for the local computer. This can also result from connect, sendto, WSAConnect, WSAJoinLeaf, or WSASendTo when the remote address or port is not valid for a remote computer (for example, address or port 0).';
  rsLongWSAENETDOWN                = 'A socket operation encountered a dead network. This could indicate a serious failure of the network system (that is, the protocol stack that the Windows Sockets DLL runs over), the network interface, or the local network itself.';
  rsLongWSAENETUNREACH             = 'A socket operation was attempted to an unreachable network. This usually means the local software knows no route to reach the remote host.';
  rsLongWSAENETRESET               = 'The connection has been broken due to keep-alive activity detecting a failure while the operation was in progress. It can also be returned by setsockopt if an attempt is made to set SO_KEEPALIVE on a connection that has already failed.';
  rsLongWSAECONNABORTED            = 'An established connection was aborted by the software in your host computer, possibly due to a data transmission time-out or protocol error.';
  rsLongWSAECONNRESET              = 'An existing connection was forcibly closed by the remote host. This normally results if the peer application on the remote host is suddenly stopped, the host is rebooted, the host or remote network interface is disabled, or the remote host uses a hard close (see setsockopt for more information on the SO_LINGER option on the remote socket). This error may also result if a connection was broken due to keep-alive activity detecting a failure while one or more operations are in progress. Operations that were in progress fail with WSAENETRESET. Subsequent operations fail with WSAECONNRESET.';
  rsLongWSAENOBUFS                 = 'An operation on a socket could not be performed because the system lacked sufficient buffer space or because a queue was full.';
  rsLongWSAEISCONN                 = 'A connect request was made on an already-connected socket. Some implementations also return this error if sendto is called on a connected SOCK_DGRAM socket (for SOCK_STREAM sockets, the to parameter in sendto is ignored) although other implementations treat this as a legal occurrence.';
  rsLongWSAENOTCONN                = 'A request to send or receive data was disallowed because the socket is not connected and (when sending on a datagram socket using sendto) no address was supplied. Any other type of operation might also return this error—for example, setsockopt setting SO_KEEPALIVE if the connection has been reset.';
  rsLongWSAESHUTDOWN               = 'A request to send or receive data was disallowed because the socket had already been shut down in that direction with a previous shutdown call. By calling shutdown a partial close of a socket is requested, which is a signal that sending or receiving, or both have been discontinued.';
  rsLongWSAETOOMANYREFS            = 'Too many references to some kernel object.';
  rsLongWSAETIMEDOUT               = 'A connection attempt failed because the connected party did not properly respond after a period of time, or the established connection failed because the connected host has failed to respond.';
  rsLongWSAECONNREFUSED            = 'No connection could be made because the target computer actively refused it. This usually results from trying to connect to a service that is inactive on the foreign host—that is, one with no server application running.';
  rsLongWSAELOOP                   = 'Cannot translate a name.';
  rsLongWSAENAMETOOLONG            = 'A name component or a name was too long.';
  rsLongWSAEHOSTDOWN               = 'A socket operation failed because the destination host is down. A socket operation encountered a dead host. Networking activity on the local host has not been initiated. These conditions are more likely to be indicated by the error WSAETIMEDOUT.';
  rsLongWSAEHOSTUNREACH            = 'A socket operation was attempted to an unreachable host. See WSAENETUNREACH.';
  rsLongWSAENOTEMPTY               = 'Cannot remove a directory that is not empty.';
  rsLongWSAEPROCLIM                = 'A Windows Sockets implementation may have a limit on the number of applications that can use it simultaneously. WSAStartup may fail with this error if the limit has been reached.';
  rsLongWSAEUSERS                  = 'Ran out of user quota.';
  rsLongWSAEDQUOT                  = 'Ran out of disk quota.';
  rsLongWSAESTALE                  = 'The file handle reference is no longer available.';
  rsLongWSAEREMOTE                 = 'The item is not available locally.';
  rsLongWSASYSNOTREADY             = 'This error is returned by WSAStartup if the Windows Sockets implementation cannot function at this time because the underlying system it uses to provide network services is currently unavailable. Users should check:';
  rsLongWSAVERNOTSUPPORTED         = 'The current Windows Sockets implementation does not support the Windows Sockets specification version requested by the application. Check that no old Windows Sockets DLL files are being accessed.';
  rsLongWSANOTINITIALISED          = 'Either the application has not called WSAStartup or WSAStartup failed. The application may be accessing a socket that the current active task does not own (that is, trying to share a socket between tasks), or WSACleanup has been called too many times.';
  rsLongWSAEDISCON                 = 'Returned by WSARecv and WSARecvFrom to indicate that the remote party has initiated a graceful shutdown sequence.';
  rsLongWSAENOMORE                 = 'No more results can be returned by the WSALookupServiceNext function.';
  rsLongWSAECANCELLED              = 'A call to the WSALookupServiceEnd function was made while this call was still processing. The call has been canceled.';
  rsLongWSAEINVALIDPROCTABLE       = 'The service provider procedure call table is invalid. A service provider returned a bogus procedure table to Ws2_32.dll. This is usually caused by one or more of the function pointers being NULL.';
  rsLongWSAEINVALIDPROVIDER        = 'The requested service provider is invalid. This error is returned by the WSCGetProviderInfo and WSCGetProviderInfo32 functions if the protocol entry specified could not be found. This error is also returned if the service provider returned a version number other than 2.0.';
  rsLongWSAEPROVIDERFAILEDINIT     = 'The requested service provider could not be loaded or initialized. This error is returned if either a service provider`s DLL could not be loaded (LoadLibrary failed) or the provider`s WSPStartup or NSPStartup function failed.';
  rsLongWSASYSCALLFAILURE          = 'A system call that should never fail has failed. This is a generic error code, returned under various conditions.'#13#10+
                                     'Returned when a system call that should never fail does fail. For example, if a call to WaitForMultipleEvents fails or one of the registry functions fails trying to manipulate the protocol/namespace catalogs.'#13#10+
                                     'Returned when a provider does not return SUCCESS and does not provide an extended error code. Can indicate a service provider implementation error.';
  rsLongWSASERVICE_NOT_FOUND       = 'No such service is known. The service cannot be found in the specified name space.';
  rsLongWSATYPE_NOT_FOUND          = 'The specified class was not found.';
  rsLongWSA_E_NO_MORE              = 'No more results can be returned by the WSALookupServiceNext function.';
  rsLongWSA_E_CANCELLED            = 'A call to the WSALookupServiceEnd function was made while this call was still processing. The call has been canceled.';
  rsLongWSAEREFUSED                = 'A database query failed because it was actively refused.';
  rsLongWSAHOST_NOT_FOUND          = 'No such host is known. The name is not an official host name or alias, or it cannot be found in the database(s) being queried. This error may also be returned for protocol and service queries, and means that the specified name could not be found in the relevant database.';
  rsLongWSATRY_AGAIN               = 'This is usually a temporary error during host name resolution and means that the local server did not receive a response from an authoritative server. A retry at some time later may be successful.';
  rsLongWSANO_RECOVERY             = 'This indicates that some sort of nonrecoverable error occurred during a database lookup. This may be because the database files (for example, BSD-compatible HOSTS, SERVICES, or PROTOCOLS files) could not be found, or a DNS request was returned by the server with a severe error.';
  rsLongWSANO_DATA                 = 'The requested name is valid and was found in the database, but it does not have the correct associated data being resolved for. The usual example for this is a host name-to-address translation attempt (using gethostbyname or WSAAsyncGetHostByName) which uses the DNS (Domain Name Server). An MX record is returned but no A record—indicating the host itself exists, but is not directly reachable.';
  rsLongWSA_QOS_RECEIVERS          = 'At least one QOS reserve has arrived.';
  rsLongWSA_QOS_SENDERS            = 'At least one QOS send path has arrived.';
  rsLongWSA_QOS_NO_SENDERS         = 'There are no QOS senders.';
  rsLongWSA_QOS_NO_RECEIVERS       = 'There are no QOS receivers.';
  rsLongWSA_QOS_REQUEST_CONFIRMED  = 'The QOS reserve request has been confirmed.';
  rsLongWSA_QOS_ADMISSION_FAILURE  = 'A QOS error occurred due to lack of resources.';
  rsLongWSA_QOS_POLICY_FAILURE     = 'The QOS request was rejected because the policy system couldn`t allocate the requested resource within the existing policy.';
  rsLongWSA_QOS_BAD_STYLE          = 'An unknown or conflicting QOS style was encountered.';
  rsLongWSA_QOS_BAD_OBJECT         = 'A problem was encountered with some part of the filterspec or the provider-specific buffer in general.';
  rsLongWSA_QOS_TRAFFIC_CTRL_ERROR = 'An error with the underlying traffic control (TC) API as the generic QOS request was converted for local enforcement by the TC API. This could be due to an out of memory error or to an internal QOS provider error.';
  rsLongWSA_QOS_GENERIC_ERROR      = 'A general QOS error.';
  rsLongWSA_QOS_ESERVICETYPE       = 'An invalid or unrecognized service type was found in the QOS flowspec.';
  rsLongWSA_QOS_EFLOWSPEC          = 'An invalid or inconsistent flowspec was found in the QOS structure.';
  rsLongWSA_QOS_EPROVSPECBUF       = 'An invalid QOS provider-specific buffer.';
  rsLongWSA_QOS_EFILTERSTYLE       = 'An invalid QOS filter style was used.';
  rsLongWSA_QOS_EFILTERTYPE        = 'An invalid QOS filter type was used.';
  rsLongWSA_QOS_EFILTERCOUNT       = 'An incorrect number of QOS FILTERSPECs were specified in the FLOWDESCRIPTOR.';
  rsLongWSA_QOS_EOBJLENGTH         = 'An object with an invalid ObjectLength field was specified in the QOS provider-specific buffer.';
  rsLongWSA_QOS_EFLOWCOUNT         = 'An incorrect number of flow descriptors was specified in the QOS structure.';
  rsLongWSA_QOS_EUNKOWNPSOBJ       = 'An unrecognized object was found in the QOS provider-specific buffer.';
  rsLongWSA_QOS_EPOLICYOBJ         = 'An invalid policy object was found in the QOS provider-specific buffer.';
  rsLongWSA_QOS_EFLOWDESC          = 'An invalid QOS flow descriptor was found in the flow descriptor list.';
  rsLongWSA_QOS_EPSFLOWSPEC        = 'An invalid or inconsistent flowspec was found in the QOS provider-specific buffer.';
  rsLongWSA_QOS_EPSFILTERSPEC      = 'An invalid FILTERSPEC was found in the QOS provider-specific buffer.';
  rsLongWSA_QOS_ESDMODEOBJ         = 'An invalid shape discard mode object was found in the QOS provider-specific buffer.';
  rsLongWSA_QOS_ESHAPERATEOBJ      = 'An invalid shaping rate object was found in the QOS provider-specific buffer.';
  rsLongWSA_QOS_RESERVED_PETYPE    = 'A reserved policy element was found in the QOS provider-specific buffer.';
{$ENDIF}


implementation

end.
