unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DBCtrls, ComCtrls, StdCtrls, ExtCtrls, Grids, DBGrids;

type
  TForm3 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    DateTimePicker1: TDateTimePicker;
    DBLookupComboBox1: TDBLookupComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DBGrid2: TDBGrid;
    UpDown1: TUpDown;
    Edit1: TEdit;
    Label8: TLabel;
    Label4: TLabel;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  cheknom, cheksum, cenaprod:string;

implementation

uses Unit1, Unit2, Unit4, Unit5, Unit6;

{$R *.dfm}

procedure TForm3.N1Click(Sender: TObject);
begin
Form1.Show;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
//������ ����� � ������� ���
DataModule2.ADOQWork.Close;
DataModule2.ADOQWork.SQL.Text:='INSERT INTO ��� ([����],[��������_����]) Values (:dt,0)';
DataModule2.ADOQWork.Parameters.ParamByName('dt').Value:=FormatDateTime('dd.mm.yyyy',DateTimePicker1.Date);
DataModule2.ADOQWork.ExecSQL;

FormShow(Sender);

//������ �� ������� � �����������
DataModule2.ADOQWork.close;
DataModule2.ADOQWork.SQL.Text:= 'SELECT * From ��� order by ���_����';
DataModule2.ADOQWork.Open;

//������� �� ������� �����
DataModule2.ADOQWork.Last;
Cheknom:=DataModule2.DataWork.DataSet.Fields[0].AsString;
Label1.Caption:='��� � '+cheknom;

//����� ������� ������� �������, ����, �� ���� � ����
DataModule2.ADOQprodukcia2.Close;
DataModule2.ADOQprodukcia2.SQL.Text:='SELECT �������.���_������, �������.����_�������, ���������.�����, �������.ʳ������, ���������.ֳ��, ��������.�I�, �������.���_����, �������.����'
+' FROM ��������� INNER JOIN (�������� INNER JOIN ������� ON ��������.[�_����������] = �������.[�_����������]) ON ���������.���_��������� = �������.���_��������� '
+ 'WHERE (((�������.���_����) = '+cheknom+'))';
DataModule2.ADOQprodukcia2.Open;

cheksum:= '0' ;
Label3.Caption:= 'C��� �� ���� (���): ' + cheksum;
Panel2.Enabled:=True;


//������������ ���� �� ����������
DBLookupComboBox2.Enabled:=True;
DateTimePicker1.Enabled:=True;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
//������� ��� ������� ���, ���������
DataModule2.ADOQchek.close;
DataModule2.ADOQchek.SQL.Text:= 'SELECT * From ��� order by ���_����';
DataModule2.ADOQchek.Open;

DBLookupComboBox1.KeyValue:=1;
DBLookupComboBox2.KeyValue:=1;

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
//���������� ���� ������� ������� ������� �������
DataModule2.ADOQWork.Close;
DataModule2.ADOQWork.SQL.Text:= 'INSERT INTO ������� ([����_�������], [ʳ������], [���_����], [���_���������], [�_����������], [����] ) '
+ ' Values (:dt, '+edit1.Text+', '+cheknom+', '+inttostr(DBLookupComboBox1.KeyValue)+', '+inttostr(DBLookupComboBox2.KeyValue)+',  '+cenaprod+')';
DataModule2.ADOQWork.Parameters.ParamByName('dt').Value:=FormatDateTime('dd.mm.yyyy',DateTimePicker1.Date);
DataModule2.ADOQWork.ExecSQL;

//�������� ������ ������� ������� � ����������� ������
DataModule2.ADOQprodukcia2.Close;
DataModule2.ADOQprodukcia2.SQL.Text:='SELECT �������.���_������, �������.����_�������, ���������.�����, �������.ʳ������, ���������.ֳ��, ��������.�I�, �������.���_����, �������.����'
+' FROM ��������� INNER JOIN (�������� INNER JOIN ������� ON ��������.[�_����������] = �������.[�_����������]) ON ���������.���_��������� = �������.���_��������� '
+ 'WHERE (((�������.���_����) = '+cheknom+'))';
DataModule2.ADOQprodukcia2.Open;

//���������� ���� ��������� � ��������� ����� ����
DataModule2.ADOQWork.Close;
DataModule2.ADOQWork.SQL.Text:=' Select Sum(�������.[����]) AS [Sum-����] FROM ������� GROUP BY �������.[���_���� ] HAVING (((�������.[���_���� ])= '+cheknom+'))';
DataModule2.ADOQWork.Open;
cheksum:= DataModule2.DataWork.DataSet.Fields[0].AsString;
label3.caption:= '���� �� ���� (���): ' + cheksum;

