#include "queue.hpp"
#include "helpers.cpp"

Ticket::Ticket(char* name, char* phoneNumb) {
    this->name = new char[strlen(name)+1];
    strcpy(name, this->name);
    
    this->phoneNumb = new char[strlen(phoneNumb)+1];
    strcpy(phoneNumb, this->phoneNumb);

    ++orderNumb;
}

Ticket::~Ticket() {
    delete[] name;
    delete[] phoneNumb;
}

// void Ticket::setName() { }
// void Ticket::setPhoneNumb() { }
// void Ticket::setOrderNumb() { }

const char* Ticket::getName() const {
    return name;
}
const char* Ticket::getPhoneNumb() const {
    return phoneNumb;
}
const int Ticket::getOrderNumb() const {
    return orderNumb;
}

std::ostream& operator<<(std::ostream& output, const Ticket& obj) {
    output << obj.name << " ," << obj.phoneNumb << " ," << obj.orderNumb << std::endl;
    return output;
}

std::istream& operator>>(std::istream& input, Ticket& obj) {
    input >> obj.name >> obj.phoneNumb;
    return input;
}

void Ticket::nameValidate(const char* name) {
    unsigned pos =0;
    while((name[pos] > 'A' && name[pos] < 'Z') || name[pos]==' ' || (name[pos] > 'a' && name[pos] < 'z')){
        ++pos;
    }
    if(pos != strlen(name)) {
        std::cout << "Name shall only include letters and space character!" << std::endl;
        //Kwo praim ako e feik imeto? Triem wsichko a ne exeption!

    }
}

void Ticket::phoneNumbValidate(int orderNumb) {
    if(strlen(phoneNumb)!= 10) {
        std::cout << "oh";
    }

    unsigned pos =0;
    while(name[pos] > '0' && name[pos] < '9'){
        ++pos;
    }
    if(pos != strlen(phoneNumb)) {
        std::cout << "Name shall only include letters and space character!" << std::endl;
        //Kwo praim ako e feik imeto? Triem wsichko a ne exeption!

    }
}   