#pragma once
#include "JSONCommand.hpp"
#include "JSONStructure.hpp"
#include <string>
#include <memory>
#include <optional>

template<typename T>
using Optional = std::optional<T>;

class JSONSaveCommand :public JSONCommand
{
public:
	JSONSaveCommand(JSONStructure*);
	JSONSaveCommand(JSONStructure*, const String&);
	virtual void execute() final;
private:
	Optional<String> m_path{};
};