/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #3

 Demonstrates switch statement with fall-through

***************
 Number of days in a month
***************
*/

#include <iostream>
using namespace std;

int main()
{
    unsigned month;

    cout << "month: ";
    cin >> month;

    if (!cin) {
        cout << "Please, enter a number!\n";
        return 0;
    }

    if (month < 0 || month > 12) {
        cerr << month << " Invalid user input!\n";
        return 1;
    }

    unsigned days = 0;
    switch (month) {
		default:
			days += 1;
		case 4: case 6: case 9: case 11:
			days += 2;
		case 2:
			days += 28;
    }

    cout << "days: " << days << endl;
    return 0;
}
