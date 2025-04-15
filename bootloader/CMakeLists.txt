cmake_minimum_required(VERSION 3.14)  # Minimum CMake ersion
set(BOOTLOADER_PROJECT_NAME "bootloader")
project(CustomBootloader VERSION 1.0 LANGUAGES CXX)  # Project name and ersion

set(CMAKE_CXX_STANDARD 17)               # Use C++17
set(CMAKE_CXX_STANDARD_REQUIRED True)

file(GLOB BOOTLOADER_SOURCES
    ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/src/*.c
)

target_include_directories(${BOOTLOADER_PROJECT_NAME} PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
)

add_executable(${BOOTLOADER_PROJECT_NAME}
    ${CMAKE_CURRENT_FUNCTION_LIST_FILE}/${BOOTLOADER_PROJECT_NAME}.c
    ${BOOTLOADER_SOURCES}
)

add_custom_command(TARGET ${BOOTLOADER_PROJECT_NAME} POST_BUILD
  COMMAND arm-none-eabi-size bootloader
)
