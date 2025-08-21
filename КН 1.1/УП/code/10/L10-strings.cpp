/*
 Introduction to Programming 2020 @ FMI
 Sample task for lecture #10

 Strings. Basic operations.
 Working with memory.

***************
 String length, String copy, String compare, String duplication
 Count the words in a text
 Extract all the words from a text
***************
*/


#include <iostream>
using std::cin;
using std::cout;
using std::endl;
using std::nothrow;

// Find the lenght of a string.
size_t strlen(const char* text)
{
    size_t len = 0;
    while (text[len])
        ++len;
    return len;
}

// Make a copy of a string - from src to dest
// Uses indexes
void strcpy(char* dest, const char* src)
{
    int pos = 0;
    while(src[pos]) {
        dest[pos] = src[pos];
        ++pos;
    }
    dest[pos] = '\0';
}

// Make a copy of a string - from src to dest
// Uses pointers
void strcpyPtr(char* dest, const char* src)
{
    while (*dest++ = *src++)
        ;
}

// Compares two strings in lexicographic order
// The result is 0 if the strings are equal,
// negative, if the first is before the second
// and positive in the other case.
int strcmp(const char* text1, const char* text2)
{
    while (*text1 && *text1 == *text2) {
        ++text1;
        ++text2;
    }
    return *text1 - *text2;
}

// Creates a duplicate of a string, using dynamic memory
char* strdup(const char* text)
{
    char* newtext = new(nothrow) char[strlen(text)+1];
    if(newtext) {
        strcpy(newtext, text);
    }
    return newtext;
}

// Check if a letter is part of a word
bool isWordLetter(char c)
{
    return (c >= 'A' && c <= 'Z') ||
           (c >= 'a' && c <= 'z') ||
           (c >= '0' && c <= '9') ||
           c == '_';
}


// Counts the words in a text.
int wordCount(const char* text)
{
    int cnt = 0;
    while (*text) {
        while (*text && !isWordLetter(*text)) {  // skip letters to the beginning of a word
            ++text;
        }
        if (*text) {
            ++cnt;                              // if there is a word, count it
        }
        while (isWordLetter(*text)) {           // skip to the end of the word
            ++text;
        }
    }
    return cnt;
}

// Check if a string is part of another string.
// Return a pointer to the first occurrence or NULL
// A naive algorithm.
const char* strstr1(const char* const where, const char* what)
{
    size_t whatLen = strlen(what);
    size_t pos;
    const char* whereEnd = where + strlen(where);

    while (where+whatLen <= whereEnd) {
        for (pos = 0; pos < whatLen; ++pos) {
            if (where[pos] != what[pos]) {
                break;
            }
        }
        if (!what[pos]) return where;
        ++where;
    }
    return nullptr;
}

/**********************************************************/
// Extract all the words from a text in a new array
// Allocates memory for that array and for each word
// Returns the count of extracted words
int extractWords(const char* text, char *** wordsPtr)
{
    int cnt = wordCount(text);  // found the count of the words
    *wordsPtr = new(nothrow) char*[cnt];    // allocate memory for the index array
    if (!*wordsPtr) return 0;

    for (int i = 0; i < cnt; ++i){          // for each word
        // go to the beginning of the word
        while (*text && !isWordLetter(*text))
            ++text;
        if (*text) {     // and if there is any
            const char* start = text;
            while (isWordLetter(*text))     // go to the end
                ++text;

            int len = text - start;         // and calculate the length of that word
            (*wordsPtr)[i] = new(nothrow) char[len+1];      // allocate memory for the word
            if (!(*wordsPtr)[i]) {    // If the allocation fails
                cout << "No memory for word " << i;
                return i;             // Return the number of successfully allocated words
                /*
                // Alternative approach - clear all the memory
                for (--i; i >= 0; --i)
                    delete[](*wordsPtr)[i];
                delete[] (*wordsPtr);
                *wordsPtr = NULL;
                return 0;
                */
            }
            for (int pos = 0; pos < len; ++pos)             // copy the word
                (*wordsPtr)[i][pos] = start[pos];
            (*wordsPtr)[i][len] = '\0';                     // put a terminal symbol at the end
        }
    }
    return cnt;
}


// A method to test the above function
void wordTest(const char* text)
{
    char ** words;
    int cnt = extractWords(text, &words);
    int properCnt = wordCount(text);
    if (!words) {
        cout << "Memory problem!" << endl;
        return;
    }
    if (cnt != properCnt) {
        cout << "Memory problem - not all words extracted!";
    }

    cout << cnt << endl;
    for (int i = 0; i < cnt; ++i)
        cout << words[i] << endl;

    for (int i = 0; i < cnt; ++i)
        delete[] words[i];
    delete[] words;
}
/**********************************************************/

int main()
{
    const char* text = "C++ is cool and pointers are cool too!";

    //char* copy = strdup(text);
    //cout << text;
    //delete[] copy;

/*
    size_t len = strlen(text);
    cout << len << endl;

    char* buff = new(nothrow) char[len+1];
    if (!buff) {
        cout << "memory problem!" << endl;
        return 1;
    }

    strcpyPtr(buff, text);
    cout << buff << endl;
    cout << strcmp(buff, text) << endl;
    buff[len-1] = '.';
    cout << strcmp(buff, text) << endl;

    delete[] buff;
*/

    cout << strstr1(text, "too!") << endl;

//    wordTest(text);
    return 0;
}
