// BDE - (C) Copyright 1994 by Borland International

// includes the macro.h header file needed for this macro
#include "dberr.h"  

//      The way to use this macro is to include the macro.h header
//      file where you want to use this macro. Then pass an IDAPI
//      function as a parameter to the macro:
//
//      #define CHKERR(parm) DBIError(__FILE__, __LINE__, \    
//     		                                   #parm, parm) ; \          
//                                   if ( GlobalDBIErr ) { \   
//                                       return GlobalDBIErr ;}
//
//      You would then use it as such:
//          CHKERR(DbiCreateTable(hDb, bOverWrite, &crTblDsc)) ;

DBIResult GlobalDBIErr;
static char szDBIStatus[(DBIMAXMSGLEN * 7)+1];
static char szMessage[(DBIMAXMSGLEN * 7)+1+110];
//====================================================================
//  Function:
//          DBIError();
//
//  Input:  module name (pCHAR), line number (UINT16), Engine function
//          name (pCHAR), Result (DBIResult)
//
//  Return: A DBIResult value.
//
//  Description:
//          This is function that takes in the information of where
//          the error accured and displays that is a message box.
//          The information listed above explains how to use this
//          function inside of a macro.
//====================================================================
DBIResult
DBIError (pCHAR module, UINT16 line, pCHAR function, DBIResult retVal)
{
    DBIErrInfo  ErrInfo;

    if (retVal == DBIERR_NONE)
    {
        GlobalDBIErr = DBIERR_NONE;
        return retVal;
    }
    if (retVal != DBIERR_CANTFINDODAPI)
    {
        // Get as much error information as possible
        DbiGetErrorInfo(TRUE, &ErrInfo);

        // Make certain information is returned on the correct error
        if (ErrInfo.iError == retVal)
        {
            strcpy(szDBIStatus, ErrInfo.szErrCode);
            strcat(szDBIStatus, "\r\n");

            if (strcmp(ErrInfo.szContext1, ""))
            {
                strcat(szDBIStatus, ErrInfo.szContext1);
                strcat(szDBIStatus, "\r\n");
            }
            if (strcmp(ErrInfo.szContext2, ""))
            {
                strcat(szDBIStatus, ErrInfo.szContext2);
                strcat(szDBIStatus, "\r\n");
            }
            if (strcmp(ErrInfo.szContext3, ""))
            {
                strcat(szDBIStatus, ErrInfo.szContext3);
                strcat(szDBIStatus, "\r\n");
            }
            if (strcmp(ErrInfo.szContext4, ""))
            {
                strcat(szDBIStatus, ErrInfo.szContext4);
                strcat(szDBIStatus, "\r\n");
            }
        }
        else {
            DbiGetErrorString(retVal, szDBIStatus);
            strcat(szDBIStatus, "\r\n");
        }

        sprintf(szMessage, "Module:\t\t%s\nFunction:\t%s\nLine:\t\t%d\n"
                "Category:\t%d\nCode:\t\t%d\nError:\r\n\r\n%s\n", module,
                function, line, ErrCat(retVal), ErrCode(retVal),
                szDBIStatus);

        MessageBox(NULL, szMessage, "Inventory Error",
                   MB_ICONEXCLAMATION);
    }
    else
    {
        MessageBox(NULL, "Cannot find IDAPI files: Check path.",
                   "IDAPI Initialization Error", MB_ICONHAND | MB_OK);
    }
    GlobalDBIErr = retVal;
    return retVal;
}
