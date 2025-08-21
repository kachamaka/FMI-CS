#include "XMLNewChildCommand.hpp"
#include "InvalidCommand.hpp"

XMLNewChildCommand::XMLNewChildCommand(XMLTree* tree, const String& id) : XMLCommand{ tree },
m_id{ id }
{
}

void XMLNewChildCommand::execute()
{
	if (!m_tree->empty())
	{
		XMLElement& el = m_tree->get_element_by_id(m_id);
		el.add_child();
		std::cout << "Successfully created new empty child.\n";
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}
