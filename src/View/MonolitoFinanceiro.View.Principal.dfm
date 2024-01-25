object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Monolito Financeiro'
  ClientHeight = 338
  ClientWidth = 679
  Color = clActiveBorder
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 319
    Width = 679
    Height = 19
    Color = clWhite
    Panels = <
      item
        Bevel = pbRaised
        Width = 150
      end
      item
        Width = 300
      end>
  end
  object MainMenu: TMainMenu
    Left = 40
    Top = 24
    object menuCadastro: TMenuItem
      Caption = 'Cadastros'
      object mnuUsuarios: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = mnuUsuariosClick
      end
      object mnuPadrao: TMenuItem
        Caption = 'Cadastro Padr'#227'o'
        OnClick = mnuPadraoClick
      end
    end
    object menuRelatorios: TMenuItem
      Caption = 'Relat'#243'rios'
    end
    object menuAjuda: TMenuItem
      Caption = 'Ajuda'
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 624
    Top = 248
  end
end
