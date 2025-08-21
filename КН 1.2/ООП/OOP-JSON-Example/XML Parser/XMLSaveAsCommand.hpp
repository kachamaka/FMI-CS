#pragma once

#include "XMLCommand.hpp"

class XMLSaveAsCommand : public XMLCommand
{
public:
	XMLSaveAsCommand() = default;
	XMLSaveAsCommand(const String&, XMLTree*);
	virtual void execute() final;
	virtual ~XMLSaveAsCommand() = default;

	String get_file_name() const;
	void set_file_name(const String&);

private:
	String m_file_name;
};