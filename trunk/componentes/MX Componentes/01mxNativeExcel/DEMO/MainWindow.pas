Unit MainWindow;

Interface

Uses
     Windows,
     Messages,
     SysUtils,
     Classes,
     Graphics,
     Controls,
     Forms,
     Dialogs,
     mxNativeExcel,
     StdCtrls;

Type
     Tfrm_MainWindow = Class( TForm )

          mxNativeExcel1: TmxNativeExcel;
          btn_Start: TButton;
          btn_Close: TButton;
          Label2: TLabel;
          Label3: TLabel;
          Label1: TLabel;

          Procedure btn_StartClick( Sender: TObject );
          Procedure btn_CloseClick( Sender: TObject );

     Private

     Public

     End;

Var
     frm_MainWindow: Tfrm_MainWindow;

Implementation

{$R *.DFM}

Procedure Tfrm_MainWindow.btn_StartClick( Sender: TObject );
Var
     I: Integer;
Begin
     With mxNativeExcel1 Do
     Begin
          NewFile;

          FileName := ChangeFileExt( ParamStr( 0 ), '' );
          AddFont( Label2.Font );
          AddFont( Label1.Font );

          SetHeader( 'Test Header' );
          SetFooter( '&N &P' );

          WriteLabel( 'This File was Create By Max''s Native Excel Component!' );
          ActiveFont := 1;
          WriteLabel( 2, 1, 'Please note that, this component is in Beta Test Phase' );

          Row := 4;
          Column := 1;
          ActiveFont := 0;

          WriteNumber( 2147400000 );

          For I := 0 To 100 Do WriteInteger( I );

          Row := 7;
          Column := 1;
          For I := 0 To 100 Do
          Begin
               If I Mod 2 = 0 Then ActiveFont := 0 Else ActiveFont := 1;
               Shading := ActiveFont = 1;
               WriteInteger( Row + I, I * 2, I );
          End;

          Shading := FALSE;

          SetColumnWidth( 1, 53 );
          SetColumnWidth( 3, 10, 10 );

          Borders := [ ebTop, ebBottom, ebLeft, ebRight ];
          WriteBoolean( 6, 1, TRUE );
          WriteBoolErr( 7, 1, beNA );

          SetLeftMargin( 0.30 ); // ** This value has to be in inches **
          SetBottomMargin( 0.30 ); // ** This value has to be in inches **
          SetTopMargin( 0.30 ); // ** This value has to be in inches **
          SetRightMargin( 0.30 ); // ** This value has to be in inches **

          ProtectSheet( TRUE );

          CloseFile;

          SaveToFile;
     End;
End;

Procedure Tfrm_MainWindow.btn_CloseClick( Sender: TObject );
Begin
     Close;
End;

End.

