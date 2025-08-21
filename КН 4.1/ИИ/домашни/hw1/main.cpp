#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <cmath>
#include <algorithm>
#include <stdexcept>
#include <set>
#include <map>
#include <chrono>
#include <climits>

using namespace std;

const int dx[] = { 0, 0, -1, 1 };
const int dy[] = { -1, 1, 0, 0 };


int countInversions(const vector<int>& array) {
    int inv = 0;
    for (int i = 0; i < array.size() - 1; ++i) {
        for (int j = i + 1; j < array.size(); ++j) {
            if (array[i] && array[j] && array[i] > array[j]) inv++;
        }
    }

    return inv;    
}

bool perfectSquare(int n) {
    int sq = sqrt(n);

    return (sq * sq == n);
}

int manhattanDist(int x1, int y1, int x2, int y2) {
    return abs(x1 - x2) + abs(y1 - y2);
}

string getMove(int x, int y) {
    if (x == 1 && y == 0) {
        return "down";
    }
    if (x == -1 && y == 0) {
        return "up";
    }
    if (x == 0 && y == 1) {
        return "right";
    }
    return "left";
}

string inverseMove(string move) {
    if (move == "left") {
        return "right";
    }
    if (move == "right") {
        return "left";
    }
    if (move == "up") {
        return "down";
    }
    return "up";
}

struct State {
    vector<int> board;
    int n;
    // where zero is now
    int zero;
    //where zero should be
    int targetZero;

    State(const vector<int>& board, int targetZero, int zero, const vector<string>& m = {}, string prevMove = "", int g = 0) {
        this->board = board;
        this->n = sqrt(board.size());
        
        this->zero = zero;
        this->targetZero = targetZero;
    }

    int calcHeuristic() {
        int heuristic = 0;

        for (int i = 0; i < n * n; ++i) {
            int num = board[i];
            if (num) {
                int x = i / n;
                int y = i % n;

                int target = (num > targetZero ? num : num - 1);

                int targetX = target / n;
                int targetY = target % n;

                heuristic += abs(x - targetX) + abs(y - targetY);
            }
        }

        return heuristic;
    }

    void swapZero(int newZero) {
        swap(board[zero], board[newZero]);
        zero = newZero;
    }

    int zeroX() {
        return zero / n;
    }

    int zeroY() {
        return zero % n;
    }

    void print() {
        cout << "------\n";
        for (int i = 0; i < board.size(); ++i) {
            cout << board[i] << " ";
            if (i % n == (n - 1)) cout << "\n";
        }
        cout << "------\n";
    }

    bool isGoal() {
        return calcHeuristic() == 0;
    }

    bool isSolvable() {
        int inversions = countInversions(board);

        if (n % 2 != 0) {
            //odd
            return inversions % 2 == 0;
        } else {
            //even
            int zX = zero / n;
            int targetZX = targetZero / n;
            return targetZX % 2 == 0 ? (inversions + zX) % 2 == 0 : (inversions + zX) % 2 != 0;
        }

    }

    int search(int level, int bound, vector<string>& path) {
        int h = calcHeuristic();
        if (h == 0) {
            return -1;
        }

        int f = level + h;
        if (f > bound) return f;

        int minCost = INT_MAX;

        for (int m = 0; m < 4; ++m) {
            int oldZX = zeroX();
            int oldZY = zeroY();
            int newZX = oldZX + dx[m];
            int newZY = oldZY + dy[m];
            if (newZX >= 0 && newZX < n && newZY >= 0 && newZY < n) {
                string move = getMove(dx[m], dy[m]);

                // skip going backwards
                if (path.size() && path[path.size()-1] == inverseMove(move)) continue;
                
                int oldZero = zero;
                int newZero = newZX * n + newZY;
                swapZero(newZero);

                // if (!isSolvable()) {
                //     swapZero(oldZero);
                //     continue;
                // }

                path.push_back(move);

                int res = search(level + 1, bound, path);
                if (res == -1) return -1;
                if (res < minCost) minCost = res;

                swapZero(oldZero);
                path.pop_back();
            }
        }
        
        return minCost;
    }
    
};

State initialize(const vector<int>& board, int targetZero) {
    for (int i = 0; i < board.size(); ++i) {
        if (board[i] == 0) {
            State st = State(board, targetZero, i);
            return st;
        }
    }

    throw invalid_argument("Couldn't initialize state");
}

void printPath(const vector<string>& moves) {
    for (int i = 0; i < moves.size(); ++i) {
        cout << inverseMove(moves[i]) << "\n";
    }
}

void print(const vector<string>& arr) {
    for (int i = 0; i < arr.size(); ++i) {
        cout << arr[i] << " ";
    }
    cout << "\n";
}

void idaStar(const vector<int>& board, int targetZero) {
    State st = initialize(board, targetZero);
    if (!st.isSolvable()) {
        cout << "-1";
        return;
    }

    chrono::steady_clock::time_point begin = chrono::steady_clock::now();
    chrono::steady_clock::time_point end;
    
    int bound = st.calcHeuristic();
    vector<string> moves;
    while (true) {
        int result = st.search(0, bound, moves);
        if (result == -1) {
            cout << moves.size() << "\n";
            printPath(moves);
            return;
        }
        bound = result;
        end = chrono::steady_clock::now();
        cout << "DIFF " << std::chrono::duration_cast<std::chrono::milliseconds>(end - begin).count() << "[ms]\n";
        begin = chrono::steady_clock::now();
    }
}

int main() {
    int n;
    cout << "Enter n = ";
    cin >> n;
    int zero;
    cout << "Enter zero index = ";
    cin >> zero;
    if (zero < 0 || zero > n) {
        if (zero != -1) {
            cout << "Enter correct zero index\n";
            return 1;
        }
        zero = n;
    }
    if (!perfectSquare(n + 1)) {
        cout << "Enter correct board...";
        return 2;
    }
    vector<int> board;
    cout << "Enter board config: ";
    for (int i = 0; i < n + 1; ++i) {
        int num;
        cin >> num;
        board.push_back(num);
    }

    try {
        idaStar(board, zero);
    }
    catch (const exception& e) {
        cerr << e.what() << '\n';
    }

    return 0;
}