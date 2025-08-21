#include "CommandParser.hpp"
#include "XMLCommand.hpp"
#include "XMLTree.hpp"
#include "XMLChildCommand.hpp"
#include "XMLChildrenCommand.hpp"
#include "XMLCloseCommand.hpp"
#include "XMLDeleteCommand.hpp"
#include "XMLHelpCpmmand.hpp"
#include "XMLNewChildCommand.hpp"
#include "XMLOpenCommand.hpp"
#include "XMLPrintCommand.hpp"
#include "XMLSaveAsCommand.hpp"
#include "XMLSaveCommand.hpp"
#include "XMLSelectCommand.hpp"
#include "XMLSetCommand.hpp"
#include "XMLTextCommand.hpp"
#include "XMLXPathCommand.hpp"
#include "ExitCommand.hpp"
#include "InvalidCommand.hpp"
#include "XMLTree.hpp"
#include "Parser.hpp"
#include <string>
#include <algorithm>
#include <iostream>

CommandParser::CommandParser(const String& file_name, XMLTree* tree) : Parser{ file_name },
m_tree{ tree }
{
}

XMLCommand* CommandParser::parse_command()
{
	size_t pos{ find_next_pos(0) };
	String operation{ find_string(pos) };
	if (operation == "open")
	{
		pos = find_next_pos(pos + operation.length());
		String file_name{ find_string(pos) };
		if (file_name == "")
			return new InvalidCommand{};
		else
			return new XMLOpenCommand{ file_name, m_tree };
	}
	if (operation == "close")
	{
		return new XMLCloseCommand{ m_tree };
	}
	if (operation == "save")
	{
		pos = find_next_pos(pos + operation.length());
		String save_as{ find_string(pos) };
		if (save_as == "")
			return new XMLSaveCommand{ m_tree };
		else
		{
			pos = find_next_pos(pos + save_as.length());
			String file_name{ find_string(pos) };
			return new XMLSaveAsCommand{ file_name, m_tree };
		}
	}
	if (operation == "help")
	{
		return new XMLHelpCommand{};
	}
	if (operation == "exit")
	{
		return new ExitCommand{};
	}
	if (operation == "print")
	{
		return new XMLPrintCommand{ m_tree };
	}
	if (operation == "select")
	{
		pos = find_next_pos(pos + operation.length());
		String id{ find_string(pos) };
		pos = find_next_pos(pos + id.length());
		String key{ find_string(pos) };
		return new XMLSelectCommand{ m_tree, id, key };
	}
	if (operation == "set")
	{
		pos = find_next_pos(pos + operation.length());
		String id{ find_string(pos) };
		pos = find_next_pos(pos + id.length());
		String key{ find_string(pos) };
		pos = find_next_pos(pos + key.length());
		String value{ find_string(pos) };
		return new XMLSetCommand{ m_tree, id, key, value };
	}
	if (operation == "children")
	{
		pos = find_next_pos(pos + operation.length());
		String id{ find_string(pos) };
		return new XMLChildrenCommand{ m_tree, id };
	}
	if (operation == "text")
	{
		pos = find_next_pos(pos + operation.length());
		String id{ find_string(pos) };
		return new XMLTextCommand{ m_tree, id };
	}
	if (operation == "child")
	{
		pos = find_next_pos(pos + operation.length());
		String id{ find_string(pos) };
		pos = find_next_pos(pos + id.length());
		int n{ std::stoi(find_string(pos)) };
		return new XMLChildCommand{ m_tree, id, n };
	}
	if (operation == "newchild")
	{
		pos = find_next_pos(pos + operation.length());
		String id{ find_string(pos) };
		return new XMLNewChildCommand{ m_tree, id };
	}
	if (operation == "delete")
	{
		pos = find_next_pos(pos + operation.length());
		String id{ find_string(pos) };
		pos = find_next_pos(pos + id.length());
		String key{ find_string(pos) };
		return new XMLDeleteCommand{ m_tree, id, key };
	}
	if (operation == "xpath")
	{
		pos = find_next_pos(pos + operation.length());
		String id{ find_string(pos) };
		pos = find_next_pos(pos + id.length());
		String xpath{ find_string(pos) };
		return new XMLXPathCommand{ m_tree, id, xpath };
	}

	//TO-DO: XML Commands Parse

	return new InvalidCommand{};
}