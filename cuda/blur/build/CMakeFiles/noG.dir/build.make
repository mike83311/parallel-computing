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
include CMakeFiles/noG.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/noG.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/noG.dir/flags.make

CMakeFiles/noG.dir/noG.c.o: CMakeFiles/noG.dir/flags.make
CMakeFiles/noG.dir/noG.c.o: ../noG.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/60575005h/cuda/blur/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/noG.dir/noG.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/noG.dir/noG.c.o   -c /home/60575005h/cuda/blur/noG.c

CMakeFiles/noG.dir/noG.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/noG.dir/noG.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/60575005h/cuda/blur/noG.c > CMakeFiles/noG.dir/noG.c.i

CMakeFiles/noG.dir/noG.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/noG.dir/noG.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/60575005h/cuda/blur/noG.c -o CMakeFiles/noG.dir/noG.c.s

CMakeFiles/noG.dir/noG.c.o.requires:

.PHONY : CMakeFiles/noG.dir/noG.c.o.requires

CMakeFiles/noG.dir/noG.c.o.provides: CMakeFiles/noG.dir/noG.c.o.requires
	$(MAKE) -f CMakeFiles/noG.dir/build.make CMakeFiles/noG.dir/noG.c.o.provides.build
.PHONY : CMakeFiles/noG.dir/noG.c.o.provides

CMakeFiles/noG.dir/noG.c.o.provides.build: CMakeFiles/noG.dir/noG.c.o


# Object files for target noG
noG_OBJECTS = \
"CMakeFiles/noG.dir/noG.c.o"

# External object files for target noG
noG_EXTERNAL_OBJECTS =

noG: CMakeFiles/noG.dir/noG.c.o
noG: CMakeFiles/noG.dir/build.make
noG: /usr/lib/x86_64-linux-gnu/libopencv_videostab.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_ts.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_superres.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_stitching.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_ocl.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_gpu.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_contrib.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_photo.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_legacy.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_video.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_objdetect.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_ml.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_calib3d.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_features2d.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_highgui.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_imgproc.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_flann.so.2.4.9
noG: /usr/lib/x86_64-linux-gnu/libopencv_core.so.2.4.9
noG: CMakeFiles/noG.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/60575005h/cuda/blur/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable noG"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/noG.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/noG.dir/build: noG

.PHONY : CMakeFiles/noG.dir/build

CMakeFiles/noG.dir/requires: CMakeFiles/noG.dir/noG.c.o.requires

.PHONY : CMakeFiles/noG.dir/requires

CMakeFiles/noG.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/noG.dir/cmake_clean.cmake
.PHONY : CMakeFiles/noG.dir/clean

CMakeFiles/noG.dir/depend:
	cd /home/60575005h/cuda/blur/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/60575005h/cuda/blur /home/60575005h/cuda/blur /home/60575005h/cuda/blur/build /home/60575005h/cuda/blur/build /home/60575005h/cuda/blur/build/CMakeFiles/noG.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/noG.dir/depend

