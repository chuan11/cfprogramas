�
 TNNTPFORM 0�  TPF0	TNNTPFormNNTPFormLeft� Top�CaptionNNTP - http://www.overbyte.beClientHeightNClientWidthLColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	OnClose	FormCloseOnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight TPanelPanel1Left Top WidthLHeight� AlignalTopTabOrder  TLabelLabel1LeftTopWidthHeightCaptionServer  TLabelLabel2Left TopTWidthHeightCaptionID  TLabelLabel3LeftTop;Width,HeightCaption	Art. Num.  TLabelLabel4LeftTop"WidthHeightCaptionGroup  TLabelLabel5LeftTopkWidthHeightCaptionFile  TLabelLabel6LeftTop� WidthHeightCaptionUser  TLabelLabel7Left8Top� Width2HeightCaptionUserName  TLabelLabel8Left� Top� Width1HeightCaptionPassWord  TEdit
ServerEditLeft0TopWidth� HeightHintEnter the NNTP server host nameParentShowHintShowHint	TabOrder Text
ServerEdit  TButtonConnectButtonLeftTopWidthKHeightHintConnect to the NNTP serverCaption&ConnectParentShowHintShowHint	TabOrderOnClickConnectButtonClick  TButtonAbortButtonLeftXTop WidthKHeightHintAbort current jobCaptionA&bortEnabledParentShowHintShowHint	TabOrder
OnClickAbortButtonClick  TButtonGroupButtonLeftTop WidthKHeightHintSelect the groupCaption&GroupParentShowHintShowHint	TabOrderOnClickGroupButtonClick  TEdit	GroupEditLeft0Top Width� HeightHint?Enter the newsgroup name such as borland.public.delphi.internetParentShowHintShowHint	TabOrderText	GroupEdit  TEditArticleNumEditLeft0Top8Width� HeightHint$Enter the article number to retreiveParentShowHintShowHint	TabOrderTextArticleNumEdit  TButtonArticleByNumberButtonLeft�TopWidthKHeightHint7Retreive an article (header and body) by article numberCaption&ArticleByNumParentShowHintShowHint	TabOrderOnClickArticleByNumberButtonClick  TButtonArticleByIDButtonLeft�TopWidthKHeightHint3Retreive an article (header and body) by article IDCaptionArticleBy&IDParentShowHintShowHint	TabOrderOnClickArticleByIDButtonClick  TButton
NextButtonLeftXTop8WidthKHeightHintGet next article infoCaption&NextParentShowHintShowHint	TabOrderOnClickNextButtonClick  TButton
LastButtonLeftXTopPWidthKHeightHintGet previous article infoCaption&LastParentShowHintShowHint	TabOrderOnClickLastButtonClick  TButtonHeadByNumberButtonLeft�Top WidthKHeightHint(Request a header only, by article numberCaption	HeadByNumParentShowHintShowHint	TabOrderOnClickHeadByNumberButtonClick  TButtonHeadByIDButtonLeft�Top WidthKHeightHint)Retreive an article header, by article IDCaptionHeadByIDParentShowHintShowHint	TabOrderOnClickHeadByIDButtonClick  TButtonBodyByNumberButtonLeft�Top8WidthKHeightHint*Request an article body, by article numberCaption	BodyByNumParentShowHintShowHint	TabOrderOnClickBodyByNumberButtonClick  TButtonBodyByIDButtonLeft�Top8WidthKHeightHint'Retreive an article body, by article IDCaptionBodyByIDParentShowHintShowHint	TabOrderOnClickBodyByIDButtonClick  TButtonStatByNumberButtonLeft�TopPWidthKHeightHint(Request stats about an article by numberCaption	StatByNumParentShowHintShowHint	TabOrderOnClickStatByNumberButtonClick  TButtonStatByIDButtonLeft�TopPWidthKHeightHint$Request stats about an article by IDCaptionStatByIDParentShowHintShowHint	TabOrderOnClickStatByIDButtonClick  TButton
ListButtonLeft�TophWidthKHeightHint0List ALL newsgroups. Will take a VERY LONG time.CaptionListParentShowHintShowHint	TabOrderOnClickListButtonClick  TEditArticleIDEditLeft0TopPWidth� HeightHint Enter the article ID to retreiveParentShowHintShowHint	TabOrderTextArticleIDEdit  TButton
PostButtonLeftTop8WidthKHeightHint&Post a hard coded article to the groupCaption&PostParentShowHintShowHint	TabOrderOnClickPostButtonClick  TButton
QuitButtonLeftXTopWidthKHeightHintQuit the NNTP serverCaption&QuitParentShowHintShowHint	TabOrderOnClickQuitButtonClick  TEditFileEditLeft0TophWidth� HeightHint5Enter the file name and path for the destination fileParentShowHintShowHint	TabOrderTextFileEdit  TButtonNewGroupsButtonLeftTophWidthKHeightHint.Request the new groups (hardcoded for 10 days)Caption	NewGroupsParentShowHintShowHint	TabOrder	OnClickNewGroupsButtonClick  TButtonNewNewsButtonLeftXTophWidthKHeightHint*Request the new news (hardcoded for 1 day)CaptionNewNewsParentShowHintShowHint	TabOrderOnClickNewNewsButtonClick  TButton
HelpButtonLeftTopPWidthKHeightHint!Request help from the NNTP serverCaptionHelpParentShowHintShowHint	TabOrderOnClickHelpButtonClick  TButtonXOverButtonLeft�TophWidthKHeightHintqList articles overview. Art. Num. can be a single number, a number and a dash or two numbers separated by a dash.CaptionXOverParentShowHintShowHint	TabOrderOnClickXOverButtonClick  TButtonOverViewFmtButtonLeftTop� WidthKHeightCaptionOverViewFmtTabOrderOnClickOverViewFmtButtonClick  TButton
DateButtonLeftXTop� WidthKHeightCaptionDateTabOrderOnClickDateButtonClick  TEditUserEditLeft0Top� Width� HeightHintZEnter "your name" <your.name@yourcompany.domain> with the double quotes and angle backets.ParentShowHintShowHint	TabOrderTextUserEdit  TEditUserNameEditLeftpTop� WidthQHeightTabOrderTextUserNameEdit  TEditPasswordEditLeftTop� WidthIHeightTabOrderTextPasswordEdit  TButtonAuthenticateButtonLeftXTop� WidthKHeightCaptionAuthenticateTabOrderOnClickAuthenticateButtonClick  TButtonModeReaderButtonLeft�Top� WidthKHeightCaptionMode ReaderTabOrderOnClickModeReaderButtonClick  TButton
XHdrButtonLeft�Top� WidthKHeightCaptionXHdrTabOrder OnClickXHdrButtonClick  TButtonListMotdButtonLeft�Top� WidthKHeightCaption	List MOTDTabOrder!OnClickListMotdButtonClick   TMemoDisplayMemoLeft Top� WidthLHeight� AlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style Lines.StringsDisplayMemo 
ParentFont
ScrollBarsssBothTabOrder  TNntpCliNntpCli1Portnntp	LineLimit   OnSessionConnectedNntpCli1SessionConnectedOnSessionClosedNntpCli1SessionClosedOnDataAvailableNntpCli1DataAvailableOnRequestDoneNntpCli1RequestDoneOnMessageBeginNntpCli1MessageBeginOnMessageEndNntpCli1MessageEndOnMessageLineNntpCli1MessageLineOnXHdrBeginNntpCli1XHdrBegin	OnXHdrEndNntpCli1XHdrEnd
OnXHdrLineNntpCli1XHdrLineLeftTop�    