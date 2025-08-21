/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #5

 Demonstrates nesting for statements

***************
 Print a number triangle
***************
*/
#include <iostream>

using namespace std;

int main()
{
    int n;
    const int spacing = 3;
    const int maxNumber = 100;

    do {
        cout << "n= ";
        cin >> n;
    }while (n < 1 || n >= maxNumber);

    for (int row = 1; row <= n; ++row) {
        //Prints one row of the triangle - it is built from several components:

        //Leading spaces
        for (int i = 0; i < n - row; ++i) {
            cout.width(spacing);
            cout << ' ';
        }

        //Increasing sequence
        for (int num = 1; num < row; ++num) {
            cout.width(spacing);
            cout << num;
        }

        //Decreasing sequence
        for (int num = row; num > 0; --num) {
            cout.width(spacing);
            cout << num;
        }
        cout << endl;
    }
    return 0;
}
