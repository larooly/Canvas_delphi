object Form1: TForm1
  Left = -1303
  Top = 189
  Width = 813
  Height = 574
  Caption = 'Form1'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 580
    Height = 535
    Align = alClient
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Panel1: TPanel
    Left = 580
    Top = 0
    Width = 217
    Height = 535
    Align = alRight
    TabOrder = 0
    object Label1: TLabel
      Left = 28
      Top = 200
      Width = 38
      Height = 13
      Caption = 'line with'
    end
    object FractalButton: TButton
      Left = 24
      Top = 8
      Width = 73
      Height = 33
      Caption = #54532#47113#53448#44536#47532#44592
      TabOrder = 0
      OnClick = FractalButtonClick
    end
    object Button1: TButton
      Left = 24
      Top = 48
      Width = 73
      Height = 33
      Caption = 'line'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 24
      Top = 87
      Width = 73
      Height = 34
      Caption = 'rect'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 24
      Top = 129
      Width = 73
      Height = 32
      Caption = 'circle'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Edit1: TEdit
      Left = 24
      Top = 224
      Width = 57
      Height = 21
      TabOrder = 4
      Text = '2'
      OnChange = Edit1Change
    end
    object ColorPick: TPanel
      Left = 1
      Top = 252
      Width = 215
      Height = 69
      Caption = 'color'
      TabOrder = 5
      OnClick = ColorPickClick
    end
    object Panel3: TPanel
      Left = 1
      Top = 368
      Width = 215
      Height = 166
      Align = alBottom
      TabOrder = 6
      object openFileButton: TButton
        Left = 0
        Top = 4
        Width = 81
        Height = 45
        Caption = 'openBitmap'
        TabOrder = 0
        OnClick = openFileButtonClick
      end
      object Button5: TButton
        Left = 24
        Top = 103
        Width = 161
        Height = 49
        Caption = 'Clearall'
        TabOrder = 1
        OnClick = Button5Click
      end
      object BitBtn1: TBitBtn
        Left = 112
        Top = 8
        Width = 65
        Height = 41
        Caption = 'savePhoto'
        TabOrder = 2
        OnClick = BitBtn1Click
      end
    end
    object Circle: TButton
      Left = 24
      Top = 168
      Width = 73
      Height = 32
      Caption = 'Free'
      TabOrder = 7
      OnClick = CircleClick
    end
    object Button4: TButton
      Left = 88
      Top = 225
      Width = 41
      Height = 17
      Caption = 'OK'
      TabOrder = 8
      OnClick = Button4Click
    end
    object Button6: TButton
      Left = 112
      Top = 8
      Width = 73
      Height = 33
      Caption = #48148#46161#54032
      TabOrder = 9
      OnClick = Button6Click
    end
  end
  object ColorDialog1: TColorDialog
    Left = 676
    Top = 320
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Bitmap|*.bmp|PNG|*.png|JPEG|*.jpg'
    Left = 596
    Top = 416
  end
  object SaveDialog1: TSaveDialog
    Filter = 'JPEG|*.jpg'
    Left = 709
    Top = 416
  end
end