//��������� �������� ��������_���� � ������� ���
DataModule2.ADOQWork.Close;
DataModule2.ADOQWork.SQL.Text:='UPDATE [���] SET ���.[��������_����] = '+cheksum+'  WHERE [���.���_����]='+cheknom;
DataModule2.ADOQWork.ExecSQL;

//����������� ���� �� ����������
DBLookupComboBox2.Enabled:=False;
DateTimePicker1.Enabled:= False;
end;

procedure TForm3.Edit1Change(Sender: TObject);
begin
//����_��������� = ���� * �-���
cenaprod:=IntToStr(DataModule2.Dataprodtabl.DataSet.Fields[3].AsInteger * strtoint(Edit1.Text));
Label8.Caption:='ֳ�� �� ������ � ���: ' + cenaprod;
end;


procedure TForm3.DBLookupComboBox1Click(Sender: TObject);
begin
//���� ���� �� ��. �� ���� �� ������ � Lable
cenaprod:=InttoStr(DataModule2.Dataprodtabl.DataSet.Fields[3].AsInteger * strtoint(Edit1.Text));
Label8.Caption:='ֳ�� �� ������ � ���: ' + cenaprod;
Label5.Caption:='ֳ�� �� ��. � ���: ' +  DataModule2.Dataprodtabl.DataSet.Fields[3].AsString;

end;


procedure TForm3.Button3Click(Sender: TObject);
begin
DataModule2.ADOQchek.Close;
DataModule2.ADOQchek.SQL.Text:= 'Delete * FROM ������� Where [���_������] = '+DBGrid2.Fields[0].AsString+'';
DataModule2.ADOQchek.ExecSQL;

DataModule2.ADOQprodukcia2.Close;
DataModule2.ADOQprodukcia2.SQL.Text:='SELECT �������.���_������, �������.����_�������, ���������.�����, �������.ʳ������, ���������.ֳ��, ��������.�I�, �������.���_����, �������.����'
+' FROM ��������� INNER JOIN (�������� INNER JOIN ������� ON ��������.[�_����������] = �������.[�_����������]) ON ���������.���_��������� = �������.���_��������� '
+ 'WHERE (((�������.���_����) = '+cheknom+'))';
DataModule2.ADOQprodukcia2.Open;

DataModule2.ADOQWork.Close;
DataModule2.ADOQWork.SQL.Text:=' Select Sum(�������.[����]) AS [Sum-����] FROM ������� GROUP BY �������.[���_���� ] HAVING (((�������.[���_���� ])= '+cheknom+'))';
DataModule2.ADOQWork.Open;
cheksum:= DataModule2.DataWork.DataSet.Fields[0].AsString;
label3.caption:= '���� �� ���� (���): ' + cheksum;

DataModule2.ADOQWork.Close;
DataModule2.ADOQWork.SQL.Text:='UPDATE [���] SET ���.[��������_����] = '+cheksum+'  WHERE [���.���_����]='+cheknom;
DataModule2.ADOQWork.ExecSQL;


DataModule2.ADOQchek.close;
DataModule2.ADOQchek.SQL.Text:= 'SELECT * From ��� order by ���_����';
DataModule2.ADOQchek.Open;

DBLookupComboBox1.KeyValue:=1;

end;

procedure TForm3.Button4Click(Sender: TObject);
begin
DataModule2.chekpechat.Close;
DataModule2.chekpechat.SQL.Text:='SELECT �������.���_������, �������.����_�������, ���������.�����, �������.ʳ������, ���������.ֳ��, ��������.�I�, �������.���_����, �������.����'
+' FROM ��������� INNER JOIN (�������� INNER JOIN ������� ON ��������.[�_����������] = �������.[�_����������]) ON ���������.���_��������� = �������.���_��������� '
+ 'WHERE (((�������.���_����) = '+cheknom+'))';
DataModule2.chekpechat.Open;

  Form5.QRLabel2.Caption:='����: '+ DateToStr(DateTimePicker1.Date );
  Form5.QRLabel3.Caption:='���������: '+ DBLookupComboBox2.Text;
  Form5.QRLabel1.Caption:='��� �: '+ cheknom;
  Form5.QRLabel10.Caption:='���� �� ���� � (���): '+ cheksum;
  Form5.QuickRep1.PreviewModal;
end;

procedure TForm3.N2Click(Sender: TObject);
begin
Form6.Show;
end;

procedure TForm3.N3Click(Sender: TObject);
begin
Close;
end;

end.
