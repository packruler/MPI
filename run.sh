#!/bin/sh


mpicc benchmark.cpp -o benchmark
echo "Compile Complete"

echo "How many processes should be used? (Default 4)"
read NUM_PROCESSES
if [ -z "$NUM_PROCESSES" ];then
    NUM_PROCESSES=4
fi

echo "How many values do you want in the array? (Default 100000000)"
read NUM_VALUES
if [ -z "$NUM_VALUES" ];then
    NUM_VALUES=100000000
fi

START=`date +%s%N | cut -b1-13`

mpiexec -np $NUM_PROCESSES ./benchmark $NUM_VALUES

END=`date +%s%N | cut -b1-13`

DURATION=`expr $END - $START`
echo "The process took " $DURATION "ms"
