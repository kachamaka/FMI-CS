#include "CommandParser.hpp"
#include "JSONOpenCommand.hpp"
#include "JSONCloseCommand.hpp"
#include "JSONSaveCommand.hpp"
#include "JSONSaveAsCommand.hpp"
#include "JSONHelpCommand.hpp"
#include "JSONExitCommand.hpp"
#include "JSONValidateCommand.hpp"
#include "JSONPrintCommand.hpp"
#include "JSONSearchCommand.hpp"
#include "JSONSetCommand.hpp"
#include "JSONCreateCommand.hpp"
#include "JSONDeleteCommand.hpp"
#include "JSONMoveCommand.hpp"
#include <iostream>

CommandParser::CommandParser(const String& content, JSONStructure* str) :
	Parser(content),
	m_structure{ str }
{

}

Pointer<JSONCommand> CommandParser::parse_command()
{
	parse_whitespace(updated_position);
	auto str = parse_string(updated_position, { ' ' }, {});
	if (!str)
	{
		throw std::runtime_error("Please, input command.");
	}
	if (str.value().compare("open") == 0)
	{
		parse_whitespace(updated_position);
		auto file_name = parse_string(updated_position, { }, {});
		if (!file_name || file_name.value().length() < 5)
		{
			throw std::runtime_error("Invalid file name.");
		}
		auto extension = file_name.value().substr(file_name.value().length() - 5);
		if (extension.compare(".json") != 0)
		{
			throw std::runtime_error("Invalid file format.");
		}
		return std::make_unique<JSONOpenCommand>(file_name.value(), m_structure);
	}
	if (str.value().compare("close") == 0)
	{
		return std::make_unique<JSONCloseCommand>(m_structure);
	}
	if (str.value().compare("save") == 0)
	{
		parse_whitespace(updated_position);
		auto path = parse_string(updated_position, { ' ' }, {});
		if (path)
		{
			return std::make_unique<JSONSaveCommand>(m_structure, path.value());
		}
		else
		{
			return std::make_unique<JSONSaveCommand>(m_structure);
		}
	}
	if (str.value().compare("saveas") == 0)
	{
		parse_whitespace(updated_position);
		auto file_name = parse_string(updated_position, { }, {});
		if (!file_name || file_name.value().length() < 5)
		{
			throw std::runtime_error("Invalid file name.");
		}
		auto extension = file_name.value().substr(file_name.value().length() - 5);
		if (extension.compare(".json") != 0)
		{
			throw std::runtime_error("Invalid file format.");
		}

		parse_whitespace(updated_position);
		auto path = parse_string(updated_position, { ' ' }, {});
		if (path)
		{
			return std::make_unique<JSONSaveAsCommand>(file_name.value(), m_structure, path.value());
		}
		else
		{
			return std::make_unique<JSONSaveAsCommand>(file_name.value(), m_structure);
		}
	}
	if (str.value().compare("help") == 0)
	{
		return std::make_unique<JSONHelpCommand>();
	}
	if (str.value().compare("exit") == 0)
	{
		return std::make_unique<JSONExitCommand>();
	}
	if (str.value().compare("validate") == 0)
	{
		return std::make_unique<JSONValidateCommand>(m_structure);
	}
	if (str.value().compare("print") == 0)
	{
		return std::make_unique<JSONPrintCommand>(m_structure);
	}
	if (str.value().compare("search") == 0)
	{
		parse_whitespace(updated_position);
		auto key = parse_string(updated_position, { ' ' }, {});
		if (!key)
		{
			throw std::runtime_error("Input key.");
		}
		return std::make_unique<JSONSearchCommand>(m_structure, key.value());
	}
	if (str.value().compare("set") == 0)
	{
		parse_whitespace(updated_position);
		auto path = parse_string(updated_position, { ' ' }, {});
		if (!path)
		{
			throw std::runtime_error("Input path.");
		}
		parse_whitespace(updated_position);
		auto str = parse_string(updated_position, { ' ' }, {});
		if (!str)
		{
			throw std::runtime_error("Input string.");
		}
		return std::make_unique<JSONSetCommand>(m_structure, path.value(), str.value());
	}
	if (str.value().compare("create") == 0)
	{
		parse_whitespace(updated_position);
		auto path = parse_string(updated_position, { ' ' }, {});
		if (!path)
		{
			throw std::runtime_error("Input path.");
		}
		parse_whitespace(updated_position);
		auto str = parse_string(updated_position, { ' ' }, {});
		if (!str)
		{
			throw std::runtime_error("Input string.");
		}
		return std::make_unique<JSONCreateCommand>(m_structure, path.value(), str.value());
	}
	if (str.value().compare("delete") == 0)
	{
		parse_whitespace(updated_position);
		auto path = parse_string(updated_position, { ' ' }, {});
		if (!path)
		{
			throw std::runtime_error("Input path.");
		}
		return std::make_unique<JSONDeleteCommand>(m_structure, path.value());
	}	
	if (str.value().compare("move") == 0)
	{
		parse_whitespace(updated_position);
		auto from = parse_string(updated_position, { ' ' }, {});
		if (!from)
		{
			throw std::runtime_error("Input <from> path.");
		}
		parse_whitespace(updated_position);
		auto to = parse_string(updated_position, { ' ' }, {});
		if (!to)
		{
			throw std::runtime_error("Input <to> path.");
		}
		return std::make_unique<JSONMoveCommand>(m_structure, from.value(), to.value());
	}
	throw std::runtime_error("Invalid command.");
}