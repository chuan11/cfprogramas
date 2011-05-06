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

Unit mxOneInstance;

Interface

Uses
     Windows,
     SysUtils,
     Classes,
     Controls,
     Forms;

Const
     mxOneInstanceVersion = $0102; // ** 1.2 **

Type
     TmxOneInstance = Class( TComponent )
     Private

          FTerminate: Boolean;
          FSwitchToPrevious: Boolean;
          Mutex: hWnd;
          MutexCreated: Boolean;

          FOnInstanceExists: TNotifyEvent;

          FVersion: Integer;

          Procedure SetVersion( Value: String );
          Function GetVersion: String;

     Public

          Procedure Loaded; Override;

          Constructor Create( AOwner: TComponent ); Override;
          Destructor Destroy; Override;

     Published

          Property SwitchToPrevious: Boolean Read FSwitchToPrevious Write FSwitchToPrevious;
          Property Terminate: Boolean Read FTerminate Write FTerminate;

          Property Version: String Read GetVersion Write SetVersion;

          Property OnInstanceExists: TNotifyEvent Read FOnInstanceExists Write FOnInstanceExists;

     End;

Implementation

Constructor TmxOneInstance.Create( AOwner: TComponent );
Begin
     Inherited Create( AOwner );
     FTerminate := True;
     FSwitchToPrevious := True;
     FVersion := mxOneInstanceVersion;
End;

Destructor TmxOneInstance.Destroy;
Begin
     If MutexCreated Then CloseHandle( Mutex );
     Inherited Destroy;
End;

Procedure TmxOneInstance.Loaded;
Var
     Title: Array[ 0..$100 ] Of Char;
     PreviousHandle: THandle;
Begin
     Inherited Loaded;

     StrPCopy( Title, Application.Title );
     MutexCreated := False;

     Mutex := CreateMutex( Nil, False, Title );

     If ( GetLastError = ERROR_ALREADY_EXISTS ) Or ( Mutex = 0 ) Then
     Begin
          If Assigned( FOnInstanceExists ) Then FOnInstanceExists( Self );

          If FSwitchToPrevious Then
          Begin
               PreviousHandle := FindWindow( Nil, Title );
               SetWindowText( PreviousHandle, '' );
               PreviousHandle := FindWindow( Nil, Title );

               If PreviousHandle <> 0 Then
               Begin
                    If IsIconic( PreviousHandle ) Then
                         ShowWindow( PreviousHandle, SW_RESTORE ) Else
                         BringWindowToTop( PreviousHandle );
               End;
          End;

          If FTerminate Then Application.Terminate;
     End;

     MutexCreated := True;
End;

Procedure TmxOneInstance.SetVersion( Value: String );
Begin
        // *** Does nothing ***
End;

Function TmxOneInstance.GetVersion: String;
Begin
{$WARNINGS OFF}
     Result := Format( '%d.%d', [ Hi( FVersion ), Lo( FVersion ) ] );
{$WARNINGS ON}
End;
End.

