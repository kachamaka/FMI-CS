/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #7

 Demonstrates simple tasks for 2D arrays

***************
 Input a 2D array and prints the sum of elements over the main diagonal
***************
*/

#include <iostream>
using std::cin;
using std::cout;
using std::endl;

const size_t MAX_SIZE = 100;

static size_t readSize();
static void   read2DArray(int array[][MAX_SIZE], size_t n, size_t m);
static void   print2DArray(int array[][MAX_SIZE], size_t n, size_t m);
static int    sumRow(int array[], size_t size);

void printMainDiag(int array[][MAX_SIZE], size_t n, size_t m)
{
    size_t min = n<m ? n : m;
    for (size_t i = 0; i < min; ++i) // i < n && i < m
        cout << array[i][i] << ' ';
    cout << endl;
}

int sumToMD(int array[][MAX_SIZE], size_t n, size_t m)
{
    int sum = 0;
    for (size_t i = 0; i < n; ++i) {
        sum += sumRow(array[i], std::min(i, m));
    }
    return sum;
}

int sumOverMD(int array[][MAX_SIZE], size_t n, size_t m)
{
    int sum = 0;
    for (size_t i = 0; i < n; ++i) {
        for (size_t j = i+1; j < m; ++j) {
            sum += array[i][j];
        }
    }
    return sum;
}

int sumOverSD(int array[][MAX_SIZE], size_t n, size_t m)
{
    int sum = 0;
    int min = std::min(n, m);
    for (size_t row = 0; row < min; ++row) {
        sum += sumRow(array[row], m-row-1);
    }
    return sum;
}

int sumToSD(int array[][MAX_SIZE], size_t n, size_t m)
{
    int sum = 0;
    int min = std::min(n, m);
    for (size_t i = 1; i < min; ++i) {
        for (size_t j = m-i; j < m; ++j)
            sum += array[i][j];
    }
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
    printMainDiag(matrix, n, m);

	cout << sumToMD(matrix, n, m) << endl;
    cout << endl;
    cout << sumToSD(matrix, n, m) << endl;   
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

int sumRow(int array[], size_t size)
{
    int sum = 0;
    for (size_t i = 0; i < size; ++i) {
        sum += array[i];
    }
    return sum;
}

