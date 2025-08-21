/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #4

 Demonstrates while statement

***************
 Counts the proper divisors of a number
***************
*/
#include <iostream>

using std::cin;
using std::cout;
using std::endl;

int main()
{
    unsigned n;

    cout << "N= ";
    cin >> n;

    unsigned divisor = 1;
    unsigned count = 0;

    while (divisor <= n) {
        if (n % divisor == 0) {     // for each divisor
            count += 1;             // increase the counter
        }
        /* Could be rewritten in that way also
           count += (n % divisor == 0);
           but it is dirty and unreadable
        */
        divisor += 1;
    }

    cout << "Number of divisors: " << count << endl;
    return 0;
}
