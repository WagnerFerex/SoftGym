object frmPageAlunos: TfrmPageAlunos
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'frmPageAlunos'
  ClientHeight = 543
  ClientWidth = 786
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pcAluno: TPageControl
    Left = 0
    Top = 0
    Width = 786
    Height = 543
    ActivePage = tsCrud
    Align = alClient
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    Style = tsFlatButtons
    TabOrder = 0
    object tsList: TTabSheet
      Caption = 'tsList'
      TabVisible = False
      DesignSize = (
        778
        533)
      object Label1: TLabel
        Left = 32
        Top = 48
        Width = 187
        Height = 30
        Caption = 'Listagem de Alunos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3815994
        Font.Height = -21
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
      end
      object btnNovo: TSpeedButton
        Left = 563
        Top = 99
        Width = 95
        Height = 29
        Anchors = [akTop, akRight]
        Caption = '&Novo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnNovoClick
      end
      object Shape1: TShape
        AlignWithMargins = True
        Left = 25
        Top = 83
        Width = 740
        Height = 2
        Margins.Left = 30
        Margins.Top = 0
        Margins.Right = 30
        Margins.Bottom = 0
        Anchors = [akLeft, akTop, akRight]
        Brush.Color = clSilver
        Pen.Style = psClear
        ExplicitWidth = 648
      end
      object Label2: TLabel
        Left = 32
        Top = 519
        Width = 165
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = '276 Registro(s) encontrados.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 471
      end
      object SpeedButton1: TSpeedButton
        Left = 659
        Top = 99
        Width = 95
        Height = 29
        Anchors = [akTop, akRight]
        Caption = 'E&xportar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButton1Click
      end
      object DBGrid1: TDBGrid
        Left = 32
        Top = 139
        Width = 722
        Height = 374
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = dsrAlunos
        DrawingStyle = gdsGradient
        GradientEndColor = 16382457
        GradientStartColor = 16382457
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5723991
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgRowLines, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = 5723991
        TitleFont.Height = -15
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
        OnTitleClick = DBGrid1TitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'CodigoAluno'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Bairro'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Logradouro'
            Title.Caption = 'Endere'#231'o'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Telefone'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Email'
            Title.Caption = 'E-mail'
            Width = 200
            Visible = True
          end>
      end
      object edtPesquisa: TEdit
        Left = 32
        Top = 102
        Width = 525
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TextHint = ' Informe o nome que deseja buscar...'
        OnChange = edtPesquisaChange
      end
      object DBNavigator1: TDBNavigator
        Left = 534
        Top = 515
        Width = 220
        Height = 18
        DataSource = dsrAlunos
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
        Anchors = [akRight, akBottom]
        Flat = True
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 2
      end
    end
    object tsCrud: TTabSheet
      Caption = 'tsCrud'
      ImageIndex = 1
      TabVisible = False
      OnShow = tsCrudShow
      DesignSize = (
        778
        533)
      object Shape2: TShape
        AlignWithMargins = True
        Left = 25
        Top = 83
        Width = 740
        Height = 2
        Margins.Left = 30
        Margins.Top = 0
        Margins.Right = 30
        Margins.Bottom = 0
        Anchors = [akLeft, akTop, akRight]
        Brush.Color = clSilver
        Pen.Style = psClear
        ExplicitWidth = 648
      end
      object Label3: TLabel
        Left = 32
        Top = 48
        Width = 178
        Height = 30
        Caption = 'Cadastro de Aluno'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3815994
        Font.Height = -21
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
      end
      object btnCancelar: TSpeedButton
        Left = 563
        Top = 48
        Width = 95
        Height = 29
        Anchors = [akTop, akRight]
        Caption = '&Cancelar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnCancelarClick
        ExplicitLeft = 471
      end
      object btnSalvar: TSpeedButton
        Left = 659
        Top = 48
        Width = 95
        Height = 29
        Anchors = [akTop, akRight]
        Caption = '&Salvar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnSalvarClick
        ExplicitLeft = 567
      end
      object gbEndereco: TGroupBox
        Left = 40
        Top = 253
        Width = 697
        Height = 188
        Anchors = [akTop]
        Caption = ' Endere'#231'o '
        TabOrder = 1
        object Label6: TLabel
          Left = 37
          Top = 74
          Width = 70
          Height = 17
          Caption = 'Logradouro'
          FocusControl = edtEndereco
        end
        object Label7: TLabel
          Left = 457
          Top = 74
          Width = 35
          Height = 17
          Caption = 'Bairro'
          FocusControl = edtBairro
        end
        object Label8: TLabel
          Left = 37
          Top = 125
          Width = 57
          Height = 17
          Caption = 'Munic'#237'pio'
          FocusControl = edtMunicipio
        end
        object Label9: TLabel
          Left = 247
          Top = 125
          Width = 15
          Height = 17
          Caption = 'UF'
          FocusControl = edtUF
        end
        object Label11: TLabel
          Left = 37
          Top = 23
          Width = 22
          Height = 17
          Caption = 'CEP'
          FocusControl = edtCEP
        end
        object Label12: TLabel
          Left = 287
          Top = 125
          Width = 48
          Height = 17
          Caption = 'N'#250'mero'
          FocusControl = edtNumero
        end
        object Label15: TLabel
          Left = 457
          Top = 125
          Width = 82
          Height = 17
          Caption = 'Complemento'
          FocusControl = edtComplemento
        end
        object edtEndereco: TDBEdit
          Left = 37
          Top = 93
          Width = 410
          Height = 25
          Hint = 'Endere'#231'o completo. ex: Rua de Exemplo, N'#186' 0, AP 000.'
          DataField = 'Logradouro'
          DataSource = dsrAlunos
          TabOrder = 1
        end
        object edtBairro: TDBEdit
          Left = 457
          Top = 93
          Width = 200
          Height = 25
          Hint = 'Bairro...'
          DataField = 'Bairro'
          DataSource = dsrAlunos
          TabOrder = 2
        end
        object edtMunicipio: TDBEdit
          Left = 37
          Top = 144
          Width = 200
          Height = 25
          Hint = 'Cidade...'
          DataField = 'Municipio'
          DataSource = dsrAlunos
          TabOrder = 3
        end
        object edtUF: TDBEdit
          Left = 247
          Top = 144
          Width = 30
          Height = 25
          Hint = 'MG'
          DataField = 'Uf'
          DataSource = dsrAlunos
          TabOrder = 4
        end
        object edtCEP: TDBEdit
          Left = 37
          Top = 42
          Width = 200
          Height = 25
          Hint = '36888-000'
          DataField = 'Cep'
          DataSource = dsrAlunos
          TabOrder = 0
          OnChange = edtCEPChange
        end
        object edtNumero: TDBEdit
          Left = 287
          Top = 144
          Width = 160
          Height = 25
          DataField = 'Numero'
          DataSource = dsrAlunos
          TabOrder = 5
        end
        object edtComplemento: TDBEdit
          Left = 457
          Top = 144
          Width = 200
          Height = 25
          Hint = 'Bairro...'
          DataField = 'Complemento'
          DataSource = dsrAlunos
          TabOrder = 6
        end
      end
      object gbDadosPrincipais: TGroupBox
        Left = 40
        Top = 110
        Width = 697
        Height = 137
        Anchors = [akTop]
        Caption = ' Dados Principais '
        TabOrder = 0
        object Label4: TLabel
          Left = 37
          Top = 22
          Width = 43
          Height = 17
          Caption = 'C'#243'digo'
          FocusControl = edtCodigo
        end
        object Label5: TLabel
          Left = 112
          Top = 22
          Width = 36
          Height = 17
          Caption = 'Nome'
          FocusControl = edtNome
        end
        object lblTelefone: TLabel
          Left = 37
          Top = 71
          Width = 49
          Height = 17
          Caption = 'Telefone'
          FocusControl = edtTelefone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lblCpf: TLabel
          Left = 247
          Top = 71
          Width = 21
          Height = 17
          Caption = 'CPF'
          FocusControl = edtCPF
        end
        object Label14: TLabel
          Left = 457
          Top = 22
          Width = 89
          Height = 17
          Caption = 'Dt. Nascimento'
        end
        object Label16: TLabel
          Left = 29
          Top = 71
          Width = 6
          Height = 17
          Caption = '*'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTelefoneMsgCampo: TLabel
          Left = 37
          Top = 117
          Width = 98
          Height = 13
          Caption = 'Campo obrigat'#243'rio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Segoe UI Symbol'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 457
          Top = 71
          Width = 36
          Height = 17
          Caption = 'E-mail'
          FocusControl = edtEmail
        end
        object edtCodigo: TDBEdit
          Left = 37
          Top = 40
          Width = 65
          Height = 25
          DataField = 'CodigoAluno'
          DataSource = dsrAlunos
          Enabled = False
          TabOrder = 0
        end
        object edtNome: TDBEdit
          Left = 112
          Top = 40
          Width = 335
          Height = 25
          Hint = 'Nome Completo do Aluno. ex Fulano de tal da Silva...'
          DataField = 'Nome'
          DataSource = dsrAlunos
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object edtTelefone: TDBEdit
          Left = 37
          Top = 90
          Width = 200
          Height = 25
          Hint = 'ex. (32) 99988-9292'
          DataField = 'Telefone'
          DataSource = dsrAlunos
          ParentColor = True
          TabOrder = 3
          OnChange = edtTelefoneChange
          OnClick = edtTelefoneClick
        end
        object edtCPF: TDBEdit
          Left = 247
          Top = 90
          Width = 200
          Height = 25
          Hint = '000.000.000-00'
          DataField = 'Cpf'
          DataSource = dsrAlunos
          TabOrder = 4
          OnClick = edtTelefoneClick
        end
        object edtDataNascimento: TDBEdit
          Left = 457
          Top = 40
          Width = 200
          Height = 25
          DataField = 'DataNascimento'
          DataSource = dsrAlunos
          TabOrder = 2
          OnClick = edtTelefoneClick
        end
        object edtEmail: TDBEdit
          Left = 457
          Top = 90
          Width = 200
          Height = 25
          DataField = 'Email'
          DataSource = dsrAlunos
          TabOrder = 5
        end
      end
      object gbObservacoes: TGroupBox
        Left = 40
        Top = 447
        Width = 697
        Height = 133
        Anchors = [akTop]
        Caption = ' Observa'#231#245'es '
        TabOrder = 2
        object mmObservacao: TDBMemo
          Left = 37
          Top = 26
          Width = 620
          Height = 89
          Hint = 'Observa'#231#245'es...'
          DataField = 'Observacao'
          DataSource = dsrAlunos
          TabOrder = 0
        end
      end
    end
  end
  object dsrAlunos: TDataSource
    DataSet = DMConnZeosLib.qryAluno
    OnStateChange = dsrAlunosStateChange
    Left = 624
    Top = 24
  end
end
