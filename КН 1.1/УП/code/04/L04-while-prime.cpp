/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #4

 Demonstrates while statement

***************
 Checks if a number is prime
***************
*/
#include <iostream>
#include <cmath>

using std::cin;
using std::cout;
using std::endl;

int main()
{
    unsigned n;

    cout << "N= ";
    cin >> n

//    n = 2147483647;

    unsigned divisor = 2;

    while (divisor < n) {
        if (n % divisor == 0) {
            break;
        }
        ++divisor;
    }

    if (divisor == n) {
        cout << "Prime" << endl;
    } else {
        cout << "Not prime" << endl;
    }
    return 0;
}











/*
// A better approach

int main()
{
    unsigned n = 2147483647;

    unsigned divisor = 3;
	bool isPrime = true;
    if (n % 2 != 0) {   // n is odd
        while (divisor*divisor <= n) {
            if (n % divisor == 0) {
				isPrime = false;
                break;
            }
            divisor += 2;
        }

        if (isPrime) {
            cout << "prime" << endl;
        } else {
            cout << "Not prime" << endl;
        }
    }
    else {              // N is even
        cout << "Not prime" << endl;
    }
    return 0;
}
*/
