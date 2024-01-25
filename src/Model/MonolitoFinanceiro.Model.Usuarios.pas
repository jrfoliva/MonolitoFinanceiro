unit MonolitoFinanceiro.Model.Usuarios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  MonolitoFinanceiro.Model.Conexao, MonolitoFinanceiro.Model.Entidade.Usuario;

type
  TdmUsuarios = class(TDataModule)
    qryUsuarios: TFDQuery;
    cdsUsuarios: TClientDataSet;
    dspUsuarios: TDataSetProvider;
    cdsUsuariosID: TStringField;
    cdsUsuariosNOME: TStringField;
    cdsUsuariosLOGIN: TStringField;
    cdsUsuariosSENHA: TStringField;
    cdsUsuariosSTATUS: TStringField;
    cdsUsuariosDATA_CADASTRO: TDateField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FEntidadeUsuario : TModelEntidadeUsuario;

  public
    { Public declarations }
    function TemLoginCadastrado(Login, ID: String): Boolean;
    procedure EfetuarLogin(Login: String; Senha: String);
    function GetUsuarioLogado : TModelEntidadeUsuario;
  end;

var
  dmUsuarios: TdmUsuarios;

implementation

uses
  MonolitoFinanceiro.View.Principal;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmUsuarios }

procedure TdmUsuarios.DataModuleCreate(Sender: TObject);
begin
  FentidadeUsuario := TModelEntidadeUsuario.Create;
end;

procedure TdmUsuarios.DataModuleDestroy(Sender: TObject);
begin
  FEntidadeUsuario.Free;
end;

procedure TdmUsuarios.EfetuarLogin(Login, Senha: String);
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    with qry do
    begin
      Connection := dmConexao.SQLConexao;
      SQL.Clear;
      SQL.Add(' Select * from USUARIOS Where login = :login and senha = :senha ');
      Parambyname('login').AsString := Login;
      Parambyname('senha').AsString := Senha;
      Open;

      if IsEmpty then
        raise Exception.Create('Usu�rio ou senha inv�lidos!');

      if fieldbyname('status').AsString <> 'A' then
        raise Exception.Create
          ('Usu�rio bloqueado, favor entrar em contato com o administrador!');

      FEntidadeUsuario.Id    := fieldbyname('ID').AsString;
      FEntidadeUsuario.Nome  := fieldbyname('NOME').AsString;
      FEntidadeUsuario.Login := fieldbyname('LOGIN').AsString;
    end;
  finally
    qry.Close;
    qry.Free;
  end;
end;

function TdmUsuarios.GetUsuarioLogado: TModelEntidadeUsuario;
begin
  Result := FEntidadeUsuario;
end;

function TdmUsuarios.TemLoginCadastrado(Login, ID: String): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(nil);
  try
    with qry  do
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
    qry.Close;
    qry.Free;
  end;

end;

end.
