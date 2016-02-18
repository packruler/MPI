#/bin/sh

mpicc benchmark.cpp -o benchmark
mpiexec -np 4 ./benchmark 100000000
