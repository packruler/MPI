#!/bin/bash
mpicc benchmark.cpp -o benchmark

MAX_NUM_PROCESSES=36

OUTPUT_FILE="benchmark.txt"

echo > $OUTPUT_FILE
PROCESS_COUNT=1

while [ $PROCESS_COUNT -le $MAX_NUM_PROCESSES ]
 do
   # clear
   echo "Working with $PROCESS_COUNT processes"
   START=`date +%s%N | cut -b1-13`
   mpiexec -np $PROCESS_COUNT ./benchmark 10000000

   END=`date +%s%N | cut -b1-13`

   DURATION=`expr $END - $START`
   echo "$PROCESS_COUNT processes took $DURATION milliseconds to complete" >> $OUTPUT_FILE
   if [[ $PROCESS_COUNT -eq 32 ]]; then
      PROCESS_COUNT=36
   else
      ((PROCESS_COUNT = PROCESS_COUNT * 2))
   fi
done
