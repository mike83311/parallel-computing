# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/60575005h/cuda/blur

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/60575005h/cuda/blur/build

# Include any dependencies generated for this target.
include CMakeFiles/CUP_trackbar.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/CUP_trackbar.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/CUP_trackbar.dir/flags.make

CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o: CMakeFiles/CUP_trackbar.dir/flags.make
CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o: ../CUP_trackbar.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/60575005h/cuda/blur/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o -c /home/60575005h/cuda/blur/CUP_trackbar.cpp

CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/60575005h/cuda/blur/CUP_trackbar.cpp > CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.i

CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/60575005h/cuda/blur/CUP_trackbar.cpp -o CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.s

CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o.requires:

.PHONY : CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o.requires

CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o.provides: CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o.requires
	$(MAKE) -f CMakeFiles/CUP_trackbar.dir/build.make CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o.provides.build
.PHONY : CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o.provides

CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o.provides.build: CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o


# Object files for target CUP_trackbar
CUP_trackbar_OBJECTS = \
"CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o"

# External object files for target CUP_trackbar
CUP_trackbar_EXTERNAL_OBJECTS =

CUP_trackbar: CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o
CUP_trackbar: CMakeFiles/CUP_trackbar.dir/build.make
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_videostab.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_ts.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_superres.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_stitching.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_ocl.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_gpu.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_contrib.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_photo.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_legacy.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_video.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_objdetect.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_ml.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_calib3d.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_features2d.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_highgui.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_imgproc.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_flann.so.2.4.9
CUP_trackbar: /usr/lib/x86_64-linux-gnu/libopencv_core.so.2.4.9
CUP_trackbar: CMakeFiles/CUP_trackbar.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/60575005h/cuda/blur/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable CUP_trackbar"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/CUP_trackbar.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/CUP_trackbar.dir/build: CUP_trackbar

.PHONY : CMakeFiles/CUP_trackbar.dir/build

CMakeFiles/CUP_trackbar.dir/requires: CMakeFiles/CUP_trackbar.dir/CUP_trackbar.cpp.o.requires

.PHONY : CMakeFiles/CUP_trackbar.dir/requires

CMakeFiles/CUP_trackbar.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/CUP_trackbar.dir/cmake_clean.cmake
.PHONY : CMakeFiles/CUP_trackbar.dir/clean

CMakeFiles/CUP_trackbar.dir/depend:
	cd /home/60575005h/cuda/blur/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/60575005h/cuda/blur /home/60575005h/cuda/blur /home/60575005h/cuda/blur/build /home/60575005h/cuda/blur/build /home/60575005h/cuda/blur/build/CMakeFiles/CUP_trackbar.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/CUP_trackbar.dir/depend

