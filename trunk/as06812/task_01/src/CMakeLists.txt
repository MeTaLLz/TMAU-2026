cmake_minimum_required(VERSION 3.10)
project(as06812_lab1)

set(CMAKE_CXX_STANDARD 11)

add_executable(as06812_lab1 
    src/Main.cpp 
    src/InputSignal.cpp
    src/Model_1_2.cpp
    src/Model_2_4.cpp
    src/Model_3_6.cpp
    src/Simulator.cpp
)
