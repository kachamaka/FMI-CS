#include "XMLSetCommand.hpp"
#include "InvalidCommand.hpp"

XMLSetCommand::XMLSetCommand(XMLTree* tree, const String& id, const String& key, const String& value) : XMLCommand{ tree },
m_id{ id },
m_key{ key },
m_value{ value }
{
}

void XMLSetCommand::execute()
{
	if (!m_tree->empty())
	{
		XMLElement& el = m_tree->get_element_by_id(m_id);
		el.set_attribute_by_key(m_key, m_value);
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}