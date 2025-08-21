#include "XMLChildCommand.hpp"
#include "InvalidCommand.hpp"
#include <algorithm>

XMLChildCommand::XMLChildCommand(XMLTree* tree, const String& id, int n) : XMLCommand{ tree },
m_id{ id },
m_n{ n }
{
}

void XMLChildCommand::execute()
{
	if (!m_tree->empty())
	{
		XMLElement element = m_tree->get_element_by_id(m_id);
		Vector<XMLElement> children = element.get_children();
		if (m_n > children.size())
		{
			InvalidCommand cmd{ "Element does not have that many children." };
			cmd.execute();
			return;
		}
		XMLElement child = children[children.size() - m_n];
		std::cout << "ID: " << child.get_id() << std::endl;
		std::cout << "Name: " << child.get_name() << std::endl;
		Vector<Pair> attr = child.get_attributes();
		if (!attr.empty())
		{
			std::cout << "Attributes: ";
			std::for_each(attr.begin(), attr.end(), [](const Pair& p)
			{
				std::cout << p.first << "=" << p.second << " ";
			});
			std::cout << std::endl;
		}
		String text = child.get_text();
		if (!text.empty())
		{
			std::cout << "Text: " << text << std::endl;
		}
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}
