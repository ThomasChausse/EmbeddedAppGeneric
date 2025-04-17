include(${CMAKE_SOURCE_DIR}/linker.cmake)

cmake_minimum_required(VERSION 3.14)  # minimum cmake ersion
set(CMAKE_CXX_STANDARD 17)               # use c++17
set(CMAKE_CXX_STANDARD_REQUIRED true)

project(App VERSION 1.0 LANGUAGES C ASM)  # project name and ersion

set(APP_PROJECT_NAME "App")

file(GLOB_RECURSE APP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.c*
)

list(APPEND APP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/${APP_PROJECT_NAME}.cpp
)

message(STATUS "App sources:")
foreach(SRC ${APP_SOURCES})
  message(STATUS "  ${SRC}")
endforeach()

add_executable(${APP_PROJECT_NAME}.elf
    ${APP_SOURCES}
)

message(STATUS "linking App with stm32_platform")
# target_sources(${APP_PROJECT_NAME}.elf PRIVATE $<TARGET_OBJECTS:stm32_platform>)

target_sources(${APP_PROJECT_NAME}.elf PRIVATE
    $<TARGET_OBJECTS:stm32_platform>
    $<TARGET_OBJECTS:platform_common>
)

add_custom_command(TARGET ${APP_PROJECT_NAME}.elf POST_BUILD
  COMMAND arm-none-eabi-size App.elf
  COMMAND arm-none-eabi-objcopy -O binary App.elf App.bin
  COMMENT "Generating ${APP_PROJECT_NAME}.bin"
)
