#pragma once

#include "XMLCommand.hpp"

class XMLTextCommand : public XMLCommand
{
public:
	XMLTextCommand(XMLTree*, const String&);
	virtual void execute() final;

private:
	String m_id{};
};