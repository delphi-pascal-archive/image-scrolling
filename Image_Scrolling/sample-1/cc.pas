unit cc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JPEG, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    procedure Move_im;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Bmp: TBitmap;
  jpg: TJpegImage;
  ix,iy,xx,yy: integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 Bmp:=TBitmap.Create;
 jpg:=TJpegImage.Create;
 Image1.Parent.DoubleBuffered:=true;
 //
 // Label1.Transparent:=true;
 // Label2.Transparent:=true;
 // Label3.Transparent:=true;
 Label1.Caption:=' X: 0, Y: 0 ';
 Label2.Caption:=' IX: 0, IY: 0 ';
 Label3.Caption:=' XX: 0, YY: 0 ';
end;

procedure TForm1.Move_im;
begin
 BitBlt(Image1.Canvas.Handle,ix,iy,Bmp.Width,Bmp.Height,Bmp.Canvas.Handle,0,0,SRCCOPY);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if OpenDialog1.Execute
 then
  begin
   jpg.LoadFromFile(OpenDialog1.FileName);
   bmp.Assign(jpg);
   Image1.Picture.Graphic:=nil;
   ix:=0;
   iy:=0;
   Move_im;
  end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if ssLeft in Shift
 then
  begin
   ix:=x-xx;
   iy:=y-yy;
   //
   if (ix>=Image1.Width-Bmp.Width) // правая сторона
      and (iy>=Image1.Height-Bmp.Height) // низ
      and (ix<=0) // левая сторона
      and (iy<=0) // верх
   then
    begin
     Image1.Picture.Graphic:=nil;
     Move_im;
    end
   else
    begin
     // правая сторона
     if (ix<Image1.Width-Bmp.Width)
     then
      begin
       ix:=Image1.Width-Bmp.Width;
       Image1.Picture.Graphic:=nil;
       Move_im;
      end;
      // низ
     if (iy<Image1.Height-Bmp.Height)
     then
      begin
       iy:=Image1.Height-Bmp.Height;
       Image1.Picture.Graphic:=nil;
       Move_im;
      end;
     // левая сторона
     if (ix>0)
     then
      begin
       ix:=0;
       Image1.Picture.Graphic:=nil;
       Move_im;
      end;
      // верх
     if (iy>0)
     then
      begin
       iy:=0;
       Image1.Picture.Graphic:=nil;
       Move_im;
      end;
    end;
  end;
 Label1.Caption:=' X: '+IntToStr(x)+', Y: '+IntToStr(y)+' ';
 Label2.Caption:=' IX: '+IntToStr(ix)+', IY: '+IntToStr(iy)+' ';
 Label3.Caption:=' XX: '+IntToStr(xx)+', YY: '+IntToStr(yy)+' ';
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (Button=mbLeft)
 then
  begin
   xx:=x-ix;
   yy:=y-iy;
   Move_im;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Bmp.Free;
 jpg.Free;
end;

end.
