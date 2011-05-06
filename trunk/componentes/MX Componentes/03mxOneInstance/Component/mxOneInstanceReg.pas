// ****************************************************************************
// * mxOneInstance component for Delphi.
// ****************************************************************************
// * Copyright 2001-2005, Bitvadász Kft. All Rights Reserved.
// ****************************************************************************
// * This component can be freely used and distributed in commercial and
// * private environments, provied this notice is not modified in any way.
// ****************************************************************************
// * Feel free to contact me if you have any questions, comments or suggestions
// * at support@maxcomponents.net
// ****************************************************************************
// * Web page: www.maxcomponents.net
// ****************************************************************************
// * Description:
// *
// * The TmxOneInstance is a VCL component to allow to start only one copy
// * of your application.
// *
// ****************************************************************************

Unit mxOneInstanceReg;

Interface

{$I MAX.INC}

// *************************************************************************************
// ** Component registration
// *************************************************************************************

Procedure Register;

Implementation

// *************************************************************************************
// ** List of used units
// *************************************************************************************

Uses SysUtils,
     Classes,

     {$IFDEF Delphi6_Up}
     DesignIntf, DesignEditors,
     {$ELSE}
     Dsgnintf,
     {$ENDIF}

     Dialogs,
     Forms,
     mxOneInstance,
     mxOneInstanceAbout;

Type

     TDesigner = IDesigner;

     {$IFDEF Delphi6_Up}
     TFormDesigner = IDesigner;
     {$ELSE}
     TFormDesigner = IFormDesigner;
     {$ENDIF}

// *************************************************************************************
// ** Component Editor
// *************************************************************************************

     TmxOneInstanceEditor = Class( TComponentEditor )

          Function GetVerbCount: integer; Override;
          Function GetVerb( Index: integer ): String; Override;
          Procedure ExecuteVerb( Index: integer ); Override;
     End;

// *************************************************************************************
// ** GetVerbCount
// *************************************************************************************

Function TmxOneInstanceEditor.GetVerbCount: integer;
Begin
     Result := 1;
End;

// *************************************************************************************
// ** GetVerb
// *************************************************************************************

Function TmxOneInstanceEditor.GetVerb( Index: integer ): String;
Begin
     Case Index Of
          0: Result := 'TmxOneInstance (C) 2002-2005 Bitvadász Kft.';
     End;
End;

// *************************************************************************************
// ** ExecuteVerb
// *************************************************************************************

Procedure TmxOneInstanceEditor.ExecuteVerb( Index: integer );
Begin
     Case Index Of
          0: ShowAboutBox( 'TmxOneInstance' );
     End;
End;

// *************************************************************************************
// ** Register, 4/5/01 11:46:42 AM
// *************************************************************************************

Procedure Register;
Begin
     RegisterComponents( 'Max', [ TmxOneInstance ] );
     RegisterComponentEditor( TmxOneInstance, TmxOneInstanceEditor );
End;

End.

