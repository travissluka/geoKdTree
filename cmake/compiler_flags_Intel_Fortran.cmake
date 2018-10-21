# (C) Copyright 2018 UCAR.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

####################################################################
# FLAGS COMMON TO ALL BUILD TYPES
####################################################################

if( HAVE_OMP )
  set( CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -qopenmp")
else( )
  set( CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -qopenmp-stubs")
endif( )

####################################################################
# RELEASE FLAGS
####################################################################

set( CMAKE_Fortran_FLAGS_RELEASE "-O3 -qopt-report0 -ftz -align all -fno-alias -qno-offload -traceback -r8   -stack_temps -safe_cray_ptr -assume byterecl -fp-model source -ftz -align all -fno-alias -align dcommons -convert big_endian  -fPIC -fpe0 -fp-model source -heap-arrays 32 -assume noold_maxminloc  -align dcommons" )

####################################################################
# DEBUG FLAGS
####################################################################

set( CMAKE_Fortran_FLAGS_DEBUG   "-g -O0 -ftz -align all -fno-alias -traceback -debug -nolib-inline -fno-inline-functions -assume protect_parens,minus0 -prec-div -prec-sqrt -check bounds -check uninit -fp-stack-check -ftrapuv -warn unused -traceback -r8 -stack_temps -safe_cray_ptr -assume byterecl -fp-model source -ftz -align all -fno-alias -align dcommons -convert big_endian  -fPIC -fpe0 -fp-model source -heap-arrays 32 -assume noold_maxminloc  -align dcommons" )

####################################################################
# BIT REPRODUCIBLE FLAGS
####################################################################

set( CMAKE_Fortran_FLAGS_BIT     "-O2 -ip -ipo -unroll -inline -no-heap-arrays" )

####################################################################
# LINK FLAGS
####################################################################

set( CMAKE_Fortran_LINK_FLAGS    "" )

####################################################################

# Meaning of flags
# ----------------
# todo

