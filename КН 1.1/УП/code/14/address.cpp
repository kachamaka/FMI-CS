/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #14

 Implementation of methods for simple Address structure
*/


#include <iostream>
#include "address.h"

using std::cin;
using std::cout;
using std::endl;

unsigned readNum(const char* text)
{
    unsigned num;
    cout << text ;
    cin >> num;
    while (!cin) {
        cin.clear();
        cin.ignore();
        cout << "You must enter positive number! \n " << text << " again";
        cin >> num;
    }
    return num;
}

void readAddress(Address& address)
{
    cout << "Enter city: ";
    cin.getline(address.city, 32);

    cin.clear();

    address.ZIP = readNum("Enter ZIP code ");
    // here the input stream is in good state
    clearCin();
    cout << "Enter street: ";
    cin.getline(address.street, 64);

    // the input stream state is unknown, but it will be fixed, if needed

    address.number = readNum("Enter street number ");
    address.ent = readNum("Enter entrance ");

    // leave the stream cleared and in good state
    clearCin();
}

void printAddress(const Address& addr)
{
    cout << "City: " << addr.city << endl;
    cout << "ZIP code: " << addr.ZIP << endl;
    cout << "Street and number: " << addr.number << ", " << addr.street << endl;
    cout << "Ent: " << addr.ent <<endl;
}

void clearCin()
{
    cin.clear();
    while (cin && cin.rdbuf()->in_avail() && isspace(cin.peek()))
        cin.ignore();
    cin.clear();
}

