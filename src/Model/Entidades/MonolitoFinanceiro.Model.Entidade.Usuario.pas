unit MonolitoFinanceiro.Model.Entidade.Usuario;

interface
type
  TModelEntidadeUsuario = class
  private
    FId: String;
    FNome: String;
    FLogin: String;

  public
    property Id: String read FId write Fid;
    property Nome: String read FNome write FNome;
    property Login: String read FLogin write FLogin;

  end;
implementation

end.
