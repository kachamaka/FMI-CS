#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
using namespace std;

struct PairPositions
{
    int left, right;
    PairPositions( int l = 0, int r = 0 ) : left(l), right(r) {}
};

PairPositions solve( char* S )
{
    int len = strlen(S);
    PairPositions p;
    int dist, max_dist = -1;
    for( int i = 0; i < len; i++ )
    {
        for( int j = i; j < len; j++ )
        {
            if( S[i] == S[j] )
            {
                int dist = j - i;
                if( dist > max_dist )
                {
                    max_dist = dist;
                    p.left = i;
                    p.right = j;
                }
            }
        }

    }

    return p;
}

int main()
{
    char S[101];
    strcpy(S, "abcdefgat");

    PairPositions p = solve(S);
    cout << p.left << " " << p.right << endl;

    return 0;
}
