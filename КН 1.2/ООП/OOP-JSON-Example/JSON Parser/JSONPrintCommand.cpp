#include "JSONPrintCommand.hpp"
#include <iostream>

JSONPrintCommand::JSONPrintCommand(JSONStructure* str) :
	JSONCommand(str)
{

}

void JSONPrintCommand::execute()
{
	if (m_str->is_active())
	{
		std::cout << *m_str << std::endl;
	}
	else
	{
		throw std::runtime_error("No file is currently open.");
	}
}