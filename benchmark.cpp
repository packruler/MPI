#include <assert.h>
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Creates an array of random numbers. Each number has a value from 0 - 1
float *create_rand_nums(int num_elements) {
  float *rand_nums = (float *)malloc(sizeof(float) * num_elements);
  assert(rand_nums != NULL);
  int i;
  for (i = 0; i < num_elements; i++) {
    rand_nums[i] = (rand() / (float)RAND_MAX);
  }
  return rand_nums;
}

// Computes the average of an array of numbers
float compute_avg(float *array, int num_elements) {
  float sum = 0.f;
  int i;
  for (i = 0; i < num_elements; i++) {
    sum += array[i];
  }
  return sum / num_elements;
}

int main(int argc, char **argv) {
  int rank, size;

  MPI_Init(&argc, &argv);               /* starts MPI */
  MPI_Comm_rank(MPI_COMM_WORLD, &rank); /* get current process id */
  MPI_Comm_size(MPI_COMM_WORLD, &size); /* get number of processes */
  double sum = 0;
  int array[1000000000];
  srand(time(NULL));
  long start = time(NULL);
  for (int i; i < sizeof(array); i++) {
    array[i] = rand();
  }

  // int val;
  // for (long i = 0; i < 1000000000; i++) {
  //   if (i % size == rank) {
  //     sum += i;
  //   }
  // }
  start = time(NULL) - start;
  printf("Sum: %f\n", sum);
  printf("Process %d took %ld seconds\n", rank, start);
  MPI_Finalize();
  return 0;
}
