#include "XMLCloseCommand.hpp"
#include "InvalidCommand.hpp"

XMLCloseCommand::XMLCloseCommand(XMLTree* tree) : XMLCommand(tree)
{
}

void XMLCloseCommand::execute()
{
	if (!m_tree->empty())
	{
		m_tree->erase();
		std::cout << "Successfully closed " << m_tree->get_open_file_name() << ".\n";
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}