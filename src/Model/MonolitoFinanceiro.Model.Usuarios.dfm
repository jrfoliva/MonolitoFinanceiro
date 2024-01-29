object dmUsuarios: TdmUsuarios
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 345
  Width = 484
  object qryUsuarios: TFDQuery
    Connection = dmConexao.SQLConexao
    SQL.Strings = (
      'select * from usuarios'
      'Order by Nome;')
    Left = 48
    Top = 32
  end
  object cdsUsuarios: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUsuarios'
    Left = 224
    Top = 32
    object cdsUsuariosid: TAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsUsuariosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 60
    end
    object cdsUsuarioslogin: TStringField
      FieldName = 'login'
      Origin = 'login'
      Required = True
    end
    object cdsUsuariossenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 60
    end
    object cdsUsuariosstatus: TStringField
      FieldName = 'status'
      Origin = '`status`'
      Required = True
      Size = 1
    end
    object cdsUsuariosdata: TDateField
      FieldName = 'data'
      Origin = '`data`'
    end
  end
  object dspUsuarios: TDataSetProvider
    DataSet = qryUsuarios
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 128
    Top = 32
  end
end
