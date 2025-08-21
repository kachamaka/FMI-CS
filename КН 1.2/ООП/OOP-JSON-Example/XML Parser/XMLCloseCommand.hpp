#pragma once

#include "XMLCommand.hpp"

class XMLCloseCommand : public XMLCommand
{
public:
	XMLCloseCommand() = default;
	XMLCloseCommand(XMLTree*);
	virtual void execute() final;
	virtual ~XMLCloseCommand() = default;
};

