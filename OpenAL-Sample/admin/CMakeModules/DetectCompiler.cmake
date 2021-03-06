MACRO(DETECT_COMPILER)
IF(NOT CMAKE_COMPILER_IS_GNUCC)
  CHECK_C_SOURCE_COMPILES(
"#ifndef __INTEL_COMPILER
#error no icc
#endif
int main(){}
" CMAKE_COMPILER_IS_ICC)
ENDIF(NOT CMAKE_COMPILER_IS_GNUCC)
ENDMACRO(DETECT_COMPILER)

MACRO(MACRO_TEST ARG VAR)
CHECK_C_SOURCE_COMPILES(
"#ifndef ${ARG}
#error ${ARG} macro not defined
#endif
int main(){}
" ${VAR})
ENDMACRO(MACRO_TEST)

#check whether we are 32/64 bits cross-compiling
MACRO(CHECK_64BITS)
IF(CMAKE_COMPILER_IS_GNUCC)
  MACRO_TEST(__LP64__  HAVE_64BITS)
  IF(HAVE_64BITS AND CMAKE_SYSTEM_MACHINE MATCHES "i.86")
    SET(CMAKE_SYSTEM_MACHINE "x86_64")
  ENDIF(HAVE_64BITS AND CMAKE_SYSTEM_MACHINE MATCHES "i.86")

  IF(NOT HAVE_64BITS AND CMAKE_SYSTEM_MACHINE MATCHES "x86_64")
    SET(CMAKE_SYSTEM_MACHINE "i686")
  ENDIF(NOT HAVE_64BITS AND CMAKE_SYSTEM_MACHINE MATCHES "x86_64")
ENDIF(CMAKE_COMPILER_IS_GNUCC)
ENDMACRO(CHECK_64BITS)
