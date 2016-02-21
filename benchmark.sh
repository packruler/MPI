#!/bin/bash
mpicc benchmark.cpp -o benchmark

echo "This will loop through the benchmark runnable increasing the number of"
echo "processes until it reaches a max."

echo "What would you like the max number of processes to be? (Minimum is 1)"
read MAX_NUM_PROCESSES;
if [ -z "$MAX_NUM_PROCESSES" ];then
    MAX_NUM_PROCESSES=1
fi


# echo "Would you like to save the times to a file? (y/n)"
# read SAVE
#
# while [ -z "$SAVE" ] && ["$SAVE" = "y" || "$SAVE" = "n"]; do
#    echo "Enter \'y\' or \'n\'"
#    read WRITE_TO_FILE
# done

echo "What file would you like to save the times to? (Default: benchmark.txt)"
read OUTPUT_FILE
if [ -z "$OUTPUT_FILE" ];then
    OUTPUT_FILE="benchmark.txt"
fi

echo > $OUTPUT_FILE
for i in $(seq 1 $MAX_NUM_PROCESSES); do
   clear
   echo "Working with $i processes"
   START=`date +%s%N | cut -b1-13`
   mpiexec -np $i ./benchmark 1000000

   END=`date +%s%N | cut -b1-13`

   DURATION=`expr $END - $START`
   echo "$i processes took $DURATION milliseconds to complete" >> $OUTPUT_FILE
done
