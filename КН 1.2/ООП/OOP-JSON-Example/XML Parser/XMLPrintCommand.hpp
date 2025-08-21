#pragma once

#include "XMLCommand.hpp"

class XMLPrintCommand : public XMLCommand
{
public:
	XMLPrintCommand() = default;
	XMLPrintCommand(XMLTree*);
	virtual void execute() final;
	virtual ~XMLPrintCommand() = default;
};