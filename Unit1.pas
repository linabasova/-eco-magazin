unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit2: TEdit;
    Edit5: TEdit;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    DBLookupComboBox1: TDBLookupComboBox;
    TabSheet2: TTabSheet;
    DBGridpersonal: TDBGrid;
    Panel3: TPanel;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    TabSheet3: TTabSheet;
    DBGrid2: TDBGrid;
    Panel4: TPanel;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    TabSheet4: TTabSheet;
    DBGrid3: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, DB, Unit4;

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
//Додавання запросу таблиці Продукція
DataModule2.ADOQprodukcia.Close;
DataModule2.ADOQprodukcia.SQL.Text:='SELECT Продукція.Код_продукції, Продукція.Назва, Продукція.Кількість, Продукція.Ціна, Постачальник.[Назва країни] '
 + 'FROM Постачальник INNER JOIN Продукція ON Постачальник.Код_постачальника = Продукція.Код_постачальника';
DataModule2.ADOQprodukcia.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//Кнопка додади для запросу таблиці з продукцією на формі довідник
Edit1.Text:=' ';
Edit3.Text:='0';
Edit4.Text:='0';
DBLookupComboBox1.KeyValue:=1;

Button5.Visible:=True;
Button6.Visible:=False;

Panel2.Visible:=True;
Panel1.Visible:=False;

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
//Кнопка додати запис до запросу таблиці продукції на формі довідник
DataModule2.ADOQWork.Close;
DataModule2.ADOQWork.SQL.Text:='INSERT INTO Продукція ([Назва], [Код_постачальника] , [Кількість], [Ціна] )'
+ ' values ("'+Edit1.Text+'", '+IntToStr(DBLookupComboBox1.KeyValue)+', '+Edit3.Text+', '+Edit4.Text+')' ;
DataModule2.ADOQWork.ExecSQL;

DataModule2.ADOQprodukcia.Close;
DataModule2.ADOQprodukcia.SQL.Text:= 'SELECT Продукція.Код_продукції, Продукція.Назва, Продукція.Кількість, Продукція.Ціна, Постачальник.[Назва країни] '
 + 'FROM Постачальник INNER JOIN Продукція ON Постачальник.Код_постачальника = Продукція.Код_постачальника';
DataModule2.ADOQprodukcia.Open;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//Кнопка змінити до  запросу таблиці продукція на формі довідник
Edit1.Text:=DBGrid1.Fields[1].AsString;
Edit3.Text:=DBGrid1.Fields[3].AsString;
Edit4.Text:=DBGrid1.Fields[2].AsString;
DataModule2.ADOTpostachalnik.Locate('Назва країни', DBGrid1.Fields[4].AsString,[loCaseInsensitive, loPartialKey]);
DBLookupComboBox1.KeyValue:=StrToInt(DataModule2.Datapostachalnik.DataSet.Fields[0].AsString);

Button5.Visible:=False;
Button6.Visible:=True;

Panel2.Visible:=True;
Panel1.Visible:=False;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
//Кнопка змінити запис запросу таблиці продукція на формі довідник
DataModule2.ADOQWork.Close;
DataModule2.ADOQWork.SQL.Text:='UPDATE Продукція SET Продукція.Назва = "'+Edit1.Text+'", Продукція.Код_постачальника = '+IntToStr(DBLookupComboBox1.KeyValue)+', Продукція.Кількість = '+Edit3.Text+', Продукція.Ціна = '+Edit4.Text+' '
+ ' WHERE (((Продукція.Код_продукції)='+DBGrid1.Fields[0].AsString+'))';
DataModule2.ADOQWork.ExecSQL;

FormShow(Sender);

Panel2.Visible:=False;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
//Кнопка видалення товару з запросу таблиці з продукцією на формі довідник
DataModule2.ADOQWork.Close;
DataModule2.ADOQWork.SQL.Text:='DELETE * FROM Продукція WHERE (Продукція.Код_продукції = '+DBGrid1.Fields[0].AsString+')';
DataModule2.ADOQWork.ExecSQL;
FormShow(Sender);
end;



procedure TForm1.Button9Click(Sender: TObject);
begin
//Кнопка Ок для пошуку
DataModule2.ADOQprodukcia.Close;
DataModule2.ADOQprodukcia.SQL.Text:= 'SELECT Продукція.Код_продукції, Продукція.Назва, Продукція.Кількість, Продукція.Ціна, Постачальник.[Назва країни] '
 + 'FROM Постачальник INNER JOIN Продукція ON Постачальник.Код_постачальника = Продукція.Код_постачальника WHERE Продукція.Код_продукції = '+Edit2.Text+' ORDER BY Продукція.Код_продукції';
DataModule2.ADOQprodukcia.Open;
end;

procedure TForm1.Edit5Change(Sender: TObject);
begin
//Пошук по назві
DataModule2.ADOQprodukcia.Close;
DataModule2.ADOQprodukcia.SQL.Text:= 'SELECT Продукція.Код_продукції, Продукція.Назва, Продукція.Кількість, Продукція.Ціна, Постачальник.[Назва країни] '
 + 'FROM Постачальник INNER JOIN Продукція ON Постачальник.Код_постачальника = Продукція.Код_постачальника WHERE Продукція.Назва like "%'+Edit5.Text+'%" ORDER BY Продукція.Код_продукції';
DataModule2.ADOQprodukcia.Open;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
//Кнопка додати до таблиці персонал
DataModule2.ADOTpersonal.Insert;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
//Кнопка змінити до таблиці персонал
if DataModule2.ADOTpersonal.Modified then DataModule2.ADOTpersonal.Post;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
//Кнопка видалити до таблиці персонал
DataModule2.ADOTpersonal.Delete;
end;



procedure TForm1.Button7Click(Sender: TObject);
begin
//Кнопка відмини для додаваня та зміни запису
Edit1.Text:=' ';
Edit3.Text:='0';
Edit4.Text:='0';
DBLookupComboBox1.KeyValue:=1;

Button5.Visible:=True;
Button6.Visible:=True;

Panel2.Visible:=True;
Panel1.Visible:=True;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
//Кнопка відміна для пошуку
Edit2.Text:= ' ';
Edit5.Text:= ' ';
FormShow(Sender);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//Виводить форму з прайс-листом для друку або перегляду у форматі документа
Form4.QuickRep1.PreviewModal;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
//Кнопка додати до таблиці постачальник
DataModule2.ADOTablePostach.Insert;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
//Кнопка змінити до таблиці постачальник
if DataModule2.ADOTablePostach.Modified then DataModule2.ADOTablePostach.Post;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
//Кнопка видалити до таблиці постачальник
DataModule2.ADOTablePostach.Delete;
end;


end.
