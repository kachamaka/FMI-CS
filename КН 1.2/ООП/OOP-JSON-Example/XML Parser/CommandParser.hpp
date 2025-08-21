#pragma once
#include "XMLCommand.hpp"
#include "XMLTree.hpp"
#include "Parser.hpp"

using String = std::string;

class CommandParser : public Parser
{
public:
	CommandParser(const String&, XMLTree*);
	virtual ~CommandParser() = default;

	XMLCommand* parse_command();

private:
	XMLTree* m_tree{};
};