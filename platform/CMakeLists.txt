message(STATUS "Platform : ${CURRENT_PLATFORM}")
include(${CMAKE_SOURCE_DIR}/linker.cmake)

# HAL and startup sources (e.g., stm32f4xx_it.c, startup.s)
file(GLOB STM32_SOURCES
    ${CURRENT_PLATFORM}/Core/Src/*stm32*.c
    ${CURRENT_PLATFORM}/Core/Startup/*.s
    ${CURRENT_PLATFORM}/Drivers/STM32*/Src/*.c
)

# Runtime stubs: syscalls and memory
set(RUNTIME_SOURCES
    ${CURRENT_PLATFORM}/Core/Src/syscalls.c
    ${CURRENT_PLATFORM}/Core/Src/sysmem.c
)

message(STATUS "HAL Sources:")
foreach(file ${STM32_SOURCES})
  message(STATUS "  ${file}")
endforeach()

message(STATUS "Runtime Sources:")
foreach(file ${RUNTIME_SOURCES})
  message(STATUS "  ${file}")
endforeach()

# Platform HAL library (e.g., STM32 HAL, startup)
add_library(stm32_platform OBJECT ${STM32_SOURCES})

# Common runtime object library (syscalls)
add_library(platform_common OBJECT ${RUNTIME_SOURCES})

# Common include paths for both
target_include_directories(stm32_platform PUBLIC
    ${CURRENT_PLATFORM}/Core/Inc
    ${CURRENT_PLATFORM}/Drivers/CMSIS/Include
    ${CURRENT_PLATFORM}/Drivers/CMSIS/Device/ST/STM32F4xx/Include
    ${CURRENT_PLATFORM}/Drivers/STM32F4xx_HAL_Driver/Inc
)

target_include_directories(platform_common PUBLIC
    ${CURRENT_PLATFORM}/Core/Inc
)
