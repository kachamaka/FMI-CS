#include <iostream>
#include <string>
#include <cstring>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

#include "2DTable.h"

using namespace std;

const int BUFFER_SIZE = 1024;
const int PORT = 8080;

int main() {
    try {
        // Create a socket
        int server_socket = socket(AF_INET, SOCK_STREAM, 0);
        if (server_socket < 0) {
            cerr << "Error creating socket" << endl;
            return 1;
        }

        // Bind the socket to a local address and port
        sockaddr_in address;
        address.sin_family = AF_INET;
        address.sin_port = htons(PORT);
        address.sin_addr.s_addr = INADDR_ANY;

        // Bind the socket to the address
        if (bind(server_socket, (struct sockaddr*)&address, sizeof(address)) < 0) {
            cerr << "Error binding socket" << endl;
            return 2;
        }

        // Set the socket to listen for incoming connections
        listen(server_socket, SOMAXCONN);

        // Accept an incoming connection
        sockaddr_in client_address;
        socklen_t client_len = sizeof(client_address);
        int client_socket = accept(server_socket, (sockaddr*)&client_address, &client_len);

        if (client_socket < 0) {
            cerr << "Error accepting connection" << endl;
            return 3;
        }

        // Receive data
        int numThreads, rows, cols;
        read(client_socket, &numThreads, sizeof(int));
        read(client_socket, &rows, sizeof(int));
        read(client_socket, &cols, sizeof(int));
        cout << "Received numThreads, rows, cols: " << numThreads << " " << rows << " " << cols << "\n";

        int size = rows * cols;
        int* table = new int[size];
        for(int i = 0; i < size; ++i) table[i] = 0;

        cout << "Initializing table...\n";
        initializeTable(table, rows, cols, numThreads);

        for(int i = 0; i < size; ++i) {
            write(client_socket, &table[i], sizeof(int));
        }
        cout << "Table sent!\n";
        
        // Close the socket
        close(client_socket);
        close(server_socket);

    } catch(...) {
        cout << "Error!\n";
        return -1;
    }

    return 0;
}
