{Conditional defines that affect compilation}
// Debug (release) compiler options
// + Add options
// - Remove opetions
{$D+} // debug information
{$H+} // Huge strings

{$IFOPT D-}

// Settings for Release mode

{$C-} // Assert directives
{$I-} // I/O checking
{$R-} // Range checking
{$L-} // Local symbol information
{$O+} // Optimization must be ON
{$Q-} // Overflow checking
{$W-} // Stack frames
{$S-} // Stack overflow checking
{$Y-} // Symbol reference information
{$V-} // Var-String Checking

{$ELSE}

// Settings for Debug mode
{$C+} // Assert directives
{$I+} // I/O checking
{$R+} // Range checking
{$L+} // Local symbol information
{$O-} // Optimization must be ON
{$Q+} // Overflow checking
{$W+} // Stack frames
{$S+} // Stack overflow checking
{$V+} // Var-String Checking

{$ENDIF}

{$IFDEF LINUX}
{$B-}  // Ensure that Complete Boolean Evaluation is off
{$J-}  // Constants from here are not assignable
{$T-}  // Ensure that the result of the @ operator is always an untyped Pointer
{$ENDIF}

{$IFDEF Win32}
  {$A+} {Word Align Data}
{$ELSE}
  {$A-} {Byte Align Data}
{$ENDIF}

// ----------------------------------------------------------------------------

{$IFNDEF VER80}       // Delphi 1.0
  {$DEFINE VERSION1}
  {$DEFINE VERSION1_OR_HIGHER}
{$ENDIF}

{$IFNDEF VER90}       // Delphi 2.0
  {$UNDEF VERSION1}
  {$DEFINE VERSION2}
  {$DEFINE VERSION2_OR_HIGHER}
{$ENDIF}

{$IFNDEF VER100}      // Delphi 3.0
  {$UNDEF VERSION1}
  {$UNDEF VERSION2}
  {$DEFINE VERSION3}
  {$DEFINE VERSION3_OR_HIGHER}
{$ENDIF}

{$IFDEF VER120}       // Delphi 4.0
  {$UNDEF VERSION1}
  {$UNDEF VERSION2}
  {$UNDEF VERSION3}
  {$DEFINE VERSION4}
  {$DEFINE VERSION4_OR_HIGHER}
{$ENDIF}

{$IFDEF VER130}       // Delphi 5.0
  {$UNDEF VERSION1}
  {$UNDEF VERSION2}
  {$UNDEF VERSION3}
  {$UNDEF VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION5_OR_HIGHER}
{$ENDIF}

{$IFDEF VER140}       // Delphi 6.0
  {$UNDEF VERSION1}
  {$UNDEF VERSION2}
  {$UNDEF VERSION3}
  {$UNDEF VERSION4}
  {$UNDEF VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION6_OR_HIGHER}
{$ENDIF}

{$IFDEF VER150}       // Delphi 7.0
  {$UNDEF VERSION1}
  {$UNDEF VERSION2}
  {$UNDEF VERSION3}
  {$UNDEF VERSION4}
  {$UNDEF VERSION5}
  {$UNDEF VERSION6}
  {$DEFINE VERSION6_OR_HIGHER}
  {$DEFINE VERSION7}
{$ENDIF}

{$IFDEF VER160}       // Delphi 8.0
  {$UNDEF VERSION1}
  {$UNDEF VERSION2}
  {$UNDEF VERSION3}
  {$UNDEF VERSION4}
  {$UNDEF VERSION5}
  {$UNDEF VERSION6}
  {$UNDEF VERSION7}
  {$DEFINE VERSION6_OR_HIGHER}
  {$DEFINE VERSION8}
{$ENDIF}

{$IFDEF VER170}       // Delphi 9.0
  {$UNDEF VERSION1}
  {$UNDEF VERSION2}
  {$UNDEF VERSION3}
  {$UNDEF VERSION4}
  {$UNDEF VERSION5}
  {$UNDEF VERSION6}
  {$UNDEF VERSION7}
  {$UNDEF VERSION8}
  {$DEFINE VERSION6_OR_HIGHER}
  {$DEFINE VERSION9}
{$ENDIF}

{$IFDEF VERSION6_OR_HIGHER}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

{$IFDEF VER93}       // Borland C++ Builder 1.0
  {$DEFINE VERSION2}
{$ENDIF}

{$IFDEF VER110}      // Borland C++ Builder 3.0
  {$UNDEF VERSION2}
  {$DEFINE VERSION3}
  {$ObjExportAll on}
{$ENDIF}

{$IFDEF VER125}      // Borland C++ Builder 4.0
  {$UNDEF VERSION3}
  {$DEFINE VERSION4}
  {$ObjExportAll on}
{$ENDIF}

{$IFDEF VER130}      // Borland C++ Builder 5.0
  {$UNDEF VERSION4}
  {$IFDEF BCB}
    {$ObjExportAll on}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER140}      // Borland C++ Builder 6.0
  {$UNDEF VERSION5}
  {$IFDEF BCB}
    {$ObjExportAll on}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER150}      // Borland C++ Builder 7.0
  {$UNDEF VERSION6}
  {$IFDEF BCB}
    {$ObjExportAll on}
    {$WARN UNSAFE_CODE OFF}
  {$ENDIF}
{$ENDIF}

// ----------------------------------------------------------------------------

{.$DEFINE LINUX} // Esta linha é apenas teste !
{.$UNDEF LINUX}  // Esta linha é apenas teste !
{.$DEFINE FAESP}

{$IFDEF LINUX} 
  {$DEFINE CLX}
{$ENDIF}

// This conditional definition affects in the access component 
// the data that you use 
{$DEFINE ACTIVEDELPHI}
{$DEFINE WITH_ABOUT_INFO}

{$IF Defined(VERSION6) or Defined(VERSION6_OR_HIGHER)}
  {$DEFINE WITH_DBX}    // Borland Database Express           - Cross Platform
{$IFEND}
{.$DEFINE WITH_ZEOSLIB}  // ZeosDBO www.zeoslib.net            - Cross Platform
{$DEFINE WITH_IBX}      // Borland Interbase Express          - Cross Platform
{$DEFINE WITH_BDE}      // Borland Database Engine            - Only VCL
{$DEFINE WITH_ADO}      // Microsoft Access Database Objects  - Only VCL
{$DEFINE WITH_ADS}      // Advantage Database Server          - Cross Platform
