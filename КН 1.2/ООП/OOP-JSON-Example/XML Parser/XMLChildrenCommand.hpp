#pragma once

#include "XMLCommand.hpp"

class XMLChildrenCommand : public XMLCommand
{
public:
	XMLChildrenCommand(XMLTree*, const String&);
	virtual void execute() final;

private:
	String m_id{};
};