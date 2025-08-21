#include <iostream>
#include "student.hpp"

using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

const unsigned MAX_NUM_STUDENTS = 50;

void printMenu(){
    cout << "Choose an option: " << endl
         << "1 - Add student" << endl
         << "2 - Get average marks of the student" << endl
         << "3 - Print personal information about the students" << endl
         << "4 - Print information about faculty num and marks" << endl
         << "0 - Exit" << endl;
}

int main() {
    unsigned choice;
    Student students[MAX_NUM_STUDENTS];

    while(choice != 0){
        printMenu();
        cin >> choice;
        switch (choice) {
        case 1:
            
            break;
        case 2:

            break;
        case 3:

            break;
        case 4:

            break;
        case 0:
            return 0;
        }
    }

    

    return 0;
}