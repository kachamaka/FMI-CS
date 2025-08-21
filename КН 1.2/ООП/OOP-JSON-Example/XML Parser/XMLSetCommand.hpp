#pragma once

#include "XMLCommand.hpp"

class XMLSetCommand : public XMLCommand
{
public:
	XMLSetCommand(XMLTree*, const String&, const String&, const String&);
	virtual void execute() final;

private:
	String m_id{};
	String m_key{};
	String m_value{};
};