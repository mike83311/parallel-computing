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
include CMakeFiles/Blur_Gray.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Blur_Gray.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Blur_Gray.dir/flags.make

CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o: CMakeFiles/Blur_Gray.dir/flags.make
CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o: ../Blur_Gray.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/60575005h/cuda/blur/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o   -c /home/60575005h/cuda/blur/Blur_Gray.c

CMakeFiles/Blur_Gray.dir/Blur_Gray.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Blur_Gray.dir/Blur_Gray.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/60575005h/cuda/blur/Blur_Gray.c > CMakeFiles/Blur_Gray.dir/Blur_Gray.c.i

CMakeFiles/Blur_Gray.dir/Blur_Gray.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Blur_Gray.dir/Blur_Gray.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/60575005h/cuda/blur/Blur_Gray.c -o CMakeFiles/Blur_Gray.dir/Blur_Gray.c.s

CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o.requires:

.PHONY : CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o.requires

CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o.provides: CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o.requires
	$(MAKE) -f CMakeFiles/Blur_Gray.dir/build.make CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o.provides.build
.PHONY : CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o.provides

CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o.provides.build: CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o


# Object files for target Blur_Gray
Blur_Gray_OBJECTS = \
"CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o"

# External object files for target Blur_Gray
Blur_Gray_EXTERNAL_OBJECTS =

Blur_Gray: CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o
Blur_Gray: CMakeFiles/Blur_Gray.dir/build.make
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_videostab.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_ts.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_superres.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_stitching.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_ocl.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_gpu.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_contrib.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_photo.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_legacy.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_video.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_objdetect.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_ml.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_calib3d.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_features2d.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_highgui.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_imgproc.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_flann.so.2.4.9
Blur_Gray: /usr/lib/x86_64-linux-gnu/libopencv_core.so.2.4.9
Blur_Gray: CMakeFiles/Blur_Gray.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/60575005h/cuda/blur/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable Blur_Gray"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Blur_Gray.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Blur_Gray.dir/build: Blur_Gray

.PHONY : CMakeFiles/Blur_Gray.dir/build

CMakeFiles/Blur_Gray.dir/requires: CMakeFiles/Blur_Gray.dir/Blur_Gray.c.o.requires

.PHONY : CMakeFiles/Blur_Gray.dir/requires

CMakeFiles/Blur_Gray.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Blur_Gray.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Blur_Gray.dir/clean

CMakeFiles/Blur_Gray.dir/depend:
	cd /home/60575005h/cuda/blur/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/60575005h/cuda/blur /home/60575005h/cuda/blur /home/60575005h/cuda/blur/build /home/60575005h/cuda/blur/build /home/60575005h/cuda/blur/build/CMakeFiles/Blur_Gray.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Blur_Gray.dir/depend
