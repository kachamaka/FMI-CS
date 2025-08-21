#include "Core.hpp"
#include "CommandParser.hpp"
#include "ExitCommand.hpp"

#include <iostream>

void Core::start()
{
	String line{};
	while (std::getline(std::cin, line))
	{
		CommandParser parser{ line, &m_tree };
		XMLCommand* cmd = parser.parse_command();
		cmd->execute();
		if (dynamic_cast<const ExitCommand*>(cmd) != nullptr)
		{
			delete cmd;
			break;
		}
		delete cmd;
	}
}