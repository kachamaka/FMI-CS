#include "JSONMoveCommand.hpp"
#include "PathParser.hpp"
#include <iostream>

JSONMoveCommand::JSONMoveCommand(JSONStructure* str, const String& from, const String& to) :
	JSONCommand(str),
	m_from{ from },
	m_to{ to }
{

}

void JSONMoveCommand::execute()
{
	try
	{
		PathParser p1{ m_from, m_str };
		auto from = p1.get_element();
		PathParser p2{ m_to, m_str };
		auto to = p2.create_element();
		*to = *from;
		PathParser p3{ m_from, m_str };
		p3.delete_element();
		std::cout << "Successfully moved element.\n";
	}
	catch (std::exception & e)
	{
		std::cout << e.what() << std::endl;
	}
}