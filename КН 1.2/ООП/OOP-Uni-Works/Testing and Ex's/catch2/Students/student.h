#ifndef _STUDENT_H_
#define _STUDENT_H_

#include "struct_grades.h"
const int MAX_NAME_SIZE = 30;
const int FAC_NUM = 5;
class Student
{
private:
    char *firstName;
    char *surName;
    char *lastName;
    char *ID;
    char fac_num[FAC_NUM];
    Marks marks[SUBJECTS];

public:
    // Student();
    // ~Student();
    char *allocateName(const char *name);
    void readFacNum();
    char *readID();
    void readStudent();
    void cleanStudent();
};

int strlenght(const char *text);
char *strCopy(char *destination, const char *source);
int strCompare(const char *firstS, const char *secondS);
char *getTempName(const char *name);
int swapped(int a, int b);
void printWord(int firstIndex, int secondIndex, char *text);
int findFirstIndex(int &firstIndex, const char *text);

// void strcpy(char *dest, const char *src);
// int strcmp(const char *text1, const char *text2);
// int strlen(const char *text);

#endif
