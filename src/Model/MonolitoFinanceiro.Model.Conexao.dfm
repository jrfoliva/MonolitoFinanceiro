object dmConexao: TdmConexao
  OnCreate = DataModuleCreate
  Height = 371
  Width = 459
  object SQLConexao: TFDConnection
    Params.Strings = (
      'Database=sistemas'
      'User_Name=root'
      'Password=masterkey'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 104
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'D:\FONTES\DELPHI_PROJETOS\MonolitoFinanceiro\lib\libmysql.dll'
    Left = 64
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 48
    Top = 200
  end
  object FDTransaction1: TFDTransaction
    Connection = SQLConexao
    Left = 224
    Top = 136
  end
end
