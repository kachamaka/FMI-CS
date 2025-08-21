#pragma once
#include "ICommand.hpp"
#include "XMLTree.hpp"


class XMLCommand : public ICommand
{
public:
	XMLCommand() = default;
	XMLCommand(XMLTree*);
	virtual void execute() = 0;
	virtual ~XMLCommand() = default;

protected:
	XMLTree* m_tree{};
};