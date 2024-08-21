object frmPageDashboard: TfrmPageDashboard
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'frmPageDashboard'
  ClientHeight = 520
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 729
    Height = 520
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 723
      Height = 70
      Margins.Bottom = 10
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Bem Vindo ao SoftGym! O Melhor Sistema para Academias.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5987163
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlBottom
      ExplicitWidth = 699
    end
    object Shape1: TShape
      AlignWithMargins = True
      Left = 30
      Top = 83
      Width = 669
      Height = 2
      Margins.Left = 30
      Margins.Top = 0
      Margins.Right = 30
      Margins.Bottom = 0
      Align = alTop
      Brush.Color = clGray
      Pen.Style = psClear
      ExplicitLeft = 0
      ExplicitTop = 41
      ExplicitWidth = 705
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 30
      Top = 95
      Width = 669
      Height = 375
      Margins.Left = 30
      Margins.Top = 10
      Margins.Right = 30
      Margins.Bottom = 50
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      ExplicitTop = 85
      ExplicitHeight = 435
      object DBCtrlGrid1: TDBCtrlGrid
        Left = 0
        Top = 0
        Width = 669
        Height = 374
        Align = alClient
        AllowDelete = False
        AllowInsert = False
        ColCount = 4
        Color = clWhite
        DataSource = dsrDashboard
        PanelBorder = gbNone
        PanelHeight = 187
        PanelWidth = 163
        ParentColor = False
        TabOrder = 0
        RowCount = 2
        ExplicitWidth = 885
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 10
          Top = 10
          Width = 143
          Height = 167
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alClient
          BevelOuter = bvNone
          Color = 16316664
          ParentBackground = False
          TabOrder = 0
          ExplicitLeft = 96
          ExplicitTop = 56
          ExplicitWidth = 185
          ExplicitHeight = 41
          DesignSize = (
            143
            167)
          object Shape2: TShape
            Left = 0
            Top = 0
            Width = 6
            Height = 167
            Align = alLeft
            Brush.Color = 33023
            Pen.Style = psClear
            ExplicitHeight = 125
          end
          object DBEdit2: TDBEdit
            Left = 23
            Top = 84
            Width = 104
            Height = 25
            Anchors = [akLeft, akRight]
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            CharCase = ecUpperCase
            Ctl3D = False
            DataField = 'Descricao'
            DataSource = dsrDashboard
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = True
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            ExplicitTop = 72
            ExplicitWidth = 178
          end
          object DBEdit1: TDBEdit
            Left = 23
            Top = 35
            Width = 96
            Height = 29
            Anchors = [akLeft, akRight]
            AutoSize = False
            BevelInner = bvNone
            BevelOuter = bvNone
            BiDiMode = bdLeftToRight
            BorderStyle = bsNone
            DataField = 'Qtd'
            DataSource = dsrDashboard
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -27
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBiDiMode = False
            ParentColor = True
            ParentFont = False
            TabOrder = 1
            ExplicitTop = 23
            ExplicitWidth = 160
          end
        end
      end
    end
  end
  object dsrDashboard: TDataSource
    DataSet = cdsDashboard
    Left = 520
    Top = 120
  end
  object cdsDashboard: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 552
    Top = 120
    Data = {
      A20000009619E0BD010000001800000002000500000003000000440003517464
      04000100120000000944657363726963616F0100490012000100055749445448
      020002001200000000006400000009456D2041747261736F0000EB0000001241
      6C756E6F73204361646173747261646F7300000A0000000B4D6F64616C696461
      64657300000F0000000B4D6F64616C6964616465730000050000000A4176616C
      6961E7F56573}
    object cdsDashboardQtd: TIntegerField
      Alignment = taCenter
      FieldName = 'Qtd'
      ReadOnly = True
    end
    object cdsDashboardDescricao: TStringField
      Alignment = taCenter
      FieldName = 'Descricao'
      ReadOnly = True
      Size = 18
    end
  end
end
