#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <cuda_runtime.h>

#define WIDTH 32
#define ROW_M 256
#define COL_M 256
#define ROW_N 256
#define COL_N 256
#define ROW_MxN ROW_M
#define COL_MxN COL_N


__global__ void MatMulKernel(float *Md, float *Nd, float *Pd, int width);
void MatMul(float *M, float *N, float *P, int width);
void printTwoDimDynamicArray(float *Array, const int col, const int row);


int main(int argc, char *argv[])
{
    int i, j, k;
    int width = WIDTH;

    // Dynamic
    float *M = (float *)malloc(ROW_M * COL_M * sizeof(float));
    float *N = (float *)malloc(ROW_N * COL_N * sizeof(float));  
    float *P = (float *)malloc(ROW_MxN * COL_MxN * sizeof(float));
    float *MxN = (float *)malloc(ROW_MxN * COL_MxN * sizeof(float));

    int pass = 1;
    
    // Initial
    for (i = 0; i < ROW_M; ++i) {
        for (j = 0; j < COL_M; ++j) {
            M[i*COL_M + j] = rand() % 5;
        }
    }
    for (i = 0; i < ROW_N; ++i) {
        for (j = 0; j < COL_N; ++j) {
            N[i*COL_N + j] = rand() % 5;
        }
    }


    struct timeval starttime, endtime;
    gettimeofday(&starttime, NULL);

    // CPU
    for (i = 0; i < ROW_M; ++i) {
        for (j = 0; j < COL_N; ++j) {
            for (k = 0; k < COL_M; ++k) {
                MxN[i*COL_N + j] += M[i*COL_M + k] * N[k*COL_N + j];
            }
        }
    }

    gettimeofday(&endtime, NULL);
    double executime;
    executime = (endtime.tv_sec - starttime.tv_sec) * 1000.0;
    executime += (endtime.tv_usec - starttime.tv_usec) / 1000.0;
    printf("CPU time: %13lf msec\n", executime);
    /*
    printTwoDimDynamicArray(M, COL_M, ROW_M);
    printf("============================\n");
    printTwoDimDynamicArray(N, COL_N, ROW_N);
    printf("============================\n");
    printTwoDimDynamicArray(MxN, COL_MxN, ROW_MxN);
    */

    // GPU
    MatMul((float *)M, (float *)N, (float *)P, width);
    
    // Compare
    for(i = 0; i < ROW_MxN; i++) {
        for(j = 0; j < COL_MxN; j++) {
            if(MxN[i*COL_MxN + j] != P[i*COL_MxN + j]) {
                printf("MxN[%d][%d] = %2.0f   P[%d][%d] = %2.0f\n", i, j, MxN[i*COL_MxN + j], i, j, P[i*COL_MxN + j]);
                pass = 0;
            }
            
        }
    }

    free(M);
    free(N);
    free(P);
    free(MxN);
    
    
    printf("Test %s\n", (pass)?"PASSED":"FAILED");
    
    return 0;
}

void printTwoDimDynamicArray(float *Array, const int col, const int row) {
    int x, y;
    for(y = 0; y != row; ++y) {
        for(x = 0; x != col; ++x)
            printf("%f ", Array[y*col + x]);
            
        printf("\n");      
    }
}

// Matrix multiplication kernel called by MatMul()
__global__ void MatMulKernel(float *Md, float *Nd, float *Pd, int width){
    int row = (blockIdx.y * blockDim.y) + threadIdx.y;
    int col = (blockIdx.x * blockDim.x) + threadIdx.x;
    
    float Pvalue = 0;
    
    // Multiply M and N
    if(row < ROW_MxN && col < COL_MxN){
        for (int k = 0; k < COL_M; ++k) {
            float Melement = *(Md + row*COL_M + k);
            float Nelement = *(Nd + k*COL_N + col);
            Pvalue += Melement * Nelement;
        }

        *(Pd + row*COL_N + col) = Pvalue;
    }
}

// Matrix multiplication - Host code
void MatMul(float *M, float *N, float *P, int width)
{
    size_t size_M = ROW_M * COL_M * sizeof(float);
    size_t size_N = ROW_N * COL_N * sizeof(float);
    size_t size_P = ROW_MxN * COL_MxN * sizeof(float);

    float *Md, *Nd, *Pd;
    
    // Allocate and Load M, N to device memory
    cudaMalloc((void **)&Md, size_M);
    cudaMemcpy(Md, M, size_M, cudaMemcpyHostToDevice);
    
    cudaMalloc((void **)&Nd, size_N);
    cudaMemcpy(Nd, N, size_N, cudaMemcpyHostToDevice);
    
    // Allocate P on the device
    cudaMalloc((void **)&Pd, size_P);
    
    // Setup the execution configuration
    int gridDim_X = (ROW_MxN + 31)/32;
    int gridDim_Y = (COL_MxN + 31)/32;
    dim3 dimGrid(gridDim_X, gridDim_Y);
    dim3 dimBlock(width, width);
    printf("============================\n");

    // Get start time event
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);
    
    // Invoke kernel
    MatMulKernel<<<dimGrid, dimBlock>>>(Md, Nd, Pd, width);
    cudaError_t cuda_err = cudaGetLastError();
    if ( cudaSuccess != cuda_err ){
        printf("before kernel call: error = %s\n", cudaGetErrorString (cuda_err));
        exit(1) ;
    }
    
    // Get stop time event
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    // Compute execution time
    float elapsedTime;
    cudaEventElapsedTime(&elapsedTime, start, stop);
    printf("GPU time: %13f msec\n", elapsedTime);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    
    // Read P from device memory
    cudaMemcpy(P, Pd, size_P, cudaMemcpyDeviceToHost);
    
    // Free device memory
    cudaFree(Md);
    cudaFree(Nd);
    cudaFree(Pd);
}
