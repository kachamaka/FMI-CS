/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #4

 Demonstrates nested while statements

***************
 Calculates the sum of first N prime numbers;
***************
*/
#include <iostream>

using std::cin;
using std::cout;
using std::endl;

int main()
{
    int n = 0;
    do {
        cout << "n = ";
        cin >> n;

        while (!cin) {
            cin.clear();    // clear the error marker
            cin.ignore();   // ignore one symbol
            cin >> n;       // try again to read a number
        }
    } while (n < 1);


    // 2 is a prime, so add to sum and cnt
    // Also start from 3 as first prime candidate
    unsigned numberToTest = 3;
    unsigned primeCnt = 1,
             sum = 0 + 2;

    while (primeCnt < n) {
        // Check if numberToTest is a prime
        unsigned div = 3;
        while (div * div <= numberToTest) {
            if (numberToTest % div == 0) break;
            div += 2;
        }

        if (div * div > numberToTest) { // it is prime
            sum += numberToTest;
            ++primeCnt;
        }

        numberToTest += 2;  // next prime candidate
    }

    cout << "Sum = " << sum << endl;
    return 0;
}
