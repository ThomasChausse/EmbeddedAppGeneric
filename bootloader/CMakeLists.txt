include(${CMAKE_SOURCE_DIR}/linker.cmake)

cmake_minimum_required(VERSION 3.14)  # minimum cmake ersion
set(CMAKE_CXX_STANDARD 17)               # use c++17
set(CMAKE_CXX_STANDARD_REQUIRED true)

project(custombootloader VERSION 1.0 LANGUAGES C ASM)  # project name and ersion

set(BOOTLOADER_PROJECT_NAME "bootloader")

file(GLOB_RECURSE BOOTLOADER_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.c
)

list(APPEND BOOTLOADER_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/${BOOTLOADER_PROJECT_NAME}.c
)

message(STATUS "bootloader sources:")
foreach(SRC ${BOOTLOADER_SOURCES})
  message(STATUS "  ${SRC}")
endforeach()

add_executable(${BOOTLOADER_PROJECT_NAME}.elf
    ${BOOTLOADER_SOURCES}
)
target_include_directories(${BOOTLOADER_PROJECT_NAME}.elf PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/inc  
)
message(STATUS "linking bootloader with stm32_platform")
# target_sources(${BOOTLOADER_PROJECT_NAME}.elf PRIVATE $<TARGET_OBJECTS:stm32_platform>)

target_sources(${BOOTLOADER_PROJECT_NAME}.elf PRIVATE
    $<TARGET_OBJECTS:stm32_platform>
    $<TARGET_OBJECTS:platform_common>
)

add_custom_command(TARGET ${BOOTLOADER_PROJECT_NAME}.elf POST_BUILD
  COMMAND arm-none-eabi-size bootloader.elf
  COMMAND arm-none-eabi-objcopy -O binary bootloader.elf bootloader.bin
  COMMENT "Generating ${BOOTLOADER_PROJECT_NAME}.bin"
)
