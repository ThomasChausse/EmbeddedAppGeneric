cmake_minimum_required(VERSION 3.14)  # Minimum CMake ersion
set(CMAKE_CXX_STANDARD 17)               # Use C++17
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(EmbeddedApp VERSION 1.0 LANGUAGES CXX)  # Project name and ersion 

set(EMBEDDED_APP_PROJECT_NAME "EmbeddedApp")  

file(GLOB_RECURSE EMBEDDED_APP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
    ${CMAKE_SOURCE_DIR}/stm32/it/*.c
    ${CMAKE_SOURCE_DIR}/stm32/sys/*.c
    ${CMAKE_SOURCE_DIR}/stm32/startup/*.s
)

add_executable(${EMBEDDED_APP_PROJECT_NAME}
    ${EMBEDDED_APP_PROJECT_NAME}.cpp
    ${EMBEDDED_APP_SOURCES}
)

add_custom_command(TARGET ${EMBEDDED_APP_PROJECT_NAME} POST_BUILD
  COMMAND arm-none-eabi-size EmbeddedApp  
  COMMAND arm-none-eabi-objcopy -O binary EmbeddedApp.elf EmbeddedApp.bin  
  COMMENT "Generating bootloader.bin"
)
