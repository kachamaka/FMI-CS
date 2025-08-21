#ifndef TRIANGLE_H
#define TRIANGLE_H

class Triangle {
private: 
    unsigned a;
    unsigned b;
    unsigned c;

public:
    void read();
    unsigned perimeter();
    double area();
};


#endif