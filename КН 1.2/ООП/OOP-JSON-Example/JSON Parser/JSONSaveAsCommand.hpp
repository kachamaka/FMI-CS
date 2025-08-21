#pragma once
#include "JSONCommand.hpp"
#include "JSONStructure.hpp"
#include <string>
#include <memory>
#include <optional>

template<typename T>
using Optional = std::optional<T>;

class JSONSaveAsCommand :public JSONCommand
{
public:
	JSONSaveAsCommand(const String&, JSONStructure*);
	JSONSaveAsCommand(const String&, JSONStructure*, const String&);
	virtual void execute() final;
private:
	String m_file_name{};
	Optional<String> m_path{};
};