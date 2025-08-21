#ifndef helpful
#define helpful

unsigned strlen(const char *text) {
    unsigned len = 0;
    while(text[len]) {
        ++len;
    }
    return len;
}

void strcpy(char *where, const char *what) {
    unsigned position = 0;
    while (what[position]) {
        where[position] = what[position];
        ++position;
    }
    where[position] = '\0';
}


#endif