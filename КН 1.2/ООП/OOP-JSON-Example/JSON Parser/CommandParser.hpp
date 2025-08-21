#pragma once
#include "JSONCommand.hpp"
#include "JSONStructure.hpp"
#include "Parser.hpp"


class CommandParser : public Parser
{
public:
	CommandParser(const String&, JSONStructure*);
	virtual ~CommandParser() = default;

	Pointer<JSONCommand> parse_command();

private:
	JSONStructure* m_structure{};
};