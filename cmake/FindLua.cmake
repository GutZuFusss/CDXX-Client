if(NOT CMAKE_CROSSCOMPILING)
  find_package(PkgConfig QUIET)
  pkg_check_modules(PC_LUA lua)
endif()

set_extra_dirs_lib(LUA lua)
find_library(LUA_LIBRARY
  NAMES lua53
  HINTS ${HINTS_LUA_LIBDIR} ${PC_LUA_LIBDIR} ${PC_LUA_LIBRARY_DIRS}
  PATHS ${PATHS_LUA_LIBDIR}
  ${CROSSCOMPILING_NO_CMAKE_SYSTEM_PATH}
)
set_extra_dirs_include(LUA lua "${LUA_LIBRARY}")
find_path(LUA_INCLUDEDIR
  NAMES lua.h
  HINTS ${HINTS_LUA_INCLUDEDIR} ${PC_LUA_INCLUDEDIR} ${PC_LUA_INCLUDE_DIRS}
  PATHS ${PATHS_LUA_INCLUDEDIR}
  ${CROSSCOMPILING_NO_CMAKE_SYSTEM_PATH}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Lua DEFAULT_MSG LUA_LIBRARY LUA_INCLUDEDIR)

mark_as_advanced(LUA_LIBRARY LUA_INCLUDEDIR)

if(LUA_FOUND)
  set(LUA_LIBRARIES ${LUA_LIBRARY})
  set(LUA_INCLUDE_DIRS ${LUA_INCLUDEDIR})

  is_bundled(LUA_BUNDLED "${LUA_LIBRARY}")
  if(LUA_BUNDLED AND TARGET_OS STREQUAL "windows")
    set(LUA_COPY_FILES "${EXTRA_LUA_LIBDIR}/lua53.dll")
  else()
    set(LUA_COPY_FILES)
  endif()
endif()
