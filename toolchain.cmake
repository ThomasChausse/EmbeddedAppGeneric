set(CPU "" CACHE STRING "Target CPU architecture")
#
# STM32F401xe toolchain (arm-none-eabi)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR cortex-m4)

set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)

add_compile_options(
    -mcpu=cortex-m4
    -mthumb
    -ffreestanding
    -Wall
)

# # Librairies
set(CURRENT_PLATFORM "${CMAKE_CURRENT_SOURCE_DIR}/platform/stmf401xe")

# Disable test programs
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_C_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER /usr/bin/arm-none-eabi-g++)
