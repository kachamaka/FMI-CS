#include <iostream>
using std::cin;
using std::cout;
using std::nothrow;

void clearMem(int** arr, size_t size)
{
    for (size_t i = 0; i < size; ++i)
        delete[] arr[i];
    delete[] arr;
}

bool readArray(int**& array, size_t& rows, size_t& cols)
{
    cin >> rows;
    cin >> cols;
    array = new(nothrow) int*[rows];
    if (array){
        for (size_t i = 0; i < rows; ++i){
            array[i] = new(nothrow) int[cols];
            if (array[i]) {
                for (int j = 0; j < cols; ++j)
                    cin >> array[i][j];
            }
            else {
                clearMem(array, i);
                array = nullptr;
                break;
            }
        }
    }
    return array != nullptr;
}

size_t countElems(const int* const array, size_t len, int k)
{
    size_t l = 0;
    for (size_t i = 0; i < len; ++i) {
        l += array[i] % k == 0;
    }
    return l;
}

bool transformArr(const int*const*const array, size_t rows, size_t cols,
                  int K,
                  int**& resultArr, size_t& resRows, size_t*& columnLen)
{
    resRows = 0;
    for (size_t i = 0; i < rows; ++i) {
        if (countElems(array[i], cols, K)) {
            ++resRows;
        }
    }
    if (!resRows) {
        resultArr = nullptr;
        return true;
    }

    resultArr = new(nothrow) int*[resRows];
    columnLen = new(nothrow) size_t[resRows];
    if (!resultArr || !columnLen) {
        delete[] resultArr;
        delete[] columnLen;
        return false;
    }

    resRows = 0;
    for (size_t i = 0; i < rows; ++i) {
        size_t len = countElems(array[i], cols, K);
        if (len) {
            resultArr[resRows] = new(nothrow) int[len];
            if (!resultArr[resRows]) {
                clearMem(resultArr, resRows);
                delete[] columnLen;
                return false;
            }
            len = 0;
            for (size_t j = 0; j < cols; ++j){
                if (array[i][j]%K == 0) {
                    resultArr[resRows][len++] = array[i][j];
                }
            }
            columnLen[resRows++] = len;
        }
    }
    return true;
}

void printArr(const int*const*const array, size_t rows, const size_t* colLens)
{
    for (size_t i = 0; i < rows; ++i) {
        for (size_t j = 0; j < colLens[i]; ++j) {
            cout << array[i][j] << " ";
        }
        cout << "\n";
    }
}

int main()
{
    int** array;
    size_t rows, cols;
    if (readArray(array, rows, cols)) {
        int k;
        cin >> k;
        if (k == 0) {
            cout << "Bad data!";
        }
        else {
            int** result;
            size_t r_rows;
            size_t* r_cols;

            if (transformArr(array, rows, cols, k,
                             result, r_rows, r_cols)) {
                printArr(result, r_rows, r_cols);
                clearMem(result, r_rows);
                delete[] r_cols;
            }
        }
        clearMem(array, rows);
    }
    return 0;
}
