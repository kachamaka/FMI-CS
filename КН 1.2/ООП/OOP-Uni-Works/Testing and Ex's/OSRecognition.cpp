#include <iostream>
#include <stdlib.h>

#ifdef __unix__
#define isWindows false
void clear()
{
    system("clear");
}

#elif defined(_WIN32) || defined(WIN32)  
#define isWindows true
void clear()
{
    system("CLS");
}

#endif

int main()
{
    char c[5];
    if(isWindows){
    std::cout<<"\nYour current OS is Windows!\nPress Enter to clear the screen.\n";
    }
    else{
        std::cout<<"\nYour current OS is UNIX-like !\nPress Enter to clear the screen.\n";
    }
    std::cin.getline(c,5);
    clear();
    std::cout<<"------------------All clear!---------------\n";

    return 0;
}