CPU="cortex-m4"
BUILD_TYPE="release"
LINKER_SCRIPT_PATH="$(pwd)/platform/stmf401xe/STM32F401RETX_FLASH.ld"
TOOLCHAIN_FILE_PATH="toolchain.cmake"
# CURRENT_PLATFORM="STM32F4xx"

clean(){
  find . -type d -name build -exec rm -rf {} +
  find . -type d -name CMakeFiles -exec rm -rf {} +
  find . -type f -name Makefile -exec rm {} +
  find . -type f -name cmake_install.cmake -exec rm {} +
}

cross_compiler_headers(){
STD_INCLUDES=$(arm-none-eabi-gcc -xc -E -v - < /dev/null 2>&1 | \
  sed -n '/#include <...> search starts here:/,/End of search list./p' | \
  grep -E '^\s*/usr.*/include')

  rm -f .clangd
  echo "CompileFlags:" > .clangd 
  echo  "\tAdd:" >> .clangd 

  for include in $STD_INCLUDES; do 
    echo "\t\t- -I$include" >> .clangd
  done
  echo "\t\t- -I/usr/include/newlib" >> .clangd
  sed -i 's/\t/  /g' .clangd
}

# Parse the args using getopt
OPTIONS="c:b:l:f"
LONGOPTS="--cpu:--build:--linker:--flash"
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"

# Extract options
while true; do
  case "$1" in
    -c|--cpu)
      CPU="$2"
      shift 2
      ;;
    -b|--build)
      BUILD_TYPE="$2"
      shift 2
      ;;
    -l|--linker)
      BUILD_TYPE="$2"
      shift 2
      ;;
    -t|--toolchain)
      BUILD_TYPE="$2"
      shift 2
      ;;
    -f|--flash)
      FLASH=true
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

  ############## Script ###############
  cross_compiler_headers
  clean

  mkdir build

  cmake -S . \
    -DCPU=${CPU} \
    -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -B build \
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE_PATH} \
    -DSELECTED_LINKER_SCRIPT=${LINKER_SCRIPT_PATH}

  cmake --build build

