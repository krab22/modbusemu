unit SumoSystemType;

{$mode objfpc}{$H+}

interface

type

  TSumoSystemType = (stNoType, stEsso, stEssoM,stEssoMv2);
  TSumoSystemTypeSet = set of TSumoSystemType;
  TSumoSystemTypeArrayName = Array[TSumoSystemType] of String;

const
  DEF_ADDR            = '127.0.0.1';
  DEF_PORT            = 80;
  DEF_MAX_RETRY_COUNT = 5;
  DEF_RETRY_INTERVAL  = 5000;

  SUMO_NOTYPE    = 'notype';
  SUMO_ESSO      = 'esso';
  SUMO_ESSO_M    = 'esso-m';
  SUMO_ESSO_M_v2 = 'esso-m-2';

  SystemTypeNames : TSumoSystemTypeArrayName = (SUMO_NOTYPE,SUMO_ESSO, SUMO_ESSO_M,SUMO_ESSO_M_v2);

  function GetSystemIDFromString(AName : String): TSumoSystemType;

implementation

uses sysutils;

function GetSystemIDFromString(AName : String): TSumoSystemType;
begin
  Result := stNoType;
  if SameText(SUMO_ESSO,AName)then Result := stEsso;
  if SameText(SUMO_ESSO_M,AName)then Result := stEssoM;
  if SameText(SUMO_ESSO_M_v2,AName)then Result := stEssoMv2;
end;

end.
