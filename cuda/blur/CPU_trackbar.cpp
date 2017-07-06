#include "opencv/cv.h"
#include "opencv/highgui.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define PI 3.14159265358979323846
using namespace cv;


void createWeightMatrix(int blurRadius);
float getWeight(int blurRadius, int sigma, int x, int y);
void calculateWeightMatrix(float *weightArr, int blurRadius, int sigma);
void getFinalWeightMatrix(float *weightArr, int blurRadius);
void printArray(float *Array, int ROW, int COL);
void printArrayChar(unsigned char *Array, int ROW, int COL);


int blurRadius;
int sigma;


void test(int, void*){
    IplImage* sourceImg;
    IplImage* outputImg;

    sourceImg = cvLoadImage("orange_cat.jpg", 1);
    
    outputImg = cvLoadImage("orange_cat.jpg", 1);



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

    float *Blue_Temp    = (float *)malloc(length * length * sizeof(float));
    float *Green_Temp   = (float *)malloc(length * length * sizeof(float));
    float *Red_Temp     = (float *)malloc(length * length * sizeof(float));

    float BBB = 0;
    float GGG = 0;
    float RRR = 0;


    printf("blurRadius = %d\tsigma = %d\n", blurRadius, sigma);


    // 
    for(int i = 0; i < ROW; i++){
        for(int j = 0; j < COL_Step; j = j + 3){
            Blue[i * COL + (j/3)]   = sourceImg->imageData[i * COL_Step + j];
            Green[i * COL + (j/3)]  = sourceImg->imageData[i * COL_Step + j + 1];
            Red[i * COL + (j/3)]    = sourceImg->imageData[i * COL_Step + j + 2];
        }
    }


    
    for(int y = 0; y < ROW; y++){
        for(int x = 0; x < COL; x++){
            int count = 0;
            
            for(int j = (y - blurRadius); j < (y + blurRadius + 1); j++){
                for(int i = (x - blurRadius); i < (x + blurRadius + 1); i++){
                    if((i < 0) || (j < 0) || (i >= COL) || (j >= ROW)){
                        Blue_Temp[count]    = 0;
                        Green_Temp[count]   = 0;
                        Red_Temp[count]     = 0;
                    }
                    else {
                        Blue_Temp[count]    = (float)Blue[j * COL + i];
                        Green_Temp[count]   = (float)Green[j * COL + i];
                        Red_Temp[count]     = (float)Red[j * COL + i];
                    }
                    count++;
                }
            }

            for(int j = 0; j < length; j++){
                for(int i = 0; i < length; i++){
                    BBB += (Blue_Temp[j * length + i] * weightArr[j * length + i]);
                    GGG += (Green_Temp[j * length + i] * weightArr[j * length + i]);
                    RRR += (Red_Temp[j * length + i] * weightArr[j * length + i]);
                }
            }
            
            Blue_Blur[y * COL + x] = (unsigned char)BBB;
            Green_Blur[y * COL + x] = (unsigned char)GGG;
            Red_Blur[y * COL + x] = (unsigned char)RRR;

            BBB = 0;
            GGG = 0;
            RRR = 0;
        }
    }
    


    for(int i = 0; i < ROW; i++){
        for(int j = 0; j < COL_Step; j = j + 3){
            outputImg->imageData[i * COL_Step + j]     = Blue_Blur[i * COL + (j/3)];
            outputImg->imageData[i * COL_Step + j + 1] = Green_Blur[i * COL + (j/3)];
            outputImg->imageData[i * COL_Step + j + 2] = Red_Blur[i * COL + (j/3)];
        }
    }
    
    //cvSaveImage("output2.jpg", outputImg, 0);
    cvShowImage("sourceImg", sourceImg);
    cvShowImage("CPU", outputImg);

    free(Blue);
    free(Green);
    free(Red);

    free(Blue_Blur);
    free(Green_Blur);
    free(Red_Blur);

    free(Blue_Temp);
    free(Green_Temp);
    free(Red_Temp);
    
    free(weightArr);
}


int main(int argc, char **argv){
    blurRadius = 1;
    sigma = 1;
    cvNamedWindow("CPU",CV_WINDOW_AUTOSIZE);
 
    createTrackbar("blurRadius:", "CPU", &blurRadius, 100, test);
    createTrackbar("sigma:", "CPU", &sigma, 100, test);

    test(0, 0);

    cvWaitKey(0);

    return 0;
}






float getWeight(int blurRadius, int sigma, int x, int y){
    //float sigma = 5.0;//(blurRadius * 2 + 1) / 2;
    float weight = (1 / (2 * PI * sigma * sigma)) * exp(-(x * x + y * y)/(2 * sigma * sigma));
    return weight;
}
void calculateWeightMatrix(float *weightArr, int blurRadius, int sigma){
    int length = blurRadius * 2 + 1;
    for(int i = 0; i < length; i++){ 
        for(int j = 0; j < length; j++){ 
            weightArr[i * length + j] = getWeight(blurRadius, sigma, j - blurRadius, blurRadius - i); 
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
            weightArr[i * length + j] = weightArr[i * length + j] / weightSum; 
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







