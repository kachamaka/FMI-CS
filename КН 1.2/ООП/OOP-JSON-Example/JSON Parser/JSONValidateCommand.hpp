#pragma once
#include "JSONCommand.hpp"
#include "JSONStructure.hpp"
#include <string>
#include <memory>

class JSONValidateCommand :public JSONCommand
{
public:
	JSONValidateCommand(JSONStructure*);
	virtual void execute() final;
};