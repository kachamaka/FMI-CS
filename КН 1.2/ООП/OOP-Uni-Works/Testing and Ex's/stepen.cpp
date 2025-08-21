#include <iostream>
using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

void powdigniSe(int& n, int stepen, int br){
    if((br+1) == stepen) return;
    else {
        n *= n;
        powdigniSe(n, stepen, br+1);
    }
}

int ofBePrawBeshe(int n, int stepen){
    cout << n << endl;
    if (stepen == 0) return 1;
    else return ( n * ofBePrawBeshe((n), (stepen-1)));
}

int main(){
    int n=0, stepen =0;
    cin >> n >> stepen;

    //powdigniSe(n, stepen, 1);
    n = ofBePrawBeshe(n,stepen);
    
    cout << n;
    return 0;
}
