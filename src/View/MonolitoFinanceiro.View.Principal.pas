unit MonolitoFinanceiro.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    menuCadastro: TMenuItem;
    menuRelatorios: TMenuItem;
    menuAjuda: TMenuItem;
    mnuUsuarios: TMenuItem;
    mnuPadrao: TMenuItem;
    procedure mnuUsuariosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuPadraoClick(Sender: TObject);
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
  MonolitoFinanceiro.View.Login;

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

end;

procedure TfrmPrincipal.mnuPadraoClick(Sender: TObject);
begin
  frmCadastroPadrao.Show;
end;

procedure TfrmPrincipal.mnuUsuariosClick(Sender: TObject);
begin
  frmUsuarios.Show;
end;

end.
