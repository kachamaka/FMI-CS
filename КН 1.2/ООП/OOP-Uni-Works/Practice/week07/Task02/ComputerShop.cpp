#include "ComputerShop.hpp"

ComputerShop::ComputerShop() 
    : shopName(nullptr), computerList(nullptr)
{
}

ComputerShop::~ComputerShop() {
    delete[] shopName;
    for(size_t i = 0; i < computersInStock; ++i) {
        delete[] computerList[i];
    }
    delete[] computerList;
}

void addComputer(const char* brand) {
    
}


void ComputerShop::printList() {

}
void ComputerShop::buyComputer(const char& brand, double money) {

}