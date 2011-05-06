// Borland C++ - (C) Copyright 1994 by Borland International

#ifndef __TUERR_H
#define __TUERR_H

#include <windows.h>
#include <idapi.h>
#include <tutility.h>
#include <stdio.h>

#define TUERR(parm) TUError(__FILE__, __LINE__, \
                            #parm, parm) ; \
                            if (GlobalTUError) { \
                               return GlobalTUError ;}

#define TUERR_CLEANUP(parm) TUError(__FILE__, __LINE__, \
                            #parm, parm) ; \
                            if (GlobalTUError) { \
                               goto CleanUp ;}

extern DBIResult GlobalTUError;

DBIResult TUError(pCHAR, UINT16, pCHAR, DBIResult);

#endif
