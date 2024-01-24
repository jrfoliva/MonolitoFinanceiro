unit MonolitoFinanceiro.Utilitarios;

interface
type
  TUtilitarios = class
    class function GetID : String;
  end;

implementation

uses
  System.SysUtils;

{ TUtilitario }

class function TUtilitarios.GetID: String;
var
  LStrAux: String;
begin
  // Gera Id neste Formato  ['{9D96C0A7-984E-4A4F-8CBE-AEB5E84C5174}']
  LStrAux := TGUID.NewGuid.ToString;
  LStrAux := StringReplace(LStrAux, '{', '', [rfReplaceAll]);
  LStrAux := StringReplace(LStrAux, '}', '', [rfReplaceAll]);

  Result := LStrAux;
end;

end.
