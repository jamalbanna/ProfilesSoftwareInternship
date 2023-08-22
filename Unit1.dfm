object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 816
  ClientWidth = 816
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label8: TLabel
    Left = 88
    Top = 16
    Width = 34
    Height = 15
    Caption = 'Label8'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 816
    Height = 816
    ActivePage = PRODUCTS
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 812
    ExplicitHeight = 815
    object PRODUCTS: TTabSheet
      Caption = 'PRODUCTS'
      object Label1: TLabel
        Left = 32
        Top = 16
        Width = 63
        Height = 15
        Caption = 'Department'
      end
      object Label2: TLabel
        Left = 32
        Top = 88
        Width = 39
        Height = 15
        Caption = 'Group1'
      end
      object Label3: TLabel
        Left = 32
        Top = 160
        Width = 39
        Height = 15
        Caption = 'Group2'
      end
      object Label4: TLabel
        Left = 32
        Top = 240
        Width = 39
        Height = 15
        Caption = 'Group3'
      end
      object Label5: TLabel
        Left = 32
        Top = 312
        Width = 39
        Height = 15
        Caption = 'Group4'
      end
      object Label6: TLabel
        Left = 32
        Top = 400
        Width = 39
        Height = 15
        Caption = 'Group5'
      end
      object Label7: TLabel
        Left = 32
        Top = 480
        Width = 74
        Height = 21
        Caption = 'PRICE LIST'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 160
        Top = 0
        Width = 121
        Height = 23
        TabOrder = 0
        TextHint = 'From'
      end
      object Edit2: TEdit
        Left = 160
        Top = 29
        Width = 121
        Height = 23
        TabOrder = 1
        TextHint = 'To'
      end
      object CheckBox1: TCheckBox
        Left = 368
        Top = 16
        Width = 97
        Height = 17
        Caption = 'ALL'
        TabOrder = 2
        OnClick = CheckBox1Click
      end
      object Edit3: TEdit
        Left = 160
        Top = 85
        Width = 121
        Height = 23
        TabOrder = 3
        TextHint = 'From'
      end
      object Edit4: TEdit
        Left = 160
        Top = 114
        Width = 121
        Height = 23
        TabOrder = 4
        TextHint = 'To'
      end
      object CheckBox2: TCheckBox
        Left = 360
        Top = 104
        Width = 97
        Height = 17
        Caption = 'ALL'
        TabOrder = 5
        OnClick = CheckBox2Click
      end
      object Edit5: TEdit
        Left = 160
        Top = 157
        Width = 121
        Height = 23
        TabOrder = 6
        TextHint = 'From'
      end
      object Edit6: TEdit
        Left = 160
        Top = 186
        Width = 121
        Height = 23
        TabOrder = 7
        TextHint = 'To'
      end
      object CheckBox3: TCheckBox
        Left = 360
        Top = 163
        Width = 97
        Height = 17
        Caption = 'ALL'
        TabOrder = 8
        OnClick = CheckBox3Click
      end
      object Edit7: TEdit
        Left = 160
        Top = 240
        Width = 121
        Height = 23
        TabOrder = 9
        TextHint = 'From'
      end
      object Edit8: TEdit
        Left = 160
        Top = 269
        Width = 121
        Height = 23
        TabOrder = 10
        TextHint = 'To'
      end
      object CheckBox4: TCheckBox
        Left = 368
        Top = 256
        Width = 97
        Height = 17
        Caption = 'ALL'
        TabOrder = 11
        OnClick = CheckBox4Click
      end
      object Edit9: TEdit
        Left = 160
        Top = 320
        Width = 121
        Height = 23
        TabOrder = 12
        TextHint = 'From'
      end
      object Edit10: TEdit
        Left = 160
        Top = 349
        Width = 121
        Height = 23
        TabOrder = 13
        TextHint = 'To'
      end
      object CheckBox5: TCheckBox
        Left = 368
        Top = 336
        Width = 97
        Height = 17
        Caption = 'ALL'
        TabOrder = 14
        OnClick = CheckBox5Click
      end
      object Edit11: TEdit
        Left = 160
        Top = 400
        Width = 121
        Height = 23
        TabOrder = 15
        TextHint = 'From'
      end
      object Edit12: TEdit
        Left = 160
        Top = 429
        Width = 121
        Height = 23
        TabOrder = 16
        TextHint = 'To'
      end
      object CheckBox6: TCheckBox
        Left = 384
        Top = 419
        Width = 97
        Height = 17
        Caption = 'ALL'
        TabOrder = 17
        OnClick = CheckBox6Click
      end
      object Button1: TButton
        Left = 160
        Top = 551
        Width = 75
        Height = 25
        Caption = 'GO'
        TabOrder = 18
        OnClick = Button1Click
      end
      object Edit13: TEdit
        Left = 160
        Top = 482
        Width = 121
        Height = 23
        TabOrder = 19
      end
      object CheckBox7: TCheckBox
        Left = 120
        Top = 528
        Width = 161
        Height = 17
        Caption = 'Delete Items Outside List'
        TabOrder = 20
      end
      object ProgressBar1: TProgressBar
        Left = 32
        Top = 616
        Width = 705
        Height = 17
        TabOrder = 21
        Visible = False
      end
    end
    object ORDERS: TTabSheet
      Caption = 'ORDERS'
      ImageIndex = 1
      object Label9: TLabel
        Left = 40
        Top = 8
        Width = 35
        Height = 15
        Caption = 'Orders'
      end
      object Label10: TLabel
        Left = 40
        Top = 288
        Width = 87
        Height = 15
        Caption = 'Order Line Items'
      end
      object DBGrid1: TDBGrid
        Left = -4
        Top = 29
        Width = 497
        Height = 249
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
      object Button2: TButton
        Left = 512
        Top = 284
        Width = 105
        Height = 25
        Caption = 'Update Orders'
        TabOrder = 1
        OnClick = Button2Click
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 309
        Width = 493
        Height = 276
        DataSource = DataSource2
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
  end
  object EDBEngine1: TEDBEngine
    Active = True
    Signature = 'edb_signature'
    EncryptionPassword = 'elevatesoft'
    LicensedSessions = 4096
    ConfigPath = 'C:\Testdata\EDB\SWEETSAL'
    ConfigName = 'EDBConfig'
    ConfigExtension = '.EDBCfg'
    LockExtension = '.EDBLck'
    LogExtension = '.EDBLog'
    LogCategories = [lcInformation, lcWarning, lcError]
    CatalogName = 'EDBDatabase'
    CatalogExtension = '.EDBCat'
    BackupExtension = '.EDBBkp'
    UpdateExtension = '.EDBUpd'
    TableExtension = '.EDBTbl'
    TableIndexExtension = '.EDBIdx'
    TableBlobExtension = '.EDBBlb'
    TablePublishExtension = '.EDBPbl'
    CacheModules = False
    ServerName = 'EDBSrvr'
    ServerDescription = 'ElevateDB Server'
    ServerEncryptionPassword = 'elevatesoft'
    ServerAuthorizedAddresses.Strings = (
      '*')
    ServerJobRetries = 10
    Left = 656
    Top = 112
  end
  object EDBSession1: TEDBSession
    Connected = True
    LoginUser = 'Administrator'
    LoginPassword = 'EDBDefault'
    SessionName = 'SWEETSAL'
    LocalSignature = 'edb_signature'
    LocalEncryptionPassword = 'elevatesoft'
    LocalConfigPath = 'C:\Testdata\EDB\SWEETSAL'
    LocalConfigName = 'EDBConfig'
    LocalConfigExtension = '.EDBCfg'
    LocalLockExtension = '.EDBLck'
    LocalLogExtension = '.EDBLog'
    LocalLogCategories = [lcInformation, lcWarning, lcError]
    LocalCatalogName = 'EDBDatabase'
    LocalCatalogExtension = '.EDBCat'
    LocalBackupExtension = '.EDBBkp'
    LocalUpdateExtension = '.EDBUpd'
    LocalTableExtension = '.EDBTbl'
    LocalTableIndexExtension = '.EDBIdx'
    LocalTableBlobExtension = '.EDBBlb'
    LocalTablePublishExtension = '.EDBPbl'
    LocalCacheModules = False
    RemoteSignature = 'edb_signature'
    RemoteEncryptionPassword = 'elevatesoft'
    RemoteAddress = '127.0.0.1'
    Left = 656
    Top = 176
  end
  object EDBDatabase1: TEDBDatabase
    Connected = True
    DatabaseName = 'SWEETSALDB'
    Database = 'SWEETSAL'
    SessionName = 'SWEETSAL'
    Left = 656
    Top = 240
  end
  object EDBQuery1: TEDBQuery
    DatabaseName = 'SWEETSALDB'
    SessionName = 'SWEETSAL'
    SQL.Strings = (
      
        'SELECT ABSS3_StkItems.CODE, ABSS3_StkItems.NAME, ABSS3_StkItems.' +
        'CATALOG, ABSS3_StkItems.DEPARTMENT,'
      '       ABSS3_StkPrice.Q1_SALEPRICE, ABSS3_StkQty.QTYONHAND'
      'FROM ABSS3_StkItems'
      
        'JOIN ABSS3_StkPrice ON ABSS3_StkItems.CODE = ABSS3_StkPrice.ITEM' +
        'CODE'
      'JOIN ABSS3_StkQty ON ABSS3_StkItems.CODE = ABSS3_StkQty.ITEMCODE'
      'WHERE (DEPARTMENT BETWEEN '#39'AA'#39' AND '#39'FPARABIC'#39')'
      'AND (GROUP1 BETWEEN '#39' F'#39' AND '#39'RF'#39')'
      'AND (GROUP2 BETWEEN '#39'A'#39' AND '#39'Z'#39')'
      'AND (GROUP3='#39'G1.1.11'#39')'
      'AND (GROUP4=GROUP4)'
      'AND (ABSS3_StkPrice.SALECURRENCY = '#39'USD'#39')'
      'AND (ABSS3_StkQty.WAREHOUSE='#39'ECOM'#39')'
      'AND (ABSS3_StkPrice.PRICELIST = '#39'STANDARD'#39')')
    Params = <>
    Left = 656
    Top = 312
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 652
    Top = 410
  end
  object FDQuery1: TFDQuery
    Left = 652
    Top = 522
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 556
    Top = 370
  end
  object FDQuery2: TFDQuery
    Left = 564
    Top = 482
  end
end
