#include <windows.h>
#include <idapi.h>
#include <tutility.h>
#include <tuerr.h>
#include <dberr.h>

#include <string.h>
#include <alloc.h>

// Location of files on the system - update as needed.
const char szDirectory[] = "f:\\work\\tutility\\rebuild";
const char szTblDir[] = "f:\\work\\tutility\\tables\\";
const char szPrivDir[] = "f:\\work\\tutility\\private\\";

DBIResult CheckErrorTables(hDBIDb hDb, pCHAR szErrTableName);

static CHAR        szMessage[DBIMAXMSGLEN + 1 + 200];
static CHAR        szTemp[150];

int PASCAL
WinMain (HINSTANCE hCurInstance,
         HINSTANCE hPrevInstance,
         LPSTR lpCmdLine,
         int nCmdShow)
{
    DBIResult   rslt;           // Return value from BDE and TUtility functions.
    hDBIDb      hDb;            // Handle to the database.
    hDBICur     hCur;           // Handle to the cursor.

    SESInfo     sesInfo;        // Information on the session (PrivateDir).
    pBYTE       pRecBuf;        // Record Buffer

    DBITBLNAME  szTableName;    // Name of the table.
                                //   Must be fully qualified.
    DBITBLNAME  szDriverType;   // Driver Type - must be szPARADOX.
    DBITBLNAME  szErrTableName; // Name of the error table.
                                // Must be fully qualified.
    DBITBLNAME  szBackupTableName; // Name of the backup table
    DBITBLNAME  szKeyviolName;  // Name of the Key Violation error.
    DBITBLNAME  szProblemTableName; // Name of the problems table.
    DBITBLNAME  szDebugInfo;    // File to store trace information.

    INT16       iOptions;       // Table Validate option.
    UINT16      iErrorLevel;    // Error Level of the table.
    CRTblDesc   crTblDesc;      // Table Create Descriptor

    hTUSes      hTUSession;     // TUTility session handle.

    UINT16      iFldCount;
    UINT16      iIdxCount;
    UINT16      iSecRecCount;
    UINT16      iValChkCount;
    UINT16      iRintCount;
    UINT16      iOptParams;
    UINT16      iOptDataLen;
    UINT16      iCount;

    iCount = SetHandleCount(80);
    if (iCount < 80)
    {
        MessageBox(NULL, "Not enough available file handles",
                    "Init Error", MB_ICONHAND);
        return 1;
    }

    // initialize variables to 0. Needed for verification in CleanUp.
    hDb = 0;
    hCur = 0;
    pRecBuf = NULL;

    iOptions = 0;

    // Set the name and type of the table.
    strcpy(szTableName, "custom");
    strcpy(szDriverType, szPARADOX);

    // Set the name and paths of certain tables.
    strcpy(szBackupTableName, szDirectory);
    strcat(szBackupTableName, "\\custo_");

    strcpy(szKeyviolName, szDirectory);
    strcat(szKeyviolName, "\\KEYVIOL");

    strcpy(szProblemTableName, szDirectory);
    strcat(szProblemTableName, "\\PROBLEMS");

    strcpy(szDebugInfo, szDirectory);
    strcat(szDebugInfo, "\\rebuild.inf");

    CHKERR(DbiInit(NULL));

    CHKERR(DbiDebugLayerOptions(DEBUGON | FLUSHEVERYOP | OUTPUTTOFILE,
           szDebugInfo));

    // Initialize TUtility
    TUERR_CLEANUP(TUInit(&hTUSession));

    CHKERR_CLEANUP(DbiOpenDatabase(NULL, NULL, dbiREADONLY, dbiOPENEXCL,
                                   NULL, NULL, NULL, NULL, &hDb));

    CHKERR_CLEANUP(DbiSetDirectory(hDb, (char *)szTblDir));


    // Private directory for the application.
    CHKERR_CLEANUP(DbiSetPrivateDir((char *)szPrivDir));

    // Determine the private directory.
    //   Repetetive in a small example, but done to show how it
    //   would be done in a larger application.
    CHKERR_CLEANUP(DbiGetSesInfo(&sesInfo));

    // Set the error table to be written to the private directory.
    strcpy(szErrTableName, sesInfo.szPrivDir);
    strcat(szErrTableName, "\\__TUERR.DB");

    // Fully qualify the path to the table
    CHKERR_CLEANUP(DbiFormFullName(hDb, szTableName, szDriverType,
                                   szTableName));

    // Need to remove the extension from the file name
    szTableName[strlen(szTableName)-3] = 0;

    // Check the table for corruption.
    rslt = TUVerifyTable(hTUSession,
	                     szTableName,
	                     szDriverType,
                         szErrTableName,
	                     NULL,
	                     iOptions,
	                     &iErrorLevel);

    // Check if a problem occured in the Verify function.
    if (rslt)
    {
        TUError(__FILE__, __LINE__, "TUVerifyTable", rslt);
        goto CleanUp;
    }
    else
    {
        // Determine if a problem was detected in the table.
        if (iErrorLevel)
        {
            CheckErrorTables(hDb, szErrTableName);

            // Determine if table structure information can be gotten from
            // the table.
            if (iErrorLevel < 3)
            {
                memset((void *)&crTblDesc, 0, sizeof(crTblDesc));

                rslt = TUGetCRTblDescCount(
                                    hTUSession,
                                    szTableName,
                                    &iFldCount,
                                    &iIdxCount,
                                    &iSecRecCount,
                                    &iValChkCount,
                                    &iRintCount,
                                    &iOptParams,
                                    &iOptDataLen);
                if (rslt)
                {
                    TUError(__FILE__, __LINE__, "TUVerifyTable", rslt);
                    goto CleanUp;
                }

                // Set the information for the table
                strcpy(crTblDesc.szTblName, szTableName);
                strcpy(crTblDesc.szTblType, szDriverType);
                strcpy(crTblDesc.szErrTblName, szErrTableName);

                crTblDesc.iFldCount     = iFldCount;
                crTblDesc.pfldDesc      = (pFLDDesc)malloc(
                                            iFldCount * sizeof(FLDDesc));
                crTblDesc.iIdxCount     = iIdxCount;
                crTblDesc.pidxDesc      = (pIDXDesc)malloc(
                                            iIdxCount * sizeof(IDXDesc));
                crTblDesc.iSecRecCount  = iSecRecCount;
                crTblDesc.psecDesc      = (pSECDesc)malloc(
                                            iSecRecCount * sizeof(SECDesc));
                crTblDesc.iValChkCount  = iValChkCount;
                crTblDesc.pvchkDesc     = (pVCHKDesc)malloc(
                                            iValChkCount * sizeof(VCHKDesc));
                crTblDesc.iRintCount    = iRintCount;
                crTblDesc.printDesc     = (pRINTDesc)malloc(
                                            iRintCount * sizeof(RINTDesc));
                crTblDesc.iOptParams    = iOptParams;
                crTblDesc.pfldOptParams = (pFLDDesc)malloc(
                                            iOptParams * sizeof(FLDDesc));
                crTblDesc.pOptData      = (pBYTE)malloc(
                                            iOptDataLen * DBIMAXSCFLDLEN);

                rslt = TUFillCRTblDesc(hTUSession,
                                       &crTblDesc,
                                       szTableName,
                                       NULL);
                if (rslt)
                {
                    TUError(__FILE__, __LINE__, "TUFillCRTblDesc", rslt);
                    goto CleanUp;
                }

                rslt = TURebuildTable(hTUSession,
                                      szTableName,
                                      szDriverType,
                                      szBackupTableName,
                                      szKeyviolName,
                                      szProblemTableName,
                                      &crTblDesc);
                if (rslt)
                {
                    TUError(__FILE__, __LINE__, "TURebuildTable", rslt);
                    goto CleanUp;
                }
                else
                {
                    MessageBox(NULL, "Table Rebuilt", "Rebuild Success",
                               MB_ICONHAND);
                }
            }
            else if (iErrorLevel == 3)
            {
                MessageBox(NULL, "Table cannot be automatically re-built. Need"
                           " to manually specify table structure.", "Rebuild",
                           MB_ICONHAND);
            }
            else
            {
                MessageBox(NULL, "Table cannot be re-built. Restore from backup"
                           " if available", "Rebuild", MB_ICONHAND);
            }
        }
        else
        {
            MessageBox(NULL, "No corruption Detected", "Table Ok", MB_ICONHAND);
        }
    }

CleanUp:

    if (pRecBuf)
    {
        free(pRecBuf);
    }
    if (hCur)
    {
        DbiCloseCursor(&hCur);
    }
    if (hDb)
    {
        DbiCloseDatabase(&hDb);
    }

    TUExit(hTUSession);

    CHKERR(DbiDebugLayerOptions(0, NULL));

    DbiExit();

    return 0;
}

