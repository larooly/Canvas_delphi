unit dotalot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    FractalButton: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    ColorPick: TPanel;
    ColorDialog1: TColorDialog;
    OpenDialog1: TOpenDialog;
    Panel3: TPanel;
    openFileButton: TButton;
    Button5: TButton;
    Circle: TButton;
    Button4: TButton;
    Button6: TButton;
    SaveDialog1: TSaveDialog;
    BitBtn1: TBitBtn;

    procedure FractalButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure openFileButtonClick(Sender: TObject);
    procedure ColorPickClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CircleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    State : Integer;
    DrawColor : TColor;
    PenW:Integer;
  end;

var
  Form1: TForm1;
  Drawing : Boolean;
  StartX,StartY,EndX,EndY:Integer;


implementation

uses Math;

{$R *.dfm}


procedure DrawMandelbrot(ACanvas: TCanvas; X, Y, au, bu: Double; X2, Y2: Integer);
var
  c1, c2, z1, z2, tmp: Double;
  i, j, Count: Integer;
begin
  c2 := bu;
  for i := 10 to X2 do 
  begin
    c1 := au;
    for j := 0 to Y2 do 
    begin
      z1 := 0;
      z2 := 0;
      Count := 0;
     {count is deep of iteration of the mandelbrot set
      if |z| >=2 then z is not a member of a mandelset}
      while (((z1 * z1 + z2 * z2 < 4) and (Count <= 90))) do 
      begin
        tmp := z1;
        z1 := z1 * z1 - z2 * z2 + c1;
        z2 := 2 * tmp * z2 + c2;
        Inc(Count);
      end;
      //the color-palette depends on TColor(n*count mod t)
      {$IFDEF LINUX}
      ACanvas.Pen.Color := (16 * Count mod 255);
      ACanvas.DrawPoint(j, i);
      {$ELSE}
      ACanvas.Pixels[j, i] := (16 * Count mod 255);
      {$ENDIF}
      c1 := c1 + X;
    end;
    c2 := c2 + Y;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  State := 1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  state := 2;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  state := 3;
end;
procedure TForm1.CircleClick(Sender: TObject);
begin
  state := 4;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if (Edit1.Text <> '') then
  begin
    PenW := StrToInt(Edit1.Text);
  end;
end;







procedure TForm1.ColorPickClick(Sender: TObject);
begin
  if ColorDialog1.Execute() then
  begin
  ColorPick.Color := ColorDialog1.Color;
  DrawColor := ColorDialog1.Color;
  ColorPick.Repaint;
  end;
end;

procedure TForm1.FractalButtonClick(Sender: TObject);
var
  R: TRect;
  au, ao: Integer;
  dX, dY, bo, bu: Double;
begin
  // Initialize Mandelbrot
  R.Left := 0;
  R.Right := Image1.Width;
  R.Top := 0;
  R.Bottom := Image1.Height;
  ao := 1;//1
  au := -2;
  bo := 1.5;//1.5
  bu := -1.5;
  //direct scaling cause of speed
  dX := (ao - au) / (R.Right - R.Left);
  dY := (bo - bu) / (R.Bottom - R.Top);
  DrawMandelbrot(Image1.Canvas, dX, dY, au, bu, R.Right, R.Bottom);

end;


