#include <iostream>
#include "student.hpp"
#include "helpful.cpp"

using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

const unsigned MAX_STRING = 64;

void Student::read() {
    char tmp[MAX_STRING];

    cout <<  "First name: " << endl;
    cin >> tmp;
    firstName = new(nothrow) char[strlen(tmp)];
    strcpy(firstName, tmp);


    cout <<  "Forename: " << endl;
    cin >> tmp;
    foreName = new(nothrow) char[strlen(tmp)];
    strcpy(foreName, tmp);

    cout <<  "Last name: " << endl;
    cin >> tmp;
    lastName = new(nothrow) char[strlen(tmp)];
    strcpy(lastName, tmp);

    cout << "EGN: " << endl;
    cin >> egn;

    cout << "Faculty num: " << endl;
    cin >> facNum;

    for(unsigned i = 0; i < NUM_SUBJECTS; ++i) {
        marks[i].read();
    }

}

double Student::averageMark() {
    double average = 0;
    for(unsigned i = 0; i < NUM_SUBJECTS; ++i) {
        average += marks[i].mark;
    }
    return average / NUM_SUBJECTS;
}

void Student::printDetails() {
    cout << firstName << " " << foreName << " " << lastName << endl
         << egn << endl << Student::averageMark() << endl;
}

void Student::printMarks() {
    cout << facNum << endl;
    for (unsigned i = 0; i < 5; ++i){
        cout << marks[i].subject << ": " << marks[i].mark << endl;
    } 
}

void Student::clean() {
    delete[] firstName;
    delete[] foreName;
    delete[] lastName;
    for(unsigned i = 0; i < NUM_SUBJECTS; ++i){
        marks[i].clean();
    }
}