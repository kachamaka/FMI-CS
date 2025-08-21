#include "JSONValidateCommand.hpp"
#include <iostream>

JSONValidateCommand::JSONValidateCommand(JSONStructure* str) :
	JSONCommand(str)
{

}

void JSONValidateCommand::execute()
{
	try
	{
		m_str->parse(m_str->get_content());
		std::cout << "File is valid." << std::endl;
	}
	catch (std::exception & e)
	{
		std::cout << e.what() << std::endl;
	}
}