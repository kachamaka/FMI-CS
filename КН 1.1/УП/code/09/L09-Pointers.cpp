/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #9

 Pointers and memory

***************
 Working with pointers and arrays
 Pointers and output function arguments
 A basic example on dynamic memory
***************
*/

#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

const int MAX_SIZE = 100;

static unsigned readSize();

// Reads an array data from the stdin
void readArray(int* array, unsigned size)
{
    for (unsigned i = 0; i < size; ++i) {
        cin >> array[i];
    }
}

// Generates random content of an array
void generateArray(int* array, unsigned size, int max = RAND_MAX)
{
    static bool initialized = false;
    if (!initialized) {
		initialized = true;
		srand(time(0));
	}

    for (unsigned i = 0; i < size; ++i) {
        array[i] = rand() % max * (rand()%2 ? 1 : -1);
    }
    for (unsigned i = 0; i < size; ++i) {
        array[i] = rand() % 1000;
    }
}

// Prints the array on the stdout
// Note the const modifier!
void printArray(const int* array, unsigned size)
{
    for (unsigned i = 0; i < size; ++i) {
        cout << array[i] << " ";
    }
    cout << endl;
}

// Swap values of two numbers, passed by address
static void swap(int* a, int* b)
{
    int t = *a;
    *a = *b;
    *b = t;
}

// Find the minimal element in an array
// Returns pointer to that element
const int* minElement(const int* array, unsigned size)
{
    const int* min = array;
    for (unsigned i = 1; i < size; ++i) {
        if (array[i] < *min)
            min = array + i;
    }
    return min;
}

// Selection sort.
// A simple and short implementation, using pointers
void selectionSort(int* array, unsigned size)
{
    for(unsigned i = 0; i < size-1; ++i) {
        // Note the address arithmetic. Why it is needed?
        // Can we use something like this:
        //swap(array+i, minElement(array+i, size-i));
        swap(array+i, array+(minElement(array+i, size-i)-array));
    }
}


// Finds the minimum and maximum values in an array.
// As that function returns two values, they are returned by arguments
// This arguments are passed as pointers, but they are pointers itself...
// so we get double pointers ;)
void minMaxPtr(int* arr, unsigned size, int** min, int** max)
{
    *min = arr;  // Initialize both pointers to point to the first element
    *max = arr;

    // Use address arithmetics to determine the end of the array
    for (int* end = arr+size; arr < end; ++arr) {
        if (*arr < **min) *min = arr;  // If we find better value, redirect the pointers to it
        if (*arr > **max) *max = arr;
    }
}


// Find the minimal and maximal values in an array
// Both values are returned through arguments - by address
void minMax(int* arr, unsigned size, int* min, int* max)
{
    // Will use previous function, so we use two pointers
    int *minPtr, *maxPtr;
    // and call the function
    minMaxPtr(arr, size, &minPtr, &maxPtr);

    // extract the values to the arguments
    *min = *minPtr;
    *max = *maxPtr;
}

// Sample function, that demonstrates proper usage of dynamic memory allocation
void filterArray();


int main()
{
/*
    int array[MAX_SIZE];
    unsigned n = readSize();

    generateArray(array, n);
    printArray(array, n);

    int min, max;
    minMax(array, n, &min, &max);
    cout << min << endl << max << endl;

    selectionSort(array, n);

    printArray(array, n);
*/
    filterArray();
    return 0;
}


// Reads size of an array from the stdin,
//allocates array, fills it with random data and return a pointer to it
static int* readArrayDynamic(unsigned * size)
{
   unsigned n;
   cin >> n;

   int * arr = new(nothrow) int[n];
   if (!arr) {
       return nullptr;
   }

   generateArray(arr, n);
   *size = n;
   return arr;
}

static void pause()
{
    cin.sync();
    cout << "... press enter to continue ...";
    cin.get();
}

// Generate a random array in the dynamic memory
// Then extracts only even elements into new allocated array.
void filterArray()
{
    unsigned n;
    int* data = readArrayDynamic(&n);       // generate the initial array
    if (!data) {                            // Mandatory check!
        cerr << "No memory!" << endl;
        return;
    }

    //printArray(data, n);
    cout << "--- Check the memory with initial array ---\n";
    pause();                            // Take a look at the memory at that point

    // count the even elements, again with pointers
    int cnt = 0;
    for (int* iter = data; iter < data + n; ++iter)
        if (*iter % 2 == 0)
            ++cnt;

    // allocate memory only for the even elements
    int* result = new(nothrow) int[cnt];
    if (!result) {        // mandatory check
        delete[] data;    // If something goes wrong, clean the previously allocated memory
        cerr << "No memory for copy!" << endl;
        return;
    }

    // Copy all even elements using pointers
    // one for reading and one to write
    for (int *read = data, *write = result; read < data + n; ++read)
        if (*read % 2 == 0)
            *write++ = *read;       // * is with higher priority than ++ !

    cout << "--- Check the memory with both arrays ---\n";
    pause();                            // Take a look at the memory at that point

    delete[] data;       // Clean the initial array, as we do not need it any more

    //printArray(data, cnt);
    cout << "--- Check the memory with result ---\n";
    pause();                            // Take a look at the memory at that point

    delete[] result;                    // final clean up

    cout << "--- Check the memory at the end ---\n";
    pause();                            // Take a look at the memory at that point
}

static unsigned readSize()
{
    unsigned n;
    do {
        cout << "N= ";
        cin >> n;
    } while (n == 0 || n > MAX_SIZE);
    return n;
}
