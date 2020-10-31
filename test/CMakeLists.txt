cmake_minimum_required(VERSION 3.3)
project(Test_dot_cs211 CXX)
include(.cs211/cmake/CMakeLists.txt)

add_test_program(try_catch one_test.cxx)

add_program(my_game my_game.cxx)
target_link_libraries(my_game ge211)

add_program(my_game2 my_game2.cxx)
target_link_libraries(my_game2 ge211)
