#pragma once

#include "XMLCommand.hpp"

class XMLSaveCommand : public XMLCommand
{
public:
	XMLSaveCommand() = default;
	XMLSaveCommand(XMLTree*);
	virtual void execute() final;
	virtual ~XMLSaveCommand() = default;
};