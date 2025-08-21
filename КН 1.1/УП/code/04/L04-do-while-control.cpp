/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #4

 Demonstrates do-while statement

***************
Checks if a number is prime
***************
*/
#include <iostream>

using std::cin;
using std::cout;

int main()
{
    int number;
    do {
        cout << "Number = ";
        cin >> number;
    } while (number <= 1);

    int divisor = 2;
    do {
        if (number % divisor == 0) break;
        ++divisor;
    } while (divisor*divisor <= number);

    cout << "The number is "
         << (number % divisor ? "" : "not ")
         << "prime \n";
    return 0;
}
