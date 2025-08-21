#pragma once

#include "XMLCommand.hpp"

class XMLXPathCommand : public XMLCommand
{
public:
	XMLXPathCommand(XMLTree*, const String&, const String&);
	virtual void execute() final;

private:
	String m_id{};
	String m_xpath{};
};