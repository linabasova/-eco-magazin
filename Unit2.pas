unit Unit2;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataModule2 = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOTpostachalnik: TADOTable;
    ADOTpersonal: TADOTable;
    ADOQchek: TADOQuery;
    ADOQprodukcia: TADOQuery;
    Datapostachalnik: TDataSource;
    Datapersonal: TDataSource;
    Dataprodukcia: TDataSource;
    Datachek: TDataSource;
    ADOQWork: TADOQuery;
    DataWork: TDataSource;
    ADOQprodukcia2: TADOQuery;
    Dataprodukcia2: TDataSource;
    ADOTprodtabl: TADOTable;
    Dataprodtabl: TDataSource;
    ADOTpersonal2: TADOTable;
    Datapersonal2: TDataSource;
    ADOTPrice: TADOTable;
    DataPrice: TDataSource;
    ADOTablePostach: TADOTable;
    DataTablePostach: TDataSource;
    chekpechat: TADOQuery;
    Datachekpechat: TDataSource;
    prodaji: TADOQuery;
    Dataprodaji: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation

uses Unit1, Unit3, Unit4, Unit5;

{$R *.dfm}

end.

















