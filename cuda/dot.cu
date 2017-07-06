#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <time.h>

const int Array = 1024 * 1024 * 8;
const int threadsPerBlock = 512;

__global__ void dot(int *d_a, int *d_b, int *d_c){
    int tid = threadIdx.x;
    int tidTemp = tid ;

    while(tidTemp < Array){
        d_c[tidTemp] = d_a[tidTemp] * d_b[tidTemp];
        tidTemp += blockDim.x;
    }

    __syncthreads();

    int i = Array / 2;
    while(i != 0){
        tid = threadIdx.x;
        while(tid < i){
            d_c[tid] += d_c[tid + i];
            tid += blockDim.x;
        }
        __syncthreads();

        i /= 2;
    }
}

int main(){
    int *a, *b, *c, *gold_c;
    int *d_a, *d_b, *d_c;
    int i;
    int pass = 1;

    a = (int*)malloc(Array*sizeof(int));
    b = (int*)malloc(Array*sizeof(int));
    c = (int*)malloc(Array*sizeof(int));
    gold_c = (int*)malloc(Array*sizeof(int));
    
    for(i = 0; i < Array; i++){
        a[i] = rand()%100;
        b[i] = rand()%100;
    }

    struct timespec t_start, t_end;
    double elapsedTimeCPU;

    clock_gettime(CLOCK_REALTIME, &t_start);

    //dot
    int sum = 0;
    for(i = 0; i < Array; i++){
        //gold_c[i] = a[i] * b[i];
        sum += a[i] * b[i];
    }

    clock_gettime(CLOCK_REALTIME, &t_end);

    elapsedTimeCPU = (t_end.tv_sec - t_start.tv_sec) * 1000.0;
    elapsedTimeCPU += (t_end.tv_nsec - t_start.tv_nsec) / 1000000.0;
    printf("CPU elapsedTime: %lf ms\n", elapsedTimeCPU);
    

    cudaMalloc((void**)&d_a, Array * sizeof(int));
    cudaMalloc((void**)&d_b, Array * sizeof(int));
    cudaMalloc((void**)&d_c, Array * sizeof(int));
    
    cudaMemcpy(d_a, a, Array*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, Array*sizeof(int), cudaMemcpyHostToDevice);
    
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);

    dot<<<1, threadsPerBlock>>>(d_a, d_b, d_c);

    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);

    float cudaelapsedTime;
    cudaEventElapsedTime(&cudaelapsedTime, start, stop);
    printf("GPU elapsedTime: %lf ms\n", cudaelapsedTime);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    cudaMemcpy(c, d_c, Array*sizeof(int), cudaMemcpyDeviceToHost);
    
    /*for(i = 0; i < Array; i++){
        if(gold_c[i] != c[i]){
            pass = 0;
            break;
        }
    }*/

    if(c[0] != sum){
        pass =0;
    }

    if(pass==1)
        printf("test pass!\n");
    else
        printf("error...\n");
    
    return 0;

}










