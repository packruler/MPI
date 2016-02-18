#/bin/sh

mpicc benchmark.cpp -o benchmark
mpiexec -np 1 ./benchmark
