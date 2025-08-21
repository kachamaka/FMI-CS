#ifndef HELPERS
#define HELPERS

unsigned int strlen(const char* string) {
    unsigned len = 0;
    while(*string++) {
        ++len;
    }
    return len;
}


void strcpy(const char* source, char* destination) {
    unsigned pos = 0;
    // while(*destination = *source)
    //     ;
    while(source[pos]) {
        destination[pos] = source[pos];
        ++pos;
    }
    destination[pos] = 0;
}


#endif