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
void printArray(double *Array, int length);

int main(int argc, char** argv){
    IplImage* sourceImg;

    
    if(argc != 3){
        printf("Using command: %s source_image search_image\n",argv[0]);
        exit(1);
    }

    int blurRadius = atoi(argv[1]);
    double sigma = atof(argv[2]);
    int length = blurRadius * 2 + 1;
    double *weightArr = (double *)malloc((blurRadius * 2 + 1) * (blurRadius * 2 + 1) * sizeof(double));
    //createWeightMatrix(blurRadius);
    calculateWeightMatrix(weightArr, blurRadius, sigma);
    printArray(weightArr, length);
    getFinalWeightMatrix(weightArr, blurRadius);
    printArray(weightArr, length);

    free(weightArr);

    return 0;
}
/*
void createWeightMatrix(int blurRadius){
    double *weightArr = (double *)malloc((blurRadius * 2 + 1) * (blurRadius * 2 + 1));
}
*/
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
    printf("%f\n", weightSum);
    for(int i = 0; i < length; i++){ 
        for(int j = 0; j < length; j++ ){ 
            weightArr[i * length + j] = weightArr[i * length + j] / weightSum; 
        } 
    }
}

void printArray(double *Array, int length){
    int x, y;
    for(y = 0; y != length; ++y) {
        for(x = 0; x != length; ++x)
            printf("%lf ", Array[y * length + x]);
            
        printf("\n");      
    }
    printf("==============================================================\n");
}




