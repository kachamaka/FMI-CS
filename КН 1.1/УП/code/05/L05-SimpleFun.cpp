/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #5

 Demonstrates sample functions

***************
 Minimum of two numbers
***************
*/

#include <iostream>
using namespace std;

int min(int a, int b)
{
    if (a < b) {
        return a;
    }
    return b;
}


int main()
{
    int x, y;
    cin >> x >> y;
    cout << min (x, y);

    return 0;
}
