#pragma once

#include "XMLCommand.hpp"

class XMLSelectCommand : public XMLCommand
{
public:
	XMLSelectCommand(XMLTree*, const String&, const String&);
	virtual void execute() final;

private:
	String m_id{};
	String m_key{};
};