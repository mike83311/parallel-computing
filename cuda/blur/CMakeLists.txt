cmake_minimum_required(VERSION 2.8)
project(blur)
find_package(OpenCV REQUIRED)
find_package(CUDA QUIET REQUIRED)


add_executable(blur blur.c)
target_link_libraries(blur m)
target_link_libraries(blur ${OpenCV_LIBS})


# cuda_add_executable(matching matching.cu)
# target_link_libraries(matching ${OpenCV_LIBS})


# add_executable(example example.cpp)
# target_link_libraries(example m)
# target_link_libraries(example ${OpenCV_LIBS})


# add_executable(test test.c)
# target_link_libraries(test m)
# target_link_libraries(test ${OpenCV_LIBS})


# add_executable(Blur_Gray Blur_Gray.c)
# target_link_libraries(Blur_Gray m)
# target_link_libraries(Blur_Gray ${OpenCV_LIBS})


# add_executable(Blur_CPU Blur_CPU.c)
# target_link_libraries(Blur_CPU m)
# target_link_libraries(Blur_CPU ${OpenCV_LIBS})


# cuda_add_executable(Blur_GPU Blur_GPU.cu)
# target_link_libraries(Blur_GPU m)
# target_link_libraries(Blur_GPU ${OpenCV_LIBS})


# 
# add_executable(noG noG.c)
# target_link_libraries(noG m)
# target_link_libraries(noG ${OpenCV_LIBS})

# cuda_add_executable(noG_GPU noG_GPU.cu)
# target_link_libraries(noG_GPU m)
# target_link_libraries(noG_GPU ${OpenCV_LIBS})



# # CPU
# add_executable(CPU_trackbar CPU_trackbar.cpp)
# target_link_libraries(CPU_trackbar m)
# target_link_libraries(CPU_trackbar ${OpenCV_LIBS})


# # GPU
# cuda_add_executable(GPU_trackbar GPU_trackbar.cu)
# target_link_libraries(GPU_trackbar m)
# target_link_libraries(GPU_trackbar ${OpenCV_LIBS})








