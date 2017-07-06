#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <time.h>
#define N 10000
 __global__ void add(int *d_a, int *d_b, int *d_c){
    d_c[blockIdx.x] = d_a[blockIdx.x] + d_b[blockIdx.x];
 }

 int main(){
    int *a, *b, *c, *gold_c;
    int *d_a, *d_b, *d_c;
    int i;
    int pass = 1;


    a = (int*)malloc(N*sizeof(int));
    b = (int*)malloc(N*sizeof(int));
    c = (int*)malloc(N*sizeof(int));    
    gold_c = (int*)malloc(N*sizeof(int));
    for(i=0; i<N; i++){
        a[i] = rand()%100;
        b[i] = rand()%100;
    }
    
    struct timespec t_start, t_end;
    double elapsedTimeCPU;
    // start time
    clock_gettime( CLOCK_REALTIME, &t_start);
    
    for(i=0; i<N; i++){
        gold_c[i] = a[i] + b[i];
    }
    // stop time
    clock_gettime( CLOCK_REALTIME, &t_end);
    // compute and print the elapsed time in millisec
    elapsedTimeCPU = (t_end.tv_sec - t_start.tv_sec) * 1000.0;
    elapsedTimeCPU += (t_end.tv_nsec - t_start.tv_nsec) / 1000000.0;
    printf("CPU elapsedTime: %lf ms\n", elapsedTimeCPU);
    
    
    cudaMalloc((void**)&d_a, N * sizeof(int));
    cudaMalloc((void**)&d_b, N * sizeof(int));
    cudaMalloc((void**)&d_c, N * sizeof(int));
    
    
    cudaMemcpy(d_a, a, N*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, N*sizeof(int), cudaMemcpyHostToDevice);
    
    // Get start time event
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);
    
    add<<<N, 1>>>(d_a, d_b, d_c);
    
    // Get stop time event    
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop); 
    // Compute execution time
    float elapsedTime;
    cudaEventElapsedTime(&elapsedTime, start, stop);
    printf("GPU time: %13f msec\n", elapsedTime);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);


    cudaMemcpy(c, d_c, N*sizeof(int), cudaMemcpyDeviceToHost);
    
    for(i=0; i<N; i++){
        if(gold_c[i]!=c[i]){
            pass = 0;
            break;
        }
    }
    
    if(pass==1)
        printf("test pass!\n");
    else
        printf("error...\n");
    
    return 0;
 }
