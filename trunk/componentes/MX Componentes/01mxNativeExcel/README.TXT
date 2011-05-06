*******************************************************

 TmxNativeExcel for Delphi 5,6,7,2005
 Copyright (c) 2001-2005 Bitvadász Kft.
	
*******************************************************

 Contact :
 ---------
 
 eMail: support@maxcomponents.net

 To get more information on  my component please have a 
 look at  the my Web Site which can be found on the Net
 at http://www.maxcomponents.net

 You  can find there updates, help files and the latest 
 information about known problems.

*******************************************************

 Thanks:
 -------

 I would like to say a big thanks to Mark O'Brien
 at Microsoft Corporation. His Excel documentation 
 helped me to create this component. Thanks....

*******************************************************

 Warning: 
 ----------

 Please note that, this component is not finished yet.
 It was created only for my TmxExport componentpack. 
 Some public functions do not work correctly. 
 So If you want to use it in your applications please 
 use only those functions that you can find at the end 
 of this readme file. I have not enough information 
 about the structure of BIFF files to continue the 
 developing, so If somebody has new BIFF specification 
 please send that to my e-mail address.  Thanks.

*******************************************************

 Overview :
 ----------

 The TmxNativeExcel is a 100% native VCL component helps 
 you to create Excel BIFF files without any OLE, OCX or
 other objects and tools.

 Help file is not available at the moment. I am sorry! 
 I hope the demo application helps you.
 
*******************************************************

 How to install :
 ----------------

 Delphi 5:
 
 Open mxNativeExcel_d5.dpk project file, compile and install it.
 Now TmxNativeExcel will  be available in Max Palette.

 Delphi 6:
 
 Open mxNativeExcel_d6.dpk project file, compile and install it.
 Now TmxNativeExcel will  be available in Max Palette.

 Delphi 7:
 
 Open mxNativeExcel_d7.dpk project file, compile and install it.
 Now TmxNativeExcel will  be available in Max Palette.

 Delphi 2005:
 
 Open mxNativeExcel_d9.dpk project file, compile and install it.
 Now TmxNativeExcel will  be available in Max Palette.

*******************************************************

 How to use:
 -----------

 The demonstration application shows all the possibilities.

 Types:
 ------

 TmxBIFFVersion = ( bvBIFF2, bvBIFF3, bvBIFF4, bvBIFF5 );
 TmxExcelStatus = ( esInvalid, esOpened, esClosed );

 TmxMoveAfterEnter = ( maNone, maUp, maDown, maLeft, maRight );

 TmxBoolErr = ( beTRUE, beFALSE, beNULL, beDIV0, beVALUE, beREF, beNAME, beNUM, beNA );

 TmxExcelBorders = ( ebTop, ebBottom, ebLeft, ebRight );
 TmxExcelBorderSet = Set Of TmxExcelBorders;

 TmxExcelAlignment = ( eaGeneral, eaLeft, eaRight, eaCenter, eaFill, eaMultiPlan );

 TmxExcelMargin = ( emLeft, emRight, emTop, emBottom );

 Usable Properties:
 ------------------

 ActiveFont: Integer; // *** See AddFont Procedure ***
 Alignment: TmxExcelAlignment; 
 BIFF: TmxBIFFVersion;
 Borders: TmxExcelBorderSet;
 Row: Word;
 Column: Word;
 Filename: String;
 Shading: Boolean;
 Hidden: Boolean; // *** See ProtectSheet Procedure ***
 Locked: Boolean; // *** See ProtectSheet Procedure ***

 MoveAfterEnter: maRight; // *** It moves the cursor after write ***

 Usable Procedures:
 ------------------

 Procedure NewFile;
 Procedure CloseFile;

 Procedure SaveToFile;
 Procedure SaveToStream( AStream: TStream );

 Function IsFileOpened: Boolean;

 Procedure ProtectSheet( Value: Boolean );
 Procedure SetColumnDefault( FirstCol, LastCol: Word );

 Procedure AddFont( Value: TFont ); // ** You can add maximum 4 fonts ***

 Procedure SetHeader( Value: PChar );;
 Procedure SetHeader( Value: String ); 

 Procedure SetFooter( Value: PChar ); 
 Procedure SetFooter( Value: String ); 

 Procedure SetColumnWidth( Column: Word; AWidth: Integer ); 
 Procedure SetColumnWidth( FirstCol, LastCol: Word; AWidth: Integer ); 
        
 Procedure SetMargin( Margin: TmxExcelMargin; AWidth: Double );
 Procedure SetLeftMargin( AWidth: Double );
 Procedure SetRightMargin( AWidth: Double );
 Procedure SetBottomMargin( AWidth: Double );
 Procedure SetTopMargin( AWidth: Double );

 Procedure WriteBlank; Overload;
 Procedure WriteBlank( ARow, ACol: Word ); 
 
 Procedure WriteInteger( Value: Integer ); 
 Procedure WriteInteger( ARow, ACol, Value: Word ); 

 Procedure WriteNumber( Value: Double ); 
 Procedure WriteNumber( ARow, ACol: Word; Value: Double );

 Procedure WriteLabel( Value: PChar );
 Procedure WriteLabel( ARow, ACol: Word; Value: PChar );

 Procedure WriteLabel( Value: String ); 
 Procedure WriteLabel( ARow, ACol: Word; Value: String ); 

 Procedure WriteBoolErr( Value: TmxBoolErr ); 
 Procedure WriteBoolErr( ARow, ACol: Word; Value: TmxBoolErr ); 
         
 Procedure WriteBoolean( Value: Boolean ); 
 Procedure WriteBoolean( ARow, ACol: Word; Value: Boolean ); 
 
 Procedure WriteData( Value: Variant ); 
 Procedure WriteData( ARow, ACol: Word; Value: Variant ); 
 
*******************************************************

 Enjoy It.

*******************************************************
*******************************************************
