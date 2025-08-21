#include "XMLPrintCommand.hpp"
#include "InvalidCommand.hpp"

XMLPrintCommand::XMLPrintCommand(XMLTree* tree) : XMLCommand{ tree }
{
}

void XMLPrintCommand::execute()
{
	if (!m_tree->empty())
	{
		std::cout << *m_tree;
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}