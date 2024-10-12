object DmZeosLib: TDmZeosLib
  OldCreateOrder = False
  Height = 197
  Width = 283
  object ConnSQlite: TZConnection
    ControlsCodePage = cCP_UTF16
    Properties.Strings = (
      'RawStringEncoding=DB_CP'
      'Undefined_Varchar_AsString_Length=255')
    BeforeConnect = ConnSQliteBeforeConnect
    DisableSavepoints = False
    Port = 0
    Protocol = 'sqlite'
    Left = 32
    Top = 24
  end
end
