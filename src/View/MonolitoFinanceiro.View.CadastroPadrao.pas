unit MonolitoFinanceiro.View.CadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TfrmCadastroPadrao = class(TForm)
    PnlPrincipal: TCardPanel;
    CardCadastro: TCard;
    CardPesquisa: TCard;
    pnlPesquisar: TPanel;
    PnlBotoes: TPanel;
    pnlGrid: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    edtPesquisa: TEdit;
    btnPesquisar: TButton;
    ImageList1: TImageList;
    btnSair: TButton;
    btnImprimir: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnIncluir: TButton;
    Panel1: TPanel;
    btnCancelar: TButton;
    btnSalvar: TButton;
    DataSource1: TDataSource;
    pnlInfoTop: TPanel;
    lblInfOperacao: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroPadrao: TfrmCadastroPadrao;

implementation

{$R *.dfm}

procedure TfrmCadastroPadrao.btnAlterarClick(Sender: TObject);
begin
  PnlPrincipal.ActiveCard := CardCadastro;
end;

procedure TfrmCadastroPadrao.btnCancelarClick(Sender: TObject);
begin
  PnlPrincipal.ActiveCard := CardPesquisa;
end;

procedure TfrmCadastroPadrao.btnIncluirClick(Sender: TObject);
begin
  PnlPrincipal.ActiveCard := CardCadastro;
end;

procedure TfrmCadastroPadrao.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroPadrao.FormShow(Sender: TObject);
begin
  PnlPrincipal.ActiveCard := CardPesquisa;
end;

end.
