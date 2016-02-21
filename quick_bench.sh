#!/bin/bash
mpicc benchmark.cpp -o benchmark

MAX_NUM_PROCESSES=36

OUTPUT_FILE="benchmark.txt"

echo > $OUTPUT_FILE
for i in $(seq 1 $MAX_NUM_PROCESSES); do
   clear
   echo "Working with $i processes"
   START=`date +%s%N | cut -b1-13`
   mpiexec -np $i ./benchmark 10000000

   END=`date +%s%N | cut -b1-13`

   DURATION=`expr $END - $START`
   echo "$i processes took $DURATION milliseconds to complete" >> $OUTPUT_FILE
done
