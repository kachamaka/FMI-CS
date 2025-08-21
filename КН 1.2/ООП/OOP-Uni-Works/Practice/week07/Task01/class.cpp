#include "class.hpp"

//#include "helpers.hpp"


unsigned Computer::serialNumber = 0;

Computer::Computer() 
    : brand(0), processor(nullptr), video(nullptr), hardDrive(nullptr),
        weight(0), batteryLife(0), price(0), quantity(0)
{
}

Computer::Computer(char* brand, char* processor, char* video, char* hardDrive, double weight, int batteryLife, double price, unsigned int quantity) { 
    uniqueSerialNumber = serialNumber;
    this->brand = brand;
    this->processor = processor;
    this->video = video;
    this->hardDrive = hardDrive;
    this->weight = weight;
    this->batteryLife = batteryLife;
    this->price = price;
    this->quantity = quantity;
    ++serialNumber;
}

Computer::~Computer() {
    delete[] brand;
    delete[] processor;
    delete[] video;
    delete[] hardDrive;
}

//setters should be 
//void Computer::setBrand(const char* brand) etc

//also if u use as my helpers.hpp - they're static functions
//therefore when u use them it's like this ->    
// Helpers::strlen(neshto);

// another point skobite sa na greshnoto mqsto
// should be strlen(string) + 1 :DDD 

// I thinks that's all for now uwu

void Computer::setBrand() {
    char tmp[256];
    cout << "Brand: " << endl;
    cin >> tmp;
    brand = new char[Helpers::strlen(tmp)+1];
    Helpers::strcpy(tmp, brand);
}
void Computer::setProcessor() {
    char tmp[256];
    cout << "Processor: " << endl;
    cin >> tmp;
    processor = new char[strlen(tmp+1)];
    strcpy(tmp, processor);

}
void Computer::setVideo() {
    char tmp[256];
    cout << "Video: " << endl;
    cin >> tmp;
    video = new char[strlen(tmp+1)];
    strcpy(tmp, video);

}
void Computer::setHardDrive() {
    char tmp[256];
    cout << "HardDrive: " << endl;
    cin >> tmp;
    hardDrive = new char[strlen(tmp+1)];
    strcpy(tmp, hardDrive);

}

void Computer::setWeight() {
    cout << "Weight: " << endl;
    cin >> weight;
}

void Computer::setBatterylife() {
    cout << "Battery life: " << endl;
    cin >> batteryLife;
}

void Computer::setPrice() {
    cout << " : " << endl;
    cin >> price;
}

void Computer::setQuantity() {
    cout << "Quantity: " << endl;
    cin >> quantity;
}



unsigned Computer::getUniqueSerialNumber() const {
    return uniqueSerialNumber;
}
char*    Computer::getBrand() const {
    return brand;
}
char*    Computer::getProcessor() const {
    return processor;
}
char*    Computer::getVideo() const {
    return video;
}
char*    Computer::getHardDrive() const {
    return hardDrive;
}
double   Computer::getWeight() const {
    return weight;
}
int      Computer::getBatterylife() const {
    return batteryLife;
}
double   Computer::getPrice() const {
    return price;
}
unsigned Computer::getQuantity() const {
    return quantity;
}

