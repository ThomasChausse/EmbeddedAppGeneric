message(STATUS "")
message(STATUS "Platform :   ${CURRENT_PLATFORM}") 
message(STATUS "")

file(GLOB STM32_SOURCES
    ${CMAKE_SOURCE_DIR}/${CURRENT_PLATFORM}/Core/Src/*.c
    ${CMAKE_SOURCE_DIR}/${CURRENT_PLATFORM}/Core/Startup/*.s
)

add_library(stm32_platform STATIC ${STM32_SOURCES})

target_include_directories(stm32_platform PUBLIC
    ${CMAKE_SOURCE_DIR}/${CURRENT_PLATFORM}/Core/Inc
    ${CMAKE_SOURCE_DIR}/${CURRENT_PLATFORM}/Drivers/CMSIS/Include
    ${CMAKE_SOURCE_DIR}/${CURRENT_PLATFORM}/Drivers/CMSIS/Device/ST/STM32F4xx/Include
)

