/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #10

 Working with memory and high-dimensional arrays

***************
   Three different ways to allocate and free memory for a matrix
***************
*/


#include <iostream>
using std::cin;
using std::cout;
using std::endl;
using std::nothrow;

void readMatrix(int ** matrix, size_t rows, size_t columns);
void printMatrix(int ** matrix, size_t rows, size_t columns);

int ** allocMatrixByRows(size_t rows, size_t columns);
void clearMatrixByRows(int ** matrix, size_t rows);

int ** allocMatrixInBlock(size_t rows, size_t columns);
void clearMatrixInBlock(int ** matrix);


/*******************************************/
const int ROW_SIZE = 10;
void readMatrixArray(int matrix[][ROW_SIZE], size_t rows, size_t columns);
void printMatrixArray(int matrix[][ROW_SIZE], size_t rows, size_t columns);
void clearMatrixAsArray(int matrix[][ROW_SIZE]);

typedef int rowType[ROW_SIZE];
rowType* allocMatrixAsArray(size_t rows);

int main()
{
    int ** m = nullptr;

    m = allocMatrixByRows(3, 4);
    if (!m) return 1;
    readMatrix(m, 3, 4);
    printMatrix(m, 3, 4);
    clearMatrixByRows(m, 3);

    m = allocMatrixInBlock(3, 4);
    if (!m) return 1;
    readMatrix(m, 3, 4);
    printMatrix(m, 3, 4);
    clearMatrixInBlock(m);


    rowType* arr = allocMatrixAsArray(3);
    if (!arr) return 1;
    readMatrixArray(arr, 3, 4);
    printMatrixArray(arr, 3, 4);
    clearMatrixAsArray(arr);

    return 0;
}


void readMatrix(int * const * const matrix, size_t rows, size_t columns)
{
    for (size_t i = 0; i < rows; ++i)
        for (size_t j = 0; j < columns; ++j)
            cin >> matrix[i][j];
}

void printMatrix(const int * const * const matrix, size_t rows, size_t columns)
{
    for (size_t i = 0; i < rows; ++i) {
        for (size_t j = 0; j < columns; ++j)
            cout << matrix[i][j] << " ";
        cout << "\n";
    }
}

/***************************/
/*  Row by row allocation  */
/***************************/
int ** allocMatrixByRows(size_t rows, size_t columns)
{
    int ** matrix = new(nothrow) int*[rows];
    if (!matrix) return matrix;

    for (size_t i = 0; i < rows; ++i) {
        matrix[i] = new(nothrow) int[columns];
        if (!matrix[i]) {
            clearMatrixByRows(matrix, i);
            return nullptr;
        }
    }

    return matrix;
}

void clearMatrixByRows(int ** matrix, size_t rows)
{
    for (size_t i = 0; i < rows; ++i)
        delete[] matrix[i];
    delete[] matrix;
}

/***************************/
/* Single block allocation */
/***************************/
int ** allocMatrixInBlock(size_t rows, size_t columns)
{
    int ** matrix = new(nothrow) int*[rows];
    if (!matrix) return matrix;

    matrix[0] = new(nothrow) int[rows*columns];
    if (!matrix[0]) {
        delete[] matrix;
        return nullptr;
    }

    for (size_t i = 1; i < rows; ++i)
        matrix[i] = matrix[i-1] + columns;

    return matrix;
}

void clearMatrixInBlock(int ** matrix)
{
    delete[] matrix[0];
    delete[] matrix;
}


/***************************/
/* Direct array allocation */
/***************************/
void readMatrixArray(int matrix[][ROW_SIZE], size_t rows, size_t columns)
{
    for (size_t i = 0; i < rows; ++i) {
        for (size_t j = 0; j < columns; ++j)
            cin >> matrix[i][j];
    }
}

void printMatrixArray(int matrix[][ROW_SIZE], size_t rows, size_t columns)
{
    for (size_t i = 0; i < rows; ++i) {
        for (size_t j = 0; j < columns; ++j)
            cout << matrix[i][j] << " ";
        cout << "\n";
    }
}

void clearMatrixAsArray(int matrix[][ROW_SIZE])
{
    delete[] matrix;
}

rowType* allocMatrixAsArray(size_t rows)
{
    rowType* matrix = new(nothrow) rowType[rows];
    return matrix;
}
