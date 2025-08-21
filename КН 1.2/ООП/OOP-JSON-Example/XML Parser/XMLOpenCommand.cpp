#include "XMLOpenCommand.hpp"
#include "InvalidCommand.hpp"
#include <fstream>

XMLOpenCommand::XMLOpenCommand(const String& file_name, XMLTree* tree) : XMLCommand{ tree },
m_file_name{ file_name }
{
}

String XMLOpenCommand::get_file_name() const
{
	return m_file_name;
}

void XMLOpenCommand::set_file_name(const String& file_name)
{
	m_file_name = file_name;
}

void XMLOpenCommand::execute()
{
	if (m_tree->empty())
	{
		String file_name = get_file_name();
		std::ifstream in{ file_name };
		m_tree->set_open_file_name(file_name);
		m_tree->parse(in);
		std::cout << "Successfully opened " << m_tree->get_open_file_name() << ".\n";
	}
	else
	{
		InvalidCommand cmd{ "Another file is currently open. Please close it." };
		cmd.execute();
	}
}