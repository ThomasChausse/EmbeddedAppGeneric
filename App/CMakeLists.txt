cmake_minimum_required(VERSION 3.14)  # Minimum CMake ersion
set(CMAKE_CXX_STANDARD 17)               # Use C++17
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(EmbeddedApp VERSION 1.0 LANGUAGES C CXX ASM)  # Project name and ersion 

set(EMBEDDED_APP_PROJECT_NAME "EmbeddedApp")  

file(GLOB_RECURSE EMBEDDED_APP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
)

add_executable(${EMBEDDED_APP_PROJECT_NAME}
    ${EMBEDDED_APP_PROJECT_NAME}.cpp
    ${EMBEDDED_APP_SOURCES}
)

target_link_libraries(${EMBEDDED_APP_PROJECT_NAME}.elf PRIVATE stm32_platform)

add_custom_command(TARGET ${EMBEDDED_APP_PROJECT_NAME} POST_BUILD
  COMMAND arm-none-eabi-size EmbeddedApp  
  COMMENT "Generating bootloader.bin"
  COMMAND arm-none-eabi-objcopy -O binary EmbeddedApp.elf EmbeddedApp.bin  
)
