#include <iostream>
#include <math.h>

using std::cin;
using std::cout;
using std::nothrow;
using std::endl;

struct Point{
    double x, y;

    void readCoordinates(){
        cout << "x: " <<endl;
        cin >> x;
        cout << "y: " <<endl;
        cin >> y;
    }

    void printCoordinates(){
        cout << "(" << x << ", " << y << ")" << endl;
    }

    double distanceStart(){
        return sqrt(x*x+y*y);
    }

    

};

double distanceTwoPoints(Point pt1, Point pt2){
    double biggieX = ((pt1.x > pt2.x) ? pt1.x : pt2.x);
    double smolX = ((pt1.x < pt2.x) ? pt1.x : pt2.x);

    double biggieY = ((pt1.y > pt2.y) ? pt1.y : pt2.y);
    double smolY = ((pt1.y < pt2.y) ? pt1.y : pt2.y);

    return sqrt() 
}

int main(){

    Point pt1, pt2;

    cout << "Pt1 stuff: " << endl;

    pt1.readCoordinates();

    cout << "Pt2 stuff: " << endl;

    pt2.readCoordinates();

    pt1.printCoordinates();

    pt2.printCoordinates();

    double l1 =0, l2=0;

    l1 = pt1.distanceStart();
    l2 = pt2.distanceStart();

    cout << l1 << endl << l2 << endl;

    double distance =0;

    distance = 

    return 0;
}