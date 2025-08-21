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
int lab[SIZE][SIZE] =           // The maze itself.
{
    {0, 1, 0, 0, 0, 1, 1, 0, 0, 0},
    {0, 1, 0, 1, 1, 0, 0, 0, 0, 0},
    {0, 1, 1, 1, 1, 0, 1, 0, 1, 0},
    {0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 0, 1, 1, 1, 1},
    {1, 0, 1, 1, 0, 0, 1, 0, 0, 0},
    {0, 0, 1, 0, 1, 1, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 1, 0},
    {0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0}
};

const int dx[] = {0,  1,  0, -1};     // Ways to move by X axis
const int dy[] = {1,  0, -1,  0};     // Ways to move by Y axis
const int numMoves = sizeof(dx)/sizeof(dx[0]);

//  Global destination coordinates.
// The idea is not to pass it as arguments at every step
static int g_endX, g_endY;

int hasPathRec(int x, int y, int step, int path[])
{
    //  Terminal checks
    // first the success state:
    if (x == g_endX && y == g_endY) {
        return step;
    }

    path[step] = 100*x+y;

    // and then the failure state:
    if (x < 0 || x >= SIZE || y < 0 || y >= SIZE) { // out of the array
        return -1;
    }
    if (lab[x][y] != 0) {                           // or an obstacle
        return -1;
    }

    lab[x][y] = 2;
    // Try recursively to find a way in any possible direction
    int hasPath = -1;
    for (int direction = 0; hasPath <0 && direction < numMoves; ++direction) {
        hasPath = hasPathRec(x + dx[direction], y + dy[direction], step+1, path);
    }
    return hasPath;
}

bool hasPath(int startX, int startY, int endX, int endY)
{
    g_endX = endX;
    g_endY = endY;
    int path[SIZE*SIZE] = {0};
    int count = hasPathRec(startX, startY, 0, path);
    if (count > 0)
    {
        for (int i = 0; i < count; ++i)
            cout << path[i]/100 << ',' << path[i]%100 << endl;
    }
    return count >= 0;
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

    cout << boolalpha << hasPath(0, 0, 0, 9) << endl;
    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            cout << lab[i][j] << " ";
        }
        cout << endl;
    }
    return 0;
}
