unit Unit1;

{Bitmap Scrolling par Caribensila}

interface

uses
  Windows, Classes, StdCtrls, Graphics, Controls, Forms, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
 StartX,StartY: integer;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 StartX:=X;
 StartY:=Y;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if ssLeft in Shift
 then
  begin 
   Image1.Left:=Image1.Left-(StartX-X); // Translation horizontale
   Image1.Top:=Image1.Top-(StartY-Y); // Translation verticale
   // Pour faire correspondre le bord du Bitmap au bord du TImage
   if Image1.Left>0
   then Image1.Left:=0;
   if Image1.Top>0
   then Image1.Top:=0;
   if Image1.Left<Panel1.Width-Image1.Width
   then Image1.Left:=Panel1.Width-Image1.Width;
   if Image1.Top<Panel1.Height-Image1.Height
   then Image1.Top:=Panel1.Height-Image1.Height;
  end;
end;

end.
