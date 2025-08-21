#include "JSONSearchCommand.hpp"
#include <algorithm>
#include <iostream>

JSONSearchCommand::JSONSearchCommand(JSONStructure* str, const String& key) :
	JSONCommand(str),
	m_key{key}
{

}

void JSONSearchCommand::execute()
{
	Vector<JSONValue> results = m_str->search(m_key);
	std::for_each(results.begin(), results.end(), [](auto& el) {
		el.print(std::cout, 0);
		std::cout << std::endl;
	});
	if (results.size() == 0)
	{
		std::cout << "Nothing found.\n";
	}
}