cmake_minimum_required(VERSION 3.10)

project(SPUTNIK CUDA CXX C)

cmake_policy(SET CMP0104 OLD)

##
### Build options.
##
option(BUILD_TEST "Build test suite" OFF)
option(BUILD_BENCHMARK "Build benchmark suite" OFF)

##
### Handle Dependencies.
##

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/modules)
include(cmake/Dependencies.cmake)

##
### C++ and CUDA flags.
##

# Requires C++11.
set(CMAKE_CXX_STANDARD 11)

if(BUILD_TEST)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DSPUTNIK_BUILD_TEST")
  set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -DSPUTNIK_BUILD_TEST")
endif()

enable_language(CUDA)

# check if CUDA is available
include(CheckLanguage)
check_language(CUDA)

if(NOT DEFINED CMAKE_CUDA_STANDARD)
  set(CMAKE_CUDA_STANDARD 11)
  set(CMAKE_CUDA_STANDARD_REQUIRED ON)
endif()

# the CUDA compute capability for our Titan X GPUs is 5.2 (https://developer.nvidia.com/cuda-gpus)
if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
  set(CMAKE_CUDA_ARCHITECTURES 52)
endif()

##
### Project build.
##

include_directories("${PROJECT_SOURCE_DIR}")
add_subdirectory(sputnik)
