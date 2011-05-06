// Borland C++ - (C) Copyright 1994 by Borland International

#ifndef __DBERR_H
#define __DBERR_H

#include <windows.h>
#include <idapi.h>
#include <stdio.h>
#include <string.h>

#define CHKERR(parm) DBIError(__FILE__, __LINE__, \
                            #parm, parm) ; \
                            if (GlobalDBIErr) { \
                               return GlobalDBIErr ;}

#define CHKERR_CLEANUP(parm) DBIError(__FILE__, __LINE__, \
                            #parm, parm) ; \
                            if (GlobalDBIErr) { \
                               goto CleanUp ;}

extern DBIResult GlobalDBIErr;

DBIResult DBIError(pCHAR, UINT16, pCHAR, DBIResult);

#endif
