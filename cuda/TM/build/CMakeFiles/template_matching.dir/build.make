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
CMAKE_SOURCE_DIR = /home/60575005h/cuda/TM

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/60575005h/cuda/TM/build

# Include any dependencies generated for this target.
include CMakeFiles/template_matching.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/template_matching.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/template_matching.dir/flags.make

CMakeFiles/template_matching.dir/template_matching.c.o: CMakeFiles/template_matching.dir/flags.make
CMakeFiles/template_matching.dir/template_matching.c.o: ../template_matching.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/60575005h/cuda/TM/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/template_matching.dir/template_matching.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/template_matching.dir/template_matching.c.o   -c /home/60575005h/cuda/TM/template_matching.c

CMakeFiles/template_matching.dir/template_matching.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/template_matching.dir/template_matching.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/60575005h/cuda/TM/template_matching.c > CMakeFiles/template_matching.dir/template_matching.c.i

CMakeFiles/template_matching.dir/template_matching.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/template_matching.dir/template_matching.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/60575005h/cuda/TM/template_matching.c -o CMakeFiles/template_matching.dir/template_matching.c.s

CMakeFiles/template_matching.dir/template_matching.c.o.requires:

.PHONY : CMakeFiles/template_matching.dir/template_matching.c.o.requires

CMakeFiles/template_matching.dir/template_matching.c.o.provides: CMakeFiles/template_matching.dir/template_matching.c.o.requires
	$(MAKE) -f CMakeFiles/template_matching.dir/build.make CMakeFiles/template_matching.dir/template_matching.c.o.provides.build
.PHONY : CMakeFiles/template_matching.dir/template_matching.c.o.provides

CMakeFiles/template_matching.dir/template_matching.c.o.provides.build: CMakeFiles/template_matching.dir/template_matching.c.o


# Object files for target template_matching
template_matching_OBJECTS = \
"CMakeFiles/template_matching.dir/template_matching.c.o"

# External object files for target template_matching
template_matching_EXTERNAL_OBJECTS =

template_matching: CMakeFiles/template_matching.dir/template_matching.c.o
template_matching: CMakeFiles/template_matching.dir/build.make
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_videostab.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_ts.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_superres.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_stitching.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_ocl.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_gpu.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_contrib.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_photo.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_legacy.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_video.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_objdetect.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_ml.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_calib3d.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_features2d.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_highgui.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_imgproc.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_flann.so.2.4.9
template_matching: /usr/lib/x86_64-linux-gnu/libopencv_core.so.2.4.9
template_matching: CMakeFiles/template_matching.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/60575005h/cuda/TM/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable template_matching"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/template_matching.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/template_matching.dir/build: template_matching

.PHONY : CMakeFiles/template_matching.dir/build

CMakeFiles/template_matching.dir/requires: CMakeFiles/template_matching.dir/template_matching.c.o.requires

.PHONY : CMakeFiles/template_matching.dir/requires

CMakeFiles/template_matching.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/template_matching.dir/cmake_clean.cmake
.PHONY : CMakeFiles/template_matching.dir/clean

CMakeFiles/template_matching.dir/depend:
	cd /home/60575005h/cuda/TM/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/60575005h/cuda/TM /home/60575005h/cuda/TM /home/60575005h/cuda/TM/build /home/60575005h/cuda/TM/build /home/60575005h/cuda/TM/build/CMakeFiles/template_matching.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/template_matching.dir/depend
