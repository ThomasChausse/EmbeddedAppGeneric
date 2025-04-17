cmake_minimum_required(VERSION 3.14)
set(CMAKE_C_STANDARD 11)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(toolchain.cmake)

project(dual_banking C CXX ASM)

option(BUILD_BOOTLOADER "Build the bootloader component" ON)
option(BUILD_APP "Build the main application" ON)

add_subdirectory(platform)

if(${BUILD_BOOTLOADER})
  add_subdirectory(bootloader) 
endif()

if(${BUILD_APP})
  add_subdirectory(App) 
endif()
