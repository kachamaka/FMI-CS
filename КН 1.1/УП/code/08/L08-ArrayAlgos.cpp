/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #8

 Basic algorithms for arrays.

*****************
 Minimal and maximal element;
 Insertion and removal of elements, filter;
 Sorting:
    - selection sort
    - insertion sort
    - bubble sort
 Searching:
    - linear
    - binary
    - region of equal elements
*****************
*/

#include <iostream>
#include <cstdlib>
#include <ctime>

using std::cin;
using std::cout;
using std::cerr;
using std::endl;

const int MAX_SIZE = 100;

/* Generic helper functions */
unsigned readSize();
void readArray(int array[], unsigned size);
void printArray(int array[], unsigned size);
void swap(int arr[], unsigned i, unsigned j);

// Find the minimum value in the array
int minElement(int array[], unsigned size)
{
    // First approximation
    int min = array[0];
    for (unsigned i = 1; i < size; ++i) {
        if (array[i] < min)     // there is a better value
            min = array[i];
    }
    return min;
}


// Find the index of the minimal element in the array
unsigned minIndex(int array[], unsigned size)
{
    minFrom(array, 0, size);
}


// Find the index of the minimal element in a range
unsigned minFrom(int array[], unsigned from, unsigned to)
{
    unsigned min = from;
    for (unsigned i = from + 1; i < to; ++i) {
        if (array[i] < array[min])
            min = i;
    }
    return min;
}


// Removes all negative elements in an array
// Return the size of the result array
unsigned filterNegative(int array[], unsigned size)
{
    unsigned read = 0,  // reading index
             write = 0; // writing index
    for (read = 0; read < size; ++read) {
        if (array[read] >= 0) {
            array[write] = array[read];
            ++write;
        }
    }
    return write;
}


// Insert an element into array at a given position.
// Preserves the order of the elements
// Returns true if the operation is successful
bool insertAt(int array[], unsigned position, int x, unsigned n)
{
    // Check the position for validity
    if (position > n) {
        cerr << "Bad position!" << endl;
        return false;
    }

    // shifts the elements towards the end to free the position
    for (unsigned i = n; i > position; --i)
        array[i] = array[i-1];

    // put the element at the freed position
    array[position] = x;
    return true;
}


// Insert an element into array at a given position
// Doesn't preserve the order of other elements
// Returns true if the operation is successful
bool insertAtDirect(int array[], unsigned position, int x, unsigned n)
{
    // Check the position for validity
    if (position > n) {
        cerr << "Bad position!" << endl;
        return false;
    }

    array[n] = array[position];
    array[position] = x;
    return true;
}


// Remove an element at a given position.
// Preserves the order of the elements.
// Returns true if the operation is successful
bool deleteAt(int array[], unsigned position, unsigned n)
{
    // Check the position for validity
    if (position >= n) {
        cerr << "Bad position!" << endl;
        return false;
    }

    // Shifts the elements towards beginning of the array
    for (unsigned i = position; i < n-1; ++i) {
        array[i] = array[i+1];
    }
    return true;
}


// Remove an element at a given position.
// Doesn't preserve the order of the elements.
// Returns true if the operation is successful.
bool deleteAtDirect(int array[], unsigned position, unsigned n)
{
    // Check the position for validity
    if (position >= n) {
        cerr << "Bad position!" << endl;
        return false;
    }

    array[position] = array[n-1];
    return true;
}


// Insert an element into array SORTED in ascending order.
// Keeps the array sorted
void insertSorted(int array[], int x, unsigned size)
{
    int i = size;

    // Shifts all elements, greater than X to ensure free position
    while (i > 0 && array[i-1] > x) {
        array[i] = array[i-1];
        --i;
    }

    // At the end place the element at that position
    array[i] = x;
}


// Selection sort
void selectionSort(int array[], unsigned size)
{
    for(unsigned i = 0; i < size-1; ++i) {
        int m = minFrom(array, i, size);
        swap(array, m, i);
    }
}


