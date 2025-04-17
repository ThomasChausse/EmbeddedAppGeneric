if(NOT DEFINED SELECTED_LINKER_SCRIPT)
    file(GLOB LINKER_SCRIPT_CANDIDATES "${CURRENT_PLATFORM}/*_FLASH.ld")
    list(LENGTH LINKER_SCRIPT_CANDIDATES LINKER_SCRIPT_COUNT)

    if(LINKER_SCRIPT_COUNT EQUAL 0)
        message(FATAL_ERROR "No *_FLASH.ld found in ${CURRENT_PLATFORM}")
    endif()

    if(LINKER_SCRIPT_COUNT GREATER 1)
        message(WARNING "Multiple *_FLASH.ld scripts found in ${CURRENT_PLATFORM}, using the first one:")
        foreach(script ${LINKER_SCRIPT_CANDIDATES})
            message(STATUS "  → ${script}")
        endforeach()
    endif()

    list(GET LINKER_SCRIPT_CANDIDATES 0 LINKER_SCRIPT)
    set(SELECTED_LINKER_SCRIPT "${LINKER_SCRIPT}" CACHE FILEPATH "Linker script to use")
    message(STATUS "Using linker script: ${SELECTED_LINKER_SCRIPT}")
endif()

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T${SELECTED_LINKER_SCRIPT} -Wl,-Map=${CMAKE_BINARY_DIR}/${BOOTLOADER_PROJECT_NAME}.map")
