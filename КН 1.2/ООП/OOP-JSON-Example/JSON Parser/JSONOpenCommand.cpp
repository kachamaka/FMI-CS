#include "JSONOpenCommand.hpp"
#include "JSONParser.hpp"
#include <fstream>
#include <sstream>
#include <iostream>

JSONOpenCommand::JSONOpenCommand(const String& file_name, JSONStructure* str) :
	JSONCommand(str),
	m_file_name{ file_name }
{

}

void JSONOpenCommand::execute()
{
	try
	{
		if (m_str->is_active())
		{
			throw std::runtime_error("There is already an open file.");
		}

		std::ifstream in{ m_file_name };

		std::stringstream buffer;
		buffer << in.rdbuf();
		String content = buffer.str();

		m_str->set_file_name(m_file_name);
		m_str->parse(content);

		std::cout << "Successfully opened " << m_file_name << ".\n";
	}
	catch (std::exception& e)
	{
		std::cout << e.what() << std::endl;
	}
	
}