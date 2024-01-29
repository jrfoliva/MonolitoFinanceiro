unit MonolitoFinanceiro.View.CadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.WinXPanels,
  Vcl.Buttons;

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
    ImageList1: TImageList;
    btnImprimir: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnIncluir: TButton;
    pnlDecisao: TPanel;
    btnCancelar: TButton;
    btnSalvar: TButton;
    DataSource1: TDataSource;
    pnlInfoTop: TPanel;
    lblInfOperacao: TLabel;
    btnSair: TButton;
    btnPesquisar: TButton;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCampos;
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
  LimparCampos;

end;

procedure TfrmCadastroPadrao.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroPadrao.FormShow(Sender: TObject);
begin
  PnlPrincipal.ActiveCard := CardPesquisa;
end;

procedure TfrmCadastroPadrao.LimparCampos;
var
  Contador : Integer;
begin
  for Contador := 0 to Pred(ComponentCount) do
    if Components[Contador] is TCustomEdit then
      TCustomEdit(Components[Contador]).Clear;
end;

end.
