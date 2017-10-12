unit Localize;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils;

procedure TranslateAppResourcestrungs;
procedure TranslateAppObject(ATranslatedObject : TPersistent);

var POFullFileName : String;

implementation

uses {strutils,} Translations, LCLTranslator, LResources;

var ObjTraslator : TPOTranslator;

procedure TranslateAppObject(ATranslatedObject : TPersistent);
begin
  if POFullFileName = '' then Exit;
  if not Assigned(ObjTraslator) then Exit;
  if not Assigned(ATranslatedObject) then Exit;

  ObjTraslator.UpdateTranslation(ATranslatedObject);
end;

procedure TranslateAppResourcestrungs;
begin
  if POFullFileName = '' then Exit;
  TranslateResourceStrings(POFullFileName);
end;

procedure Initialize;
var TempFileName : String;
begin
  POFullFileName := '';
  {$IFDEF WINDOWS}
  TempFileName := StringReplace(ParamStr(0),'.exe','.po',[rfIgnoreCase,rfReplaceAll]);
  {$ENDIF}
  {$IFDEF UNIX}
  TempFileName := Format('%s.po',[ParamStr(0)]);
  {$ENDIF}
  if not FileExists(TempFileName) then Exit;

  POFullFileName := TempFileName;

  ObjTraslator := TPOTranslator.Create(POFullFileName);
  if not Assigned(ObjTraslator) then Exit;

  if Assigned(LRSTranslator) then FreeAndNil(LRSTranslator);
  LRSTranslator := ObjTraslator;
end;

procedure finalize;
begin
  if Assigned(LRSTranslator) then FreeAndNil(LRSTranslator);
  ObjTraslator := nil;
end;

initialization
Initialize;

finalization;
finalize;

end.

