set(CPU "" CACHE STRING "Target CPU architecture")

# STM32F401xe toolchain (arm-none-eabi)
set(CMAKE_SYSTEM_NAME Generic)
# set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_PROCESSOR cortex-m4)
# Disable test programs
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_C_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER_WORKS TRUE)

# Librairies
set(CURRENT_PLATFORM "platform/stmf401xe")

# Compilers
set(CMAKE_C_COMPILER /usr/bin/arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER /usr/bin/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER /usr/bin/arm-none-eabi-g++)

# # Ensure CMake knows how to compile objects
set(CMAKE_C_COMPILE_OBJECT "<CMAKE_C_COMPILER> <FLAGS> -o <OBJECT> -c <SOURCE>")
set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> cr <TARGET> <OBJECTS>")

# Add CPU flags and common options
add_compile_options(
    -mcpu=cortex-m4
    -mthumb
    -ffreestanding
    -Wall
)

# Optional: set C++ specific flags
add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>)
add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>)
