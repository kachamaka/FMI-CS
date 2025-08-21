#include <iostream>
#include "time.hpp"

void isBigger(Time t1, Time t2){
    if(t1.getHour() != t2.getHour())
        t1.getHour() > t2.getHour() ? t1.print() : t2.print();
    else t1.getMinutes() > t2.getMinutes() ? t1.print() : t2.print();
}

int main(){
    Time t1(12, 15);
    Time t2(10, 25); //,t3, t4, t5, t6;

    (t1+t2).print();

    Time t3;

    t3 = t1+t2;
    t3.print();

    Time t4;
    t4 = t1 + 5;
    t4.print();

    Time t5;
    t5= 6 + t1;
    t5.print();

    isBigger(t1, t2);

    return 0;
}