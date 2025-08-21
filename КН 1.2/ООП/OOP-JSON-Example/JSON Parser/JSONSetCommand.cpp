#include "JSONSetCommand.hpp"
#include "PathParser.hpp"
#include <iostream>

JSONSetCommand::JSONSetCommand(JSONStructure* str, const String& path, const String& string) :
	JSONCommand(str),
	m_string{ string },
	m_path{ path }
{

}

void JSONSetCommand::execute()
{
	try
	{
		PathParser parser{ m_path, m_str };
		auto el = parser.get_element();
		if (el == nullptr)
		{
			throw std::runtime_error("Element not found");
		}
		el->set_value(m_string);
		std::cout << "Successfully set element.\n";
	}
	catch (std::exception & e)
	{
		std::cout << e.what() << std::endl;
	}
}