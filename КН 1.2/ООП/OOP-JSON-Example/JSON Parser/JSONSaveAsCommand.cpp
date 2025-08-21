#include "JSONSaveAsCommand.hpp"
#include "PathParser.hpp"
#include <iostream>

JSONSaveAsCommand::JSONSaveAsCommand(const String& file_name, JSONStructure* str) :
	JSONCommand(str),
	m_file_name{ file_name },
	m_path{}
{

}

JSONSaveAsCommand::JSONSaveAsCommand(const String& file_name, JSONStructure* str, const String& path) :
	JSONCommand(str),
	m_file_name{file_name},
	m_path{ path }
{
}

void JSONSaveAsCommand::execute()
{
	
	try
	{
		m_str->set_file_name(m_file_name);
		if (m_path)
		{
			PathParser parser{ m_path.value(), m_str };
			auto el = parser.get_element();
			if (el == nullptr)
			{
				throw std::runtime_error("Nothing found on this path.");
			}
			auto file_name = m_str->get_file_name();
			std::ofstream out{ file_name };
			el->write_to_file(out, 0);
			std::cout << "Successfully saved to file " + file_name << std::endl;
		}
		else
		{
			auto file_name = m_str->get_file_name();
			std::ofstream out{ file_name };
			m_str->get_element()->write_to_file(out, 0);
			std::cout << "Successfully saved to file " + file_name << std::endl;
		}
	}
	catch (std::exception & e)
	{
		std::cout << e.what() << std::endl;
	}
}