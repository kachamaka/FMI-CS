#ifndef PACE_H
#define PACE_H

#include "MinSec.hpp"

using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

class Pace {
private: 
    //double minPerKm, secondsPerKm;
    double kmPerHour;

public:
    Pace();
    Pace(MinSec Time);
    Pace(double kmPerHourInput);

    //Pace(double minPerKmInput, double secondsPerKmInput);
    
    double transformInMinsSeconds();
    double transformInKmPerHour();

};


#endif