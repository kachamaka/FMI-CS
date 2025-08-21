#include <iostream>

using namespace std;

void slab(int& a, int& b)
{
    int hold = a;
    a = b;
    b = hold;
}

void pechatnicata(int arr[], int sz)
{
    for (int i = 0; i < sz; i++) {
        cout << arr[i] << " ";
    }
}

void djurkai(int arr[], int sz, int pos)
{
    if (pos == sz - 1) {
        pechatnicata(arr, sz);
        cout << endl;
        return;
    }

    for (int i = pos; i < sz; i++) {
        slab(arr[i], arr[pos]);
        djurkai(arr, sz, pos+1);
        slab(arr[i], arr[pos]);
    }
}

int main()
{
    int arr[5] = {1, 2, 3, 4, 5};
    djurkai(arr, 5, 0);
    return 0;
}
