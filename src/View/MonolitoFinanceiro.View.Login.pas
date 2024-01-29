unit MonolitoFinanceiro.View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  TfrmLogin = class(TForm)
    pnlEsquerda: TPanel;
    imgLogo: TImage;
    pnlPrincipal: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    PnlUsuario: TPanel;
    Label4: TLabel;
    edtLogin: TEdit;
    pnlButton: TPanel;
    pnlSenha: TPanel;
    Label5: TLabel;
    edtSenha: TEdit;
    btnEntrar: TButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtLoginKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  MonolitoFinanceiro.Model.Usuarios, MonolitoFinanceiro.Model.Sistema;

{$R *.dfm}

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  if Trim(edtLogin.Text) = '' then
  begin
    Application.MessageBox('Informe o seu usuário!', 'Atenção', MB_OK + MB_ICONWARNING);
    edtLogin.SetFocus;
    Abort
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    Application.MessageBox('Informe a sua senha!', 'Atenção', MB_OK + MB_ICONWARNING);
    edtSenha.SetFocus;
    Abort
  end;

  try
    dmUsuarios.EfetuarLogin(Trim(edtLogin.Text), Trim(edtSenha.Text));
    dmSistema.DataUltimoAcesso(Now);
    dmSistema.UsuarioUltimoAcesso(dmUsuarios.GetUsuarioLogado.Login);
    ModalResult := mrOk;
  Except
    on Erro: Exception do
    begin
      Application.MessageBox(PWideChar(Erro.Message), 'Atenção', MB_OK + MB_ICONERROR);
      edtLogin.SetFocus;
    end;
  end;
end;

procedure TfrmLogin.edtLoginKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (edtLogin.Text <> '') and (key = 13) then
    edtSenha.SetFocus;
end;

procedure TfrmLogin.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (edtSenha.Text <> '') and (key = 13) then
    btnEntrar.SetFocus;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtLogin.Text := dmSistema.UsuarioUltimoAcesso;
end;

end.
