#pragma once
#include "JSONCommand.hpp"
#include "JSONStructure.hpp"
#include <string>
#include <memory>


class JSONExitCommand :public JSONCommand
{
public:
	virtual void execute() final;
};