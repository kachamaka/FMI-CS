#pragma once
#include "JSONCommand.hpp"
#include "JSONStructure.hpp"
#include <string>
#include <memory>

using String = std::string;

template <typename T>
using Pointer = std::unique_ptr<T>;

class JSONMoveCommand :public JSONCommand
{
public:
	JSONMoveCommand(JSONStructure*, const String&, const String&);
	virtual void execute() final;
private:
	String m_from{};
	String m_to{};
};
