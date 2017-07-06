#include <stdio.h>
#include <stdlib.h>

#define ROW_M 4
#define COL_M 3
#define ROW_N 3
#define COL_N 2
#define ROW_MxN ROW_M
#define COL_MxN COL_N

void printTwoDimDynamicArray(float *Array, const int col, const int row) {
	int x, y;
	for(y = 0; y != row; ++y) {
		for(x = 0; x != col; ++x)
			printf("%f ", Array[y*col + x]);
			
		printf("\n");      
	}
}

int main(){
	int x, y;
	int i, j;
	
	float *M = (float *)malloc(ROW_M * COL_M * sizeof(float));

    float *N = (float *)malloc(ROW_N * COL_N * sizeof(float));
    
    float *MxN = (float *)malloc(ROW_MxN * COL_MxN * sizeof(float));
    
    for (int i = 0; i < ROW_M; ++i) {
        for (int j = 0; j < COL_M; ++j) {
            M[i*COL_M + j] = rand() % 5;
        }
    }
    for (int i = 0; i < ROW_N; ++i) {
        for (int j = 0; j < COL_N; ++j) {
            N[i*COL_N + j] = rand() % 5;
        }
    }
	printf("%d %d\n", ROW_MxN, COL_MxN);
	printTwoDimDynamicArray(M, COL_M, ROW_M);
	printf("============================\n");
	printTwoDimDynamicArray(N, COL_N, ROW_N);
	printf("============================\n");

	/*
	for (int i = 0; i < ROW_M; ++i) {
        for (int j = 0; j < COL_N; ++j) {
            for (int k = 0; k < COL_M; ++k) {
                *(MxN + i*COL_N + j) += *(M + i*COL_M + k) * *(N + k*COL_N + j);
            }
        }
    }
    */

    for (int i = 0; i < ROW_M; ++i) {
        for (int j = 0; j < COL_N; ++j) {
            for (int k = 0; k < COL_M; ++k) {
                MxN[i*COL_N + j] += M[i*COL_M + k] * N[k*COL_N + j];
            }
        }
    }

    printTwoDimDynamicArray(MxN, COL_N, ROW_M);

	/*
	for(y = 0; y != row; ++y) {
		for(x = 0; x != col; ++x)
			Array[y][x] = y + x;
	}
	*/

	//printTwoDimDynamicArray(Array, col, row);
	
	//free(Array);
	free(M);
	free(N);
	free(MxN);

}




