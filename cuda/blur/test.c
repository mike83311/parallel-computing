#include "opencv/cv.h"
#include "opencv/highgui.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define PI 3.14159265358979323846


void createWeightMatrix(int blurRadius);
double getWeight(int blurRadius, double sigma, int x, int y);
void calculateWeightMatrix(double *weightArr, int blurRadius, double sigma);
void getFinalWeightMatrix(double *weightArr, int blurRadius);
void printArray(double *Array, int ROW, int COL);



int main(int argc, char **argv){
    IplImage* sourceImg;
    IplImage* outputImgB;
    IplImage* outputImgG;
    IplImage* outputImgR;

    if((sourceImg = cvLoadImage(argv[1], 1)) == NULL){
        printf("%s cannot be openned\n", argv[1]);
        exit(1);
    }
    printf("height of sourceImg: %d\n", sourceImg->height);
    printf("width of sourceImg: %d\n", sourceImg->width);
    printf("size of sourceImg: %d\n", sourceImg->imageSize);

    outputImgB = cvLoadImage(argv[1], 1);
    outputImgG = cvLoadImage(argv[1], 1);
    outputImgR = cvLoadImage(argv[1], 1);
    
    printf("1\n");



    int blurRadius = atoi(argv[2]);
    double sigma = atof(argv[3]);
    int length = blurRadius * 2 + 1;
    double *weightArr = (double *)malloc((blurRadius * 2 + 1) * (blurRadius * 2 + 1) * sizeof(double));
    //createWeightMatrix(blurRadius);
    calculateWeightMatrix(weightArr, blurRadius, sigma);
    printArray(weightArr, length, length);
    getFinalWeightMatrix(weightArr, blurRadius);
    printArray(weightArr, length, length);



    

    int COL_Step = sourceImg->widthStep;
    int COL = sourceImg->width;
    int ROW = sourceImg->height;

    unsigned char *Blue     = (unsigned char *)malloc(ROW * COL * sizeof(unsigned char));
    unsigned char *Green    = (unsigned char *)malloc(ROW * COL * sizeof(unsigned char));
    unsigned char *Red      = (unsigned char *)malloc(ROW * COL * sizeof(unsigned char));

    printf("2\n");

    for(int i = 0; i < ROW; i++){
        for(int j = 0; j < COL_Step; j = j + 3){
            Blue[i * COL + (j/3)]   = sourceImg->imageData[i * COL_Step + j] * weightArr[4];
            Green[i * COL + (j/3)]  = sourceImg->imageData[i * COL_Step + j + 1] * weightArr[4];
            Red[i * COL + (j/3)]    = sourceImg->imageData[i * COL_Step + j + 2] * weightArr[4];
        }
    }

    //printArray(Blue, ROW, COL);



    
    printf("3\n");

    for(int i = 0; i < ROW; i++){
        for(int j = 0; j < COL_Step; j = j + 3){
            outputImgB->imageData[i * COL_Step + j]      = Blue[i * COL + (j/3)];
            outputImgB->imageData[i * COL_Step + j + 1]  = 0;
            outputImgB->imageData[i * COL_Step + j + 2]  = 0;
            
            outputImgG->imageData[i * COL_Step + j]      = 0;
            outputImgG->imageData[i * COL_Step + j + 1]  = Green[i * COL + (j/3)];
            outputImgG->imageData[i * COL_Step + j + 2]  = 0;

            outputImgR->imageData[i * COL_Step + j]      = 0;
            outputImgR->imageData[i * COL_Step + j + 1]  = 0;
            outputImgR->imageData[i * COL_Step + j + 2]  = Red[i * COL + (j/3)];
        }
    }


    cvShowImage("sourceImg", sourceImg);
    cvShowImage("Blue", outputImgB);
    cvShowImage("Green", outputImgG);
    cvShowImage("Red", outputImgR);
    cvWaitKey(0);
    cvDestroyWindow("sourceImg");
    cvReleaseImage(&sourceImg);
    cvDestroyWindow("Blue");
    cvReleaseImage(&outputImgB);
    cvDestroyWindow("Green");
    cvReleaseImage(&outputImgG);
    cvDestroyWindow("Red");
    cvReleaseImage(&outputImgR);



    free(weightArr);
    free(Blue);
    free(Green);
    free(Red);




    return 0;
}






double getWeight(int blurRadius, double sigma, int x, int y){
    //double sigma = 5.0;//(blurRadius * 2 + 1) / 2;
    double weight = (1 / (2 * PI * sigma * sigma)) * exp(-(x * x + y * y)/(2 * sigma * sigma));
    return weight;
}
void calculateWeightMatrix(double *weightArr, int blurRadius, double sigma){
    int length = blurRadius * 2 + 1;
    for(int i = 0; i < length; i++){ 
        for(int j = 0; j < length; j++){ 
            weightArr[i * length + j] = getWeight(blurRadius, sigma, j - blurRadius, blurRadius - i); 
        } 
    }
}
void getFinalWeightMatrix(double *weightArr, int blurRadius){
    int length = blurRadius * 2 + 1;
    double weightSum = 0; 
    for(int i = 0; i < length; i++){ 
        for(int j = 0; j < length; j++){ 
            weightSum += weightArr[i * length + j]; 
        } 
    } 
    for(int i = 0; i < length; i++){ 
        for(int j = 0; j < length; j++ ){ 
            weightArr[i * length + j] = weightArr[i * length + j] / weightSum; 
        } 
    }
}

void printArray(double *Array, int ROW, int COL){
    int x, y;
    for(y = 0; y != ROW; ++y) {
        for(x = 0; x != COL; ++x)
            printf("%lf ", Array[y * COL + x]);
            
        printf("\n");      
    }
    printf("==============================================================\n");
}










