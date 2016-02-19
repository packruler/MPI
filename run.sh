#/bin/sh


mpicc benchmark.cpp -o benchmark
echo "Compile Complete"
echo "How many processes should be used? (Enter # of processes)"
read PROC
START=`date +%s%N | cut -b1-13`

time mpiexec -np $PROC ./benchmark 10000000

END=`date +%s%N | cut -b1-13`

DURATION=`expr $END - $START`
echo "The process took " $DURATION "ms"
