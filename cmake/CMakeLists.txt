cmake_minimum_required(VERSION 3.3)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/.cs211/cmake")
include(211helpers)
include(211commands)

enable_testing()

find_local_package(Catch2 .cs211/lib/catch VERSION 2020.1)
find_local_package(Ge211  .cs211/lib/ge211 VERSION 2020.5)

include_directories(src)

# vim: ft=cmake
