#include <iostream>
#include <thread>
#include <vector>

using namespace std;

void writeToTable(int* array, int startRow, int endRow, int cols) {
    for (int i = startRow; i < endRow; ++i) {
        for (int j = 0; j < cols; ++j) {
            array[i * cols + j] = i + j;
        }
    }
}

void initializeTable(int* table, int rows, int cols, int numThreads) {
    vector<thread> threads;

    // Spread rows among threads
    for (int i = 0; i < numThreads; ++i) {
        int startRow = i * rows / numThreads;
        int endRow = (i + 1) * rows / numThreads;
        threads.emplace_back(writeToTable, table, startRow, endRow, cols);
    }

    // Wait all threads
    for (auto& t : threads) t.join();
}
