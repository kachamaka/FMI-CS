#include "struct.hpp"

const int MAX_SERVERS = 10;

class ServerCluster {

private:
    Server servers[MAX_SERVERS];
    Server** servers;

public:
    ServerCluster();
    ~ServerCluster();

    void print();
    void addServer();
    unsigned countInNetwork();
    const Server* operator-=(const char* IPAdress);

};