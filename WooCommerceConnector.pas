unit WooCommerceConnector;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Phys.CDataWooCommerceDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.CDataWooCommerce, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, edbcomps;

type
  TWooCommerceConnector = class

  private
    procedure CreateCategory(AName: String);
    function GetCategoryId(AName: String): Integer;
  public
    TConnection: TFDConnection;
    TDriver: TFDPhysCDataWooCommerceDriverLink;
    constructor Create;
    destructor Destroy; override;
    procedure SetUpConnection(AShopURL, AUserName, APassword, ARTK: String);
    procedure CreateItem(ASku, AName, APrice, ADesc, ACategory: String;
      AQuantity: Integer);
    procedure UpdatePrice(AId: Integer; APrice: String);
    procedure UpdateQuantity(AId, AQuantity: Integer);
    procedure UpdateItem(AName, APrice, ADesc, ACategory: String;
      AId, AQuantity: Integer);
    procedure GetLatestModified(DateLastUpdated: TDateTime);
    procedure GetLatestOrderLineModified(DateLastUpdated: TDateTime);
    function GetId(ASku: String): Integer;
    procedure DeleteOne(AId: Integer);
    procedure DeleteAll;
    function GetCategoryJSON(AName: String): String;

  end;

implementation

constructor TWooCommerceConnector.Create;
begin
  TConnection := TFDConnection.Create(nil);
end;

procedure TWooCommerceConnector.SetUpConnection(AShopURL, AUserName, APassword,
  ARTK: String);
begin
  TConnection.ConnectionString :=
    'DriverId=CDataWooCommerce;AuthScheme=Basic;Url=' + AShopURL + ';User=' +
    AUserName + ';Password=' + APassword + ';RTK=' + ARTK + ';';
  try
    TConnection.Connected := True;
  finally
  end;
end;

function TWooCommerceConnector.GetId(ASku: string): Integer;
var
  vQuery: TFDQuery;
  vId: Integer;
begin
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := TConnection;
    vQuery.SQL.Text := 'Select Id FROM Products WHERE Sku=:sku';
    vQuery.ParamByName('SKU').AsString := ASku;
    vQuery.Open;
    vId := vQuery.FieldByName('id').AsInteger;
  finally
  vQuery.Free;
    Result := vId;
  end;
end;

function TWooCommerceConnector.GetCategoryJSON(AName: String): String;
var
  vId: Integer;
begin
  vId := GetCategoryId(AName);
  if vId = 0 then
  begin
    CreateCategory(AName);
    vId := GetCategoryId(AName);
  end;
  Result := '[{"id":"' + IntToStr(vId) + '","name":"' + AName + '","slug": " ' +
    AName + 'cat"}]';
end;

procedure TWooCommerceConnector.UpdatePrice(AId: Integer; APrice: String);
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := TConnection;
    vQuery.SQL.Text :=
      'UPDATE Products SET RegularPrice = :NewPrice WHERE Id = :id';
    vQuery.ParamByName('NewPrice').AsString := APrice;
    vQuery.ParamByName('id').AsInteger := AId;
    vQuery.ExecSQL;
  finally
    vQuery.Free;
  end;
end;

procedure TWooCommerceConnector.UpdateQuantity(AId, AQuantity: Integer);
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := TConnection;
    vQuery.SQL.Text :=
      'UPDATE Products SET StockQuantity = :newQuantity WHERE Id = :id';
    vQuery.ParamByName('newQuantity').AsInteger := AQuantity;
    vQuery.ParamByName('id').AsInteger := AId;
    vQuery.ExecSQL;
  finally
    vQuery.Free;
  end;
end;

procedure TWooCommerceConnector.DeleteOne(AId: Integer);
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := TConnection;
    vQuery.SQL.Text := 'DELETE FROM Products WHERE Id= :id';
    vQuery.Params[0].AsInteger := AId;
    vQuery.ExecSQL;
  finally
    vQuery.Free;
  end;
end;

procedure TWooCommerceConnector.DeleteAll;
var
  vQuery: TFDQuery;
  vQuery2: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  vQuery2 := TFDQuery.Create(nil);
  try
    vQuery.Connection := TConnection;
    vQuery2.Connection := TConnection;
    vQuery.SQL.Text := 'SELECT Id FROM Products';
    vQuery.Open;
    while not vQuery.Eof do
    begin
      vQuery2.SQL.Text := 'DELETE FROM Products WHERE Id= :id';
      vQuery2.Params[0].AsInteger := vQuery.FieldByName('id').AsInteger;
      vQuery2.ExecSQL;
      vQuery.Next;
    end;
  finally
    vQuery.Free;
    vQuery2.Free;
  end;
