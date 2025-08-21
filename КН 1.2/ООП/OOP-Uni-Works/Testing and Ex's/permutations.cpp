#include <iostream>
using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

void swap(int& a, int& b){
    int temp = a;
    a=b;
    b=temp;
}

void print(int arr[], unsigned n){
    for(unsigned i = 0; i < n; i++){
        cout << arr[i] << " ";
    }
}

void permutations(int arr[], unsigned n, unsigned position, unsigned beenThere){
    if(position > n){
        //position = beenThere+1;
        //beenThere++;
        //if(beenThere == n) return;
        return;
    }

    

    print(arr, position+1);

    cout << endl;

    permutations(arr, n, position+1, 0);



}



int main(){
    int arr[5] = {0,1,2,3,4};
    permutations(arr, 5, 0, 0);

    return 0;
}