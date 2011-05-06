/****************************************************************************/
/*                                                                          */
/*      Copyright Borland International, 1992.  All Rights Reserved.        */
/*                                                                          */
/****************************************************************************/

#ifndef __TUTILITY_H
#define __TUTILITY_H

// TUtility (TUVerifyTable) Session Options
#define TU_APPEND_ERRORS        1
#define TU_NO_SECONDARY         2
#define TU_NO_WARNINGS          4
#define TU_HEADER_ONLY          8
#define TU_DIALOG_HIDE          16
#define TU_NO_LOCK              32

typedef UINT16	hTUSes;
typedef hTUSes far *phTUSes;

#ifdef __cplusplus
extern "C"	{
#endif	//   __cplusplus

DBIResult DBIFN TUInit(
	phTUSes	hTUSession);

DBIResult DBIFN TUVerifyTable(
	hTUSes		        hTUSession,
	char far *	        pszTableName,
	char far *	        pszDriverType,
	char far *	        pszErrTableName,
	char far *	        pszPassword,
	int			iOptions,
	unsigned int far *	piErrorLevel);

DBIResult DBIFN TURebuildTable(
	hTUSes		hTUSession,
	char far *	pszTableName,
	char far *	pszDriverType,
	char far *	pszBackupTableName,
	char far *	pszKeyviolName,
	char far *	pszProblemTableName,
	pCRTblDesc	pCrDesc);

DBIResult	DBIFN TUGetCRTblDescCount(
	hTUSes		hTUSession,
	char far *	pszTableName,
	pUINT16		iFldCount,
	pUINT16		iIdxCount,
	pUINT16		iSecRecCount,
	pUINT16		iValChkCount,
	pUINT16		iRintCount,
	pUINT16		iOptParams,
	pUINT16		iOptDataLen);

DBIResult	DBIFN TUFillCRTblDesc(
	hTUSes		hTUSession,
	pCRTblDesc 	pCrDesc,
	char far *	pszTableName,
	char far *	pszPassword);

DBIResult DBIFN TUFillCURProps(
	hTUSes		hTUSession,
	char far *	pszTableName,
	pCURProps	tblProps);

DBIResult DBIFN TUExit(
	hTUSes	hTUSession);

DBIResult DBIFN TUGetErrorString(
	DBIResult iErrorcode,
	char far *pszError);

typedef enum                              // Verify Callback processes
{
	TUVerifyHeader      = 0,
	TUVerifyIndex       = 1,
	TUVerifyData        = 2,
	TUVerifySXHeader    = 3,
	TUVerifySXIndex     = 4,
	TUVerifySXData      = 5,
	TUVerifySXIntegrity = 6,
	TUVerifyTableName   = 7
} TUVerifyProcess;

typedef struct  // Call back info for Verify Callback function
{
	WORD percentdone;
	DBIPATH	tablename;
	TUVerifyProcess process;
	WORD currentindex;
	WORD totalindex;
} TUVerifyCallBack;

#ifdef __cplusplus
}
#endif //  __cplusplus

#endif
