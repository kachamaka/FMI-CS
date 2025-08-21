/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #7

 Demonstrates simple tasks for 2D arrays

***************
 Prints a matrix by in a diagonal way
***************
*/


#include <iostream>
using std::cin;
using std::cout;
using std::endl;

const size_t MAX_SIZE = 100;

size_t readSize();
void printArray(int array[], size_t size);
void read2DArray(int array[][MAX_SIZE], size_t n, size_t m);
void print2DArray(int array[][MAX_SIZE], size_t n, size_t m);

void printDiag(int array[][MAX_SIZE], size_t n, size_t m)
{
    for (int diag = -(int)(n-1); diag < (int)m; ++diag) {
        for (int row = 0; row < n; row++) {
            int col = diag + row;
            if (col >= 0 && col < m)
                cout << array[row][col] << " ";
        }
        cout << endl;
    }
}


int main()
{
    unsigned n, m;
    int matrix[MAX_SIZE][MAX_SIZE];

    n = readSize();
    m = readSize();
    read2DArray(matrix, n, m);

    cout << endl;
	print2DArray(matrix, n, m);

    printDiag(matrix, n, m);
    cout << endl;
    return 0;
}


size_t readSize()
{
    size_t n;
    do {
        cout << "N= ";
        cin >> n;
    } while (n == 0 || n > MAX_SIZE);
    return n;
}

void read2DArray(int array[][MAX_SIZE], size_t n, size_t m)
{
    for (size_t i = 0; i < n; ++i) {
        for (size_t j = 0; j < m; ++j) {
            cin >> array[i][j];
        }
    }
}

void print2DArray(int array[][MAX_SIZE], size_t n, size_t m)
{
    for (size_t i = 0; i < n; ++i) {
        printArray(array[i], m);
    }
}

void printArray(int array[], size_t size)
{
    for (unsigned i = 0; i < size; ++i) {
        cout << array[i] << " ";
    }
    cout << endl;
}