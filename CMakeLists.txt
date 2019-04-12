cmake_minimum_required( VERSION 3.3.2 FATAL_ERROR )

project( geokdtree Fortran )

set( CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH} )

set( ECBUILD_DEFAULT_BUILD_TYPE Release )
set( ENABLE_OS_TESTS           OFF CACHE BOOL "Disable OS tests" FORCE )
set( ENABLE_LARGE_FILE_SUPPORT OFF CACHE BOOL "Disable testing of large file support" FORCE )

include( ecbuild_system NO_POLICY_SCOPE )

ecbuild_requires_macro_version( 2.7 )

################################################################################
# Project
################################################################################

ecbuild_declare_project()

ecbuild_enable_fortran( REQUIRED )

################################################################################
# Dependencies
################################################################################


################################################################################
# Definitions
################################################################################


################################################################################
# Export package info
################################################################################

list( APPEND GEOKDTREE_TPLS )

set( GEOKDTREE_INCLUDE_DIRS ${CMAKE_Fortran_MODULE_DIRECTORY})
set( GEOKDTREE_LIBRARIES geokdtree)

get_directory_property( GEOKDTREE_DEFINITIONS COMPILE_DEFINITIONS )

foreach( _tpl ${GEOKDTREE_TPLS} )
  string( TOUPPER ${_tpl} TPL )
  list( APPEND GEOKDTREE_EXTRA_DEFINITIONS   ${${TPL}_DEFINITIONS}  ${${TPL}_TPL_DEFINITIONS}  )
  list( APPEND GEOKDTREE_EXTRA_INCLUDE_DIRS  ${${TPL}_INCLUDE_DIRS} ${${TPL}_TPL_INCLUDE_DIRS} )
  list( APPEND GEOKDTREE_EXTRA_LIBRARIES     ${${TPL}_LIBRARIES}    ${${TPL}_TPL_LIBRARIES}    )
endforeach()

################################################################################
# Sources
################################################################################

set( GEOKDTREE_LINKER_LANGUAGE Fortran )

include( geokdtree_compiler_flags )
include_directories( ${GEOKDTREE_INCLUDE_DIRS} )

list ( APPEND geokdtree_files
	kdtree.f90
)

################################################################################
# Library
################################################################################

ecbuild_add_library( TARGET   geokdtree
                     SOURCES  ${geokdtree_files}
                     LINKER_LANGUAGE ${GEOKDTREE_LINKER_LANGUAGE}
                    )

################################################################################
# Finalise configuration
################################################################################

# prepares a tar.gz of the sources and/or binaries
ecbuild_install_project( NAME geokdtree )

# print the summary of the configuration
ecbuild_print_summary()
