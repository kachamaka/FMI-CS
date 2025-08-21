/*
 Introduction to Programming 2020 @ FMI
 Sample tasks for lecture #12

  Introduction to preprocessor.

*/

#include <iostream>
#include <cassert>
using namespace std;

#define MIN(a, b) ((a)<(b)?(a):(b))

#ifdef DEBUG
#   define dbgPrint(fun, p1, p2) cout << fun"(" << p1 << ", " << p2 << ")" << endl
#else
#   define dbgPrint
#endif

static double power(double x, unsigned n)
{
    assert ("power input parametrer" && n < 10);
    dbgPrint("power", x, n);

    if (n == 0)
        return 1;

    double p2 = power(x, n/2);
    if (n%2 == 1)
        return x * p2 * p2;
    else
        return p2 * p2;
}

static double sqrt(double x)
{
    assert (x >= 0);
    double result = 0;
    //.......
    assert (result >= 0);
    assert (abs(result*result - x) < 0.0001);
    return result;
}

int main()
{
    cout << power(2, 100) << endl;
    return 0;
}
