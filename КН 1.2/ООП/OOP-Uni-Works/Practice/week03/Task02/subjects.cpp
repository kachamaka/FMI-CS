#include <iostream>
#include "subjects.hpp"

using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

void Subjects::read() {
    char *tmp;
    cout << "Subject: " << endl;
    cin >> tmp;
    subject = new(nothrow) char[strlen(tmp)];
    strcpy(subject, tmp);

    cout << "Mark: " << endl;
    cin >> mark;

}

void Subjects::clean() {
    delete[] subject;
}