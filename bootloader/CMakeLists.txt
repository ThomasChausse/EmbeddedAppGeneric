cmake_minimum_required(VERSION 3.14)  # Minimum CMake ersion
set(CMAKE_CXX_STANDARD 17)               # Use C++17
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(CustomBootloader VERSION 1.0 LANGUAGES C)  # Project name and ersion

set(BOOTLOADER_PROJECT_NAME "bootloader")

file(GLOB_RECURSE BOOTLOADER_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.c
    ${CMAKE_ROO}
)
add_executable(${BOOTLOADER_PROJECT_NAME}.elf
    ${BOOTLOADER_PROJECT_NAME}.c
    ${BOOTLOADER_SOURCES}
)

target_link_libraries(${BOOTLOADER_PROJECT_NAME}.elf PRIVATE stm32_platform)

# Include paths
target_include_directories(${BOOTLOADER_PROJECT_NAME}.elf PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
   ${STM32_SOFTWARE_PATH}/Drivers/CMSIS/Include
    ${STM32_SOFTWARE_PATH}/Drivers/CMSIS/Device/ST/STM32F4xx/Include
)

add_custom_command(TARGET ${BOOTLOADER_PROJECT_NAME}.elf POST_BUILD
  COMMAND arm-none-eabi-size bootloader.elf
  COMMAND arm-none-eabi-objcopy -O binary bootloader.elf bootloader.bin
  COMMENT "Generating bootloader.bin"
)