// Insertion sort
void insertionSort(int array[], unsigned size)
{
    for (unsigned i = 1; i < size; ++i) {
        insertSorted(array, array[i], i);
    }
}


// Bubble sort
void bubbleSort(int array[], unsigned size)
{
    bool changed = false;       // If an element was moved in the last pass
    unsigned sorted = 0;        // The number of already sorted elements
    do {
        changed = false;        // At the beginning there are no moved elements
        // Then we check all pairs of adjoining elements
        for (unsigned i = size-1; i > sorted; --i) {
            if (array[i] < array[i-1]) {    // and if there is a pair with not proper order
                swap(array, i, i-1);        // swap the elements
                changed = true;             // and mark the move
            }
        }
        ++sorted;                           // update the size of already sorted part
    } while (changed);
}


// Sequential searching for a given element
// Returns its index if the element exists or -1 otherwise
int search(int array[], int x, unsigned size)
{
    for(unsigned i = 0; i < size; ++i) {
        if (array[i] == x)
            return i;
    }
    return -1;
}


// Binary search for a given element in a SORTED array
// Returns its index if the element exists or -1 otherwise
int binarySearch(int array[], int x, unsigned size)
{
    // left and right borders of the searching range
    unsigned left = 0, right = size;

    // while the range is not empty
    while (left < right) {
        // find the middle of the range
        unsigned middle = (left + right) / 2;

        if (array[middle] == x)     // If the element is found
            return middle;          // return its index

        if (array[middle] < x)      // If current element is less than X
            left = middle + 1;      // cut the left half
        else
            right = middle;         // else cut the right half
    }
    return -1;                      // If we reach that point the element is not into the array
}


// Locate and print the range of all elements with a given value in a sorted array
// A sample application for binary search and how useful it is ;)
void findRange(int array[], int x, unsigned size)
{
    unsigned left = 0, right = size;

    while (left < right) {
        unsigned middle = (left + right) / 2;
        if (array[middle] < x)
            left = middle + 1;
        else
            right = middle;
    }
    if (array[left] != x)
        return;

    int lb = left;

    right = size;
    while (left < right) {
        unsigned middle = (left + right) / 2;
        if (array[middle] <= x)
            left = middle + 1;
        else
            right = middle;
    }
    int rb = left;

    cout << "[" << lb << ", " << rb << "]" << endl;
}

void generateArray(int array[], unsigned size, int max = RAND_MAX);

int main()
{
    //int array[MAX_SIZE];
    //unsigned n = readSize();

    //readArray(array, n);
    ////generateArray(array, n);
    //printArray(array, n);

    //n = filterNegative(array, n);
    //printArray(array, n);
    int arr[] = [12, -27676, 211621, 904304, 161270, -292822, 732004, 860511, -825806, -721722, 536428, -927571];
    selectionSort(arr, 12)

    return 0;
}


unsigned readSize()
{
    unsigned n;
    do {
        cout << "N = ";
        cin >> n;
    } while (n == 0 || n > MAX_SIZE);
    return n;
}

void readArray(int array[], unsigned size)
{
    for (unsigned i = 0; i < size; ++i) {
        cin >> array[i];
    }
}

void generateArray(int array[], unsigned size, int max)
{
	static bool inited;
	if (!inited) {
		inited = true;
		srand(time(0));
	}

    for (unsigned i = 0; i < size; ++i) {
        array[i] = rand() % max * (rand()%2 ? 1 : -1);
    }
}

void printArray(int array[], unsigned size)
{
    for (unsigned i = 0; i < size; ++i) {
        cout << array[i] << " ";
    }
    cout << endl;
}

void swap(int arr[], unsigned i, unsigned j)
{
    if (i != j) {
        int t = arr[i];
        arr[i] = arr[j];
        arr[j] = t;
    }
}
