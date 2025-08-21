#include <iostream>
#include "time.hpp"

using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

void Time::setHour(int hour) {
        if (hour >= 0 && hour <= 23) {
            this->hour = hour;
        } else {
            this->hour = 0;
        }
}

void Time::setMinutes(int minute) {
    if (minute >= 0 && minute <= 59) {
        this->minute = minute;
    }
    else {
        //hour += minute % 60;
        this->minute = 0;
    }
}

Time::Time() {
    setMinutes(0);
    setHour(0);
}

Time::Time(int hour, int minute) {
    setMinutes(minute);
    setHour(hour);
}

int Time::getHour() {
    return hour;
}

int Time::getMinutes() {
    return minute;
}

Time Time::operator+(const Time& t) {
    int newHour = (hour + t.hour + (minute + t.minute) / 60 ) % 24;

    int newMinute = (minute + t.minute) % 60;
        
    Time result(newHour, newMinute);
        
    return result;
}

Time Time::operator+(int hour) {
    int newHour = (this->hour + hour) % 24;
    Time result(newHour, minute);
    return result;
}

Time& Time::operator=(const Time &t) {
    hour = t.hour;
    minute = t.minute;
    return *this; //
}

void Time::print() {
    if (hour < 10) {
        cout << "0";
    }
    cout << hour << ":";

    if (minute < 10) {
        cout << "0";
    }
    cout << minute << endl;
}

Time operator+(int hour, const Time& t) {
    int newHour = (t.hour + hour) % 24;
    Time result(newHour, t.minute);
    return result;
}

/*
void isBigger(Time t1, Time t2){
    if(t1.getHour() != t2.getHour())
        t1.getHour() > t2.getHour() ? t1.print() : t2.print();
    else t1.getMinutes() > t2.getMinutes() ? t1.print() : t2.print();
}
*/