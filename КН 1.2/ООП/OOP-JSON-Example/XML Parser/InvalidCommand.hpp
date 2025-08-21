#pragma once
#include "XMLCommand.hpp"

class InvalidCommand : public XMLCommand
{
public:
	InvalidCommand() = default;
	InvalidCommand(const String&);
	virtual void execute() final;

private:
	String m_message{ "Invalid operation." };
};