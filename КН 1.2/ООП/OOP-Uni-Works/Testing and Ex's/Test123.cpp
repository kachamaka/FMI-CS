#include <iostream>
#include<ios> //used to get stream size
#include<limits> //used to get numeric limits

using namespace std;

const unsigned int numOfPossibilities = 9;

void fix_input()
{
	cin.clear();
	cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

int main() {

/*
    */

    short ans;

	do {
		cout << "\nEnter you choice:";
		cin >> ans;
		if (!cin) {
			fix_input();
			cout << "Please , choose a valid option from 1 to " << numOfPossibilities << endl;
			ans = 0;
		}
		else if (ans <= 0 || ans > numOfPossibilities) {
			cout << "Please , choose a valid option from 1 to " << numOfPossibilities << endl;
		}

	} while (ans <= 0 || ans > numOfPossibilities);

 
    
    return 0;

}