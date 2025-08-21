#pragma once
#include "ICommand.hpp"
#include "JSONStructure.hpp"
#include <string>
#include <memory>

using String = std::string;

template <typename T>
using Pointer = std::unique_ptr<T>;

class JSONCommand : public ICommand
{
public:
	JSONCommand() = default;
	JSONCommand(JSONStructure*);
protected:
	JSONStructure* m_str{};
};