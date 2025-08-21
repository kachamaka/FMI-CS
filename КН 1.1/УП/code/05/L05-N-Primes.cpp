/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #5

 Demonstrates functions: default parameters and
 different types of parameter passing

***************
 Print first N prime numbers
***************
*/

#include <iostream>
using namespace std;

bool isPrime(unsigned n)
{
    // The smallest prime is 2
    if (n < 2) {
        return false;
    }

    // Two is the only even prime
    if (n % 2 == 0) {
        return n == 2;
    }

    // Check only odd divisors
    for (int div = 3; div*div <= n; div += 2) {
        if (n % div == 0) {
            return false;
        }
    }

    return true;
}

void nPrimes(int n)
{
    int num = 1;
    int count = 0;

    while (count < n) {
        if (isPrime(num)) {
            cout << count+1 << " : " << num << endl;
            ++count;
        }
        ++num;
    }
}

void swap (int& a, int& b)
{
    int t = a;
    a = b;
    b = t;
}

int input(int max, int min = 1)
{
    int n;

    if (max < min) {
        swap (max, min);
    }

    do {
        cout << "n= ";
        cin >> n;
    } while (n < min || n > max);

    return n;
}

int main()
{
    nPrimes(input(1000));

    return 0;
}
