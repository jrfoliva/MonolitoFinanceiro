unit MonolitoFinanceiro.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.SysUtils;

type
  TfrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    menuCadastro: TMenuItem;
    menuRelatorios: TMenuItem;
    menuAjuda: TMenuItem;
    mnuUsuarios: TMenuItem;
    mnuPadrao: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure mnuUsuariosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuPadraoClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  MonolitoFinanceiro.View.Splash, MonolitoFinanceiro.View.Usuarios, MonolitoFinanceiro.View.CadastroPadrao,
  MonolitoFinanceiro.View.Login, MonolitoFinanceiro.Model.Entidade.Usuario,
  MonolitoFinanceiro.Model.Usuarios;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
   frmSplash := TFrmSplash.Create(nil);
   try
     frmSplash.ShowModal;
   finally
     FreeAndNil(frmSplash);
   end;

   frmLogin := TFrmLogin.Create(nil);
   try
     frmLogin.ShowModal;
     if frmLogin.ModalResult <> mrOk then
       Application.Terminate;
   finally
     FreeAndNil(frmLogin);
   end;
   StatusBar1.Panels.Items[1].Text := 'Usuario: ' + UpperCase(dmUsuarios.GetUsuarioLogado.Nome);
end;

procedure TfrmPrincipal.mnuPadraoClick(Sender: TObject);
begin
  frmCadastroPadrao.Show;
end;

procedure TfrmPrincipal.mnuUsuariosClick(Sender: TObject);
begin
  frmUsuarios.Show;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Text := 'Data: ' + DateTimeToStr(Now);
end;

end.
