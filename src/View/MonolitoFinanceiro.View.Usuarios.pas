unit MonolitoFinanceiro.View.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MonolitoFinanceiro.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.WinXCtrls,
  MonolitoFinanceiro.Utilitarios, Vcl.Buttons, Vcl.Menus;

type
  TfrmUsuarios = class(TfrmCadastroPadrao)
    pnlSecao: TPanel;
    gbUsuario: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtNome: TEdit;
    edtLogin: TEdit;
    edtSenha: TEdit;
    ToggleStatus: TToggleSwitch;
    mnuLimparSenha: TPopupMenu;
    LimparSenha: TMenuItem;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LimparSenhaClick(Sender: TObject);
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
  MonolitoFinanceiro.Model.Usuarios, BCrypt;

{$R *.dfm}

procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  LblInfOperacao.Caption := 'Alteração';
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
  LblInfOperacao.Caption := 'Inclusão';
  LimparCampos;
  edtNome.SetFocus;
  dmUsuarios.cdsUsuarios.Insert;
end;

procedure TfrmUsuarios.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  dmUsuarios.cdsUsuarios.close;
  dmUsuarios.cdsUsuarios.CommandText :=
    'Select * from USUARIOS where nome like :pNome order by Nome;';
  dmUsuarios.cdsUsuarios.ParamByName('pNome').AsString :=
    '%' + trim(edtPesquisa.Text) + '%';
  dmUsuarios.cdsUsuarios.Open;
  if dmUsuarios.cdsUsuarios.Recno > 0 then
    DBGrid1.SelectedIndex := dmUsuarios.cdsUsuarios.Recno - 1;
end;

procedure TfrmUsuarios.btnSalvarClick(Sender: TObject);
var
  LStatus: String;
  Mensagem: PWideChar;
  LHash: String;
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

  LStatus := 'A';
  if ToggleStatus.State = tssOff then
    LStatus := 'B';

  if dmUsuarios.TemLoginCadastrado(trim(edtLogin.Text),
    dmUsuarios.cdsUsuarios.fieldbyname('id').AsString) then
  begin
    Application.MessageBox
      (PWideChar(Format('O login %s já existe no cadastro de usuários.',
      [edtLogin.Text])), 'Atenção!', MB_OK + MB_ICONWARNING);
    edtLogin.SetFocus;
    abort;
  end;

  Mensagem := 'Registro alterado com sucesso!';

  with dmUsuarios.cdsUsuarios do
  begin
    if State in [dsInsert] then
    begin
      // fieldbyname('id').AsString := TUtilitarios.GetID; //Definido como auto_increment
      fieldbyname('data').AsDateTime := Now;
      Mensagem := 'Registro inserido com sucesso!';
    end;

    LHash := TBCrypt.GenerateHash(trim(edtSenha.Text));
    fieldbyname('nome').AsString := trim(edtNome.Text);
    fieldbyname('login').AsString := trim(edtLogin.Text);
    fieldbyname('senha').AsString := LHash;
    fieldbyname('status').AsString := LStatus;
    Post;
    ApplyUpdates(0);
    Refresh;
  end;

  Application.MessageBox(Mensagem, 'Atenção!', MB_OK + MB_ICONINFORMATION);
  pnlPrincipal.ActiveCard := CardPesquisa;

  inherited;

end;

procedure TfrmUsuarios.BuscaRegistros;
begin
  with dmUsuarios.cdsUsuarios do
  begin
    close;
    CommandText := ' Select * from USUARIOS order by Nome ';
    Open;
  end;

end;

procedure TfrmUsuarios.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  btnPesquisarClick(Self);
end;

procedure TfrmUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(frmUsuarios);
end;

procedure TfrmUsuarios.FormShow(Sender: TObject);
begin
  inherited;
  pnlPrincipal.ActiveCard := CardPesquisa;
  BuscaRegistros;
  if not dmUsuarios.cdsUsuarios.IsEmpty then
    DBGrid1.SetFocus;
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
end;

procedure TfrmUsuarios.LimparSenhaClick(Sender: TObject);
begin
  inherited;
  if not DataSource1.DataSet.IsEmpty then
  begin
    try
      dmUsuarios.LimparSenha(DataSource1.DataSet.fieldbyname('id').AsString);
      Application.MessageBox(PWideChar(Format('Senha padrão redefinida para o usuário: %s',[DataSource1.DataSet.fieldbyname('login').AsString])), 'Atenção!', MB_OK + MB_ICONINFORMATION);
    except
      on E: Exception do
        Application.MessageBox(PWideChar(E.Message), 'Atenção!',
          MB_OK + MB_ICONERROR);
    end;

  end;

end;

end.
