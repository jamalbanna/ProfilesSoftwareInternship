unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, WooCommerceConnector,
  Data.DB, edbcomps, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    EDBEngine1: TEDBEngine;
    EDBSession1: TEDBSession;
    EDBDatabase1: TEDBDatabase;
    EDBQuery1: TEDBQuery;
    PageControl1: TPageControl;
    PRODUCTS: TTabSheet;
    ORDERS: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    Edit3: TEdit;
    Edit4: TEdit;
    CheckBox2: TCheckBox;
    Edit5: TEdit;
    Edit6: TEdit;
    CheckBox3: TCheckBox;
    Edit7: TEdit;
    Edit8: TEdit;
    CheckBox4: TCheckBox;
    Edit9: TEdit;
    Edit10: TEdit;
    CheckBox5: TCheckBox;
    Edit11: TEdit;
    Edit12: TEdit;
    CheckBox6: TCheckBox;
    Button1: TButton;
    Edit13: TEdit;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button2: TButton;
    FDQuery1: TFDQuery;
    CheckBox7: TCheckBox;
    ProgressBar1: TProgressBar;
    DataSource2: TDataSource;
    FDQuery2: TFDQuery;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBGrid2: TDBGrid;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    TWC: TWooCommerceConnector;
    DateLastUpdated: TDateTime;
    TempDateLastUpdated: TDateTime;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  vSku, vName, vShortDesc, vRegularPrice, vCategory, vCategoryFormatted: String;
var
  vId, vStockQuantity: Integer;
