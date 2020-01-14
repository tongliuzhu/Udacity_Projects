#!/bin/bash
# Go into the directory where this bash script is contained.

cd `dirname $0`

echo -e "\e[33m clang format chechking!...\e[0m"
source clang-format.sh $(pwd)/src
source clang-format.sh $(pwd)/include
echo -e "\e[33m clang format done!...\e[0m"

mkdir -p build
cd build
cmake ..
make && cd ..

if [ $(which gnome-terminal) ]; then
    TERMINAL=gnome-terminal
fi

if [ $(which xfce4-terminal) ]; then
    TERMINAL=xfce4-terminal
fi

${TERMINAL} --title "simulator" -x bash -c " ./run_simulator.sh;" --maximize &
sleep 1
${TERMINAL} --tab --title "planning_algorithm" -x bash -c "./run_algorithm.sh;"&
