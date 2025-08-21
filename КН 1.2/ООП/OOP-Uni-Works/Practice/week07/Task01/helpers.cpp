#include "helpers.hpp"

std::size_t Helpers::strlen(const char* string) {
    std::size_t len = 0;
    while(*string++) {
        ++len;
    }
    return len;
}


void Helpers::strcpy(const char* source, char* destination) {
    std::size_t pos = 0;
    // while(*destination = *source)
    //     ;
    while(source[pos]) {
        destination[pos] = source[pos];
        ++pos;
    }
    destination[pos] = 0;
}

bool Helpers::areTheSame(const char* checkThis, size_t strLengthWhat, const char* compareWithThis, size_t strLenCompared) {
    if(strLengthWhat != strLenCompared) {
        return 0;
    }
    for(size_t i = 0; i < strLengthWhat; ++i) {
        if(checkThis[i] != compareWithThis[i]) {
            return 0;
        }
    }
    return 1;
}