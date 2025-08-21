/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #14

  Structures.
  Implementation of some code to work with a student structure.
*/

#include "student.h"
#include <iostream>
#include <cstring>

using namespace std;

// Helper functions
static void readName(char*& name);
static Program readProgram();
static unsigned int readNumber(const char* name, unsigned max);
static bool readFlag(const char* name);
static const char* const programToText(Program prg);

void readStudent(Student& student)
{
    // Clear old data before read new one
    clearStudentData(student);

    readName(student.name);
    readAddress(student.address);
    student.program = readProgram();

    student.facNum = readNumber("faculty number", (1 << 17) - 1); // limit to the maximum data range
    student.course = readNumber("course", 6);      // maximum value is 5-th course
    student.stream = readNumber("stream", 4);      // maximum value is 3-th stream
    student.group = readNumber("group", 11);       // max 10 groups

    student.regular = readFlag("Is regular student?");
    student.interrupt = readFlag("Is the student interrupted?");
}

void printStudent(const Student& student)
{
    cout << "\n**************************************************************************\n";
    cout << "Information for student " << student.name << endl;
    cout << "Address: " << endl;
    printAddress(student.address);
    cout << "Program: " << programToText(student.program) << endl;
    cout << "FN: " << student.facNum << endl;
    cout << "Course: " << student.course << endl;
    cout << "Stream: " << student.stream << endl;
    cout << "Group: " << student.group << endl;
    cout << "The student is " << (student.regular ? "" : "not ") << "regular." << endl;
    cout << "The student is " << (student.interrupt ? "" : "not ") << "interrupted." << endl;
    cout << "**************************************************************************\n";
}

void clearStudentData(Student& student)
{
    delete[] student.name;
}

// Read data for the student name. Takes care for the dynamic memory
static void readName(char*& name)
{
    char buffer[1024] = "";

    cout << "Enter name for the student: ";
    cin.getline(buffer, sizeof(buffer));

    cin.clear();

    name = new(nothrow) char[strlen(buffer) + 1];
    if (name) strcpy(name, buffer);
}


// Read data for the educational program
static Program readProgram()
{
    Program prg = PROGRAM_UNKNOWN;
    cout << "Enter program: ";

    cin >> (int&)prg;

    clearCin();

    if (prg >= PROGRAM_COUNT || prg < PROGRAM_UNKNOWN) {
        cout << "Invalid value. The program must be a number between " << PROGRAM_UNKNOWN
             << " and " << (PROGRAM_COUNT - 1) << endl;
    }
    return prg;
}

// Reads a numeric value.
// A prompt text and maximal value are passed as arguments
static unsigned int readNumber(const char* name, unsigned max)
{
    unsigned val = max;

    do {
        cout << "Enter " << name << ": ";
        cin >> val;
        if (!cin) {
            cin.clear();
            cin.ignore();
        }
    } while (val >= max);

    clearCin();

    return val;
}

// Reads a boolean value.
// A prompt text is passed as argument
static bool readFlag(const char* name)
{
    char ans;
    do {
        cout << name << "(y/n): ";
        cin >> ans;
    } while (ans != 'n' && ans != 'y' && ans != 'N' &&ans != 'Y');

    clearCin();

    return ans == 'y' || ans == 'Y';
}

static const char* const programToText(Program prg)
{
    switch (prg) {
    case PROGRAM_UNKNOWN:    return "Unknown program";
    case INFORMATICS:        return "Informatics";
    case COMPUTER_SCIENCE:   return "Computer science";
    case MATH:               return "Math";
    case APPLIED_MATH:       return "Applied math (bow)";
    case STATICTICS:         return "Statistics";
    default:                 return "Bad program value!";
    }

    // must never reach this line
    return nullptr;
}
