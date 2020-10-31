cmake_minimum_required(VERSION 3.3)

if(NOT DOT_CS211_DIR)
    set(DOT_CS211_DIR "${PROJECT_SOURCE_DIR}/.cs211")
endif()

list(APPEND CMAKE_MODULE_PATH "${DOT_CS211_DIR}/cmake")
include(211helpers)
include(211commands)

enable_testing()

find_local_package(Catch2 .cs211/lib/catch VERSION 2020.2)
find_local_package(Ge211  .cs211/lib/ge211 VERSION 2020.7)

include_directories(src)

# vim: ft=cmake
