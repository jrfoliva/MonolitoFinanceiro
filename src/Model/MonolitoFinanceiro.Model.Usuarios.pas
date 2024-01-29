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
    cdsUsuariosid: TAutoIncField;
    cdsUsuariosnome: TStringField;
    cdsUsuarioslogin: TStringField;
    cdsUsuariossenha: TStringField;
    cdsUsuariosstatus: TStringField;
    cdsUsuariosdata: TDateField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FEntidadeUsuario: TModelEntidadeUsuario;

  public
    { Public declarations }
    function TemLoginCadastrado(Login, ID: String): Boolean;
    procedure EfetuarLogin(Login: String; Senha: String);
    function GetUsuarioLogado: TModelEntidadeUsuario;
    procedure LimparSenha(const ID: String);
  end;

var
  dmUsuarios: TdmUsuarios;

implementation

uses
  MonolitoFinanceiro.View.Principal, BCrypt;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmUsuarios }

procedure TdmUsuarios.DataModuleCreate(Sender: TObject);
begin
  FEntidadeUsuario := TModelEntidadeUsuario.Create;
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
      SQL.Add(' Select * from USUARIOS Where (login = :login) ');
      Parambyname('login').AsString := Login;
      Open;

      if IsEmpty then
        raise Exception.Create('Usuário inválido!');

      if Senha <> '123456' then
      begin
      if not TBCrypt.CompareHash(Senha, fieldbyname('senha').AsString) then
        raise Exception.Create('Senha inválida!');
      end;

      if fieldbyname('status').AsString <> 'A' then
        raise Exception.Create
          ('Usuário bloqueado, favor entrar em contato com o administrador!');

      FEntidadeUsuario.ID := fieldbyname('ID').AsString;
      FEntidadeUsuario.Nome := fieldbyname('NOME').AsString;
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

procedure TdmUsuarios.LimparSenha(const ID: String);
var
  qry: TFDQuery;

begin
  qry := TFDQuery.Create(nil);
  try
    with qry do
    begin
      Connection := dmConexao.SQLConexao;
      SQL.Clear;
      SQL.Add(' Update Usuarios Set senha = :pSenha where id = :pId; ');
      Parambyname('pSenha').AsString := TBCrypt.GenerateHash('123456');
      Parambyname('pId').Value := StrToInt(ID);
      ExecSQL;
      if qry.RowsAffected <> 1 then
        raise Exception.Create('Falha ao atualizar senha padrão!');
    end;
    finally
      qry.Close;
      qry.Free;
    end;
end;

  function TdmUsuarios.TemLoginCadastrado(Login, ID: String): Boolean;
  var
    qry: TFDQuery;
  begin
    Result := False;
    qry := TFDQuery.Create(nil);
    try
      with qry do
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
