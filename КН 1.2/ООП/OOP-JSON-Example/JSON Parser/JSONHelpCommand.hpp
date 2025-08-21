#pragma once
#include "JSONCommand.hpp"
#include "JSONStructure.hpp"
#include <string>
#include <memory>

class JSONHelpCommand :public JSONCommand
{
public:
	virtual void execute() final;
};