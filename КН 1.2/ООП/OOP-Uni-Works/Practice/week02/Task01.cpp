  
/**
 * \brief Something somethings something
 * \author Ellzie
 */

#include <iostream>
#include <cstring>
using std::cin;
using std::cout;
using std::nothrow;
using std::endl;
using std::strcmp;

const int MAX_SIZE = 1000;
const int SYMBOLS = 256;
const int MAX_ISBN = 13;

//

struct Book{
    char title[SYMBOLS]; //!< Stores title
    char author[SYMBOLS]; //!< Stores author
    char numISBN[MAX_ISBN]; //!< Stores ISBN of the books

    //! Function for reading book dets
    void readBookDetails(){
        cout << endl << "Title: " ;
        cin.ignore();
        cin.getline(title, SYMBOLS);

        cout << endl << "Author: " ;
        cin.ignore();
        cin.getline(author, SYMBOLS);
        //cin >> Book[i].author;

        cout << endl << "ISBN of the book: " ;
        cin >> numISBN;
    }
};

struct Library{
    Book books[MAX_SIZE]; //!< Books struct
    int numBooks = 0;  //!<  //!< num books
    //int cnt =0;

    //! Function for adding books
    void addBook(){
        if(numBooks < MAX_SIZE){
            Book currentBook;
            currentBook.readBookDetails();
            //cnt++;
            books[numBooks++] = currentBook;
            
        }
        else{
            cout << "Shelves are full." << endl;
        }
    } 

    //! Function removing books
    void removeBook(){
        char isbn[MAX_ISBN]; //!< isbn num
        cout << "ISBN of the book u wanna remove: " << endl;
        cin >> isbn;

        for(int i = 0; i<numBooks; i++){
            if(!(strcmp(books[i].numISBN, isbn))){
                //cnt--;
                
                books[i] = books[numBooks-1];
                numBooks--;
            }
        }

    }

    //! Function for num of books
    int numOfBooks(){
        return numBooks;
    }

};

void printMenu(){
    cout << "What do you want to do?" << endl
         << "1. Add books." << endl 
         << "2. Remove books." << endl
         << "3. Print available books." << endl
         << "4. Exit." << endl;
}

int main(){
    int choice = 0;
    Library userStuff;

    do{
        printMenu();
        cin >> choice;

        if(choice == 1){
            userStuff.addBook();
        }
        else if (choice == 2){
            userStuff.removeBook();
        }
        else if(choice == 3){
            cout << userStuff.numOfBooks() << endl;
        }
        else {
            cout << "Invalid choice :( 1-4 pliz!" << endl;
        }
    }
    while(choice != 4);
    
    cout << "Goodbye!" << endl;

    return 0;
}

/*void add_book(int n){
    cout << "How many books do you want to add? " ;
    cin >> n;

    for(int i = 0; i < n; i++){
        cout << endl << "Title: " ;
        cin.getline(Book[i].title, 256);

        cout << endl << "Author: " ;
        cin.getline(Book[i].author, 256);
        //cin >> Book[i].author;

        cout << endl << "ISBN of the book: " ;
        cin.getline(Book[i].numISBN, 256);
        //in >> Book[i].numISBN;
    }
}
*/

void remove_book(int n){

}

void print_books(int n){

}