unit MonolitoFinanceiro.View.Splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmSplash = class(TForm)
    pnlPrincipal: TPanel;
    imgLogo: TImage;
    lblStatus: TLabel;
    ProgressBar1: TProgressBar;
    lblSistema: TLabel;
    Timer1: TTimer;
    lblVersao: TLabel;
    pnlImages: TPanel;
    imgConfig: TImage;
    imgDll: TImage;
    imgDB: TImage;
    imgStart: TImage;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaStatus(mensagem: String; imagem: TImage);
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.AtualizaStatus(mensagem: String; imagem: TImage);
begin
  lblStatus.Caption := mensagem;
  imagem.Visible := True;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position <= 100 then
  begin
    ProgressBar1.StepIt;
    pnlImages.Visible := True;
    case ProgressBar1.Position of
      1:
        AtualizaStatus('Carregando as configurações...', imgConfig);
      25:
        AtualizaStatus('Carregando dependências...', imgDll);
      50:
        AtualizaStatus('Conectando ao Banco de Dados...', imgDB);
      75:
        AtualizaStatus('Inicializando o Sistema...', imgStart);
      100:
        begin
          sleep(50);
          close;
        end;
    end;
  end;
end;

end.
