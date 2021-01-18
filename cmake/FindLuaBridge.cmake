if(NOT PREFER_BUNDLED_LIBS)
  set(CMAKE_MODULE_PATH ${ORIGINAL_CMAKE_MODULE_PATH})
  find_package(LUABRIDGE)
  set(CMAKE_MODULE_PATH ${OWN_CMAKE_MODULE_PATH})
  if(LUABRIDGE_FOUND)
    set(LUABRIDGE_BUNDLED OFF)
    set(LUABRIDGE_DEP)
  endif()
endif()

if(NOT LUABRIDGE_FOUND)
  set(LUABRIDGE_BUNDLED ON)
  set(LUABRIDGE_SRC_DIR src/engine/external/luabridge)
  set_src(LUABRIDGE_SRC GLOB ${LUABRIDGE_SRC_DIR}
    List.h
    LuaBridge.h
    Map.h
    RefCountedObject.h
    RefCountedPtr.h
    UnorderedMap.h
    Vector.h
    Array.h
    detail/CFunctions.h
    detail/ClassInfo.h
    detail/Config.h
    detail/Constructor.h
    detail/dump.h
    detail/FuncTraits.h
    detail/Iterator.h
    detail/LuaException.h
    detail/LuaHelpers.h
    detail/LuaRef.h
    detail/Namespace.h
    detail/Security.h
    detail/Stack.h
    detail/TypeList.h
    detail/TypeTraits.h
    detail/Userdata.h
  )
  #add_library(luabridge INTERFACE ${LUABRIDGE_SRC})
  set(LUABRIDGE_INCLUDEDIR ${LUABRIDGE_SRC_DIR})
  target_include_directories(luabridge PRIVATE ${LUABRIDGE_INCLUDEDIR})

  set(LUABRIDGE_DEP $<TARGET_OBJECTS:luabridge>)
  set(LUABRIDGE_INCLUDE_DIRS ${LUABRIDGE_INCLUDEDIR})
  set(LUABRIDGE_LIBRARIES)

  list(APPEND TARGETS_DEP luabridge)

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(LuaBridge DEFAULT_MSG LUABRIDGE_INCLUDEDIR)
endif()
