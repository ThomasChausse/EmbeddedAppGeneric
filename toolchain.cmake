set(CPU "" CACHE STRING "Target CPU architecture")
# cmake -B build -DCMAKE_TOOLCHAIN_FILE=toolchain-arm-none-eabi.cmake -DCPU=cortex-m7

# # STM32F401xe toolchain (arm-none-eabi)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Compilers
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)

set(CPU_FLAGS "-mcpu=${CPU} -mthumb")
set(CMAKE_C_FLAGS "${CPU_FLAGS} -ffreestanding -Wall")
set(CMAKE_CXX_FLAGS "${CPU_FLAGS} -fno-rtti -fno-exceptions -ffreestanding -Wall")
set(CMAKE_ASM_FLAGS "${CPU_FLAGS}")

option(BUILD_BOOTLOADER "Build bootloader" ON)
option(BUILD_APP "Build main app" ON)

if(BUILD_BOOTLOADER)
  add_subdirectory(bootloader)
endif()

if(BUILD_APP)
  add_subdirectory(app)
endif()
