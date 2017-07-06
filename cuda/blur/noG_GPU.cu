#include "opencv/cv.h"
#include "opencv/highgui.h"
#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define PI 3.14159265358979323846
#define WIDTH 32


// GPU
__global__ void Blur_Kernel(unsigned char *d_Blue, unsigned char *d_Green, unsigned char *d_Red, unsigned char *d_Blue_Blur, unsigned char *d_Green_Blur, unsigned char *d_Red_Blur, float *d_weightArr, int blurRadius, int length, int COL, int ROW);
void gaussian_blur(unsigned char *Blue, unsigned char *Green, unsigned char *Red, unsigned char *Blue_Blur, unsigned char *Green_Blur, unsigned char *Red_Blur, float *weightArr, int blurRadius, int length, int COL, int ROW);


// Weight Matrix
void createWeightMatrix(int blurRadius);
float getWeight(int blurRadius, float sigma, int x, int y);
void calculateWeightMatrix(float *weightArr, int blurRadius, float sigma);
void getFinalWeightMatrix(float *weightArr, int blurRadius);
void printArray(float *Array, int ROW, int COL);
void printArrayChar(unsigned char *Array, int ROW, int COL);



int main(int argc, char **argv){
    IplImage* sourceImg;
    IplImage* outputImg;
    

    if((sourceImg = cvLoadImage(argv[1], 1)) == NULL){
        printf("%s cannot be openned\n", argv[1]);
        exit(1);
    }
    printf("height of sourceImg: %d\n", sourceImg->height);
    printf("width of sourceImg: %d\n", sourceImg->width);
    printf("size of sourceImg: %d\n", sourceImg->imageSize);

    outputImg = cvLoadImage(argv[1], 1);



    int blurRadius = atoi(argv[2]);
    float sigma = atof(argv[3]);
    int length = blurRadius * 2 + 1;
    float *weightArr = (float *)malloc((blurRadius * 2 + 1) * (blurRadius * 2 + 1) * sizeof(float));

    calculateWeightMatrix(weightArr, blurRadius, sigma);
    getFinalWeightMatrix(weightArr, blurRadius);
    

    int COL_Step = sourceImg->widthStep;
    int COL = sourceImg->width;
    int ROW = sourceImg->height;

    // Input BGR Array
    unsigned char *Blue         = (unsigned char *)malloc(ROW * COL * sizeof(unsigned char));
    unsigned char *Green        = (unsigned char *)malloc(ROW * COL * sizeof(unsigned char));
    unsigned char *Red          = (unsigned char *)malloc(ROW * COL * sizeof(unsigned char));
    
    // Output BGR Array
    unsigned char *Blue_Blur    = (unsigned char *)malloc(ROW * COL * sizeof(unsigned char));
    unsigned char *Green_Blur   = (unsigned char *)malloc(ROW * COL * sizeof(unsigned char));
    unsigned char *Red_Blur     = (unsigned char *)malloc(ROW * COL * sizeof(unsigned char));


    // 
    for(int i = 0; i < ROW; i++){
        for(int j = 0; j < COL_Step; j = j + 3){
            Blue[i * COL + (j/3)]   = sourceImg->imageData[i * COL_Step + j];
            Green[i * COL + (j/3)]  = sourceImg->imageData[i * COL_Step + j + 1];
            Red[i * COL + (j/3)]    = sourceImg->imageData[i * COL_Step + j + 2];
        }
    }



    // GPU function
    gaussian_blur(Blue, Green, Red, Blue_Blur, Green_Blur, Red_Blur, weightArr, blurRadius, length, COL, ROW);
    
    
    // Set BGR To Output Image
    for(int i = 0; i < ROW; i++){
        for(int j = 0; j < COL_Step; j = j + 3){
            outputImg->imageData[i * COL_Step + j]     = Blue_Blur[i * COL + (j/3)];
            outputImg->imageData[i * COL_Step + j + 1] = Green_Blur[i * COL + (j/3)];
            outputImg->imageData[i * COL_Step + j + 2] = Red_Blur[i * COL + (j/3)];
        }
    }
    
    cvSaveImage("noG_black_cat.jpg", outputImg, 0);
    // cvSaveImage("output2.jpg", outputImg, 0);
    cvShowImage("sourceImg", sourceImg);
    cvShowImage("GPU", outputImg);
    
    cvWaitKey(0);
    
    cvDestroyWindow("sourceImg");
    cvReleaseImage(&sourceImg);
    cvDestroyWindow("GPU");
    cvReleaseImage(&outputImg);
    
    free(Blue);
    free(Green);
    free(Red);

    free(Blue_Blur);
    free(Green_Blur);
    free(Red_Blur);
    
    free(weightArr);


    return 0;
}





