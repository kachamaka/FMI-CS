/*
 Introduction to Programming 2020 @ FMI
 Sample tasks for lecture #13

  Function pointers.

***************
 Accumulate algorithm over array
 Map function on a string
 Simple interactive calculator
*/

#include <iostream>
using std::cin;
using std::cout;
using std::endl;

typedef int (*binFun)(int, int);
int accumulate(int a[], int n, binFun fun, int start)
{
    for (int i = 0; i < n; ++i) {
        start = fun(start, a[i]);
    }
    return start;
}

/* **********************************************************/

typedef char (*funPtr)(char);

void processString(char* text, funPtr processor)
{
    while (*text) {
        *text = processor(*text);
        ++text;
    }
}

char toUpper(char c)
{
    if (c >= 'a' && c <= 'z') {
        return c - 'a' + 'A';
    }
    return c;
}

char toLower(char c)
{
    if (c >= 'A' && c <= 'Z') {
        return c - 'A' + 'a';
    }
    return c;
}

/* **********************************************************/

int sum(int a, int b)
{
    return a+b;
}

int sub(int a, int b)
{
    return a-b;
}

int mul(int a, int b)
{
    return a*b;
}

int divide(int a, int b)
{
    if (b) return a/b;
    return 0;
}

int mod(int a, int b)
{
    if (b) return a%b;
    return 0;
}

int eq(int a, int b)
{
    return a==b;
}

int gt (int a, int b)
{
    return a > b;
}

int lt (int a, int b)
{
    return gt(b, a);
}

int min(int a, int b)
{
    return a < b ? a : b;
}

int max(int a, int b)
{
    return sub(sum(a, b), min(a, b));
}

static const char   oper[]      = {'+', '-', '*',    '/', '%', '=', '>', '<', 'm', 'M'};
static const binFun functions[] = {sum, sub, mul, divide, mod,  eq,  gt,  lt, min, max};
static const int    arraySize   = sizeof(oper)/sizeof(oper[0]);

binFun selectFun(char operation)
{
    for (int i = 0; i < arraySize; ++i) {
        if (oper[i] == operation) {
            return functions[i];
        }
    }
    return nullptr;
}

int calc(int a, int b, char operation)
{
    binFun function = selectFun(operation);
    if (!function) {
        cout << "unknown operation!\n";
        return -1;
    }
    return function(a, b);
}

int posCnt(int res, int x)
{
    return x > 0 ? res + 1 : res;
}

int main()
{
    int arr[] = {1, 2, 3, 0, 5, 0, -4, -5};
    const size_t size = sizeof(arr)/sizeof(arr[0]);

    cout << accumulate(arr, 5, sum, 0) << endl;
    cout << accumulate(arr, 5, mul, 1) << endl;
    cout << accumulate(arr, size, posCnt, 0) << endl;
/*
    cout << accumulate(arr, 5, [](int a, int b){return a<b?a:b;}, arr[0]) << endl;

    while (rand()%10) {
        char text[] = "I like to point things. Even functions ;)";
        switch(rand()%4) {
            case 0:    processString(text, toUpper);
            break;
            case 1:    processString(text, toLower);
            break;
            case 2:    processString(text, [](char){return '0';});
            break;
            case 3:    processString(text, [](char a){cout << a; return a;});
            break;
        }
        cout << text << endl;
    }
*/

/*
    char c;
    do {
        int x, y;
        cin >> x >> c >> y;
        if (c == 'e') break;
        cout << calc (x, y, c) << "\n";
    } while (cin);
*/

    return 0;
}
