#include <iostream>
#include "pace.hpp"

Pace::Pace(){
        cout << "I sq?" << endl;
        minPerKm = 0;
        secondsPerKm = 0;
        kmPerHour = 0;
}

Pace::Pace(double minPerKmInput, double secondsPerKmInput){
    cout << "Minutes per KM: " << endl;
    cin >> minPerKMInput;
    cout << "Seconds per KM: " << endl;
    cin >> secondsPerKmInput;
}

Pace::Pace(double kmPerHourInput){
    cout << "Km per hour: " << endl;
    cin >> kmPerHourInput;
}

double transformInMinsSeconds(){
    return 60 / kmPerHour;
}

double transformInKmPerHour(){
    Time.min = 60/kmPerHour;
    Time.sec = 3600*kmPerHour - 60* Time.min; 
    return Time;
}

/*

double neshto() {
    return 60/kmPerHour;
}


void transformInMinsSeconds(double kmPerHour){
    cout << 60 / kmPerHour << endl;
    
}

void transformInKmPerHour(double minPerKmInput, double secondsPerKmInput){
    cout << "Minutes per km to km/h: " << 60 / minPerKmInput << endl;
    cout << "Seconds per km to km/h: " << 3600 / secondsPerKmInput << endl;
}

*/