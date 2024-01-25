object dmUsuarios: TdmUsuarios
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 345
  Width = 484
  object qryUsuarios: TFDQuery
    Connection = dmConexao.SQLConexao
    SQL.Strings = (
      'select * from usuarios')
    Left = 48
    Top = 32
  end
  object cdsUsuarios: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUsuarios'
    Left = 216
    Top = 32
    object cdsUsuariosID: TStringField
      DisplayWidth = 5
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 36
    end
    object cdsUsuariosNOME: TStringField
      DisplayWidth = 37
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
    object cdsUsuariosLOGIN: TStringField
      DisplayWidth = 20
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Required = True
    end
    object cdsUsuariosSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Required = True
      Visible = False
    end
    object cdsUsuariosSTATUS: TStringField
      DisplayWidth = 7
      FieldName = 'STATUS'
      Origin = '`STATUS`'
      Required = True
      Size = 1
    end
    object cdsUsuariosDATA_CADASTRO: TDateField
      DisplayWidth = 14
      FieldName = 'DATA_CADASTRO'
      Origin = 'DATA_CADASTRO'
      Required = True
    end
  end
  object dspUsuarios: TDataSetProvider
    DataSet = qryUsuarios
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 128
    Top = 32
  end
end