__global__ void Blur_Kernel(unsigned char *d_Blue, unsigned char *d_Green, unsigned char *d_Red, unsigned char *d_Blue_Blur, unsigned char *d_Green_Blur, unsigned char *d_Red_Blur, float *d_weightArr, int blurRadius, int length, int COL, int ROW){
    int row = (blockIdx.y * blockDim.y) + threadIdx.y;
    int col = (blockIdx.x * blockDim.x) + threadIdx.x;
    int i, j;


    float BBB = 0;
    float GGG = 0;
    float RRR = 0;


    if(row < ROW && col < COL){
        for(j = 0; j < length; j++){
            for(i = 0; i < length; i++){
                if(((row - blurRadius + j) < 0) || ((col - blurRadius + i) < 0) || ((row - blurRadius + j) >= ROW) || ((col - blurRadius + i) >= COL)){
                    // do nothing
                }
                else {
                    BBB += ((float)d_Blue[(row - blurRadius + j) * COL + (col - blurRadius + i)] * d_weightArr[j * length + i]);
                    GGG += ((float)d_Green[(row - blurRadius + j) * COL + (col - blurRadius + i)] * d_weightArr[j * length + i]);
                    RRR += ((float)d_Red[(row - blurRadius + j) * COL + (col - blurRadius + i)] * d_weightArr[j * length + i]);
                }

                // if(((col - blurRadius + j) >= 0) && ((row - blurRadius + i) >= 0) && ((col - blurRadius + j) < COL) && ((row - blurRadius + i) < ROW)){
                //     BBB += ((float)d_Blue[(row - blurRadius + j) * COL + (col - blurRadius + i)] * d_weightArr[j * length + i]);
                //     GGG += ((float)d_Green[(row - blurRadius + j) * COL + (col - blurRadius + i)] * d_weightArr[j * length + i]);
                //     RRR += ((float)d_Red[(row - blurRadius + j) * COL + (col - blurRadius + i)] * d_weightArr[j * length + i]);
                // }
            }
        }
        d_Blue_Blur[row * COL + col] = (unsigned char)BBB;
        d_Green_Blur[row * COL + col] = (unsigned char)GGG;
        d_Red_Blur[row * COL + col] = (unsigned char)RRR;  
    }
}

void gaussian_blur(unsigned char *Blue, unsigned char *Green, unsigned char *Red, unsigned char *Blue_Blur, unsigned char *Green_Blur, unsigned char *Red_Blur, float *weightArr, int blurRadius, int length, int COL, int ROW){
    size_t size_BGR = ROW * COL * sizeof(unsigned char);
    size_t size_weight = length * length * sizeof(float);

    unsigned char *d_Blue, *d_Green, *d_Red, *d_Blue_Blur, *d_Green_Blur, *d_Red_Blur;
    float *d_weightArr;

    // Allocate
    cudaMalloc((void **)&d_Blue, size_BGR);
    cudaMemcpy(d_Blue, Blue, size_BGR, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&d_Green, size_BGR);
    cudaMemcpy(d_Green, Green, size_BGR, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&d_Red, size_BGR);
    cudaMemcpy(d_Red, Red, size_BGR, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&d_weightArr, size_weight);
    cudaMemcpy(d_weightArr, weightArr, size_weight, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&d_Blue_Blur, size_BGR);
    cudaMalloc((void **)&d_Green_Blur, size_BGR);
    cudaMalloc((void **)&d_Red_Blur, size_BGR);


    // Setup
    int gridDim_X = (COL + 31)/32;
    int gridDim_Y = (ROW + 31)/32;
    dim3 dimGrid(gridDim_X, gridDim_Y);
    dim3 dimBlock(WIDTH, WIDTH);

    // Get start time event
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);

    // Invoke kernel
    Blur_Kernel<<<dimGrid, dimBlock>>>(d_Blue, d_Green, d_Red, d_Blue_Blur, d_Green_Blur, d_Red_Blur, d_weightArr, blurRadius, length, COL, ROW);


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
    cudaMemcpy(Blue_Blur, d_Blue_Blur, size_BGR, cudaMemcpyDeviceToHost);
    cudaMemcpy(Green_Blur, d_Green_Blur, size_BGR, cudaMemcpyDeviceToHost);
    cudaMemcpy(Red_Blur, d_Red_Blur, size_BGR, cudaMemcpyDeviceToHost);

    
    // Free device memory
    cudaFree(d_Blue);
    cudaFree(d_Green);
    cudaFree(d_Red);

    cudaFree(d_Blue_Blur);
    cudaFree(d_Green_Blur);
    cudaFree(d_Red_Blur);

    cudaFree(d_weightArr);

}





float getWeight(int blurRadius, float sigma, int x, int y){
    //float sigma = 5.0;//(blurRadius * 2 + 1) / 2;
    float weight = (1 / (2 * PI * sigma * sigma)) * exp(-(x * x + y * y)/(2 * sigma * sigma));
    return weight;
}

void calculateWeightMatrix(float *weightArr, int blurRadius, float sigma){
    int length = blurRadius * 2 + 1;
    for(int i = 0; i < length; i++){ 
        for(int j = 0; j < length; j++){ 
            weightArr[i * length + j] = 0.0;//getWeight(blurRadius, sigma, j - blurRadius, blurRadius - i); 
        } 
    }
}

void getFinalWeightMatrix(float *weightArr, int blurRadius){
    int length = blurRadius * 2 + 1;
    float weightSum = 0; 
    for(int i = 0; i < length; i++){ 
        for(int j = 0; j < length; j++){ 
            weightSum += weightArr[i * length + j]; 
        } 
    } 
    for(int i = 0; i < length; i++){ 
        for(int j = 0; j < length; j++ ){ 
            weightArr[i * length + j] = (float) 1 / (length * length);//weightArr[i * length + j] / weightSum; 
        } 
    }
}

void printArrayChar(unsigned char *Array, int ROW, int COL){
    int x, y;
    for(y = 0; y != ROW; ++y) {
        for(x = 0; x != COL; ++x)
            printf("%u ", Array[y * COL + x]);
            
        printf("\n");      
    }
    printf("==============================================================\n");
}

void printArray(float *Array, int ROW, int COL){
    int x, y;
    for(y = 0; y != ROW; ++y) {
        for(x = 0; x != COL; ++x)
            printf("%lf ", Array[y * COL + x]);
            
        printf("\n");      
    }
    printf("==============================================================\n");
}
















