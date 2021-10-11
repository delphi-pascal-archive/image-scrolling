program Image_Scrolling_1;

uses
  Forms,
  cc in 'cc.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
