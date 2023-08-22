program Project6;

uses
  Vcl.Forms,
//  Unit7 in 'Unit7.pas' {Form7},
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
//  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
