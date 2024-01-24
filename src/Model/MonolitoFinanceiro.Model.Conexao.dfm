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
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 40
    Top = 112
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
    Left = 208
    Top = 104
  end
end
