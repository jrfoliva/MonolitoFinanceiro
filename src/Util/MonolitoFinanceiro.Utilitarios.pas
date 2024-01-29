unit MonolitoFinanceiro.Utilitarios;

interface

uses
  Vcl.Controls;
type
  TUtilitarios = class
    class function GetID : String;

    private

    public
      procedure MoveFocusToNextComponent(CurrentComponent, NextComponent: TWinControl);

  end;

implementation

uses
  System.SysUtils, Vcl.StdCtrls;

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

procedure TUtilitarios.MoveFocusToNextComponent(CurrentComponent, NextComponent: TWinControl);
begin
  if (NextComponent <> nil) and (NextComponent.Enabled) then
  begin
    NextComponent.SetFocus;
    if (NextComponent is TCustomEdit) then
      TCustomEdit(NextComponent).SelectAll; // Seleciona todo o texto se o próximo componente for um edit
  end;
end;

end.
