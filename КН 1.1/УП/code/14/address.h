/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #14

 Simple structure for Address.
 All members are statically allocated.
*/

#ifndef _ADDRESS_HEADER_INCLUDED_
#define _ADDRESS_HEADER_INCLUDED_

struct Address
{
    char city[32];
    char street[64];
    unsigned short number;
    unsigned short ent;
    unsigned long ZIP;
};

// Print an address to the standard out
void printAddress(const Address& address);

// Read address data from the standard input
void readAddress(Address& address);

void clearCin();

#endif //_ADDRESS_HEADER_INCLUDED_
