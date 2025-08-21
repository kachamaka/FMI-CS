/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #7

 Demonstrates more complex task for array

***************
Sum of all primes below N, using Erathostenes sieve.
***************
*/
#include <iostream>
#include <cassert>
using std::cin;
using std::cout;

int main ()
{
    unsigned n;
    cin >> n;

    char sieve[1024*1024] = {0};
    assert (n < sizeof(sieve));

    for (unsigned num = 2; num*num <= n; ++num) {
        if (!sieve[num]) {
            for (unsigned mark = num*num; mark <= n; mark += num) {
                sieve[mark] = 1;
            }
        }
    }

    unsigned long long sum = 2;
    for (unsigned num = 3; num <= n; num += 2) {
        if (!sieve[num]) {
            sum += num;
        }
    }

    cout << sum << "\n";

    return 0;
}
