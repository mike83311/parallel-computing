#include "opencv/cv.h"
#include "opencv/highgui.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define PI 3.14159265358979323846


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



    struct timespec t_start, t_end;
    double elapsedTime;

    int blurRadius = atoi(argv[2]);
    float sigma = atof(argv[3]);
    int length = blurRadius * 2 + 1;
    float *weightArr = (float *)malloc((blurRadius * 2 + 1) * (blurRadius * 2 + 1) * sizeof(float));

    calculateWeightMatrix(weightArr, blurRadius, sigma);
    // printArray(weightArr, length, length);
    getFinalWeightMatrix(weightArr, blurRadius);
    // printArray(weightArr, length, length);


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
    

    // float *Blue_Temp    = (float *)malloc(length * length * sizeof(float));
    // float *Green_Temp   = (float *)malloc(length * length * sizeof(float));
    // float *Red_Temp     = (float *)malloc(length * length * sizeof(float));


    float BBB = 0;
    float GGG = 0;
    float RRR = 0;


    // 
    for(int i = 0; i < ROW; i++){
        for(int j = 0; j < COL_Step; j = j + 3){
            Blue[i * COL + (j/3)]   = sourceImg->imageData[i * COL_Step + j];
            Green[i * COL + (j/3)]  = sourceImg->imageData[i * COL_Step + j + 1];
            Red[i * COL + (j/3)]    = sourceImg->imageData[i * COL_Step + j + 2];
        }
    }



    clock_gettime(CLOCK_REALTIME, &t_start);

    for(int y = 0; y < ROW; y++){
        for(int x = 0; x < COL; x++){
            int count = 0;

            for(int j = 0; j < length; j++){
                for(int i = 0; i < length; i++){
                    if(((y - blurRadius + j) < 0) || ((x - blurRadius + i) < 0) || ((y - blurRadius + j) >= ROW) || ((x - blurRadius + i) >= COL)){
                        // do nothing
                    }
                    else {
                        BBB += ((float)Blue[(y - blurRadius + j) * COL + (x - blurRadius + i)] * weightArr[j * length + i]);
                        GGG += ((float)Green[(y - blurRadius + j) * COL + (x - blurRadius + i)] * weightArr[j * length + i]);
                        RRR += ((float)Red[(y - blurRadius + j) * COL + (x - blurRadius + i)] * weightArr[j * length + i]);
                    }
                }
            }
            
            // for(int j = (y - blurRadius); j < (y + blurRadius + 1); j++){
            //     for(int i = (x - blurRadius); i < (x + blurRadius + 1); i++){
            //         if((i < 0) || (j < 0) || (i >= COL) || (j >= ROW)){
            //             Blue_Temp[count]    = 0;
            //             Green_Temp[count]   = 0;
            //             Red_Temp[count]     = 0;
            //         }
            //         else {
            //             Blue_Temp[count]    = (float)Blue[j * COL + i];
            //             Green_Temp[count]   = (float)Green[j * COL + i];
            //             Red_Temp[count]     = (float)Red[j * COL + i];
            //         }
            //         count++;
            //     }
            // }


            // for(int j = 0; j < length; j++){
            //     for(int i = 0; i < length; i++){
            //         BBB += (Blue_Temp[j * length + i] * weightArr[j * length + i]);
            //         GGG += (Green_Temp[j * length + i] * weightArr[j * length + i]);
            //         RRR += (Red_Temp[j * length + i] * weightArr[j * length + i]);
            //     }
            // }
            

            Blue_Blur[y * COL + x] = (unsigned char)BBB;
            Green_Blur[y * COL + x] = (unsigned char)GGG;
            Red_Blur[y * COL + x] = (unsigned char)RRR;

            BBB = 0;
            GGG = 0;
            RRR = 0;
        }
    }

    // stop time
    clock_gettime(CLOCK_REALTIME, &t_end);

    // compute and print the elapsed time in millisec
    elapsedTime = (t_end.tv_sec - t_start.tv_sec) * 1000.0;
    elapsedTime += (t_end.tv_nsec - t_start.tv_nsec) / 1000000.0;

    printf("%lf ms\n", elapsedTime);



    // Set BGR To Output Image
    for(int i = 0; i < ROW; i++){
        for(int j = 0; j < COL_Step; j = j + 3){
            outputImg->imageData[i * COL_Step + j]     = Blue_Blur[i * COL + (j/3)];
            outputImg->imageData[i * COL_Step + j + 1] = Green_Blur[i * COL + (j/3)];
            outputImg->imageData[i * COL_Step + j + 2] = Red_Blur[i * COL + (j/3)];
        }
    }
    
    // cvSaveImage("output1.jpg", outputImg, 0);
    // cvSaveImage("output2.jpg", outputImg, 0);
    cvShowImage("sourceImg", sourceImg);
    cvShowImage("CPU", outputImg);
    
    cvWaitKey(0);
    
    cvDestroyWindow("sourceImg");
    cvReleaseImage(&sourceImg);
    cvDestroyWindow("CPU");
    cvReleaseImage(&outputImg);
    
    
    free(Blue);
    free(Green);
    free(Red);

    free(Green_Blur);
    free(Blue_Blur);
    free(Red_Blur);
    
    // free(Blue_Temp);
    // free(Green_Temp);
    // free(Red_Temp);

    free(weightArr);


    return 0;
}





float getWeight(int blurRadius, float sigma, int x, int y){
    float weight = (1 / (2 * PI * sigma * sigma)) * exp(-(x * x + y * y)/(2 * sigma * sigma));
    return weight;
}

void calculateWeightMatrix(float *weightArr, int blurRadius, float sigma){
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







