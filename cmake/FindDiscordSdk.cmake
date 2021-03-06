set_extra_dirs_lib(DISCORDSDK discord)
find_library(DISCORDSDK_LIBRARY
  NAMES discord_game_sdk.dll.lib discord_game_sdk.dylib discord_game_sdk.so
  HINTS ${HINTS_DISCORDSDK_LIBDIR}
  PATHS ${PATHS_DISCORDSDK_LIBDIR}
  ${CROSSCOMPILING_NO_CMAKE_SYSTEM_PATH}
)
set_extra_dirs_include(DISCORDSDK discord "${DISCORDSDK_LIBRARY}")
find_path(DISCORDSDK_INCLUDEDIR discord_game_sdk.h
  HINTS ${HINTS_DISCORDSDK_INCLUDEDIR}
  PATHS ${PATHS_DISCORDSDK_INCLUDEDIR}
  ${CROSSCOMPILING_NO_CMAKE_SYSTEM_PATH}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DiscordSdk DEFAULT_MSG DISCORDSDK_LIBRARY DISCORDSDK_INCLUDEDIR)

mark_as_advanced(DISCORDSDK_LIBRARY DISCORDSDK_INCLUDEDIR)

if(DISCORDSDK_FOUND)
  is_bundled(DISCORDSDK_BUNDLED "${DISCORDSDK_LIBRARY}")
  set(DISCORDSDK_LIBRARIES ${DISCORDSDK_LIBRARY})
  set(DISCORDSDK_INCLUDE_DIRS ${DISCORDSDK_INCLUDEDIR})

  if(DISCORDSDK_BUNDLED)
    if(TARGET_OS STREQUAL "windows")
      set(DISCORDSDK_COPY_FILES "${EXTRA_DISCORDSDK_LIBDIR}/discord_game_sdk.dll")
    elseif(TARGET_OS STREQUAL "linux")
      set(DISCORDSDK_COPY_FILES "${EXTRA_DISCORDSDK_LIBDIR}/discord_game_sdk.so")
    elseif(TARGET_OS STREQUAL "mac")
      set(DISCORDSDK_COPY_FILES "${EXTRA_DISCORDSDK_LIBDIR}/discord_game_sdk.dylib")
    endif()
  else()
    set(DISCORDSDK_COPY_FILES)
  endif()
endif()
