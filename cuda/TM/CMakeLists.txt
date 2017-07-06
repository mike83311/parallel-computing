cmake_minimum_required(VERSION 2.8)
project(TM)
find_package(OpenCV REQUIRED)
find_package(CUDA QUIET REQUIRED)

# add_executable(template_matching template_matching.c)
# target_link_libraries(template_matching ${OpenCV_LIBS})

cuda_add_executable(matching matching.cu)
target_link_libraries(matching ${OpenCV_LIBS})