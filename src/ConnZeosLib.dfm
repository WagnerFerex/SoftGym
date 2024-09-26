object DMConnZeosLib: TDMConnZeosLib
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 422
  Width = 626
  object ConnSQlite: TZConnection
    ControlsCodePage = cCP_UTF16
    Properties.Strings = (
      'RawStringEncoding=DB_CP'
      'Undefined_Varchar_AsString_Length=255')
    BeforeConnect = ConnSqliteBeforeConnect
    DisableSavepoints = False
    Port = 0
    Protocol = 'sqlite'
    LibraryLocation = 'C:\Projetos\Delphi\sqlite\sqlite3.dll'
    Left = 40
    Top = 32
  end
  object qryAluno: TZQuery
    Connection = ConnSQlite
    BeforePost = qryAlunoBeforePost
    SQL.Strings = (
      'SELECT '
      #9'CodigoAluno,'
      #9'Nome,'
      #9'DataNascimento,'
      #9'Telefone,'
      #9'Email,'
      #9'Cpf,'
      #9'Observacao,'
      #9'Cep,'
      #9'Logradouro,'
      #9'Bairro,'
      #9'Municipio,'
      #9'Uf,'
      #9'Numero,'
      #9'Complemento,'
      #9'Referencia,'
      #9'InseridoEm,'
      #9'InseridoPor,'
      #9'ModificadoEm,'
      #9'ModificadoPor'
      'FROM Aluno')
    Params = <>
    Properties.Strings = (
      'Undefined_Varchar_AsString_Length=255')
    Left = 40
    Top = 88
    object qryAlunoCodigoAluno: TZInt64Field
      AutoGenerateValue = arAutoInc
      FieldName = 'CodigoAluno'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
    end
    object qryAlunoNome: TZUnicodeStringField
      DisplayWidth = 255
      FieldName = 'Nome'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 255
    end
    object qryAlunoDataNascimento: TZDateField
      FieldName = 'DataNascimento'
      OnSetText = qryAlunoDataNascimentoSetText
      DisplayFormat.Format = 'dd/mm/yyyy'
      EditMask = '!99/99/9999;1;_'
      EditFormat.Format = 'dd/mm/yyyy'
    end
    object qryAlunoTelefone: TZUnicodeStringField
      DisplayWidth = 120
      FieldName = 'Telefone'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '!\(99\)99999-9999;0;_'
      Size = 11
    end
    object qryAlunoEmail: TZUnicodeStringField
      FieldName = 'Email'
      ProviderFlags = [pfInUpdate]
      Size = 255
    end
    object qryAlunoCpf: TZUnicodeStringField
      FieldName = 'Cpf'
      ProviderFlags = [pfInUpdate]
      EditMask = '###\.###\.###\.##;0; '
      Size = 11
    end
    object qryAlunoObservacao: TZUnicodeCLobField
      FieldName = 'Observacao'
      BlobType = ftWideMemo
    end
    object qryAlunoCep: TZInt64Field
      FieldName = 'Cep'
    end
    object qryAlunoLogradouro: TZUnicodeStringField
      FieldName = 'Logradouro'
      Size = 255
    end
    object qryAlunoBairro: TZUnicodeStringField
      FieldName = 'Bairro'
      Size = 255
    end
    object qryAlunoMunicipio: TZUnicodeStringField
      FieldName = 'Municipio'
      Size = 255
    end
    object qryAlunoUf: TZUnicodeStringField
      FieldName = 'Uf'
      Size = 255
    end
    object qryAlunoNumero: TZUnicodeStringField
      FieldName = 'Numero'
      Size = 255
    end
    object qryAlunoComplemento: TZUnicodeStringField
      FieldName = 'Complemento'
      Size = 255
    end
    object qryAlunoReferencia: TZUnicodeStringField
      FieldName = 'Referencia'
      Size = 255
    end
    object qryAlunoInseridoEm: TZDateTimeField
      FieldName = 'InseridoEm'
      Required = True
    end
    object qryAlunoInseridoPor: TZInt64Field
      FieldName = 'InseridoPor'
      Required = True
    end
    object qryAlunoModificadoEm: TZDateTimeField
      FieldName = 'ModificadoEm'
    end
    object qryAlunoModificadoPor: TZInt64Field
      FieldName = 'ModificadoPor'
    end
  end
  object qryUsuario: TZQuery
    Connection = ConnSQlite
    SQL.Strings = (
      'SELECT *'
      'FROM Usuario')
    Params = <>
    Left = 168
    Top = 88
    object qryUsuarioCodigoUsuario: TZInt64Field
      FieldName = 'CodigoUsuario'
      Required = True
    end
    object qryUsuarioNome: TZUnicodeCLobField
      FieldName = 'Nome'
      Required = True
      BlobType = ftWideMemo
    end
    object qryUsuarioLogin: TZUnicodeCLobField
      FieldName = 'Login'
      Required = True
      BlobType = ftWideMemo
    end
    object qryUsuarioSenha: TZUnicodeCLobField
      FieldName = 'Senha'
      Required = True
      BlobType = ftWideMemo
    end
    object qryUsuarioEmail: TZUnicodeCLobField
      FieldName = 'Email'
      BlobType = ftWideMemo
    end
    object qryUsuarioAcesso: TZUnicodeCLobField
      FieldName = 'Acesso'
      Required = True
      BlobType = ftWideMemo
    end
    object qryUsuarioAtivo: TZUnicodeCLobField
      FieldName = 'Ativo'
      BlobType = ftWideMemo
    end
  end
end
