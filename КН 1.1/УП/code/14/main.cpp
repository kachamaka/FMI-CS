/*
 Introduction to Programming 2020 @ FMI
 Sample code for lecture #14

  Structures. Bit fields.
*/

#include <iostream>
using std::cout;
using std::endl;

#include "address.h"
#include "student.h"


// Print all the students from a given program.
// Demonstrates pointer to structure.
void printAllFromProgram(Program prg, Student* students, int cnt)
{
    cout << "==========================================\n";
    cout << "All for program " << prg << "\n";
    for (Student* iter = students; iter < students + cnt; ++iter) {
        if (iter->program == prg)
            printStudent(*iter);
    }
    cout << "==========================================" << endl;
}

int main()
{
    Address a;
    cout << sizeof(a) << endl;
    readAddress(a);
    printAddress(a);

    cout << sizeof(Student) << endl;

/*
    const int NumStudents = 5;
    Student students[NumStudents];

    for (int i = 0; i < NumStudents; ++i) {
        students[i].name = nullptr;
        readStudent(students[i]);
    }

    for (int i = 0; i < NumStudents; ++i) {
        printStudent(students[i]);
    }

    for (int i = (int)PROGRAM_UNKNOWN; i < (int)PROGRAM_COUNT; ++i) {
        cout << "\n\n";
        printAllFromProgram((Program)i, students, NumStudents);
    }

    for (int i = 0; i < NumStudents; ++i) {
        clearStudentData(students[i]);
    }

*/
    return 0;
}


/*
Pesho
Sofia
1234
Something
23
2
1
1
1
1
y
n
Gosho
Sofia
1234
Other
33
2
2
2
1
1
y
n
Sasho
Varna
1111
Bla-Bla Bla
11
3
1
2
1
2
y
y
Ivan
Dobrich
9321
Ulichka
1
2
2
2
3
2
n
y
Dragan
Sofia
1432
Wkushti 123
321
1
1
1
1
2
n
n
*/
