#include <iostream>
#include <cmath>
#include "triangle.hpp"

using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

void Triangle::read() {
    cin >> a >> b >> c;
}

unsigned Triangle::perimeter() {
    return a + b + c;
}

double Triangle::area() {
    unsigned halfPerimeter = (a+b+c)/2;
    return sqrt(halfPerimeter*(halfPerimeter-a)*(halfPerimeter-b)*(halfPerimeter-c));
}