# Some helper functions.
cmake_minimum_required(VERSION 3.3)

# find_local_package(name dir)
#
# Look for an installed package ${name}, otherwise load the vendored
# version from ${dir}.
function(find_local_package name dir)
    cmake_parse_arguments(pa
            ""
            "VERSION"
            ""
            ${ARGN})
    find_package(${name} ${pa_VERSION} CONFIG QUIET)
    if(${name}_FOUND)
        message(STATUS "Using system ${name} library (v${${name}_VERSION})")
    else()
        message(STATUS "Using vendored ${name} library (${dir})")
        add_subdirectory(${dir} EXCLUDE_FROM_ALL)
    endif()
endfunction(find_local_package)

macro(default_to var val)
    if(NOT ${var})
        set(${var} "${val}")
    endif()
endmacro(default_to)

# glob_dirs(dest_list dir...)
#
# Sets dest_list to the names of all the files in all the given
# directories.
function(glob_dirs dest_list)
    set(accum)

    foreach(dir ${ARGN})
        file(GLOB results "${dir}/*")
        list(APPEND accum ${results})
    endforeach(dir)

    set(${dest_list} "${accum}" PARENT_SCOPE)
endfunction(glob_dirs)

# find_file_nc(dest_var filename dir...)
#
# Like find_file but doesn't cache the result and unsets
# ${dest_var} first.
function(find_file_nc dest_var filename)
    unset(${dest_var} PARENT_SCOPE)
    foreach(dir ${ARGN})
        if(EXISTS "${dir}/${filename}")
            set(${dest_var} "${dir}/${filename}" PARENT_SCOPE)
            return()
        endif()
    endforeach()
endfunction(find_file_nc)

function(find_all dest_list)
    cmake_parse_arguments(pa
            "OPTIONAL;VERBOSE"
            "AS;CALLED"
            "FILES;IN"
            ${ARGN})
    default_to(pa_AS      "find_all")
    default_to(pa_CALLED  "File")
    default_to(pa_IN      "${GE211_RESOURCE_PATH}")

    set(accum)

    foreach(arg ${pa_UNPARSED_ARGUMENTS} ${pa_FILES})
        find_file_nc(arg_file "${arg}" ${pa_IN})
        if(arg_file)
            list(APPEND accum "${arg_file}")
        elseif(NOT pa_OPTIONAL)
            string(JOIN "\n - " tried ${pa_IN})
            message(SEND_ERROR "${pa_AS}:"
                    " ${pa_CALLED} ‘${arg}’ not found. Searched in:"
                    "\n - ${tried}")
        endif()
    endforeach()

    set(${dest_list} "${accum}" PARENT_SCOPE)
endfunction(find_all)

# vim: ft=cmake
