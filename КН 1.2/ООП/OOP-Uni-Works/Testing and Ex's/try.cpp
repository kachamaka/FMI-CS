#include <iostream>
#include <new>
using std::nothrow;

int main(){
    long long int n = -1;
    long long* test=new (nothrow) long long [n];
    if(!test){
        std::cout<< "oops!";
    }

    //test[0] = 1;

    delete[] test;
    return 0;
}