{바둑판용코드
      Image1.Canvas.Brush.Color := clBlue;
   for i :=0 to 33 do
   begin
    for j :=0 to 33 do
    begin
      if((i mod 2)=0) then
      begin
        if((j mod 2)=0) then
        begin
          Image1.Canvas.Rectangle(i*10,j*10,i*10+10,j*10+10);
        end;
      end
      else
      begin;
        if((j mod 2)=1) then
        begin
          Image1.Canvas.Rectangle(i*10,j*10,i*10+10,j*10+10);
        end;
      end;
    //  Image1.Canvas.Rectangle(i*10,j*10,i*10+10,j*10+10);
    //Image1.Canvas.Rectangle(i*10,i*10,i*10+10,i*10+10);
    end;

   end;
   //Image1.Canvas.Rectangle(); }

procedure TForm1.openFileButtonClick(Sender: TObject);
begin
  If OpenDialog1.Execute() then
  begin
    Image1.Picture.LoadFromFile((OpenDialog1.FileName));

end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
with Image1.Canvas do
  begin
    Pen.Color := clWhite;
    Brush.Color := clWhite;
    Image1.Canvas.Pen.Color:=DrawColor;
    Rect(0,0,Image1.Width-1,Image1.Height-1);
    State := 1;
    DrawColor := clBlack;
    PenW := 2;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin

  Image1.Width := ClientWidth;
  Image1.Height := ClientHeight-60;
  Image1.Picture.Bitmap.Width := Image1.Width;
  Image1.Picture.Bitmap.Height := Image1.Height;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Drawing := True;


  StartX := X;
  StartY := Y;
  EndX :=X;
  EndY :=Y;
  if(State=1) or (State =2) then
  begin
    Image1.Canvas.Pen.Color :=clWhite;
    Image1.Canvas.Pen.Width := PenW;
  end;
  if(State=3) then
  begin
    Image1.Canvas.Pen.Width :=PenW;
    Image1.Canvas.Pen.Color :=DrawColor;
  end;
  if(State=4) then
  begin
    Image1.Canvas.Pen.Color :=DrawColor;
    Image1.Canvas.Pen.Width :=PenW;
    Image1.Canvas.PenPos := Point(X,Y);
  end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
PenColor : TColor;
begin
if Drawing= true then
begin
  if State=1 then//여기서부
  begin
    with Image1.Canvas do
      begin
        Pen.Mode :=pmXor;
        MoveTo(StartX,StartY);
        LineTo(EndX,EndY);
        Pen.Mode := pmXor;
        MoveTo(StartX,StartY);
        Lineto(x,y);
      end;
      EndX :=X;
      EndY:=Y;
  end;//까지 선긋ㄱ
  if State=2 then//여기서부
  begin
    with Image1.Canvas do
      begin
        Pen.Mode :=pmXor;
        MoveTo(StartX,StartY);
        LineTo(StartX,EndY);
        LineTo(EndX,EndY);
        LineTo(EndX,StartY);
        LineTo(StartX,StartY);
        Pen.Mode :=pmXor;
        MoveTo(StartX,StartY);
        LineTo(StartX,Y);
        LineTo(X,Y);
        LineTo(X,StartY);
        LineTo(StartX,StartY);

      end;
      EndX :=X;
      EndY:=Y;
  end;//까지 사각형
  if State=3 then//여기서부
  begin
    with Image1.Canvas do
      begin

        //nofillSelected;//추가
        PenColor:=Pen.Color;
        Pen.Color:=Brush.Color;
        //Image1.Canvas.Brush.Color :=
        Ellipse(StartX,StartY,EndX,EndY);
        Pen.Color:=PenColor;
        Ellipse(StartX,StartY,X,Y);
      end;
      EndX :=X;
      EndY:=Y;
  end;//까지 원
  if State=4 then
  begin
    with Image1.Canvas do
    begin
      LineTo(X,Y);
    end;
  end;

  end;
  end;


procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if State=1 then//그만그리기1
  begin
    with Image1.Canvas do
      begin
        Pen.Mode :=pmXor;
        MoveTo(StartX,StartY);
        LineTo(EndX,EndY);
        Pen.Color :=DrawColor;
        Pen.Mode:=pmCopy;
        MoveTo(StartX,StartY);
        LineTo(EndX,EndY);
      end;
  end;
  if State=2 then//2
  begin
    with Image1.Canvas do
    begin
      Pen.Mode :=pmXor;
      MoveTo(StartX,StartY);
      LineTo(StartX,EndY);
      LineTo(EndX,EndY);
      LineTo(EndX,StartY);
      LineTo(StartX,StartY);
      pen.Color :=DrawColor;
      Brush.Color := clWhite;
      pen.Mode :=pmcopy;
      MoveTo(StartX,StartY);
      LineTo(StartX,EndY);
      LineTo(EndX,EndY);
      LineTo(EndX,StartY);
      LineTo(StartX,StartY);
    end;
  end;
  Drawing := False;

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Image1.Canvas.pen.Color:=clWhite;
  Image1.Canvas.Brush.Color:=clWhite;
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  Image1.Canvas.Pen.Color:=DrawColor;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  PenW := StrToInt(Edit1.Text);
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i : Integer;
  j : Integer;
  cubeSize : Integer;

begin
  Image1.Canvas.Brush.Color :=ColorDialog1.Color;
  cubeSize :=StrToInt(Edit1.Text);
   for i :=0 to (Image1.Width div cubeSize) do
   begin
    for j :=0 to (Image1.Width div cubeSize) do
    begin
      if((i mod 2)=0) then
      begin
        if((j mod 2)=0) then
        begin
          Image1.Canvas.Rectangle(i*cubeSize,j*cubeSize,i*cubeSize+cubeSize,j*cubeSize+cubeSize);
        end;
      end
      else
      begin;
        if((j mod 2)=1) then
        begin
          Image1.Canvas.Rectangle(i*cubeSize,j*cubeSize,i*cubeSize+cubeSize,j*cubeSize+cubeSize);
        end;
      end;
    //  Image1.Canvas.Rectangle(i*10,j*10,i*10+10,j*10+10);
    //Image1.Canvas.Rectangle(i*10,i*10,i*10+10,i*10+10);
    end;

   end;
   //Image1.Canvas.Rectangle();



end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if SaveDialog1.Execute() then
  begin
    //Image1.Picture.SaveToFile('C:\hidelphi\filename.jpg');
    Image1.Picture.SaveToFile(SaveDialog1.FileName+'.jpg');
    end;
end;

end.
