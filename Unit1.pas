unit Unit1;

{
---------------- Info ----------------
Created by Zapevalov Dima 2003 Ivanovo
E-mail: ZDima1987@mail.ru
Home Page: http://www.zdima-iv.nm.ru/
--------------------------------------
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    function Chislo: integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation

{$R *.dfm}

function TForm1.Chislo: integer;
var
 i: integer;
begin
 for i:=0 to Length(Edit1.Text) do
  result:=result+Ord(Edit1.Text[i])+17;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 d: byte;
 i: integer;
 f,k: TStream;
begin
 Button1.Enabled:=false;
 Button2.Enabled:=false;
 if OpenDialog1.Execute
 then
  if SaveDialog1.Execute
  then
   begin
    f:=TFileStream.Create(OpenDialog1.FileName,fmOpenRead);
    k:=TFileStream.Create(SaveDialog1.FileName+'.cod',fmCreate);
    ProgressBar1.Max:=f.Size;
    for i:=0 to f.Size-1 do
     begin
      f.Position:=i;
      k.Position:=i;
      f.Read(d,1);
      d:=d+((i*85)-i+Chislo+28*i+(2*i+5-i-1));
      k.Write(d,1);
      ProgressBar1.Position:=i;
      Application.ProcessMessages;
      if Application.Terminated then Break;      
     end;
    ProgressBar1.Position:=i;
    k.Free;
    f.Free;
   end;
 ProgressBar1.Position:=0;
 ShowMessage('Файл закодирован!');
 Button1.Enabled:=true;
 Button2.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 d: byte;
 i: integer;
 f,k: TStream;
begin
 Button1.Enabled:=false;
 Button2.Enabled:=false;
 if OpenDialog1.Execute
 then
  if SaveDialog1.Execute
  then
   begin
    f:=TFileStream.Create(OpenDialog1.FileName,fmOpenRead);
    k:=TFileStream.Create(SaveDialog1.FileName+'.txt',fmCreate);
    ProgressBar1.Max:=f.Size;
    for i:=0 to f.Size-1 do
     begin
      f.Position:=i;
      k.Position:=i;
      f.Read(d,1);
      d:=d-((i*85)-i+Chislo+28*i+(2*i+5-i-1));
      k.Write(d,1);
      ProgressBar1.Position:=i;
      Application.ProcessMessages;
      if Application.Terminated then Break;
     end;
    ProgressBar1.Position:=i;
    k.Free;
    f.Free;
   end;
 ProgressBar1.Position:=0;
 ShowMessage('Файл раскодирован!');
 Button1.Enabled:=true;
 Button2.Enabled:=true;
end;

end.
