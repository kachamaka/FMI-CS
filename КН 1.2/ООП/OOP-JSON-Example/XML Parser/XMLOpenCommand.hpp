#pragma once

#include "XMLCommand.hpp"

class XMLOpenCommand : public XMLCommand
{
public:
	XMLOpenCommand() = default;
	XMLOpenCommand(const String&, XMLTree*);
	virtual void execute() final;
	virtual ~XMLOpenCommand() = default;

	String get_file_name() const;
	void set_file_name(const String&);

private:
	String m_file_name;
};