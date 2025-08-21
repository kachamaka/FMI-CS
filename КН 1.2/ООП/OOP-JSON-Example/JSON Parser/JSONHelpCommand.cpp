#include "JSONHelpCommand.hpp"
#include <iomanip>
#include <iostream>

const size_t WIDTH = 40;

void JSONHelpCommand::execute()
{
	std::cout << "The following commands are supported:\n";

	std::cout << std::setw(WIDTH) << std::left << "open <file>";
	std::cout << "Opens <file>.\n";

	std::cout << std::setw(WIDTH) << std::left << "close";
	std::cout << "Closes currently open file.\n";

	std::cout << std::setw(WIDTH) << std::left << "save [<path>]";
	std::cout << "Saves currently open file. If <path> is available, saves object, located at <path>.\n";

	std::cout << std::setw(WIDTH) << std::left << "saveas <file> [<path>]";
	std::cout << "Saves currently open file in <file>. If <path> is available, saves object, located at <path>.\n";

	std::cout << std::setw(WIDTH) << std::left << "help";
	std::cout << "Shows supported commands.\n";

	std::cout << std::setw(WIDTH) << std::left << "exit";
	std::cout << "Exits program.\n";

	std::cout << std::setw(WIDTH) << std::left << "validate";
	std::cout << "Shows if currently loaded JSON file is valid.\n";

	std::cout << std::setw(WIDTH) << std::left << "print";
	std::cout << "Prints currently loaded JSON structure.\n";

	std::cout << std::setw(WIDTH) << std::left << "set <path> <string>";
	std::cout << "Sets element, located at <path> to value, parsed from <string>.\n";

	std::cout << std::setw(WIDTH) << std::left << "create <path> <string>";
	std::cout << "Creates element, located at <path>, parsed from <string>.\n";

	std::cout << std::setw(WIDTH) << std::left << "delete <path>";
	std::cout << "Deletes element located at <path>.\n";

	std::cout << std::setw(WIDTH) << std::left << "move <from> <to>";
	std::cout << "Moves element from path <from> to path <to>.\n";

}

