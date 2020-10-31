cmake_minimum_required(VERSION 3.3)
project(test_dot_cs211 CXX)
include(.cs211/cmake/CMakeLists.txt)

add_test_program(test_dot_cs211 main.cxx)
target_link_libraries(test_dot_cs211 ge211)
