message(STATUS "Platform : ${CURRENT_PLATFORM}")

file(GLOB STM32_SOURCES
    ${CURRENT_PLATFORM}/Core/Src/*.c
    ${CURRENT_PLATFORM}/Core/Startup/*.s
)

message(STATUS "Sources found:")
foreach(file ${STM32_SOURCES})
  message(STATUS "  ${file}")
endforeach()

add_library(stm32_platform STATIC ${STM32_SOURCES})

target_include_directories(stm32_platform PUBLIC
    ${CURRENT_PLATFORM}/Core/Inc
    ${CURRENT_PLATFORM}/Drivers/CMSIS/Include
    ${CURRENT_PLATFORM}/Drivers/CMSIS/Device/ST/STM32F4xx/Include
)
