#include <iostream>
#include <new>

using std::cin;
using std::cout;
using std::nothrow;

size_t strlen(const char* text)
{
    size_t len = 0;
    while (text[len]) ++len;
    return len;
}

void strcpy(char* dest, const char* src)
{
    size_t pos = 0;
    while (src[pos]) {
        dest[pos] = src[pos];
        ++pos;
    }
    dest[pos] = '\0';
}

char* strdup(const char* word)
{
    char* text = new char[strlen(word)+1];
    if (text) strcpy(text, word);
    return text;
}

char toLower(char c)
{
    return (c >= 'A' && c <= 'Z') ? c - ('A' - 'a') : c;

}

bool isLetter(char c)
{
    return (c >= 'A' && c <= 'Z') ||
           (c >= 'a' && c <= 'z');
}

bool stricmp(const char* text, const char* word)
{
    while (*word) {
        if (toLower(*text) != toLower(*word)) {
            return false;
        }
        ++word;
        ++text;
    }
    return !(isLetter(*text));
}

int findInDict(const char* text, const char*const*const words, size_t size)
{
    for (int i = 0; i < (int)size; ++i) {
        if (stricmp(text, words[i]))
            return i;
    }
    return -1;
}

void clearMem(char** wordList, size_t size)
{
    for (size_t i = 0; i < size; ++i){
        delete[] wordList[i];
    }
    delete[] wordList;
}

void clearAll(char** plainWords, char** cryptedWords, size_t size)
{
    clearMem(plainWords, size);
    clearMem(cryptedWords, size);
}

bool readDict(char**& plainWords, char**& cryptedWords, size_t& size)
{
    const size_t MAX_WORD_LEN = 100;
    char buffer[MAX_WORD_LEN + 1];

    cin >> size;
    plainWords = new(nothrow) char*[size];
    cryptedWords = new(nothrow) char*[size];
    if (!plainWords || !cryptedWords){
        size = 0;
        clearAll(plainWords, cryptedWords, size);
        return false;
    }

    for (size_t i = 0; i < size; ++i) {
        cin >> buffer;
        plainWords[i] = strdup(buffer);
        cin >> buffer;
        cryptedWords[i] = strdup(buffer);
        if (!plainWords[i] || !cryptedWords[i]){
            clearAll(plainWords, cryptedWords, i+1);
            return false;
        }
    }

    return true;
}

void clearCin()
{
    cin.clear();
    char c;
    do {
        c = cin.get();
    }while (c == ' ' || c == '\n' || c == '\t');
    cin.unget();
}

char* readInputText()
{
    size_t M;
    cin >> M;
    clearCin();

    char* text = new(nothrow) char[M+1];
    if (text) {
        for (size_t i = 0; i < M; ++i) {
            text[i] = cin.get();
        }
        text[M] = '\0';
    }
    return text;
}

char* encrypt(const char* text,
              const char*const*const plainWords,
              const char*const*const cryptedWords,
              size_t size)
{
    size_t len = 0;
    const char* textIter = text;
    while(*textIter) {
        int pos = findInDict(textIter, plainWords, size);
        if (pos >= 0) {
            len += strlen(cryptedWords[pos]);
            textIter += strlen(plainWords[pos]);
        }
        else {
            ++len;
            ++textIter;
        }
    }

    char* crypted = new (nothrow) char[len+1];
    if (!crypted) return crypted;

    textIter = text;
    char* result = crypted;
    while (*textIter) {
        int pos = findInDict(textIter, plainWords, size);
        if (pos >= 0) {
            strcpy(result, cryptedWords[pos]);
            textIter += strlen(plainWords[pos]);
            result += strlen(cryptedWords[pos]);
        }
        else {
            *result = *textIter;
            ++result;
            ++textIter;
        }
    }
    *result = '\0';
    return crypted;
}

int main()
{
    size_t N;
    char** plain;
    char** crypt;

    bool readOK = readDict(plain, crypt, N);
    if (!readOK) {
        cout << "Problem while reading dictionary. \n";
        return 1;
    }

    char* plainText = readInputText();

    if (plainText) {
        char* encrypted = encrypt(plainText, plain, crypt, N);
        if (encrypted) {
            cout << encrypted;
            delete[] encrypted;
        }
        else {
            cout << "Error encrypting!\n";
        }
        delete[] plainText;
    }
    else {
        cout << "Error reading input string!\n";
    }

    clearAll(plain, crypt, N);
    return 0;
}
