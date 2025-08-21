#ifndef TIME_H
#define TIME_H

class Time{
private:

    int hour;
    int minute;

    void setHour(int hour);

    void setMinutes(int minute);

public:


    Time();

    Time(int minute, int hour);

    int getHour();

    int getMinutes();

    Time operator+(const Time& t);

    Time operator+(int hour);

    Time& operator=(const Time& t) ;

    void print();

    friend Time operator+(int hour, const Time& t);

    //void isBigger(Time t1, Time t2);

};

#endif