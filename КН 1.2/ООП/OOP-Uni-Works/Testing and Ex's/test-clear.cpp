#include <iostream>
#include <cstring>
using std::cin;
using std::cout;
using std::nothrow;
using std::endl;


unsigned enterNumber(unsigned min, unsigned max) {
    unsigned value = 0;             ////validating the input
    cin >> value;
    while (value < min || value > max || !cin) {
        if (max == 20) {
            cout << "Invalid width! Input a number between 4 and 20!" << endl;
        }
        else if (max == 40) {
            cout << "Invalid width! Input a number between 4 and 40!" << endl;
        }
        else {
            cout << "Invalid column!" << endl;
        }
        
        cin.ignore();       //instead of breaking the program, I decided to make the user input again
        cin.clear();
        cin >> value;
    }
    return value;
}

int main(){

    unsigned size = 0;
    size = enterNumber(10, 20);

    return 0;

}