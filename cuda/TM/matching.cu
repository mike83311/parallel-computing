#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <cuda_runtime.h>
#include "opencv/cv.h"
#include "opencv/highgui.h"


#define VALUE_MAX 10000000
#define WIDTH 32


struct match{
    int bestRow;
    int bestCol;
    int bestSAD;
}position;


__global__ void TM_Kernel(char *Sd_imgData, char *Pd_imgData, int *d_host_result, int R_height, int R_width, int P_height, int P_width, int S_height, int S_width, int S_widthStep, int P_widthStep);
void template_matching(char *S_imgData, char *P_imgData, int *host_result, int R_height, int R_width, int P_height, int P_width, int S_height, int S_width, int S_widthStep, int P_widthStep, int width);

//void img_info(IplImage *imgFile);

int main(int argc, char** argv){
    IplImage* sourceImg; 
    IplImage* patternImg; 
    
    int minSAD = VALUE_MAX;
    int x, y;
    int width = WIDTH;
    
    //char* ptr;

    // img data
    //char p_sourceIMG, p_patternIMG;

    //
    CvPoint pt1, pt2;
    
    // time
    // struct timespec t_start, t_end;
    // double elapsedTime;

    // shift number
    int result_height;
    int result_width;

    // difference array
    int *host_result;

    // check input files
    if(argc != 3){
        printf("Using command: %s source_image search_image\n", argv[0]);
        exit(1);
    }

    if((sourceImg = cvLoadImage( argv[1], 0)) == NULL){
        printf("%s cannot be openned\n", argv[1]);
        exit(1);
    }

    printf("height of sourceImg:%d\n", sourceImg->height);
    printf("width of sourceImg:%d\n", sourceImg->width);
    printf("size of sourceImg:%d\n", sourceImg->imageSize);

    if((patternImg = cvLoadImage(argv[2], 0)) == NULL){
        printf("%s cannot be openned\n", argv[2]);
        exit(1);
    }

    printf("height of sourceImg:%d\n", patternImg->height);
    printf("width of sourceImg:%d\n", patternImg->width);
    printf("size of sourceImg:%d\n", patternImg->imageSize);    

    // allocate memory on CPU to store SAD results
    result_height = sourceImg->height - patternImg->height + 1;
    result_width = sourceImg->width - patternImg->width + 1;
    host_result = (int *)malloc(result_height * result_width * sizeof(int));


    /*
        GPU template_matching
    */
    template_matching(sourceImg->imageData, patternImg->imageData, host_result, result_height, result_width, patternImg->height, patternImg->width, sourceImg->height, sourceImg->width, sourceImg->widthStep, patternImg->widthStep, width);

    // find minSAD
    for(y = 0; y < result_height; y++){
        for(x = 0; x < result_width; x++){
            if(minSAD > host_result[y * result_width + x]){
                minSAD = host_result[y * result_width + x];
                // give me VALUE_MAX
                position.bestRow = y;
                position.bestCol = x;
                position.bestSAD = host_result[y * result_width + x];
            }
        }
    }
    printf("minSAD is %d\n", minSAD);

    // setup the two points for the best match
    pt1.x = position.bestCol;
    pt1.y = position.bestRow;
    pt2.x = pt1.x + patternImg->width;
    pt2.y = pt1.y + patternImg->height;

    // Draw the rectangle in the source image
    cvRectangle(sourceImg, pt1, pt2, CV_RGB(255,0,0), 3, 8, 0);
    cvNamedWindow("sourceImage", 1);
    cvShowImage("sourceImage", sourceImg);
    cvNamedWindow("patternImage", 1);
    cvShowImage("patternImage", patternImg);
    cvWaitKey(0);
     

    cvDestroyWindow("sourceImage");
    cvReleaseImage(&sourceImg);
    cvDestroyWindow("patternImage");
    cvReleaseImage(&patternImg);

    return 0;

}

__global__ void TM_Kernel(char *Sd_imgData, char *Pd_imgData, int *d_host_result, int R_height, int R_width, int P_height, int P_width, int S_height, int S_width, int S_widthStep, int P_widthStep){
    // Thread row and column within matrix
    int row = (blockIdx.y * blockDim.y) + threadIdx.y;
    int col = (blockIdx.x * blockDim.x) + threadIdx.x;
    int i, j;
    char P_sourceIMG, P_patternIMG;

    int SAD = 0;
    if(row < R_height && col < R_width){
        for(j = 0; j < P_height; j++){
            for(i = 0; i < P_width; i++){
                P_sourceIMG = Sd_imgData[ ((row + j) * S_widthStep) + col + i];
                P_patternIMG = Pd_imgData[j * P_widthStep + i];
                SAD += abs(P_sourceIMG - P_patternIMG);
            }
        }
        d_host_result[row * R_width + col] = SAD;
    }
    
}

/*
void img_info(IplImage *imgFile){
    printf("height of sourceImg:%d\n", imgFile->height);
    printf("width of sourceImg:%d\n", imgFile->width);
    printf("size of sourceImg:%d\n", imgFile->imageSize);
}
*/

void template_matching(char *S_imgData, char *P_imgData, int *host_result, int R_height, int R_width, int P_height, int P_width, int S_height, int S_width, int S_widthStep, int P_widthStep, int width){
    size_t size_source = S_height * S_width * sizeof(char);
    size_t size_pattern = P_height * P_width * sizeof(char);
    size_t size_d_result = R_height * R_width * sizeof(int);

    char *Sd_imgData, *Pd_imgData;
    int *d_host_result;

    // Allocate
    cudaMalloc((void **)&Sd_imgData, size_source);
    cudaMemcpy(Sd_imgData, S_imgData, size_source, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&Pd_imgData, size_pattern);
    cudaMemcpy(Pd_imgData, P_imgData, size_pattern, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&d_host_result, size_d_result);

    // Setup
    int gridDim_X = (R_width + 31)/32;
    int gridDim_Y = (R_height + 31)/32;
    dim3 dimGrid(gridDim_X, gridDim_Y);
    dim3 dimBlock(width, width);

    // Get start time event
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);

    // Invoke kernel
    TM_Kernel<<<dimGrid, dimBlock>>>(Sd_imgData, Pd_imgData, d_host_result, R_height, R_width, P_height, P_width, S_height, S_width, S_widthStep, P_widthStep);
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
    cudaMemcpy(host_result, d_host_result, size_d_result, cudaMemcpyDeviceToHost);
    
    // Free device memory
    cudaFree(Sd_imgData);
    cudaFree(Pd_imgData);
    cudaFree(d_host_result);

}


