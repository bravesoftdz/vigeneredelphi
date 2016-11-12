unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, Grids, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    button3: TButton;
    Button4: TButton;
    Button5: TButton;
    decryptmemo: TMemo;
    keyedit: TEdit;
    encryptmemo: TMemo;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    plainmemo: TMemo;
    StringGrid1: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure encrypt;
    procedure Button2Click(Sender: TObject);
    procedure button3Click(Sender: TObject);
   procedure decrypt;

  private
    square:ARRAY[1..26,1..26] of char;

  public
    { public declarations }
  end;

var
 i,j, plength, klength:integer;
plaintext,key,s:string;
  Form1: TForm1;


implementation

{$R *.lfm}

{ TForm1 }
uses
  unit2;
procedure TForm1.Button1Click(Sender: TObject);
begin
//encrypt
 if  ( plainmemo.text = '') or (keyedit.text = '') then  showmessage('Key and/or Plaintext missing.'+#13#10+'Schlüssel und/oder Klartext fehlend.')
 else      begin
encryptmemo.text:='';   //falls was in der Verschlüsselmemo ist -> vorher löschen
key := StringReplace(keyedit.text, ' ', '', [rfReplaceAll]); //Wer mag schon Leerzeichen?
plaintext := StringReplace(plainmemo.text, ' ', '', [rfReplaceAll]); //Weiteres im Hilfebutton
plength:=length(plaintext);
klength:=length(key);

while klength<plength do begin
key:= concat(key,key);
klength:=length(key);
end;
encrypt;        end;         end;


procedure TForm1.encrypt;
var
plainvalue,keyvalue,ciphervalue:integer;
cipher:string;

begin
for
i:=1 to plength
do
begin
plainvalue:=ord (upcase (plaintext[i]))-65;
keyvalue:=ord (upcase (key[i]))-65;
ciphervalue:=((plainvalue+keyvalue)
mod
 26);
cipher:=chr(ciphervalue+65);
encryptmemo.text:=encryptmemo.text+cipher;
end;
end;

//decrypt
procedure TForm1.Button2Click(Sender: TObject);
begin
 if  encryptmemo.text = ''  then  showmessage('Encryption needed.'+#13#10+'Verschlüsselung benötigt.')
 else begin
decryptmemo.text:=''; //falls was in der entschlüsselmemo ist -> vorher löschen

plaintext:=(encryptmemo.text);
key:=keyedit.text;
plength:=length(plaintext);
klength:=length(key);
while klength<plength do
begin
key:= concat(key,key);
klength:=length(key);
end;
decrypt;
end;    end;


procedure TForm1.decrypt;
var
plainvalue,keyvalue,unciphervalue:integer;
uncipher:string;
begin
for i:=1 to plength do
begin
plainvalue:=ord (upcase(plaintext[i]))-65;
keyvalue:=ord (upcase(key[i]))-65;
unciphervalue:=((plainvalue-keyvalue+26)mod 26);
uncipher:=chr(unciphervalue+65);
decryptmemo.text:=decryptmemo.text+uncipher;

end;
end;


//Quadrat

procedure TForm1.button3Click(Sender: TObject);

var s, z:integer;
begin
button3.visible:=false;
i:=0;
for z:=1 to 26 do
begin
for s:=1 to 26-i do
square[s,z]:=chr(s+64+i);
j:=0;
for s:=26-i+1 to 26 do
begin
j:=j+1;
square[s,z]:=chr(64+j)
end;
i:=i+1;
end;
for i:=1 to 26 do
for j:=1 to 26 do
stringgrid1.cells[i-1,j-1]:=square[i,j];
stringgrid1.visible:=true;
end;
//hilfe button

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  showmessage('1. Choosing a longer key than the message is the best option.'+#13#10+'2. Prevent spaces and characters like periods. Decrypting the message will be harder.'
+#13#10+''+#13#10+'1. Eine Nachricht zu entschlüsseln, die einen kürzeren Schlüssel als die Nachricht besitzt ist einfacher.'
+#13#10+'2. Nachrichten mit Leerzeichen und allgemein Zeichen sind sehr schnell zu knacken.'+#13#10+''+#13#10+'© 2016 Jeremy Grunert')
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
Application.Terminate()

end;

//clear button
procedure TForm1.Button4Click(Sender: TObject);
begin
plainmemo.text:='';
keyedit.text:='';
encryptmemo.text:='';
decryptmemo.text:='';
end;


procedure TForm1.Button5Click(Sender: TObject);
var   wtf:twtf;
begin
  wtf := Twtf.Create(application);
   wtf.ShowModal;
end;


end.

