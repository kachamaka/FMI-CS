#pragma once

#include "XMLCommand.hpp"

class XMLNewChildCommand : public XMLCommand
{
public:
	XMLNewChildCommand(XMLTree*, const String&);
	virtual void execute() final;

private:
	String m_id{};
};