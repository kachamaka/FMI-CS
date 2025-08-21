
#include "student.h"
#include <iostream>
using std::cin;
using std::cout;
using std::endl;
using std::nothrow;

// Student::Student()
// {
//     char *firstName = nullptr;
//     char *surName = nullptr;
//     char *lastName = nullptr;
//     char *ID = nullptr;
//     char fac_num[FAC_NUM] = {};
//     Marks marks[SUBJECTS] = {};
// }
// Student::~Student()
// {
// }

void Student::readStudent()
{
    firstName = allocateName("first");
    surName = allocateName("sur");
    lastName = allocateName("last");

    ID = readID();
    readFacNum();

    for (int i = 0; i < SUBJECTS; i++)
    {
        marks[i].getSubjects();
    }
}

void Student::cleanStudent()
{
    delete[] firstName;
    delete[] surName;
    delete[] lastName;
    delete[] ID;

    for (int i = 0; i < SUBJECTS; i++)
    {
        marks[i].cleanSubject();
    }
}

char *Student::allocateName(const char *name)
{
    cout << "Enter" << name << " name" << endl;
    char tmp_name[MAX_NAME_SIZE];
    cin >> tmp_name;
    char *givenName = new (nothrow) char[strlenght(tmp_name) + 1];
    if (!givenName)
    {
        givenName = nullptr;
        delete[] givenName;
    }
    return givenName;
}

void Student::readFacNum()
{
    cout << "Please enter facult number\t";
    for (int i = 0; i < FAC_NUM; i++)
    {
        cin >> fac_num[i];
    }
}

char *Student::readID()
{
    cout << "Please enter ID number\t" << endl;
    char tmp_ID[MAX_NAME_SIZE];
    cin >> tmp_ID;
    char *givenID = new (nothrow) char[strlenght(tmp_ID) + 1];
    if (!givenID)
    {
        givenID = nullptr;
        delete[] givenID;
    }
    else
    {
        givenID = strCopy(givenID, tmp_ID);
    }
    return givenID;
}

char *Marks::getSubjects()
{
    cout << "Enter subject name" << endl;
    char tmp_subject[MAX_NAME_SIZE];
    cin >> tmp_subject;
    char *givensubject = new (nothrow) char[strlenght(tmp_subject) + 1];
    if (!givensubject)
    {
        givensubject = nullptr;
        delete[] givensubject;
    }
    else
    {
        givensubject = strCopy(givensubject, tmp_subject);
        getMark(givensubject);
    }

    return givensubject;
}

void Marks::getMark(const char *givensubject)
{
    cout << "Enter grade for" << givensubject << endl;
    cin >> grade;
}

void Marks::cleanSubject()
{
    delete[] subject;
}

int strlenght(const char *text)
{
    int counter = 0;
    if (text == nullptr)
    {
        return 0;
    }
    while (text[counter])
    {
        counter++;
    }
    return counter;
}

char *strCopy(char *destination, const char *source)
{
    int lenghtS = strlenght(source);
    int lenghtD = strlenght(destination);
    if (lenghtS <= lenghtD)
    {
        for (int i = 0; i <= lenghtS; i++)
        {
            destination[i] = source[i];
        }
        //destination[lenghtS] = '\0';
        return destination;
    }
    else
    {
        cout << "the destination stringCapacity is lower than the source";
        return nullptr;
    }
}

int strCompare(const char *firstS, const char *secondS)
{
    int lenghtS = strlenght(firstS);
    int lenghtD = strlenght(secondS);
    int resultSum = 0;
    if (lenghtS < lenghtD)
    {
        return -1;
    }
    if (lenghtS > lenghtD)
    {
        return 1;
    }
    if (lenghtS == lenghtD)
    {
        for (int i = 0; i < lenghtD; i++)
        {
            if (firstS[i] > secondS[i])
            {
                resultSum++;
            }
            else if (firstS[i] < secondS[i])
            {
                resultSum--;
            }
        }
    }
    return resultSum;
}

//====================================================================
// //! Gets string length
// //! Second version
// int strlen(const char *text)
// {
//     int len = 0;
//     while (text[len])
//     {
//         ++len;
//     }
//     return len;
// }
// //! Copies string
// //! Second version
// void strcpy(char *dest, const char *src)
// {
//     int pos = 0;
//     while (src[pos])
//     {
//         dest[pos] = src[pos];
//         ++pos;
//     }
//     dest[pos] = '\0';
// }
// //! Compare strings
// //! Second version
// int strcmp(const char *text1, const char *text2)
// {
//     while (*text1 && *text1 == *text2)
//     {
//         ++text1;
//         ++text2;
//     }
//     return *text1 - *text2;
// }
//================================================================

int swapped(int a, int b)
{
    a += b;
    b = a - b;
    a -= b;
    return a;
}

void printWord(int firstIndex, int secondIndex, char *text)
{
    for (int i = firstIndex; i <= secondIndex; i++)
    {
        cout << text[i];
    }
}

void getWord(char *text)
{
    int firstIndex = 0;
    int secondIndex = 0;
    // if (firstIndex > secondIndex)
    // {
    //     firstIndex += secondIndex;
    //     secondIndex = firstIndex - secondIndex;
    //     firstIndex -= secondIndex;
    // }

    while (!('a' <= text[firstIndex] && 'z' >= text[firstIndex] ||
             'A' <= text[firstIndex] && 'Z' >= text[firstIndex]))
    {
        firstIndex++;
    }
    secondIndex = firstIndex;
    while ('a' <= text[firstIndex] && 'z' >= text[firstIndex] ||
           'A' <= text[firstIndex] && 'B' >= text[firstIndex] ||
           text[firstIndex] != '.' || text[firstIndex] != '\0')
    {
        secondIndex++;
    }
    int wordLenght = secondIndex - firstIndex;

    printWord(firstIndex, secondIndex, text);
}

int changeNumber(int &number)
{
    number = 5;
    return number;
}

int findFirstIndex(int &firstIndex, const char *text)
{
    if (!text)
    {
        firstIndex = -1;
        return firstIndex;
    }
    if (text[firstIndex] == '\0')
    {
        firstIndex = -1;
        return -1;
    }

    while (!('a' <= text[firstIndex] && 'z' >= text[firstIndex] ||
             'A' <= text[firstIndex] && 'Z' >= text[firstIndex]) ||
           text[firstIndex] == ' ')
    {
        firstIndex++;
    }
    int maxIndex = sizeof(text) / sizeof(text[0]);
    if (firstIndex == maxIndex)
    {
        return -1;
    }

    return firstIndex;
}
