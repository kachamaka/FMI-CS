#include "XMLDeleteCommand.hpp"
#include "InvalidCommand.hpp"

XMLDeleteCommand::XMLDeleteCommand(XMLTree* tree, const String& id, const String& key) : XMLCommand{ tree },
m_id{ id },
m_key{ key }
{
}

void XMLDeleteCommand::execute()
{
	if (!m_tree->empty())
	{
		XMLElement& el = m_tree->get_element_by_id(m_id);
		el.remove_attribute(m_key);
		std::cout << "Successfully deleted attribute.\n";
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}