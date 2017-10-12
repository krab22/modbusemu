unit MBArchiverTypes;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils;

type

  TMBArchiverRangeType = (artWord, artBoolean);

  TMBArchRecord = record
    TimeStamp : TDateTime;
    DevNum    : Byte;
    Start     : Word;
    Len       : Integer;
    RegsData  : PWordarray;
  end;
  PMBArchRecord = ^TMBArchRecord;

  TMBArchRecordBool = record
    TimeStamp : TDateTime;
    DevNum    : Byte;
    Start     : Word;
    Len       : Integer;
    RegsData  : PByteArray;
  end;
  PMBArchRecordBool = ^TMBArchRecordBool;

  TMBWordArchRecord = record
    TimeStamp : TDateTime;
    RegsData  : PWordarray;
  end;
  PMBWordArchRecord = ^TMBWordArchRecord;

  TMBBoolArchRecord = record
    TimeStamp : TDateTime;
    RegsData  : PByteArray;
  end;
  PMBBoolArchRecord = ^TMBBoolArchRecord;

implementation

end.

