#include "../Task01/class.hpp"

#ifndef COMPUTER_SHOP_H
#define COMPUTER_SHOP_H


class ComputerShop{
private:
    char* shopName;
    Computer** computerList;
    unsigned computersInStock;

public:
    ComputerShop();
    ~ComputerShop();
    void addComputer(const char* brand);
    void printList();
    void buyComputer(const char& brand, double money);
    // ХМММ???
};

#endif