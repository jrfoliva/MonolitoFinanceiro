unit MonolitoFinanceiro.Model.Usuarios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  MonolitoFinanceiro.Model.Conexao;

type
  TdmUsuarios = class(TDataModule)
    sqlUsuarios: TFDQuery;
    cdsUsuarios: TClientDataSet;
    dspUsuarios: TDataSetProvider;
    cdsUsuariosID: TStringField;
    cdsUsuariosNOME: TStringField;
    cdsUsuariosLOGIN: TStringField;
    cdsUsuariosSENHA: TStringField;
    cdsUsuariosSTATUS: TStringField;
    cdsUsuariosDATA_CADASTRO: TDateField;
  private
    FNomeUsuarioLogado: String;
    FLoginUsuarioLogado: String;
    FIDUsuarioLogado: String;
    procedure SetIDUsuarioLogado(const Value: String);
    procedure SetLoginUsuarioLogado(const Value: String);
    procedure SetNomeUsuarioLogado(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    function TemLoginCadastrado(Login, ID: String): Boolean;
    procedure EfetuarLogin(Login: String; Senha: String);

    property NomeUsuarioLogado: String read FNomeUsuarioLogado write FNomeUsuarioLogado;
    property LoginUsuarioLogado: String read FLoginUsuarioLogado write FLoginUsuarioLogado;
    property IDUsuarioLogado: String read FIDUsuarioLogado write FIDUsuarioLogado;
  end;

var
  dmUsuarios: TdmUsuarios;

implementation

uses
  MonolitoFinanceiro.View.Principal;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmUsuarios }

procedure TdmUsuarios.EfetuarLogin(Login, Senha: String);
var
  SQLConsulta: TFDQuery;
begin
  SQLConsulta := TFDQuery.Create(nil);
  try
    with SQLConsulta do
    begin
      Connection := dmConexao.SQLConexao;
      SQL.Clear;
      SQL.Add(' Select * from USUARIOS Where login = :login and senha = :senha ');
      Parambyname('login').AsString := Login;
      Parambyname('senha').AsString := Senha;
      Open;

      if IsEmpty then
        raise Exception.Create('Usuário ou senha inválidos!');

      if fieldbyname('status').AsString <> 'A' then
        raise Exception.Create
          ('Usuário bloqueado, favor entrar em contato com o administrador!');

      FIDUsuarioLogado    := fieldbyname('ID').AsString;
      FNomeUsuarioLogado  := fieldbyname('NOME').AsString;
      FLoginUsuarioLogado := fieldbyname('LOGIN').AsString;
    end;
  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;

end;

procedure TdmUsuarios.SetIDUsuarioLogado(const Value: String);
begin
  FIDUsuarioLogado := Value;
end;

procedure TdmUsuarios.SetLoginUsuarioLogado(const Value: String);
begin
  FLoginUsuarioLogado := Value;
end;

procedure TdmUsuarios.SetNomeUsuarioLogado(const Value: String);
begin
  FNomeUsuarioLogado := Value;
end;

function TdmUsuarios.TemLoginCadastrado(Login, ID: String): Boolean;
var
  SQLConsulta: TFDQuery;
begin
  Result := False;
  SQLConsulta := TFDQuery.Create(nil);
  try
    with SQLConsulta do
    begin
      Connection := dmConexao.SQLConexao;
      SQL.Clear;
      SQL.Add(' SELECT ID FROM USUARIOS WHERE LOGIN = :LOGIN ');
      Parambyname('LOGIN').AsString := Login;
      Open;
      if not IsEmpty then
        Result := fieldbyname('ID').AsString <> ID;
    end;
  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;

end;

end.
