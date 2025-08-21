#include "JSONCloseCommand.hpp"
#include <iostream>

JSONCloseCommand::JSONCloseCommand(JSONStructure* str) :
	JSONCommand(str)
{

}

void JSONCloseCommand::execute()
{
	if (m_str->is_active())
	{
		m_str->clear();
		std::cout << "Successfully closed " << m_str->get_file_name() << ".\n";
	}
	else
	{
		throw std::runtime_error("No file is currently open.");
	}
}