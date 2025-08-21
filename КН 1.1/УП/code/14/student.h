/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #14

  Structures.
  Declaration of student structure.
  It demonstrates:
     - enum
     - dynamic memory allocated field
     - nested structure
     - bit fields
*/

#ifndef _STUDENT_HEADER_INCLUDED_
#define _STUDENT_HEADER_INCLUDED_

#include "address.h"

/* Enum type for the educational program */
enum Program
{
    PROGRAM_UNKNOWN,       // invalid / unknown program
    INFORMATICS,
    COMPUTER_SCIENCE,
    MATH,
    APPLIED_MATH,
    STATICTICS,

    PROGRAM_COUNT          // Marker for the end of valid enum values
};


struct Student
{
    char* name;                  // Student name - dynamically allocated string
    Address address;             // The address - nested structure
    Program program;             // Educational program - an enum value

    // Several attributes, placed in bit fields
    unsigned int facNum    : 17; // faculty number - [0..131071]
    unsigned int course    : 3;  // the course - [0..7]
    unsigned int group     : 4;  // group - [0..15]
    unsigned int stream    : 2;  // stream - [0..3]
    unsigned int regular   : 1;  // regular / extramural student
    unsigned int interrupt : 1;  // interrupted or not
    unsigned int           : 4;  // trailing alignment
};

// Reads data from the standard input.
// The structure passed have to be valid!
//  (the name pointer have to be correctly initialized)
void readStudent(Student& student);

// Print student data to the standard out.
void printStudent(const Student& student);

// Clear all the memory, allocated for a student
void clearStudentData(Student& student);

#endif //_STUDENT_HEADER_INCLUDED_