begin
  ProgressBar1.Visible := True;
  ProgressBar1.Position := 0;
  ProgressBar1.Min := 0;
  if CheckBox7.Checked then
  begin
    TWC.DeleteAll;
  end;
  EDBQuery1.SQL.Clear;
  EDBQuery1.SQL.Text :=
    'SELECT ABSS3_StkItems.CODE, ABSS3_StkItems.NAME, ABSS3_StkItems.CATALOG, ABSS3_StkItems.DEPARTMENT, ABSS3_StkPrice.Q1_SALEPRICE, ABSS3_StkQty.QTYONHAND FROM ABSS3_StkItems';
  EDBQuery1.SQL.Add
    ('JOIN ABSS3_StkPrice ON ABSS3_StkItems.CODE = ABSS3_StkPrice.ITEMCODE');
  EDBQuery1.SQL.Add
    ('JOIN ABSS3_StkQty ON ABSS3_StkItems.CODE = ABSS3_StkQty.ITEMCODE');
  if CheckBox1.Checked then
  begin
    EDBQuery1.SQL.Add
      ('AND (ABSS3_StkItems.DEPARTMENT = ABSS3_StkItems.DEPARTMENT)');
  end
  else
  begin
    EDBQuery1.SQL.Add
      ('AND (ABSS3_StkItems.DEPARTMENT BETWEEN :Dep1 AND :Dep2)');
    EDBQuery1.ParamByName('Dep1').AsString := Edit1.Text;
    EDBQuery1.ParamByName('Dep2').AsString := Edit2.Text;
  end;
  if CheckBox2.Checked then
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP1 = ABSS3_StkItems.GROUP1)');
  end
  else
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP1 BETWEEN :Grp11 AND :Grp12)');
    EDBQuery1.ParamByName('Grp11').AsString := Edit3.Text;
    EDBQuery1.ParamByName('Grp12').AsString := Edit4.Text;
  end;
  if CheckBox3.Checked then
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP2 = ABSS3_StkItems.GROUP2)');
  end
  else
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP2 BETWEEN :Grp21 AND :Grp22)');
    EDBQuery1.ParamByName('Grp21').AsString := Edit5.Text;
    EDBQuery1.ParamByName('Grp22').AsString := Edit6.Text;
  end;
  if CheckBox4.Checked then
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP3 = ABSS3_StkItems.GROUP3)');
  end
  else
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP3 BETWEEN :Grp31 AND :Grp32)');
    EDBQuery1.ParamByName('Grp31').AsString := Edit7.Text;
    EDBQuery1.ParamByName('Grp32').AsString := Edit7.Text;
  end;
  if CheckBox5.Checked then
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP4 = ABSS3_StkItems.GROUP4)');
  end
  else
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP4 BETWEEN :Grp41 AND :Grp42)');
    EDBQuery1.ParamByName('Grp41').AsString := Edit9.Text;
    EDBQuery1.ParamByName('Grp42').AsString := Edit10.Text;
  end;
  if CheckBox6.Checked then
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP5 = ABSS3_StkItems.GROUP5)');
  end
  else
  begin
    EDBQuery1.SQL.Add('AND (ABSS3_StkItems.GROUP5 BETWEEN :Grp51 AND :Grp52)');
    EDBQuery1.ParamByName('Grp51').AsString := Edit11.Text;
    EDBQuery1.ParamByName('Grp52').AsString := Edit12.Text;
  end;
  EDBQuery1.SQL.Add
    ('AND (ABSS3_StkPrice.SALECURRENCY = ''USD'') AND (ABSS3_StkQty.WAREHOUSE=''ECOM'') AND (ABSS3_StkPrice.PRICELIST=:priceList)');
  EDBQuery1.ParamByName('priceList').AsString := Edit13.Text;
  EDBQuery1.Open;
  ProgressBar1.Max := EDBQuery1.RowsAffected;

  while not EDBQuery1.Eof do
  begin
    vSku := EDBQuery1.FieldByName('CODE').AsString;
    vName := EDBQuery1.FieldByName('NAME').AsString;
    vShortDesc := EDBQuery1.FieldByName('CATALOG').AsString;
    vRegularPrice := EDBQuery1.FieldByName('Q1_SALEPRICE').AsString;
    vCategory := EDBQuery1.FieldByName('DEPARTMENT').AsString;
    vStockQuantity := EDBQuery1.FieldByName('QTYONHAND').AsInteger;
    vId := TWC.GetId(vSku);
    if vId = 0 then
    begin
      TWC.CreateItem(vSku, vName, vRegularPrice, vShortDesc, vCategory,
        vStockQuantity);
    end
    else
    begin
      TWC.UpdateItem(vName, vRegularPrice, vShortDesc, vCategory, vId,
        vStockQuantity);
    end;
    ProgressBar1.StepBy(1);
    EDBQuery1.Next;
  end;
  ProgressBar1.Visible := False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TempDateLastUpdated := now;
  FDQuery1.Connection := TWC.TConnection;
  with FDQuery1 do
  begin
    SQL.Clear;
    SQL.Text := 'SELECT * FROM Orders WHERE DateModified > :dateModified';
    ParamByName('dateModified').AsDateTime := DateLastUpdated;
    Open;
  end;
  FDQuery2.Connection := TWC.TConnection;
  with FDQuery2 do
  begin
    SQL.Clear;
    SQL.Text :=
      'SELECT * FROM OrderLineItems WHERE OrderId IN (SELECT Id FROM Orders WHERE DateModified > :dateModified)';
    ParamByName('dateModified').AsDateTime := DateLastUpdated;
    Open;
  end;
  DateLastUpdated := TempDateLastUpdated;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Edit1.Visible := False;
    Edit2.Visible := False;
  end
  else
  begin
    Edit1.Visible := True;
    Edit2.Visible := True;
  end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
  begin
    Edit3.Visible := False;
    Edit4.Visible := False;
  end
  else
  begin
    Edit3.Visible := True;
    Edit4.Visible := True;
  end;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
  begin
    Edit5.Visible := False;
    Edit6.Visible := False;
  end
  else
  begin
    Edit5.Visible := True;
    Edit6.Visible := True;
  end;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then
  begin
    Edit7.Visible := False;
    Edit8.Visible := False;
  end
  else
  begin
    Edit7.Visible := True;
    Edit8.Visible := True;
  end;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  if CheckBox5.Checked then
  begin
    Edit9.Visible := False;
    Edit10.Visible := False;
  end
  else
  begin
    Edit9.Visible := True;
    Edit10.Visible := True;
  end;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  if CheckBox6.Checked then
  begin
    Edit11.Visible := False;
    Edit12.Visible := False;
  end
  else
  begin
    Edit11.Visible := True;
    Edit12.Visible := True;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TWC := TWooCommerceConnector.Create;
  TWC.SetUpConnection('https://woo-mindfully-humble-student.wpcomstaging.com',
    'ck_a79a82f998a0db2baca67bcc829f1f43df8a4278',
    'cs_44cb4832f3f0f1cdc1a15e67261f758e983def24',
    '555A464841424335415259325231504430574E31304144444556543030315343304D0000000000005A4D534D5942524E00003645374E4552564856374B550000');
  DateLastUpdated := StrToDateTime('10/08/2000 9:00:00 AM');
end;

end.
