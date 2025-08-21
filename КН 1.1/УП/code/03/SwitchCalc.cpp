/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #3

 Demonstrates switch statement

***************
 Sample integer calculator
***************
*/

#include <iostream>
using namespace std;

int main()
{
    int x, y;
    char operation; // one of +, -, *, / or %

    cout << "X = ";
    cin >> x;
    cout << "Y = ";
    cin >> y;

    cout << "Operation: ";
    cin >> operation;

    int result;
    switch(operation) {
		case '+':
		{
			result = x+y;
			break;
		}
		case '-':
		{
			result = x-y;
			break;
		}
		case '*':
		{
			result = x*y;
			break;
		}
		case '/':
		{
			if (y != ) {       // Do not forget to handle zero division case!
				result = x/y;
			}
			else {
				cerr << "Can not divide by 0!\n";
				return 1;
			}
			break;
		}
		case '%':
		{
			if (y != 0) {        // Do not forget to handle zero division case!
				result = x%y;
			}
			else {
				cerr << "Can not divide by 0!\n";
				return 1;
			}
			break;
		}
		default:
		{
			cerr << "Unknown operation!\n";
			return 2;
		}
    }

    cout << x << operation << y << '=' << result << endl;
    return 0;
}
