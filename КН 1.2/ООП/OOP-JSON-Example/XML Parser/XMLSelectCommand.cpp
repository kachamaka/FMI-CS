#include "XMLSelectCommand.hpp"
#include "InvalidCommand.hpp"

XMLSelectCommand::XMLSelectCommand(XMLTree* tree, const String& id, const String& key) : XMLCommand{ tree },
m_id{ id },
m_key{ key }
{
}

void XMLSelectCommand::execute()
{
	if (!m_tree->empty())
	{
		auto element = m_tree->get_element_by_id(m_id);
		auto attr_value = element.get_attribute_by_key(m_key);
		std::cout << "Attribute \"" << m_key << "\" value: " << attr_value << std::endl;
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}

}