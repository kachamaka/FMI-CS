#include "XMLSaveAsCommand.hpp"
#include "InvalidCommand.hpp"

XMLSaveAsCommand::XMLSaveAsCommand(const String& file_name, XMLTree* tree) : XMLCommand{ tree },
m_file_name{ file_name }

{
}

String XMLSaveAsCommand::get_file_name() const
{
	return m_file_name;
}

void XMLSaveAsCommand::set_file_name(const String& file_name)
{
	m_file_name = file_name;
}

void XMLSaveAsCommand::execute()
{
	if (!m_tree->empty())
	{
		m_tree->save_as(m_file_name);
		std::cout << "Successfully saved another "<<m_file_name<<".\n";
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}