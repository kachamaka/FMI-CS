#include <iostream>
#include "triangle.hpp"

using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

int main(){
    Triangle t1;
    t1.read();
    cout << "P: " << t1.perimeter() << endl 
         << "A: " << t1.area() << endl;

    return 0;
}