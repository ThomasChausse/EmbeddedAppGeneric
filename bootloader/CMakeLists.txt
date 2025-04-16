cmake_minimum_required(VERSION 3.14)  # Minimum CMake ersion
set(CMAKE_CXX_STANDARD 17)               # Use C++17
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(CustomBootloader VERSION 1.0 LANGUAGES C)  # Project name and ersion

set(BOOTLOADER_PROJECT_NAME "bootloader")

add_executable(${BOOTLOADER_PROJECT_NAME}.elf
    ${BOOTLOADER_PROJECT_NAME}.c
    ${BOOTLOADER_SOURCES}
)

file(GLOB_RECURSE BOOTLOADER_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.c
    ${CMAKE_SOURCE_DIR}/stm32/it/*.c
    ${CMAKE_SOURCE_DIR}/stm32/sys/*.c
    ${CMAKE_SOURCE_DIR}/stm32/startup/*.s
)

# Include paths
target_include_directories(${BOOTLOADER_PROJECT_NAME}.elf PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
    ${CMAKE_SOURCE_DIR}/stm32/drivers
    ${CMAKE_SOURCE_DIR}/stm32/sys
    ${CMAKE_SOURCE_DIR}/stm32/it
)


add_custom_command(TARGET ${BOOTLOADER_PROJECT_NAME} POST_BUILD
  COMMAND arm-none-eabi-size bootloader.elf
  COMMAND arm-none-eabi-objcopy -O binary bootloader.elf bootloader.bin
  COMMENT "Generating bootloader.bin"
)
