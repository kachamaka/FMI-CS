#include <iostream>
using std::cin;
using std::cout;

void print(const int* arr, size_t len)
{
    if (len > 0) {
        cout << *arr << " ";
        print (arr+1, len-1);
    }
    else {
        cout << "\n";
    }
}

bool isSorted(const int* arr, size_t len)
{
    if (len < 2) {
        return true;
    }
    return (arr[0] <= arr[1]) &&
            isSorted(arr+1, len-1);
}

void insertInSorted(int* arr, int x, size_t len)
{
    if (len > 0 && arr[len-1] > x) {
        arr[len] = arr[len-1];
        insertInSorted(arr, x, len-1);
    }
    else {
        arr[len] = x;
    }
}

int main()
{
    const size_t MAX_ARRAY_SIZE = 1000;
    int arr[MAX_ARRAY_SIZE];
    size_t n;

    do {
        cin >> n;
        if (!cin){
            cin.clear();
            cin.ignore();
            n = MAX_ARRAY_SIZE + 1;
        }
    }while (n > MAX_ARRAY_SIZE);

    for (size_t i = 0; i < n; ++i) {
        int x;
        cin >> x;
        insertInSorted(arr, x, i);
    }
    if (isSorted(arr, n)) {
        cout << "Sorted\n";
        print(arr, n);
    }
    else {
        cout << "Not sorted\n";
    }

    return 0;
}
