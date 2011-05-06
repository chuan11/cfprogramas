unit fDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDM = class(TDataModule)
    tblCustomer: TTable;
    tblOrders: TTable;
    dsrCustomer: TDataSource;
    dsrOrders: TDataSource;
    tblCustomerCustNo: TFloatField;
    tblCustomerCompany: TStringField;
    tblCustomerAddr1: TStringField;
    tblCustomerAddr2: TStringField;
    tblCustomerCity: TStringField;
    tblCustomerState: TStringField;
    tblCustomerZip: TStringField;
    tblCustomerCountry: TStringField;
    tblCustomerPhone: TStringField;
    tblCustomerFAX: TStringField;
    tblCustomerTaxRate: TFloatField;
    tblCustomerContact: TStringField;
    tblCustomerLastInvoiceDate: TDateTimeField;
    tblOrdersOrderNo: TFloatField;
    tblOrdersCustNo: TFloatField;
    tblOrdersSaleDate: TDateTimeField;
    tblOrdersShipDate: TDateTimeField;
    tblOrdersEmpNo: TIntegerField;
    tblOrdersShipToContact: TStringField;
    tblOrdersShipToAddr1: TStringField;
    tblOrdersShipToAddr2: TStringField;
    tblOrdersShipToCity: TStringField;
    tblOrdersShipToState: TStringField;
    tblOrdersShipToZip: TStringField;
    tblOrdersShipToCountry: TStringField;
    tblOrdersShipToPhone: TStringField;
    tblOrdersShipVIA: TStringField;
    tblOrdersPO: TStringField;
    tblOrdersTerms: TStringField;
    tblOrdersPaymentMethod: TStringField;
    tblOrdersItemsTotal: TCurrencyField;
    tblOrdersTaxRate: TFloatField;
    tblOrdersFreight: TCurrencyField;
    tblOrdersAmountPaid: TCurrencyField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.DFM}

end.
