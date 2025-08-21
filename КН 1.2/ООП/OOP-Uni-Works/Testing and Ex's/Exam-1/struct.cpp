#include "struct.hpp"
const double EPS = 0.00001;

// static bool compareIP(){}
// static bool strCompare(const char* str1, const char* str2)
// {

// }

Server::Server() 
: OS(nullptr), memory(0), RAM(0), CPU(0)
{
    for(size_t i =0; i<5; i++) {
        IPAddress[i] = 0;
    }
}

Server::~Server() {
    delete[] OS;
}

bool Server::strcmp(const char* checkThis, size_t strLengthWhat, const char* compareWithThis, size_t strLenCompared) const{
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

bool Server::operator==(const Server& other) const
{
	bool ipMatch = (strcmp(IPAddress, 4, other.IPAddress, 4));
	bool osMatch = (strcmp(OS, strlen(OS), other.OS, strlen(other.OS)));
	bool memoryMatch = (this->memory == other.memory);
	bool ramMatch = (this->RAM == other.RAM);
	bool cpuMatch = (this->CPU - other.CPU < EPS);
    
	return ipMatch && osMatch && memoryMatch && ramMatch && cpuMatch;

}



void Server::print() const {
    std::cout << "IP Adress: " << IPAddress << std::endl;
    std::cout << "OS: " << OS << std::endl;
    std::cout << "Memory: " << memory << std::endl;
    std::cout << "RAM: " << RAM << std::endl;
    std::cout << "CPU: " << CPU << std::endl;
}

void Server::read() {
    char tmp[21];

    std::cout << "IP Adress: " << std::endl;
    IPAddress[4] = '\0';
    std::cin >> IPAddress;

    std::cout << "OS: " << std::endl;
    std::cin >> tmp;
    OS = new char[strlen(tmp)];

    std::cout << "Memory: " << std::endl;
    std::cin >> memory;
    
    std::cout << "RAM: " << std::endl;
    std::cin >> RAM;

    std::cout << "CPU: " << std::endl;
    std::cin >> CPU;

}

bool Server::operator<(const Server &other) const {
    
    std::size_t pos = 0;
    while(pos < 4 && pos < 4) {
        if(IPAddress[pos] != other.IPAddress[pos]) {
            return IPAddress[pos] < other.IPAddress[pos];
        }
        ++pos;
    }

    return false;
}

std::size_t strlen(const char* string) {
    std::size_t len = 0;
    while(*string++) {
        ++len;
    }
    return len;
}

static size_t len(const char* str)
{
    size_t len = 0;
    while (str++)
    {
        len++;
    }
    return len;
}

static void copyStr(char* destination, const char* source)
{
    size_t length = len(source);
    for (size_t i = 0; i <= length; i++)
    {
        destination[i] = source[i];
    }
}