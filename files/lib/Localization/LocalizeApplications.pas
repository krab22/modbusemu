unit LocalizeApplications;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils;

procedure TranslateAppFromPoFile(APoFileName : String);
function TranslateWithTranslator(AComponent : TPersistent) : Boolean;

implementation

uses Forms, Translations, LCLTranslator, LResources, LazFileUtils;

function TranslateWithTranslator(AComponent : TPersistent) : Boolean;
begin
  Result := False;
  if not Assigned(AComponent) then Exit;
  if not Assigned(LRSTranslator) then Exit;
  if not (LRSTranslator is TPOTranslator) then Exit;
  if not (LRSTranslator is TDefaultTranslator) then Exit;
  TUpdateTranslator(LRSTranslator).UpdateTranslation(AComponent);
  Result := True;
end;

procedure TranslateAppFromPoFile(APoFileName : String);
var LocalTranslator: TPOTranslator;
    i, Count : Integer;
begin
  if APoFileName = '' then Exit;
  if not FileExistsUTF8(APoFileName) then Exit;

  LocalTranslator := nil;

  Translations.TranslateResourceStrings(APoFileName);
  LocalTranslator := TPOTranslator.Create(APoFileName);

  if not Assigned(LocalTranslator) then Exit;

  if Assigned(LRSTranslator) then FreeAndNil(LRSTranslator);
  LRSTranslator := LocalTranslator;

  Count := Screen.CustomFormCount - 1;
  for i:= 0 to Count do LocalTranslator.UpdateTranslation(Screen.CustomForms[i]);
  Count := Screen.DataModuleCount - 1;
  for i := 0 to Count do LocalTranslator.UpdateTranslation(Screen.DataModules[i]);
end;

finalization
  if Assigned(LRSTranslator) then FreeAndNil(LRSTranslator);

end.

