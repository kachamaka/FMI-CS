/*
 Introduction to Programming 2020 @ FMI
 Sample task for lection #2

***************
 Read three integer numbers from the console
and print their average value
***************
*/

#include <iostream>
using namespace std;

int main()
{
    int num1, num2, num3;

    cout << "Enter numbers: ";
    cin >> num1 >> num2 >> num3;

    // При входни данни цели числа резултатът не е гарантирано цял
    float average = (num1 + num2 + num3) / 3.0;

    cout << "Avg (" << num1 << ","
         << num2 << "," << num3 << ") = "
         << average << endl;
    return 0;
}
