/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #5

 Demonstrates simple functions
 and default parameters

***************
  Reads N numbers and find their sum.
  Also find the average
***************
*/

#include <iostream>
using namespace std;

/*
 * Reads count numbers from the standard input
 *and returns their sum
*/
int sumNumbers(unsigned count);

/*
 * Reads a number from the standard input
 *and ensures it is in the range [min, max)
*/
int inputN(int max, int min = 1);


/*
 * Given the sum of some numbers and their count,
 *calculates the average value
*/
double average(int sum, unsigned count);


int main()
{
    unsigned N = inputN(100);
    int sum = sumNumbers(N);

    cout << "Sum: ";
    cout << sum << endl;
    cout << "Avg: ";
    cout << average(sum, N) << endl;

    return 0;
}


double average(int sum, unsigned count)
{
    return (double)sum / count;
}

int inputN(int max, int min)
{
    int n;
    do {
        cout << "N= ";
        cin >> n;
    } while (min > n || n >= max);

    return n;
}

int sumNumbers(unsigned n)
{
    int sum = 0;
    for (unsigned i = 0; i < n; ++i) {
        sum += inputN(10000, -10000);
    }

    return sum;
}
