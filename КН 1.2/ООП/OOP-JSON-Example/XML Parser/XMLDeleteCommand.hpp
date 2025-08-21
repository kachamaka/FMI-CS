#pragma once

#include "XMLCommand.hpp"

class XMLDeleteCommand : public XMLCommand
{
public:
	XMLDeleteCommand(XMLTree*, const String&, const String&);
	virtual void execute() final;

private:
	String m_id{};
	String m_key{};
};