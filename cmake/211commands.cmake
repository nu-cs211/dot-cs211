cmake_minimum_required(VERSION 3.3)

# Adds a program with the given name and source files, and sets the
# language to C++ 14
#
# Usage:
#
#   add_program(NAME [OPTION...] SRCFILE...)
#
# where OPTIONs include:
#
#   ASAN    enable address sanitizer
#   UBSAN   enable undefined behavior sanitizer
#   CXX17   enable C++ 2017
#
function (add_program name)
    cmake_parse_arguments(pa "ASAN;UBSAN;CXX17;" "" "" ${ARGN})

    add_executable(${name} ${pa_UNPARSED_ARGUMENTS})
    target_compile_options(${name} PRIVATE ${CS211_CXX_FLAGS})

    if(pa_ASAN)
        target_compile_options(${name} PRIVATE "-fsanitize=address")
        target_link_options(${name} PRIVATE "-fsanitize=address")
    endif(pa_ASAN)

    if(pa_UBSAN)
        target_compile_options(${name} PRIVATE "-fsanitize=undefined")
        target_link_options(${name} PRIVATE "-fsanitize=undefined")
    endif(pa_UBSAN)

    if(pa_CXX17)
        set_property(TARGET ${name} PROPERTY CXX_STANDARD       17)
    else(pa_CXX17)
        set_property(TARGET ${name} PROPERTY CXX_STANDARD       14)
    endif(pa_CXX17)

    set_property(TARGET ${name} PROPERTY CXX_STANDARD_REQUIRED  On)
    set_property(TARGET ${name} PROPERTY CXX_EXTENSIONS         Off)
endfunction(add_program)

# Adds a test program with the given name and source files
# Options are the same as `add_program`, but the listed
# source files should not define `main()`.
function(add_test_program name)
    add_program(${name} ${ARGN})
    target_link_libraries(${name} catch)
    add_test(Test_${name} ${name})
endfunction(add_test_program)

# Setup compilation flags

include(CheckCXXCompilerFlag)

# Sets ${out} to the list of supported flags.
function(cs211_set_supported_flags out)
    set(accum)
    foreach(flag ${ARGN})
        string(TOUPPER "${flag}" varname)
        string(REGEX REPLACE "[-=]" "_" varname "FLAG_${varname}_OK")
        check_cxx_compiler_flag(-${flag} ${varname})
        if(${varname})
            list(APPEND accum -${flag})
        endif()
    endforeach()
    set(${out} ${accum} PARENT_SCOPE)
endfunction()

# Flags we would like to pass to the compiler:
cs211_set_supported_flags(CS211_CXX_FLAGS
    Wcast-align=strict
    Wcast-qual
    Wdangling-else
    Wnull-dereference
    Wold-style-declaration
    Wold-style-definition
    Wshadow
    Wtype-limits
    Wwrite-strings
    Werror=bool-compare
    Werror=bool-operation
    Werror=int-to-pointer-cast
    Werror=pointer-to-int-cast
    Werror=return-type
    Werror=uninitialized)

# vim: ft=cmake
