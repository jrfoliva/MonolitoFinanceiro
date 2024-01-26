unit MonolitoFinanceiro.View.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MonolitoFinanceiro.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.WinXCtrls,
  MonolitoFinanceiro.Utilitarios;

type
  TfrmUsuarios = class(TfrmCadastroPadrao)
    edtNome: TEdit;
    edtLogin: TEdit;
    edtSenha: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ToggleStatus: TToggleSwitch;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BuscaRegistros;
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure LimparCampos;

  public
    { Public declarations }
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

uses
  MonolitoFinanceiro.Model.Usuarios;

{$R *.dfm}

procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  LblInfOperacao.Caption := 'Alteração de Usuário';
  with dmUsuarios.cdsUsuarios do
  begin
    edtNome.Text := fieldbyname('nome').AsString;
    edtLogin.Text := fieldbyname('login').AsString;
    edtSenha.Text := fieldbyname('senha').AsString;

    ToggleStatus.State := tssOn;
    if fieldbyname('status').AsString = 'B' then
      ToggleStatus.State := tssOff;

    edtNome.SetFocus;
    Edit;
  end;

end;

procedure TfrmUsuarios.btnCancelarClick(Sender: TObject);
begin
  inherited;
  dmUsuarios.cdsUsuarios.Cancel;
end;

procedure TfrmUsuarios.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox('Deseja realmente excluir o registro?', 'Pergunta',
    MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

  try
    dmUsuarios.cdsUsuarios.Delete;
    dmUsuarios.cdsUsuarios.ApplyUpdates(0);
  Except
    on E: Exception do
      Application.MessageBox(PWideChar(E.Message),
        'Erro ao excluir o registro!', MB_OK + MB_ICONERROR);
  end;

end;

procedure TfrmUsuarios.btnIncluirClick(Sender: TObject);
begin
  inherited;
  LblInfOperacao.Caption := 'Inclusão de Usuário';
  LimparCampos;
  edtNome.SetFocus;
  dmUsuarios.cdsUsuarios.Insert;
end;

procedure TfrmUsuarios.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  if (trim(edtPesquisa.Text) <> '') then
  begin
    dmUsuarios.cdsUsuarios.Close;
    dmUsuarios.cdsUsuarios.CommandText := 'Select * from USUARIOS Where nome like :pNome';
    dmUsuarios.cdsUsuarios.ParamByName('pNome').AsString := trim(edtPesquisa.Text) + '%';
    dmUsuarios.cdsUsuarios.Open;
  end
  else BuscaRegistros;
end;

procedure TfrmUsuarios.btnSalvarClick(Sender: TObject);
var
  LStatus: String;
  Mensagem: PWideChar;
begin
  if edtNome.Text = '' then
  begin
    edtNome.SetFocus;
    Application.MessageBox('O campo nome precisa ser preenchido.', 'Atenção!',
      MB_OK + MB_ICONWARNING);
    abort
  end;

  if edtLogin.Text = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('O campo login precisa ser preenchido.', 'Atenção!',
      MB_OK + MB_ICONWARNING);
    abort
  end;

  if edtSenha.Text = '' then
  begin
    edtSenha.SetFocus;
    Application.MessageBox('O campo senha precisa ser preenchido.', 'Atenção!',
      MB_OK + MB_ICONWARNING);
    abort
  end;

  if dmUsuarios.TemLoginCadastrado(trim(edtLogin.Text),
    dmUsuarios.cdsUsuarios.fieldbyname('id').AsString) then
  begin
    Application.MessageBox
      (PWideChar(Format('O login %s já existe no cadastro de usuários.',
      [edtLogin.Text])), 'Atenção!', MB_OK + MB_ICONWARNING);
    edtLogin.SetFocus;
    abort;
  end;

  LStatus := 'A';
  if ToggleStatus.State = tssOff then
    LStatus := 'B';

  Mensagem := 'Registro alterado com sucesso!';

  with dmUsuarios.cdsUsuarios do
  begin
    if State in [dsInsert] then
    begin
      fieldbyname('id').AsString := TUtilitarios.GetID;
      fieldbyname('data_cadastro').AsDateTime := Now;
      Mensagem := 'Registro inserido com sucesso!';
    end;
    fieldbyname('nome').AsString := trim(edtNome.Text);
    fieldbyname('login').AsString := trim(edtLogin.Text);
    fieldbyname('senha').AsString := trim(edtSenha.Text);
    fieldbyname('status').AsString := LStatus;
    Post;
    ApplyUpdates(0);
  end;

  Application.MessageBox(Mensagem, 'Atenção!', MB_OK + MB_ICONINFORMATION);
  pnlPrincipal.ActiveCard := CardPesquisa;

  inherited;

end;

procedure TfrmUsuarios.BuscaRegistros;
begin
  with dmUsuarios.cdsUsuarios do
  begin
    Close;
    CommandText := ' Select * from USUARIOS order by nome ';
    Open;
  end;

end;

procedure TfrmUsuarios.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Trim(edtPesquisa.Text) <> '' then
    btnPesquisarClick(Self);

end;

procedure TfrmUsuarios.FormShow(Sender: TObject);
begin
  inherited;
  PnlPrincipal.ActiveCard := CardPesquisa;
  BuscaRegistros;
end;

procedure TfrmUsuarios.LimparCampos;
var
  Contador: integer;
begin
  for Contador := 0 to Pred(ComponentCount) do
  begin
    if Components[Contador] is TCustomEdit then
      TCustomEdit(Components[Contador]).Clear
    else if Components[Contador] is TToggleSwitch then
      TToggleSwitch(Components[Contador]).State := tssOn;

  end;

  ToggleStatus.State := tssOn;
end;

end.
