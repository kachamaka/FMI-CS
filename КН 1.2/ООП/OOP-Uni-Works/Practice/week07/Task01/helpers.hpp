#include <iostream>
using std::cout;
using std::cin;
using std::endl;

class Helpers{

public:
    static std::size_t strlen(const char* string);
    static void strcpy(const char* source, char* destination);
    static bool areTheSame(const char* checkThis, size_t strLengthWhat, const char* compareWithThis, size_t strLenCompared);

};
