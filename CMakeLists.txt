cmake_minimum_required(VERSION 3.14)  # Minimum CMake version

project(EmbeddedCustomBootloader VERSION 1.0 LANGUAGES CXX)  # Project name and version

if(NOT CMAKE_SYSTEM_PROCESSOR STREQUAL "arm")
  message(FATAL_ERROR "Supported architectures : arm (Cortex-mX)")
endif()
message(STATUS "Root dir: ${CMAKE_SOURCE_DIR}")

set(CMAKE_CXX_STANDARD 17)               # Use C++17
set(CMAKE_CXX_STANDARD_REQUIRED True)

string(TOLOWER "${CMAKE_BUILD_TYPE}" BUILD_TYPE_LOWER)

if(BUILD_TYPE_LOWER STREQUAL "release")
  set(OPT_FLAGS "-O2 Wall")
else()
  set(OPT_FLAGS "-O0 -g -Wall")
endif()

message(STATUS "Build type : ${BUILD_TYPE_LOWER}")

# Set global variables
set(MCU_FLAGS "-mcpu=cortex-m4 -mthumb")
# set(LINKER_SCRIPT_BOOT ${CMAKE_CURRENT_SOURCE_DIR}/bootloader/linker_boot.ld)
# set(LINKER_SCRIPT_APP  ${CMAKE_CURRENT_SOURCE_DIR}/app/linker_app.ld)

# add_subdirectory(EmbeddedApp)
# add_subdirectory(bootloader)
