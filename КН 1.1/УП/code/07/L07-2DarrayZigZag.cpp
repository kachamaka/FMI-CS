/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #7

 Demonstrates simple tasks for 2D arrays

***************
 Input a 2D array and prints it in a Zig-Zag way
***************
*/

#include <iostream>
using std::cin;
using std::cout;
using std::endl;

const size_t MAX_SIZE = 100;

size_t readSize();
void read2DArray(int array[][MAX_SIZE], size_t n, size_t m);
void print2DArray(int array[][MAX_SIZE], size_t n, size_t m);

// Prints an array from left to right or in opposite direction
//depending on the value of ltr parameter
void printArray(int array[], size_t size, bool ltr = true);

void printZigZag(int array[][MAX_SIZE], size_t n, size_t m)
{
    for (size_t i = 0; i < n; ++i) {
        printArray(array[i], m, i%2 == 0);
    }
}


int main()
{
    size_t n, m;
    int matrix[MAX_SIZE][MAX_SIZE];

    n = readSize();
    m = readSize();
    read2DArray(matrix, n, m);

    print2DArray(matrix, n, m);
    cout << endl;

    printZigZag(matrix, n, m);
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

void printArray(int array[], size_t size, bool ltr)
{
    if (ltr) {
        for (size_t i = 0; i < size; ++i) {
            cout << array[i] << " ";
        }
    }
    else {
        for (int i = size-1; i >= 0; --i) {
            cout << array[i] << " ";
        }
    }
    cout << endl;
}
