/*
 Introduction to Programming 2020 @ FMI
 Sample tasks for lecture #11

  More complex Recursive functions

***************
 Hanoi towers
 Fast power
 Find a path in a maze
*/

#include <iostream>
#include <iomanip>
#include <cstdlib>
using namespace std;

/////////////////////////////////////////////
//The towers of Hanoi

// The move action - can be something more real ;).
void move(int from, int to)
{
    cout << "Премести диск от " << from << " на " << to << endl;
}

// A recursive function to solve the problem
// Moves a tower
// The arguments stand for the source pole, destination pole
// and the total number of discs in the tower
void hanoiRec(int from, int to, int n)
{
    if (n > 0) {
        int middle = 6 - from - to;
        hanoiRec(from, middle, n-1);
        move (from, to);
        hanoiRec(middle, to, n-1);
    }
}

// And the wrapper function
void hanoi(int n)
{
    hanoiRec(1, 3, n);
}

/////////////////////////////////////////////

// Fast power algorithm
double power(double x, unsigned n)
{
    if (n == 0) return 1;

    double p2 = power(x, n/2);
    if (n%2 == 1)
        return x * p2 * p2;
    else
        return p2 * p2;
}


//////////////////////////////////////////////////////////////////////////////////////////
//  The problem to check if there is a path between two cells in a maze
// The maze is represented by a matrix of numbers where
// value 0 stands for passable cell, and any other is a obstacle.

const int SIZE = 10;            // The maximal size of the maze

//  Global destination coordinates.
// The idea is not to pass it as arguments at every step
static int g_endX, g_endY;
static int lab[SIZE][SIZE] =   // The maze itself.
{
    {0, 0, 0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 1, 0, 1, 0},
    {0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
    {0, 0, 1, 0, 0, 0, 1, 1, 1, 1},
    {0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 1, 0, 1, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0}
};

int maxPathRec(int x, int y, int len, int path[], int maxPathArr[], int& maxPath)
{
    static const int dx[] = {0,  1,  0, -1};//, -1, -1, 1,  1};     // Ways to move by X axis
    static const int dy[] = {1,  0, -1,  0};//, -1,  1, 1, -1};     // Ways to move by Y axis
    static const int numMoves = sizeof(dx)/sizeof(dx[0]);

    //  Terminal checks
    // failure state:
    if (x < 0 || x >= SIZE || y < 0 || y >= SIZE) { // out of the array
        return -1;
    }
    if (lab[x][y] != 0) {                           // or an obstacle
        return -1;
    }

    // Mark the cell as visited
    lab[x][y] = -len;
    path[len-1] = x*SIZE + y;

    // the success state:
    if (x == g_endX && y == g_endY) {
        if (len > maxPath) {
            maxPath = len;
            cout << "Better path, len = " << len << endl;
            for (int i = 0; i < len; ++i){
                maxPathArr[i] = path[i];
            }
        }
        lab[x][y] = 0;
        return 1;
    }

    // Try recursively to find a way in any possible direction
    for (int direction = 0; direction < numMoves; ++direction) {
        maxPathRec(x + dx[direction], y + dy[direction], len+1, path, maxPathArr, maxPath);
    }
    lab[x][y] = 0;
    return 1;
}


int minPathRec(int x, int y, int len, int path[])
{
    static const int dx[] = {0,  1,  0, -1};//, -1, -1, 1,  1};     // Ways to move by X axis
    static const int dy[] = {1,  0, -1,  0};//, -1,  1, 1, -1};     // Ways to move by Y axis
    static const int numMoves = sizeof(dx)/sizeof(dx[0]);

    //  Terminal checks
    // failure state:
    if (x < 0 || x >= SIZE || y < 0 || y >= SIZE) { // out of the array
        return -1;
    }
    if (lab[x][y] > 0) {                           // or an obstacle
        return -1;
    }

    // ако съм бил там, но с по-дълъг път опитвам отново с по-кракия
    if (lab[x][y] < 0) {
        if (-lab[x][y] > len) {
            lab[x][y] = 0;
        }
        else {
            return -1;
        }
    }

    // Mark the cell as visited
    lab[x][y] = -len;
    path[len-1] = x*SIZE + y;

    // the success state:
    if (x == g_endX && y == g_endY) {
        return len;
    }

    // Try recursively to find a way in any possible direction
    int result = SIZE*SIZE+1;
    for (int direction = 0; direction < numMoves; ++direction) {
        int last = minPathRec(x + dx[direction], y + dy[direction], len+1, path);
        if (last > 0 && last < result)
            result = last;
    }
    return result < SIZE*SIZE+1 ? result : -1;
}



int hasPath(int startX, int startY, int endX, int endY)
{
    g_endX = endX;
    g_endY = endY;

{

    int path[SIZE*SIZE] = {0,};
    int pathArr[SIZE*SIZE] = {0,};

    //TODO: code to initialize the global LAB array
    int maxPath = -1;
    maxPathRec(startX, startY, 1, path, pathArr, maxPath);
    if (maxPath > 0) {
        for (int i = 0; i < maxPath; ++i){
            cout << pathArr[i] / SIZE << " " << pathArr[i] % SIZE << endl;
        }
    }
}

{
    int path[SIZE*SIZE] = {0,};
    int min = minPathRec(startX, startY, 1, path);
    if (min > 0) {
        cout << "Min path: \n";
        for (int i = 0; i < min; ++i){
            cout << path[i] / SIZE << " " << path[i] % SIZE << endl;
        }
    }
}

    return 1;
}


//////////////////////////////////////////////////////////////////////////////////////////
int main()
{

//    system("chcp 1251 & cls");
//    hanoi(10);

/*
    for (int i = 0; i <= 10; ++i)
        cout << power(2, i) << endl;
*/

    cout << boolalpha << hasPath(4, 4, 0, 9) << endl;
    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            cout << setw(4) << lab[i][j];
        }
        cout << endl;
    }
    return 0;
}
