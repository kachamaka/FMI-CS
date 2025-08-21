#include <iostream>
#include <cstring>
#include <stdexcept>
#include "ticket.hpp"

int Ticket::currTicketNum = 0;

void validateName(char* name)
{
    int i = 0;
    while(name[i] != '\0'){
        if(name[i] !=' ' && !((name[i] >= 'a' && name[i] <='z') || (name[i] >= 'A' && name[i] <='Z')))
        {
            throw std::invalid_argument("Invalid characters in name");
        }
        ++i;
    }
}

void validatePhoneNum(char* phone_num)
{
    int i = 0;
    while(phone_num[i] != '\0'){
        if(phone_num[i] < '0' || phone_num[i] > '9')
        {
            throw std::invalid_argument("invalid phone number");
        }
        ++i;
    }   
}
Ticket::Ticket()
{
    name = nullptr;
    setPhoneNum("0000000000");
}

Ticket::Ticket(char* name, char phone_num[PHONE_NUMBER_LEN])
{
    setName(name);
    setPhoneNum(phone_num);
    
    ticket_num = ++currTicketNum;
}

Ticket::~Ticket()
{
    if(name != nullptr) 
    {
        delete[] name;
    }
}

void Ticket::setName(char* name)
{
    int nameLen = strlen(name);
    char* buffer;
    try
    {
        buffer = new char[nameLen+1];
    }
    catch(const std::bad_alloc& e)
    {
        std::cerr << e.what() << '\n';
        throw;
    }

    if(!this->name){
        delete[] this->name;
    }

    strcpy(buffer, name);
    buffer[nameLen] = '\0';

    this->name = buffer;
}

void Ticket::setPhoneNum(char phone_num[PHONE_NUMBER_LEN])
{
    validatePhoneNum(phone_num);

    for (size_t i = 0; i < PHONE_NUMBER_LEN-1; i++)
    {
        this->phone_num[i] = phone_num[i];
    }
    this->phone_num[PHONE_NUMBER_LEN-1] = '\0';
}

const char* Ticket::getName()
{
    return name;
}
const char* Ticket::getPhone_num()
{
    return phone_num;
}

std::ostream &operator<<( std::ostream &output, const Ticket &ticket )
{
    output << "Name : " << ticket.name << " I : " << ticket.phone_num;
    return output;      
}

std::istream &operator>>( std::istream  &input, Ticket &ticket)
{
    input >> ticket.name >> ticket.phone_num;
    validateName(ticket.name);
    return input; 
}