end;

function TWooCommerceConnector.GetCategoryId(AName: String): Integer;
var
  vQuery: TFDQuery;
  vId: Integer;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := TConnection;
    vQuery.SQL.Text := 'Select Id FROM Categories WHERE Name=:name';
    vQuery.ParamByName('name').AsString := AName;
    vQuery.Open;
    vId := vQuery.FieldByName('Id').AsInteger;
  finally
    vQuery.Free;
    Result := vId;
  end;
end;

procedure TWooCommerceConnector.CreateCategory(AName: String);
var
  vQuery: TFDQuery;
  vId: Integer;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := TConnection;
    vQuery.SQL.Text := 'INSERT INTO Categories(Name) VALUES (:name)';
    vQuery.ParamByName('name').AsString := AName;
    vQuery.ExecSQL;
  finally
    vQuery.Free;
  end;
end;

procedure TWooCommerceConnector.UpdateItem(AName, APrice, ADesc,
  ACategory: String; AId, AQuantity: Integer);
begin
  var
    vQuery: TFDQuery;
  begin
    vQuery := TFDQuery.Create(nil);
    try
      vQuery.Connection := TConnection;
      vQuery.SQL.Text :=
        'UPDATE Products SET Name = :name, RegularPrice = :price, StockQuantity = :quantity,'
        + ' ShortDescription = :desc, CategoriesAggregate = :category WHERE Id = :id';
      vQuery.ParamByName('id').AsInteger := AId;
      vQuery.ParamByName('price').AsString := APrice;
      vQuery.ParamByName('quantity').AsInteger := AQuantity;
      vQuery.ParamByName('desc').AsString := ADesc;
      vQuery.ParamByName('name').AsString := AName;
      vQuery.ParamByName('category').AsString := GetCategoryJSON(ACategory);
      vQuery.ExecSQL;
    finally
      vQuery.Free;
    end;
  end;
end;

procedure TWooCommerceConnector.CreateItem(ASku, AName, APrice, ADesc,
  ACategory: String; AQuantity: Integer);
begin
  var
    vQuery: TFDQuery;
  begin
    vQuery := TFDQuery.Create(nil);
    try
      vQuery.Connection := TConnection;
      vQuery.SQL.Text :=
        'INSERT INTO Products (SKU,RegularPrice,ManageStock ,StockQuantity,ShortDescription,Name,CategoriesAggregate) '
        + 'VALUES (:sku,:price,True,:quantity, :desc,:name, :category)';
      vQuery.ParamByName('sku').AsString := ASku;
      vQuery.ParamByName('price').AsString := APrice;
      vQuery.ParamByName('quantity').AsInteger := AQuantity;
      vQuery.ParamByName('desc').AsString := ADesc;
      vQuery.ParamByName('name').AsString := AName;
      vQuery.ParamByName('category').AsString := GetCategoryJSON(ACategory);
      vQuery.ExecSQL;
    finally
      vQuery.Free;
    end;
  end;
end;

procedure TWooCommerceConnector.GetLatestModified(DateLastUpdated: TDateTime);
begin
  var
    vQuery: TFDQuery;
  begin
    vQuery := TFDQuery.Create(nil);
    try
      vQuery.Connection := TConnection;
      vQuery.SQL.Text :=
        'SELECT * FROM Orders WHERE DateModified > :dateModified';
      vQuery.ParamByName('dateModified').AsDateTime := DateLastUpdated;
      vQuery.Open;
      // while not vQuery.Eof do
      // begin
      // // iterate over results one at a time and do specific code such as write to local db
      // vQuery.Next;
      // end;
    finally
      vQuery.Free;
    end;
  end;
end;

procedure TWooCommerceConnector.GetLatestOrderLineModified(DateLastUpdated
  : TDateTime);
begin
  var
    vQuery: TFDQuery;
  begin
    vQuery := TFDQuery.Create(nil);
    try
      vQuery.Connection := TConnection;
      vQuery.SQL.Text :=
        'SELECT * FROM OrderLineItems WHERE OrderId IN (SELECT Id FROM Orders WHERE DateModified > :dateModified)';
      vQuery.ParamByName('dateModified').AsDateTime := DateLastUpdated;
      vQuery.Open;
      // while not vQuery.Eof do
      // begin
      // // iterate over results one at a time and do specific code such as write to local db
      // vQuery.Next;
      // end;
    finally
      vQuery.Free;
    end;
  end;
end;

destructor TWooCommerceConnector.Destroy;
begin
  TConnection.Free;
  inherited;
end;

end.
