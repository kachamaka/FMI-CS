#include <iostream>

using std::cin;
using std::cout;
using std::string;

class Human
{
private:
    string name="Go";
    bool forYouAlways;
    bool maybeLater;
    bool wannaDie;
public:
    Human()
    {
        forYouAlways = true;
        maybeLater = false;
        wannaDie = false;
        name += name;
    }
    bool isFree(string name)
    {
        if (name == "Zella Izzy")
        {
            return forYouAlways;
        }
        else
        {
            return maybeLater;
        }
    }
    void superHappy()
    {
        cout << "__________________\n";
        cout << "__00000___00000_ \n";
        cout << "_00000000_0000000_ \n";
        cout << "_0000000000000000_ \n";
        cout << "__00000000000000_ \n";
        cout << "____00000000000_ \n";
        cout << "_______00000_ \n";
        cout << "_________0_ \n";
        cout << "____________\n\n";
        cout << "So you have no excuse not to hang out with me !\n";
        cout << "See you later :^) \n";
    }

    void soundLikeAPlan(bool sheIsFree)
    {
        if (sheIsFree)
        {
            superHappy();
        }
        else
        {
            wannaDie = true;
        }
    }
    ~Human()
    {
        if (wannaDie)
        {
            cout << "\nYup , that's fine , don't mind me . I will just hang myself on a tree or something. :) HF!\n";
            name.erase(0, name.length()); //RIP
        }
    }
};

class Jina
{
private:
    bool isSleepy;
    bool isStudying;
    bool isBusy;
    bool simplyHatesMe = false; // I will take that a No by default...

public:
    string name;
    Jina()
    {
        string answer;
        cout << "Hey there . I'll ask you stuff regarding March 3.\n";
        cout << "-Do you think you'll be too sleepy to hang out?\n";
        cin >> answer;
        if (answer == "yes" || answer == "yup" || answer == "I am" ||
            answer == "true" || answer == "1" || answer == "uwu")
        {
            isSleepy = true;
        }
        else if (answer == "nope" || answer == "no" || answer == "nah" ||
                 answer == "for you never" || answer == "*yawn*" || answer == "false" ||
                 answer == "Do you have something in mind? ( ͡° ͜ʖ ͡°)")
        {
            isSleepy = false;
        }
        else
        {
            cout << "My creator is too lazy to understand that so I will take it for no..\n";
            isSleepy = false;
        }
        //
        //
        //
        cout << "-Have you planned studying ? (Come on , it's a holiday!)\n";
        cin >> answer;
        if (answer == "yes" || answer == "yup" || answer == "I am a nerd" ||
            answer == "true" || answer == "1" || answer == "uwu")
        {
            isStudying = true;
        }
        else if (answer == "nope" || answer == "no" || answer == "nah" ||
                 answer == "hell nah" || answer == "false" ||
                 answer == "yes, but I feel lazy , so no")
        {
            isStudying = false;
        }
        else
        {
            cout << "My creator is too lazy to understand that \n";
            cout << "(and also to rewrite that) so I will take it for no..\n";
            isStudying = false;
        }
        //
        //
        //
        cout << "-Okay anddd do you have other plans to do?\n";
        cin >> answer;
        if (answer == "yes" || answer == "yup" || answer == "unfortunately" ||
            answer == "true" || answer == "1" || answer == "well..." || answer == "It was a good idea to discuss that part...")
        {
            isBusy = true;
        }
        else if (answer == "nope" || answer == "no" || answer == "nah" ||
                 answer == "hell nah" || answer == "false" ||
                 answer == "yes, but I feel too lazy , so no")
        {
            isBusy = false;
        }
        else
        {
            cout << "My creator is too lazy to understand that \n";
            cout << "(and also to rewrite that) so I will take it for no..\n";
            isBusy = false;
        }
    }
    bool isOverallFree()
    {
        return !(isBusy || isSleepy || isStudying || simplyHatesMe);
    }
};

int main()
{
    Human me;
    Jina you;
    you.name = "Zella Izzy";

    if (me.isFree(you.name) && you.isOverallFree())
    {
        me.soundLikeAPlan(true); //<3
    }
    else
    {
        me.soundLikeAPlan(false); //;(
    }

    return 42;
}