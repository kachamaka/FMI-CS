#include <vector>
#include <iostream>
#include <chrono>
#include "2DTable.h"

using namespace std;

const int rows = 10000;
const int numThreads = 4;

int main() {
    cout << "Number of threads: " << numThreads << "\n";
    cout << "Dimensions: " << rows << "x" << rows << "\n";

    static int table[rows*rows];

    auto startMulti = chrono::steady_clock::now();

    initializeTable(table, rows, rows, numThreads);

    auto endMulti = chrono::steady_clock::now();

    auto elapsedMulti = chrono::duration_cast<chrono::milliseconds>(endMulti - startMulti);

    cout <<"Elapsed time multithreaded 2D table: " << elapsedMulti.count() <<" milliseconds\n";

    auto startLinear = chrono::steady_clock::now();

    for(int i = 0; i < rows*rows; ++i) table[i] = i*rows - rows;

    auto endLinear = chrono::steady_clock::now();

    auto elapsedLinear = chrono::duration_cast<chrono::milliseconds>(endLinear - startLinear);

    cout << "Elapsed time linear approach: " << elapsedLinear.count() << " milliseconds\n";
        

    return 0;
}