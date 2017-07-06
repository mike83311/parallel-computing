# CMakeLists.txt to build hellocuda.cu
cmake_minimum_required(VERSION 2.8)
project(cuda)
find_package(CUDA QUIET REQUIRED)



#cuda_add_executable(cuda1 cuda1.cu)
#cuda_add_executable(cuda2 cuda2.cu)
#cuda_add_executable(dot dot.cu)
#cuda_add_executable(vecDOT3 vecDOT3.cu)
cuda_add_executable(matrix matrix.cu)