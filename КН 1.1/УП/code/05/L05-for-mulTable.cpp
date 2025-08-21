/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #5

 Demonstrates for statement

***************
 Print the multiplication table
***************
*/
#include <iostream>

using namespace std;

int main()
{
    const int limit = 10;
    //Table header
    cout << "*| ";
    for (int i = 1; i < limit; ++i) {
        cout << "\t" << i;
    }
    cout << endl;

    //Separator line
    cout << "--";
    for (int i = 1; i < limit; ++i) {
        cout << "--------";
    }
    cout << endl;

    //And the table row by row
    for (int a = 1; a < limit; ++a) {
        cout << a << "| ";
        for (int b = 1; b < limit; ++b) {
            cout << "\t" << a*b;
        }
        cout << endl;
    }
    return 0;
}
