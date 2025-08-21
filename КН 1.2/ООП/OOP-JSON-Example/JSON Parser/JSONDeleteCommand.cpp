#include "JSONDeleteCommand.hpp"
#include "PathParser.hpp"
#include <iostream>

JSONDeleteCommand::JSONDeleteCommand(JSONStructure* str, const String& path) :
	JSONCommand(str),
	m_path{ path }
{

}

void JSONDeleteCommand::execute()
{
	try
	{
		PathParser p{ m_path, m_str };
		auto res = p.delete_element();
		if (res) std::cout << "Successfully deleted element.\n";
	}
	catch (std::exception & e)
	{
		std::cout << e.what() << std::endl;
	}
}