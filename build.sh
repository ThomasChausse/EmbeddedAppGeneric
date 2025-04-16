CPU="cortex-m4"
BUILD_TYPE="debug"
if [ -n "$1" ]; then
  find . -type d -name build -exec rm -rf {} +
  find . -type d -name CMakeFiles -exec rm -rf {} +
  find . -type f -name Makefile -exec rm {} +
  find . -type f -name cmake_install.cmake -exec rm {} +
else
  find . -type d -name build -exec rm -rf {} +
  find . -type d -name CMakeFiles -exec rm -rf {} +
  find . -type f -name Makefile -exec rm {} +
  find . -type f -name cmake_install.cmake -exec rm {} +

  mkdir build

  cmake -S . -DCPU=${CPU} -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -B build -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake

  cmake --build build
fi