DBIResult
CheckErrorTables (hDBIDb hDb, pCHAR szErrTableName)
{
    hDBICur     hCur;
    pBYTE       pRecBuf;
    CURProps    curProps;
    BOOL        IsBlank;        // Is the field blank?
    pCHAR       pTemp;

    hCur = 0;
    pRecBuf = NULL;

    // If so, need to get information from the error table.
    CHKERR_CLEANUP(DbiOpenTable(hDb, szErrTableName, szPARADOX,
                                NULL, NULL, 0, dbiREADONLY, dbiOPENEXCL,
                                xltFIELD, FALSE, NULL, &hCur));

    CHKERR_CLEANUP(DbiGetCursorProps(hCur, &curProps));

    pRecBuf = (pBYTE)malloc(sizeof(BYTE) * curProps.iRecBufSize);
    if (!pRecBuf)
    {
        goto CleanUp;
    }

    CHKERR_CLEANUP(DbiSetToBegin(hCur));

    while ((DbiGetNextRecord(hCur, dbiNOLOCK, pRecBuf, NULL) ==
           DBIERR_NONE))
    {
        pTemp = szMessage;

        pTemp = stpcpy(pTemp, "Table Corrupt:\r\n\r\n");
        DbiGetField(hCur, 7, pRecBuf, (pBYTE)szTemp, &IsBlank);
        pTemp = stpcpy(pTemp, szTemp);
        pTemp = stpcpy(pTemp, "\r\n\r\nFile:\r\n");
        DbiGetField(hCur, 1, pRecBuf, (pBYTE)szTemp, &IsBlank);
        pTemp = stpcpy(pTemp, szTemp);
        DbiGetField(hCur, 2, pRecBuf, (pBYTE)szTemp, &IsBlank);
        pTemp = stpcpy(pTemp, szTemp);
        DbiGetField(hCur, 3, pRecBuf, (pBYTE)szTemp, &IsBlank);
        pTemp = stpcpy(pTemp, szTemp);
        DbiGetField(hCur, 4, pRecBuf, (pBYTE)szTemp, &IsBlank);
        pTemp = stpcpy(pTemp, szTemp);

        MessageBox(NULL, szMessage, "Table Corrupt", MB_ICONHAND);
    }

CleanUp:

    if (pRecBuf)
    {
        free(pRecBuf);
    }
    if (hCur)
    {
        DbiCloseCursor(&hCur);
    }

    return DBIERR_NONE;
}


