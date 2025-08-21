#pragma once

#include "XMLCommand.hpp"

class ExitCommand : public XMLCommand
{
public:
	ExitCommand() = default;
	virtual void execute() final;
};