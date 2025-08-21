#pragma once

#include "XMLCommand.hpp"

class XMLHelpCommand : public XMLCommand
{
public:
	virtual void execute() final;
	virtual ~XMLHelpCommand() = default;
};