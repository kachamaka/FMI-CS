/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #3

 Demonstrates if statement

***************
 Solves quadratic equation
***************
*/

#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    const double EPS = 1.0/(1<<30);  // Comparison error threshold

    double a, b, c;
    /* Data input */
    cout << "a = ";
    cin >> a;

    cout << "b = ";
    cin >> b;

    cout << "c = ";
    cin >> c;

    if (abs(a) < EPS) {           // The equation is not quadratic
        if (abs(b) < EPS) {       // The statement doesn't depend on X
            if (abs(c) < EPS) {   // it is trivial 0
                cout << "All numbers are solutions." << endl;
            }
            else {                // invalid statement
                cout << "No solution." << endl;
            }
        }
        else {                    // linear equation
            double X = -c/b;
            cout << "The equation " << b << "x + " << c << " = 0"
                 << " has single root: " << X << endl;
        }
    }
    else {                        // quadratic equation
        double D = b*b - 4*a*c;
        if (D < 0) {              // negative discriminant
            cout << "The equation has no real roots!" << endl;
        }
        else if (D > 0) {         // positive discriminant
            double X1, X2;
            X1 = (-b + sqrt(D)) / (2*a);
            X2 = -X1 - b/a;       // Vieta's formula
            cout << "The equation " << a << "x^2 + " << b << "x + " << c << " = 0"
                 << " has two roots: " << X1 << " and " << X2 << endl;
        }
        else {                    // zero discriminant
            double X = -b / (2*a);
            cout << "The equation " << a << "x^2 + " << b << "x + " << c << " = 0"
                 << " has one double root: " << X << endl;
        }
    }

    return 0;
}
