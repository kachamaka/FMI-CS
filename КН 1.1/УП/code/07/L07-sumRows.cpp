/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #7

 Demonstrates simple tasks for 2D arrays

***************
 Input a 2D array and finds the sum of elements by row and column
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

int sumArray(int arr[], size_t n)
{
    int sum = 0;
    for (size_t i = 0; i < n; ++i)
        sum += arr[i];
    return sum;
}

int sumRow(int array[][MAX_SIZE], size_t row, size_t size)
{
//    int sum = 0;
//    for (size_t i = 0; i < size; ++i)
//        sum += array[row][i];
//    return sum;
    return sumArray(array[row], size);
}

int sumCol(int array[][MAX_SIZE], size_t col, size_t size)
{
    int sum = 0;
    for (size_t i = 0; i < size; ++i)
        sum += array[i][col];

    return sum;
}

int main()
{
    size_t n, m;
    int matrix[MAX_SIZE][MAX_SIZE];

    n = readSize();
    m = readSize();
    read2DArray(matrix, n, m);

    cout << endl;
    print2DArray(matrix, n, m);

    cout << endl;
    for (size_t i = 0; i < m; ++i) {
        cout << sumCol(matrix, i, n) << "  ";
    }
    cout << endl;

    for (size_t i = 0; i < n; ++i) {
        cout << sumRow(matrix, i, m) << "  ";
    }
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
        for (size_t j = 0; j < m; ++j) {
            cout << array[i][j] << " ";
        }
        cout << endl;
    }
}
