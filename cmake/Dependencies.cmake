set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

find_package(CUDAToolkit)

# TODO(tgale): Move cuSPARSE, cuBLAS deps to test & benchmark only.
#cuda_find_library(CUDART_LIBRARY cudart_static)
#cuda_find_library(CUBLAS_LIBRARY cublas_static)
#cuda_find_library(CUSPARSE_LIBRARY cusparse_static)

#list(APPEND SPUTNIK_LIBS "cudart_static;cublas_static;cusparse_static;culibos;cublasLt_static")
#list(APPEND SPUTNIK_LIBS "CUDA::cudart_static;CUDA::cublas_static;CUDA::cusparse_static;CUDA::culibos;CUDA::cublasLt_static")
list(APPEND SPUTNIK_LIBS "CUDA::cudart;CUDA::cublas;CUDA::cusparse;CUDA::culibos;CUDA::cublasLt_static")

# Google Glog.
# find_package(Glog REQUIRED)

# add_subdirectory(/home2/tabuckley/glog /home2/tabuckley/sputnik/build_glog)
add_subdirectory(third_party/glog)

# list(APPEND SPUTNIK_LIBS ${GLOG_LIBRARIES})
list(APPEND SPUTNIK_LIBS glog::glog)

if (BUILD_TEST)
  # Google Abseil.
  add_subdirectory(third_party/abseil-cpp)

  # Google Test and Google Mock.
  add_subdirectory(third_party/googletest)
  set(BUILD_GTEST ON CACHE INTERNAL "Build gtest submodule.")
  set(BUILD_GMOCK ON CACHE INTERNAL "Build gmock submodule.")
  include_directories(SYSTEM ${PROJECT_SOURCE_DIR}/third_party/googletest/googletest/include)
  include_directories(SYSTEM ${PROJECT_SOURCE_DIR}/third_party/googletest/googlemock/include)

  list(APPEND SPUTNIK_TEST_LIBS "gtest_main;gmock;absl::random_random")
endif()

if (BUILD_BENCHMARK)
  # Google Benchmark.
  add_subdirectory(third_party/benchmark)
  set(BENCHMARK_ENABLE_TESTING OFF CACHE INTERNAL "Build benchmark test suite.")
  include_directories(SYSTEM ${PROJECT_SOURCE_DIR}/third_party/benchmark/include)

  list(APPEND SPUTNIK_BENCHMARK_LIBS "gtest;absl::random_random;benchmark::benchmark_main")
endif()
