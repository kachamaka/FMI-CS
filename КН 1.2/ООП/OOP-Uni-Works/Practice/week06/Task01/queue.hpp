#ifndef TICKET_H
#define TICKET_H

#include <iostream>

class Ticket {

private:
    static const int FIRST_ID = 1;

    char* name;
    char* phoneNumb;
    int orderNumb = FIRST_ID;

public:
    Ticket(char* name, char* phoneNumb;
    ~Ticket();

    // void setName();
    // void setPhoneNumb();
    // void setOrderNumb();

    const char* getName() const;
    const char* getPhoneNumb() const;
    const int getOrderNumb() const;

    friend std::ostream& operator<<(std::ostream& output, const Ticket& obj);

    friend std::istream& operator>>(std::istream& input, Ticket& obj);

    void nameValidate(const char* name);

    void phoneNumbValidate(int orderNumb);

};


#endif