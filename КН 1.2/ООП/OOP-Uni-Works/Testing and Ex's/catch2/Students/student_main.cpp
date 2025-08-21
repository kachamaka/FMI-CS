#include <iostream>
#include "student.h"
using std::cin;
using std::cout;
using std::endl;
using std::nothrow;

// int main()
// {

//     return 0;
// }

#define CATCH_CONFIG_MAIN
#include "../catch2/catch.hpp"

// TEST_CASE("swap")
// {
//     int a = 5;
//     int b = 6;
//     REQUIRE(swapped(a, b) == 5);
// }

TEST_CASE("word", "[word]")
{
    SECTION("nullptr case")
    {
        const char *text = nullptr;
        int index = 0;
        REQUIRE(findFirstIndex(index, text) == -1);
    }

    SECTION("text:Something")
    {
        const char *text = "Something";
        int index = 0;
        REQUIRE(findFirstIndex(index, text) == 0);
    }

    SECTION("text:__Something")
    {
        const char *text = "  Something";
        int index = 0;
        REQUIRE(findFirstIndex(index, text) == 2);
    }
    SECTION("text:spaces")
    {
        const char *text = "";
        int index = 0;
        REQUIRE(findFirstIndex(index, text) == -1);
    }
    SECTION("text:emtpy")
    {
        const char *text = "   ";
        int index = 0;
        REQUIRE(findFirstIndex(index, text) == -1);
    }
}
