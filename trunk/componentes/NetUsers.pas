{

    TNetUsers  VCL component for Delphi.

    Author :  Vijendra Kumar H.
              Software Engineer
              Bangalore, INDIA.
              E-Mail : vijendrah@hotmail.com

    Desc   : Retrieves all the network user names from the given domain.

    Note   : This component is a freeware and can be used by anyone.  If you 
             use it for a commercial products, please give credit to me.  
             You may modify the source code to your desire and if you make any 
             cool modifications, please send me the mods! :)

   Initial Release : 9th July 1998

}


unit NetUsers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TNetUsers = class(TComponent)
  private
    { Private declarations }
    fServer : String;
  protected
    { Protected declarations }
    Procedure SetServer(Server : String);
  public
    { Public declarations }
     UserList: TStringList;
     Constructor Create(Owner:TComponent); override;
     Destructor Destroy; override;
     Function Execute : Boolean;
  published
    { Published declarations }
    property Server :String read fServer write SetServer;
  end;

  PnetResourceArr = ^TNetResource;

procedure Register;

implementation

Procedure TNetUsers.SetServer(Server : String);
Begin
  If fServer <> Server Then
    fServer := Server;
End;

Constructor TNetUsers.Create(Owner:TComponent);
Begin
  Inherited Create(Owner);
  If Not ( csDesigning in ComponentState ) Then
  Begin
    UserList := TStringList.Create;
    UserList.Sorted := True;
  End;
End;

Destructor TNetUsers.Destroy;
Begin
  If Not( csDesigning in ComponentState ) Then
    UserList.Destroy;
  Inherited Destroy;
End;

Function TNetUsers.Execute : Boolean;
Var
  NetResource: TNetResource;
  Buf:Pointer;
  Count, BufSize, Res: DWORD;
  i : Integer;
  lphEnum: THandle;
  p : PnetResourceArr;
Begin
  Execute := False;
  UserList.Clear;
  GetMem(Buf, 8192);
  Try
    FillChar(NetResource, SizeOf(NetResource), 0);
    NetResource.lpRemoteName := PChar(fServer);
    NetResource.dwDisplayType := RESOURCEDISPLAYTYPE_SERVER;
    NetResource.dwUsage := RESOURCEUSAGE_CONTAINER;
    NetResource.dwScope := RESOURCETYPE_DISK;
    Res := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_DISK, RESOURCEUSAGE_CONTAINER, @NetResource,lphEnum);
    If Res <> 0 then Exit;
    While true do
    Begin
      Count := -1;
      BufSize := 8192;
      Res := WNetEnumResource(lphEnum, Count, Pointer(Buf), BufSize);
      If Res = ERROR_NO_MORE_ITEMS then Exit;
      If (Res <> 0) then Exit;
      p := PNetResourceArr(Buf);
      For i := 0 to Count - 1 do
      Begin
        UserList.Add(p^.lpRemoteName + 2); { Add all the network usernames to UserList StringList }
        Inc(p);
      End;
    End;
    Res := WNetCloseEnum(lphEnum);
    If Res <> 0 then Raise Exception(Res);
    Finally
      FreeMem(Buf);
    Execute := True;
  End;
End;

procedure Register;
begin
  RegisterComponents('HVK Utility', [TNetUsers]);
end;

end.
