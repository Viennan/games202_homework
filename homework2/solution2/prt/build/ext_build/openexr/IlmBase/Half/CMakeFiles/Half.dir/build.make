# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/wiennan/桌面/games202/homework2/solution2/prt

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/wiennan/桌面/games202/homework2/solution2/prt/build

# Include any dependencies generated for this target.
include ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/compiler_depend.make

# Include the progress variables for this target.
include ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/progress.make

# Include the compile flags for this target's objects.
include ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/flags.make

ext_build/openexr/IlmBase/Half/eLut.h: ext_build/openexr/IlmBase/Half/eLut
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/wiennan/桌面/games202/homework2/solution2/prt/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating eLut.h"
	cd /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half && /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half/eLut > /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half/eLut.h

ext_build/openexr/IlmBase/Half/toFloat.h: ext_build/openexr/IlmBase/Half/toFloat
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/wiennan/桌面/games202/homework2/solution2/prt/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating toFloat.h"
	cd /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half && /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half/toFloat > /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half/toFloat.h

ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.o: ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/flags.make
ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.o: /home/wiennan/桌面/games202/homework2/solution2/prt/ext/openexr/IlmBase/Half/half.cpp
ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.o: ext_build/openexr/IlmBase/Half/eLut.h
ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.o: ext_build/openexr/IlmBase/Half/toFloat.h
ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.o: ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/wiennan/桌面/games202/homework2/solution2/prt/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.o"
	cd /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half && /usr/bin/g++-11 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.o -MF CMakeFiles/Half.dir/half.cpp.o.d -o CMakeFiles/Half.dir/half.cpp.o -c /home/wiennan/桌面/games202/homework2/solution2/prt/ext/openexr/IlmBase/Half/half.cpp

ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Half.dir/half.cpp.i"
	cd /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half && /usr/bin/g++-11 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/wiennan/桌面/games202/homework2/solution2/prt/ext/openexr/IlmBase/Half/half.cpp > CMakeFiles/Half.dir/half.cpp.i

ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Half.dir/half.cpp.s"
	cd /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half && /usr/bin/g++-11 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/wiennan/桌面/games202/homework2/solution2/prt/ext/openexr/IlmBase/Half/half.cpp -o CMakeFiles/Half.dir/half.cpp.s

# Object files for target Half
Half_OBJECTS = \
"CMakeFiles/Half.dir/half.cpp.o"

# External object files for target Half
Half_EXTERNAL_OBJECTS =

ext_build/openexr/IlmBase/Half/libHalf.a: ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/half.cpp.o
ext_build/openexr/IlmBase/Half/libHalf.a: ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/build.make
ext_build/openexr/IlmBase/Half/libHalf.a: ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/wiennan/桌面/games202/homework2/solution2/prt/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX static library libHalf.a"
	cd /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half && $(CMAKE_COMMAND) -P CMakeFiles/Half.dir/cmake_clean_target.cmake
	cd /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Half.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/build: ext_build/openexr/IlmBase/Half/libHalf.a
.PHONY : ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/build

ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/clean:
	cd /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half && $(CMAKE_COMMAND) -P CMakeFiles/Half.dir/cmake_clean.cmake
.PHONY : ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/clean

ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/depend: ext_build/openexr/IlmBase/Half/eLut.h
ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/depend: ext_build/openexr/IlmBase/Half/toFloat.h
	cd /home/wiennan/桌面/games202/homework2/solution2/prt/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/wiennan/桌面/games202/homework2/solution2/prt /home/wiennan/桌面/games202/homework2/solution2/prt/ext/openexr/IlmBase/Half /home/wiennan/桌面/games202/homework2/solution2/prt/build /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half /home/wiennan/桌面/games202/homework2/solution2/prt/build/ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : ext_build/openexr/IlmBase/Half/CMakeFiles/Half.dir/depend

