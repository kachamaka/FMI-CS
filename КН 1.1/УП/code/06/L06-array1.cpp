/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #6

 Demonstrates simple tasks for arrays
***************
 Read an array and print it in reverse order
 Find the minimal element in array
 Find the index of minimal element with given property
***************
*/

#include <iostream>
using std::cin;
using std::cout;
using std::endl;

// Prints the array in reverse order
void printRev(int arr[], unsigned n);

// The minimal element in array
int minimum(int array[], unsigned size);

// The index of the smallest even element
int minEvenIndex(int array[], unsigned size);

// The average of all elements in an array
double avg(int array[], unsigned size);

int minBelowAvg(int array[], unsigned size);

int main()
{
    const unsigned MAX_SIZE = 200;

    unsigned n;
    int array[MAX_SIZE];

    do {
        cout << "N= ";
        cin >> n;
    } while (n == 0 || n > MAX_SIZE);

    for (unsigned i = 0; i < n; ++i) {
//        cout << "a[" << i << "]=";
        cin >> array[i];
    }

//    int sum = 0;
//    for (unsigned i = 0; i < n; ++i)
//        sum += array[i];
//    cout << "Sum = " << sum << endl;

    for (unsigned i = 0; i < n; ++i) {
        cout << array[i] << " ";
    }
    cout << endl;

//    printRev(array, n);

//    int min = minimum(array, n);
//    cout << min << endl;

//    int minIndex = minEvenIndex(array, n);
//    if (minIndex < 0) {
//        cout << "No even nums!\n";
//    }
//    else {
//        array[minIndex] *= 2;
//        printRev(array, n);
//    }

    cout << minBelowAvg(array, n) << endl; //!?!?!?

    return 0;
}

void printRev(int arr[], unsigned n)
{
    //Note the type (int). It is important
    for (int i = n-1; i >= 0; --i) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int minimum(int array[], unsigned size)
{
    int min = array[0];
    for (unsigned i = 1; i < size; ++i) {
        if (min > array[i]) {
            min = array[i];
        }
    }
    return min;
}

int minEvenIndex(int array[], unsigned size)
{
    int min = -1;
    unsigned i;

    for (i = 0; i < size; ++i) {
        if (array[i] % 2 == 0) {
            min = i;
            break;
        }
    }

    for (++i; i < size; ++i) {
        if (array[i] % 2 == 0 && array[min] > array[i]) {
            min = i;
        }
    }
    return min;
}

double avg(int array[], unsigned size)
{
    double sum = 0;

    for (unsigned i = 0; i < size; ++i) {
        sum += array[i];
    }

    return sum / size; // NaN if size is 0
}

int minBelowAvg(int array[], unsigned size)
{
    if (size == 0) {
        return -1;
    }

    double arrayAvg = avg(array, size);

    unsigned minIndex = 0;
    while (minIndex < size &&
           array[minIndex] >= arrayAvg) {
        ++minIndex;
    }

    for (unsigned i = minIndex + 1; i < size; ++i) {
        if (array[i] < arrayAvg && array[i] < array[minIndex]) {
            minIndex = i;
        }
    }

    return minIndex < size ? minIndex : -1;
}
