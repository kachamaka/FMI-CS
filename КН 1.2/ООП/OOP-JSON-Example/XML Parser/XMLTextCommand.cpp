#include "XMLTextCommand.hpp"
#include "InvalidCommand.hpp"

XMLTextCommand::XMLTextCommand(XMLTree* tree, const String& id) : XMLCommand{ tree },
m_id{ id }
{
}

void XMLTextCommand::execute()
{
	if (!m_tree->empty())
	{
		XMLElement& element = m_tree->get_element_by_id(m_id);
		if(&element!=nullptr)std::cout << element.get_text() << std::endl;
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}