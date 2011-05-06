                              TUTility API
                      Functions to verify and rebuild
                             Paradox tables.


                                Features
                                ========

The TUtility API allows an application developer to verify and fix
Paradox tables from within an application, up to and including
Paradox level 5 tables. By using this API, a user is not forced to
run a seperate application in order to fix a corrupted table. For
example, the Table repair form provided for use with Paradox for
Windows, which was written using the TUTILITY.DLL.

Note that not all table curruption is fixable using this API -
sometimes a table will be in such a corrupted state that the
only method of restoring that table is from a backup. In general,
we recomend making periodic backup copies of your data.

The UTLAPI.ZIP file contains the following files:

Core TUtility files:
TUTILITY.DLL        - Core DLL containing the TUtility functions.
TUTILITY.LIB        - Import Library for TUTILITY.DLL.
TUTILITY.H          - C Header file for TUTILITY.DLL.
TUTILITY.HLP        - Information on the TUtility API functions.
PASCAL\TUTILITY.PAS - Pascal Unit for TUTILITY.DLL.
README.TXT          - This file.

Example files:
DBERR.C             - Error handling for IDAPI functions
DBERR.H
TUERR.H             - Error handling for TUtility functions
TUERR.CPP
REBUILD\REBUILD.CPP - Source for the example
REBUILD\REBUILD.DEF - Module Definition file for the example
REBUILD\REBUILD.IDE - BC 4.x project file for the example
TABLES\CUSTOM.*     - Table for the example.


                          REDISTIBUTION RIGHTS
                          ====================

The TUTILITY.DLL file is freely redistributable with an application
developed with the Borland Database Engine.


                          !!!!! WARNING !!!!!

Use of this product is at your own risk. This is NOT an
official Borland product, and as such we do not provide any
technical support on the information contained in this document.


                           !!! Disclaimer !!!

DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.

