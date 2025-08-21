#include "JSONCreateCommand.hpp"
#include "PathParser.hpp"
#include <iostream>

JSONCreateCommand::JSONCreateCommand(JSONStructure* str, const String& path, const String& string ) :
	JSONCommand(str),
	m_string{ string },
	m_path{ path }
{

}

void JSONCreateCommand::execute()
{
	try
	{
		PathParser p{ m_path, m_str };
		auto res = p.create_element();
		auto response = res->set_value_check(m_string);
		if (response)std::cout << "Successfully created element.\n";
		else throw std::runtime_error("Element exists.");
	}
	catch (std::exception& e)
	{
		std::cout << e.what() << std::endl;
	}
}