#include "book.h"
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#define imin(a,b) (a<b?a:b)

const int N = 512;
const int threadsPerBlock = 512;
const int blocksPerGrid = 1;

__global__ void dot( int *a, int *b, int *c ) {
    int tid = threadIdx.x;

    if (tid < N) {
        c[tid] = a[tid] * b[tid];
    }

    __syncthreads();

    int i = N / 2;
    while (i != 0) {
        if (tid < i){
            c[tid] += c[tid + i];
        }
        __syncthreads();

        i /= 2;
    }
}


int main( void ) {
    int   *a, *b, *c;
    int   *dev_a, *dev_b, *dev_c;
    struct timespec t_start, t_end;
    int i;
    // allocate memory on the cpu side
    a = (int*)malloc( N*sizeof(int) );
    b = (int*)malloc( N*sizeof(int) );
    c = (int*)malloc( sizeof(int) );

    // allocate the memory on the GPU
    HANDLE_ERROR( cudaMalloc( (void**)&dev_a,
                              N*sizeof(int) ) );
    HANDLE_ERROR( cudaMalloc( (void**)&dev_b,
                              N*sizeof(int) ) );
    HANDLE_ERROR( cudaMalloc( (void**)&dev_c,
                              N*sizeof(int) ) );

    // fill in the host memory with data
    srand(time(NULL));
    for (i=0; i<N; i++) {
        a[i] = rand()%256;
        b[i] = rand()%256;
    }
    // Get start time event
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);
    // copy the arrays 'a' and 'b' to the GPU
    HANDLE_ERROR( cudaMemcpy( dev_a, a, N*sizeof(int),
                              cudaMemcpyHostToDevice ) );
    HANDLE_ERROR( cudaMemcpy( dev_b, b, N*sizeof(int),
                              cudaMemcpyHostToDevice ) ); 

    
    dot<<<blocksPerGrid,threadsPerBlock>>>( dev_a, dev_b, dev_c );
    

    
    //check cuda error
    cudaError_t status = cudaGetLastError();
    if ( cudaSuccess != status ){
        fprintf(stderr, "Error: %s\n", cudaGetErrorString(status));
        exit(1) ;
    }                                           

    // copy the array 'c' back from the GPU to the CPU
    HANDLE_ERROR( cudaMemcpy( c, dev_c,
                              sizeof(int),
                              cudaMemcpyDeviceToHost ) );
    // Get stop time event    
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop); 
    // Compute execution time
    float elapsedTime;
    cudaEventElapsedTime(&elapsedTime, start, stop);
    printf("GPU time: %13f msec\n", elapsedTime);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    
     
    //printf("GPU result is %d\n",c);
    // start time
    clock_gettime( CLOCK_REALTIME, &t_start);
    /*CPU version*/
    int dot=0;
    for(i=0;i<N;i++){
       dot+=a[i]*b[i];
    }
    // stop time
    clock_gettime( CLOCK_REALTIME, &t_end);

    // compute and print the elapsed time in millisec
    elapsedTime = (t_end.tv_sec - t_start.tv_sec) * 1000.0;
    elapsedTime += (t_end.tv_nsec - t_start.tv_nsec) / 1000000.0;
    printf("CPU time: %13lf ms\n", elapsedTime);
    printf("CPU result is %d\n",dot);
    printf("GPU result is %d\n",*c);    
    if(*c == dot)
       printf("test pass!\n");
    else
       printf("test fail!\n");
    
    // free memory on the gpu side
    HANDLE_ERROR( cudaFree( dev_a ) );
    HANDLE_ERROR( cudaFree( dev_b ) );
    HANDLE_ERROR( cudaFree( dev_c ) );

    // free memory on the cpu side
    free( a );
    free( b );
    free( c );
}
