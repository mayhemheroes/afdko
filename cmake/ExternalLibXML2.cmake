include (ExternalProject)
# cmake_policy(SET CMP0114 NEW)

message("\n=======CMAKE_CURRENT_BINARY_DIR: ${CMAKE_CURRENT_BINARY_DIR} ====\n")
set(LIBXML2_TARGET external.libxml2)
set(LIBXML2_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/${LIBXML2_TARGET})
set(LIBXML2_SRC_DIR ${LIBXML2_INSTALL_DIR}/src/${LIBXML2_TARGET})
set(LIBXML2_INCLUDE_DIRS ${LIBXML2_INSTALL_DIR}/include/libxml2)
set(LIBXML2_LIBRARY
        ${LIBXML2_INSTALL_DIR}/lib/libxml2.lib)
include_directories(${LIBXML2_INCLUDE_DIRS})

# # This build requires make, ensure we have it, or error out.
# if(CMAKE_GENERATOR MATCHES ".*Makefiles")
#   set(MAKE_EXECUTABLE "$(MAKE)")
# else()
#   find_program(MAKE_EXECUTABLE make)
#   if(NOT MAKE_EXECUTABLE)
#     message(FATAL_ERROR "Could not find 'make', required to build libxml2.")
#   endif()
# endif()


set(LIBXML2_GIT_REPOSITORY https://gitlab.gnome.org/GNOME/libxml2.git)
if(NOT DEFINED LIBXML2_TAG)
  set(LIBXML2_TAG master)
endif()

ExternalProject_Add(${LIBXML2_TARGET}
  PREFIX ${LIBXML2_TARGET}
  GIT_REPOSITORY ${LIBXML2_GIT_REPOSITORY}
  GIT_TAG ${LIBXML2_TAG}
  SOURCE_DIR ${LIBXML2_SRC_DIR}
  # CONFIGURE_COMMAND ${LIBXML2_SRC_DIR}/autogen.sh --without-python
  #                                                 --without-zlib
  #                                                 --without-iconv
  #                                                 --without-lzma
  #                                                 --prefix=${LIBXML2_INSTALL_DIR}                                             
  # BYPRODUCTS ${LIBXML2_LIBRARY}
  # BUILD_COMMAND cmake --build ${LIBXML2_INSTALL_DIR}/src/external.libxml2-build
  # INSTALL_COMMAND cmake --install ${LIBXML2_INSTALL_DIR}/src/external.libxml2-build
  CONFIGURE_COMMAND cmake -S ${CMAKE_CURRENT_BINARY_DIR}/${LIBXML2_TARGET}/src/${LIBXML2_TARGET} -B ${CMAKE_CURRENT_BINARY_DIR}/${LIBXML2_TARGET}/src/${LIBXML2_TARGET}-build -D CMAKE_INSTALL_PREFIX=usr/local -D LIBXML2_WITH_ICONV=OFF -D LIBXML2_WITH_LZMA=OFF -D LIBXML2_WITH_ZLIB=OFF -D LIBXML2_WITH_PYTHON=OFF -D BUILD_SHARED_LIBS=OFF
  # CONFIGURE_COMMAND ${LIBXML2_SRC_DIR}/autogen.sh --without-python
  #                                                 --prefix=${LIBXML2_INSTALL_DIR}
  BYPRODUCTS ${LIBXML2_LIBRARY}
  BUILD_COMMAND cmake --build ${CMAKE_CURRENT_BINARY_DIR}/${LIBXML2_TARGET}/src/${LIBXML2_TARGET}-build --target libxml2
  INSTALL_COMMAND ""
  # INSTALL_COMMAND cmake --install ${LIBXML2_INSTALL_DIR}/src/external.libxml2-build
)

ExternalProject_Get_Property(${LIBXML2_TARGET} SOURCE_DIR)

add_library(libxml2 STATIC IMPORTED)
set_property(TARGET libxml2 PROPERTY IMPORTED_LOCATION ${LIBXML2_LIBRARY}
            )
add_dependencies(libxml2 ${LIBXML2_TARGET})
