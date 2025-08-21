#include "XMLChildrenCommand.hpp"
#include "InvalidCommand.hpp"
#include <algorithm>

XMLChildrenCommand::XMLChildrenCommand(XMLTree* tree, const String& id) : XMLCommand{ tree },
m_id{ id }
{
}

void XMLChildrenCommand::execute()
{
	if (!m_tree->empty())
	{
		XMLElement element = m_tree->get_element_by_id(m_id);
		Vector<XMLElement> children = element.get_children();
		std::for_each(children.begin(), children.end(), [](const XMLElement& el) {
			std::cout << el;
		});
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}