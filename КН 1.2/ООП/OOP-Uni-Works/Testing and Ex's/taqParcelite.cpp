#include <iostream>
using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

void vrushtamPamet(unsigned** matrix, unsigned n){
    for(unsigned i = 0; i<n; i++){
        delete[] matrix[i];
    }
    delete[] matrix;
}

unsigned** iskamPamet(unsigned n, unsigned m){
    unsigned** matrix = new(nothrow) unsigned*[m];
    if(!matrix) return matrix;

    for(unsigned i = 0; i < m; i++){
        matrix[i] = new(nothrow) unsigned[n];
        if(!matrix[i]){
            vrushtamPamet(matrix, i);
            return nullptr;
        }
    }

    return matrix;
}

void vuvejdamParceli(unsigned n, unsigned m, unsigned** snimka){
    for(unsigned i = 0; i < n; i++){
        for(unsigned j = 0; j < m; j++){
            cin >> snimka[i][j];
        }
    }
}

void tursimParceli(unsigned** snimka, unsigned n, unsigned m, unsigned currColumn, unsigned currRow, unsigned parcel){
    if(snimka[currColumn][currRow]<0){
        return;
    }

    if(currRow > n || currColumn > m){
        return;
    }


    return tursimParceli(snimka, n, m, ++currColumn, currRow, parcel) || tursimParceli(snimka, n, m, currColumn, ++currRow, parcel)
           || tursimParceli(snimka, n, m, ++currColumn, ++currRow, parcel)

}

int main(){
    unsigned n=0, m=0;
    cin >> n >> m;

    unsigned** snimka = 0;
    snimka = iskamPamet(n,m);

    vuvejdamParceli(n, m, snimka);

    tursimParceli(snimka, n, m, 0);

    vrushtamPamet(snimka, m);
    return 0;
}