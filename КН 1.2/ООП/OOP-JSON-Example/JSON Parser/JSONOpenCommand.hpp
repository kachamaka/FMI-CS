#pragma once
#include "JSONCommand.hpp"
#include "JSONStructure.hpp"
#include <string>
#include <memory>

class JSONOpenCommand :public JSONCommand
{
public:
	JSONOpenCommand(const String&, JSONStructure*);
	virtual void execute() final;
private:
	String m_file_name{};
};