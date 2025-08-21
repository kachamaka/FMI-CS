#ifndef STUDENT_H
#define STUDENT_H

#include "subjects.hpp"

const unsigned EGN_MAX = 10;
const unsigned FACNUM_MAX = 6;
const unsigned NUM_SUBJECTS = 5;

class Student{
private:
    char *firstName;
    char *foreName;
    char *lastName;
    char egn[EGN_MAX];
    char facNum[FACNUM_MAX];
    Subjects marks[NUM_SUBJECTS];

public:
    void read();

    double averageMark();

    void printDetails();

    void printMarks();

    void clean();

};

#endif