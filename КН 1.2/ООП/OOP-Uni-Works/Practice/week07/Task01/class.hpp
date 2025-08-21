//#include <iostream>

#include "helpers.hpp"

#ifndef COMPUTER_H
#define COMPUTER_H

class Computer {
private:
    static unsigned serialNumber;
    unsigned uniqueSerialNumber;
    char* brand;
    char* processor;
    char* video;
    char* hardDrive;
    double weight;
    int batteryLife;
    double price;
    unsigned int quantity;

public:
    Computer();
    Computer(char* brand, char* processor, char* video, char* hardDrive, double weight, int batteryLife, double price, unsigned int quantity);
    ~Computer();

    void setBrand();
    void setProcessor();
    void setVideo();
    void setHardDrive();
    void setWeight();
    void setBatterylife();
    void setPrice();
    void setQuantity();

    unsigned getUniqueSerialNumber() const ;
    char* getBrand() const ;
    char* getProcessor() const ;
    char* getVideo() const ;
    char* getHardDrive() const ;
    double getWeight() const ;
    int getBatterylife() const ;
    double getPrice() const ;
    unsigned int getQuantity() const ;

};

#endif