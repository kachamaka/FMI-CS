#include <iostream>
#include <string>
#include <cstring>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

using namespace std;

const int BUFFER_SIZE = 1024;
const int PORT = 8080;

int main() {
    try {
        // Create a socket
        int client_socket = socket(AF_INET, SOCK_STREAM, 0);
        if (client_socket < 0) {
            cout << "Error creating socket\n";
            return 1;
        }

        // Connect to the server
        sockaddr_in server_address;
        server_address.sin_family = AF_INET;
        server_address.sin_port = htons(PORT);
        server_address.sin_addr.s_addr = INADDR_ANY;
        if(connect(client_socket, (sockaddr*)&server_address, sizeof(server_address)) < 0) {
            cout << "Error connecting to server\n";
            return 2;
        }

        // Get data
        int numThreads, rows, cols;
        cout << "Enter num of threads: ";
        cin >> numThreads;
        cout << "Enter num of rows: ";
        cin >> rows;
        cout << "Enter num of cols: ";
        cin >> cols;

        // Send data
        write(client_socket, &numThreads, sizeof(int));
        write(client_socket, &rows, sizeof(int));
        write(client_socket, &cols, sizeof(int));

        cout << "Sent numThreads, rows, cols: " << numThreads << " " << rows << " " << cols << "\n";
        
        int size = rows * cols;
        int* table = new int[size];

        // Receive table
        for(int i = 0; i < size; ++i) {
            read(client_socket, &table[i], sizeof(int));
        }

        // Print table
        cout << "Received table: \n";
        for(int i = 0; i < rows*cols; ++i) {
            cout << table[i] << ((i + 1) % cols == 0 ? "\n" : " ");
        }

        // Close the socket
        close(client_socket);
    } catch(...) {
        cout << "ERROR!\n";
        return -1;
    }

    return 0;
}