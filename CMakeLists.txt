cmake_minimum_required(VERSION 3.14)  # Minimum CMake version
set(CMAKE_CXX_STANDARD 17)               # Use C++17
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(EmbeddedCustomBootloader VERSION 1.0 LANGUAGES CXX)  # Project name and version

include(toolchain.cmake)

option(BUILD_BOOTLOADER "Build bootloader" ON)
option(BUILD_APP "Build main app" OFF)

add_subdirectory(platform)

if(BUILD_BOOTLOADER)
  add_subdirectory(bootloader)
endif()

if(BUILD_APP)
add_subdirectory(App)
endif()

string(TOLOWER "${CMAKE_BUILD_TYPE}" BUILD_TYPE_LOWER)
message(STATUS "Build type : ${BUILD_TYPE_LOWER}")

if(BUILD_TYPE_LOWER STREQUAL "release")
  set(OPT_FLAGS "-O2 Wall")
else()
  set(OPT_FLAGS "-O0 -g -Wall")
endif()
