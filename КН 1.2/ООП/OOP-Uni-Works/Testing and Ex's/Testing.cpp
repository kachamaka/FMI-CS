#include <iostream>
#include<ios> //used to get stream size
#include<limits> //used to get numeric limits

using namespace std;

const unsigned int NUMBER_OF_CHOICES = 9;

void fixInput() 
{
    cin.clear();
    cin.ignore();
}

int main() {

/*
    */

    short choice;

    do {
		cout << "\nEnter you choice:";
        cin >> choice;
        if(!cin) {
            fixInput();
            cout << "Your choice should be between 0 and 9!" << endl;
            choice = -1;
        }
        else if (choice < 0 || choice > NUMBER_OF_CHOICES) {
			cout << "Please , choose a valid option from 1 to " << NUMBER_OF_CHOICES << endl;
        }

    } while (choice < 0 || choice > NUMBER_OF_CHOICES);


    return 0;

}


/*
const unsigned int numOfPossibilities = 9;


void fix_input()
{
	cin.clear();
	cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

/*

    short ans;

	do {
		cout << "\nEnter you choice:";
		cin >> ans;
		if (!cin)
		{
			fix_input();
			cout << "Please , choose a valid option from 1 to " << numOfPossibilities << endl;
			ans = 0;
		}
		else if (ans <= 0 || ans > numOfPossibilities) {
			cout << "Please , choose a valid option from 1 to " << numOfPossibilities << endl;
		}

	} while (ans <= 0 || ans > numOfPossibilities);

 
    while(cin || (choice >= 0 && choice <= NUMBER_OF_CHOICES)) {
        cout << " Gib " << endl;
        cin >> choice;
        fixInput();
    }
    */