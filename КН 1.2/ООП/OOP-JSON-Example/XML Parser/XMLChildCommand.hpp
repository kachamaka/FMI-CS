#pragma once

#include "XMLCommand.hpp"

class XMLChildCommand : public XMLCommand
{
public:
	XMLChildCommand(XMLTree*, const String&, int);
	virtual void execute() final;

private:
	String m_id{};
	int m_n{};
};