#include "Core.hpp"
#include "CommandParser.hpp"
#include "JSONExitCommand.hpp"
#include <iostream>
#include <exception>

void Core::start()
{
	String line{};
	while (std::getline(std::cin, line))
	{
		try
		{
			CommandParser parser{ line, &str };
			Pointer<JSONCommand> cmd = parser.parse_command();
			if (dynamic_cast<JSONExitCommand*>(&*cmd) != nullptr)
			{
				break;
			}
			cmd->execute();
		}
		catch (std::exception& e)
		{
			std::cout << e.what() << std::endl;
		}
	}
}