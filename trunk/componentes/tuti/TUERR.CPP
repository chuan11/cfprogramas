// BDE - (C) Copyright 1994 by Borland International

// includes the macro.h header file needed for this macro
#include "tuerr.h"  
#include <string.h>

//      The way to use this macro is to include the macro.h header
//      file where you want to use this macro. Then pass an IDAPI
//      function as a parameter to the macro:
//
//      #define TUERR(parm) DBIError(__FILE__, __LINE__, \
//     		                                   #parm, parm) ; \
//                                   if ( GlobalTUError ) { \
//                                       return GlobalTUError ;}
//

DBIResult GlobalTUError;
static char szTUStatus[(DBIMAXMSGLEN * 7)+1];
static char szMessage[(DBIMAXMSGLEN * 7)+1+110];
//====================================================================
//  Function:
//          TUError();
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
TUError (pCHAR module, UINT16 line, pCHAR function, DBIResult retVal)
{
    DBIErrInfo  ErrInfo;

    if (retVal == DBIERR_NONE)
    {
        GlobalTUError = DBIERR_NONE;
        return retVal;
    }
    if (retVal != DBIERR_CANTFINDODAPI)
    {
        // Get as much error information as possible
        DbiGetErrorInfo(TRUE, &ErrInfo);

        // Make certain information is returned on the correct error
        if (ErrInfo.iError == retVal)
        {
            strcpy(szTUStatus, ErrInfo.szErrCode);
            strcat(szTUStatus, "\r\n");

            if (strcmp(ErrInfo.szContext1, ""))
            {
                strcat(szTUStatus, ErrInfo.szContext1);
                strcat(szTUStatus, "\r\n");
            }
            if (strcmp(ErrInfo.szContext2, ""))
            {
                strcat(szTUStatus, ErrInfo.szContext2);
                strcat(szTUStatus, "\r\n");
            }
            if (strcmp(ErrInfo.szContext3, ""))
            {
                strcat(szTUStatus, ErrInfo.szContext3);
                strcat(szTUStatus, "\r\n");
            }
            if (strcmp(ErrInfo.szContext4, ""))
            {
                strcat(szTUStatus, ErrInfo.szContext4);
                strcat(szTUStatus, "\r\n");
            }
        }
        else {
            TUGetErrorString(retVal, szTUStatus);
            strcat(szTUStatus, "\r\n");
        }

        sprintf(szMessage, "Module:\t\t%s\nFunction:\t%s\nLine:\t\t%d\n"
                "Category:\t%d\nCode:\t\t%d\nError:\r\n\r\n%s\n", module,
                function, line, ErrCat(retVal), ErrCode(retVal),
                szTUStatus);

        MessageBox(NULL, szMessage, "TUtility Error",
                   MB_ICONEXCLAMATION);
    }
    else
    {
        MessageBox(NULL, "Cannot find IDAPI files: Check path.",
                   "IDAPI Initialization Error", MB_ICONHAND | MB_OK);
    }

    GlobalTUError = retVal;
    return retVal;
}
