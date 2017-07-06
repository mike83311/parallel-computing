#include <cv.h>
#include <highgui.h>
#include <stdio.h>
 
//using namespace cv;
 
// Image Size: 600x800
uchar Blue[800][600];
uchar Green[800][600];
uchar Red[800][600];
uchar Gray[800][600];
 
int lowRed;
int const max_lowRed = 100;
 
int lowGreen;
int const max_lowGreen = 100;
 
int lowBlue;
int const max_lowBlue = 100;
 
int lowThreshold;
int const max_lowThreshold = 255;
 
const char* window_name = "Binary Map";
 
IplImage *ImageOriginal;
IplImage *ImageGray;
IplImage *ImageBinary;
 
void test(int, void*)
{
    ImageGray = cvLoadImage("fang.jpg",CV_LOAD_IMAGE_COLOR);
    ImageBinary = cvLoadImage("fang.jpg",CV_LOAD_IMAGE_COLOR);
 
    /* Load Image RGB Values */
    for(int i=0;i<ImageOriginal->height;i++){
        for(int j=0;j<ImageOriginal->widthStep;j=j+3){
            Blue[i][(int)(j/3)]=ImageOriginal->imageData[i*ImageOriginal->widthStep+j];
            Green[i][(int)(j/3)]=ImageOriginal->imageData[i*ImageOriginal->widthStep+j+1];
            Red[i][(int)(j/3)]=ImageOriginal->imageData[i*ImageOriginal->widthStep+j+2];
        }
    }
    /* Implement Algorithms */
    for(int i=0;i<ImageOriginal->height;i++){
        for(int j=0;j<ImageOriginal->width;j++){
            Gray[i][j]=(uchar)(lowRed*0.01*Red[i][j] + lowGreen*0.01*Green[i][j] + lowBlue*0.01*Blue[i][j]);
            Red[i][j]=Gray[i][j];
            Green[i][j]=Gray[i][j];
            Blue[i][j]=Gray[i][j];
        }
    }
    /* Save Image RGB Values */
    for(int i=0;i<ImageGray->height;i++){
        for(int j=0;j<ImageGray->widthStep;j=j+3){
            ImageGray->imageData[i*ImageGray->widthStep+j]=Blue[i][(int)(j/3)];
            ImageGray->imageData[i*ImageGray->widthStep+j+1]=Green[i][(int)(j/3)];
            ImageGray->imageData[i*ImageGray->widthStep+j+2]=Red[i][(int)(j/3)];
        }
    }
 
    cvThreshold(ImageGray, ImageBinary, lowThreshold, 255, THRESH_BINARY);
 
    cvSaveImage("HappyImage.jpg",ImageBinary);
    cvShowImage(window_name,ImageBinary);
 
    cvShowImage("Gray Image",ImageGray);
}
 
int main(){
    ImageOriginal = cvLoadImage("fang.jpg",CV_LOAD_IMAGE_COLOR);
 
    lowThreshold = 128;
 
    cvNamedWindow(window_name,CV_WINDOW_AUTOSIZE);
 
    createTrackbar("Red:", window_name, &lowRed, max_lowRed, test);
    createTrackbar("Green:", window_name, &lowGreen, max_lowGreen, test);
    createTrackbar("Blue:", window_name, &lowBlue, max_lowBlue, test);
    createTrackbar("Threshold:", window_name, &lowThreshold, max_lowThreshold, test);
 
    test(0, 0);
 
    waitKey(0);
 
    return EXIT_SUCCESS;
}