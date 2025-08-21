#include "XMLHelpCpmmand.hpp"
#include<iomanip>

const size_t WIDTH = 40;

void XMLHelpCommand::execute()
{
	std::cout << "The following commands are supported:\n";

	std::cout << std::setw(WIDTH) << std::left << "open <file>";
	std::cout << "Opens <file>.\n";

	std::cout << std::setw(WIDTH) << std::left << "close";
	std::cout << "Closes currently open file.\n";

	std::cout << std::setw(WIDTH) << std::left << "save";
	std::cout << "Saves currently open file.\n";

	std::cout << std::setw(WIDTH) << std::left << "saveas <file>";
	std::cout << "Saves currently open file in <file>.\n";

	std::cout << std::setw(WIDTH) << std::left << "help";
	std::cout << "Shows supported commands.\n";

	std::cout << std::setw(WIDTH) << std::left << "exit";
	std::cout << "Exits program.\n";

	std::cout << std::setw(WIDTH) << std::left << "print";
	std::cout << "Prints currently loaded XML tree.\n";

	std::cout << std::setw(WIDTH) << std::left << "select <id> <key>";
	std::cout << "Prints attribute value of <id> with <key>.\n";

	std::cout << std::setw(WIDTH) << std::left << "set <id> <key> <value>";
	std::cout << "Sets attribute value of <id> with <key> to <value>.\n";

	std::cout << std::setw(WIDTH) << std::left << "children <id>";
	std::cout << "Prints children of <id>.\n";

	std::cout << std::setw(WIDTH) << std::left << "child <id> <n>";
	std::cout << "Prints <n>-th child of <id>.\n";

	std::cout << std::setw(WIDTH) << std::left << "text <id>";
	std::cout << "Prints text of <id>.\n";

	std::cout << std::setw(WIDTH) << std::left << "delete <id> <key>";
	std::cout << "Deletes attribute of <id> with <key>.\n";

	std::cout << std::setw(WIDTH) << std::left << "newchild <id>";
	std::cout << "Adds new child to <id>.\n";

	std::cout << std::setw(WIDTH) << std::left << "xpath <id> <XPath>";
	std::cout << "Prints response to <XPath> of <id>.\n";
}

