/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #7

 Demonstrates simple tasks for 2D arrays

***************
 Multiply two matrices
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

/*
 Multiplies the matrix m1 with dimension NxM by the matrix m2 with dimension MxK.
 The result is in the matrix result, with dimension NxK
*/
void multMatrix(int m1[][MAX_SIZE], int m2[][MAX_SIZE],  // Input matrices
				int result[][MAX_SIZE],					 // Result matrix
				size_t n, size_t m, size_t k)		     // dimentions
{
	for (size_t i = 0; i < n; ++i) {
		for (size_t j = 0; j < k; ++j) {
			result[i][j] = 0;
			for (size_t internal = 0; internal < m; ++internal) {
				result[i][j] += m1[i][internal] * m2[internal][j];
			}
		}
	}
}

int main()
{
	int a[MAX_SIZE][MAX_SIZE],
		b[MAX_SIZE][MAX_SIZE],
		c[MAX_SIZE][MAX_SIZE];

	unsigned n = readSize(),
			 m = readSize(),
			 k = readSize();

	read2DArray(a, n, m);
	read2DArray(b, m, k);
	multMatrix(a, b, c, n, m, k);

	cout << '\n';
	print2DArray(a, n, m);
	cout << " multiplied by \n";
	print2DArray(b, m, k);
	cout << " equals \n";
	print2DArray(c, n, k);

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

static void printArray(int array[], size_t size)
{
    for (size_t i = 0; i < size; ++i) {
        cout << array[i] << " ";
    }
    cout << endl;
}

void print2DArray(int array[][MAX_SIZE], size_t n, size_t m)
{
    for (size_t i = 0; i < n; ++i) {
        printArray(array[i], m);
    }
}
