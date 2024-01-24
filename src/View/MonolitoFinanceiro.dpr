program MonolitoFinanceiro;

uses
  Vcl.Forms,
  MonolitoFinanceiro.View.Principal in 'MonolitoFinanceiro.View.Principal.pas' {frmPrincipal},
  MonolitoFinanceiro.View.CadastroPadrao in 'MonolitoFinanceiro.View.CadastroPadrao.pas' {frmCadastroPadrao},
  MonolitoFinanceiro.View.Splash in 'MonolitoFinanceiro.View.Splash.pas' {frmSplash},
  MonolitoFinanceiro.Model.Conexao in '..\Model\MonolitoFinanceiro.Model.Conexao.pas' {dmConexao: TDataModule},
  MonolitoFinanceiro.View.Usuarios in 'MonolitoFinanceiro.View.Usuarios.pas' {frmUsuarios},
  MonolitoFinanceiro.Model.Usuarios in '..\Model\MonolitoFinanceiro.Model.Usuarios.pas' {dmUsuarios: TDataModule},
  MonolitoFinanceiro.Utilitarios in '..\Util\MonolitoFinanceiro.Utilitarios.pas',
  MonolitoFinanceiro.View.Login in 'MonolitoFinanceiro.View.Login.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCadastroPadrao, frmCadastroPadrao);
  Application.CreateForm(TfrmUsuarios, frmUsuarios);
  Application.CreateForm(TdmUsuarios, dmUsuarios);
  Application.Run;
end.
