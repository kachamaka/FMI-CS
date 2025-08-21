#include "PathParser.hpp"
#include <iostream>

PathParser::PathParser(const String& path, JSONStructure* str) : Parser(path),
																m_str{str},
																cur_value{nullptr}
{
}

JSONValue* PathParser::get_element() 
{
	parse_character('$', updated_position);
	cur_value = m_str->get_element();
	return get_next_element(0);
}

JSONValue* PathParser::create_element()
{
	parse_character('$', updated_position);
	cur_value = m_str->get_element();
	return create_next_element(updated_position);
}

JSONValue* PathParser::create_next_element(size_t position)
{
	auto obj = parse_object_or_create();
	JSONValue* arr_el = nullptr;
	if (obj == nullptr) arr_el = parse_array_element_or_create();
	if (!has_next())
	{
		if (obj != nullptr)
		{
			return obj;
		}
		if (arr_el != nullptr)
		{
			return arr_el;
		}
		throw std::runtime_error("Error occured");
	}
	else
	{
		cur_value = obj != nullptr ? obj : arr_el;
	}
	return create_next_element(updated_position);
}

JSONValue* PathParser::get_next_element(size_t position)
{
	auto obj = parse_object();
	JSONValue* arr_el = nullptr;
	if (obj == nullptr)
	{
	
		arr_el = parse_array_element();
	}
	if (!has_next())
	{
		if (obj != nullptr)
		{
			return obj;
		}
		if (arr_el != nullptr)
		{
			return arr_el;
		}
		throw std::runtime_error("Nothing found on this path.");
	}
	else
	{
		cur_value = obj != nullptr ? obj : arr_el;
	}
	return get_next_element(updated_position);
}

bool PathParser::has_next() const
{
	return content[updated_position] == '.' || content[updated_position] == '[';
}

JSONValue* PathParser::parse_object()
{
	auto ch = parse_character('.', updated_position);
	if (ch)
	{
		auto key = parse_string(updated_position, { '.', '[' }, {']'});
		if (!key) throw std::runtime_error("Path parsing error.");
		return cur_value->get_object_by_key(key.value());
	}
	return nullptr;
}
JSONValue* PathParser::parse_array_element()
{
	auto ch = parse_character('[', updated_position);
	JSONValue* rt;
	if (ch)
	{
		auto number = parse_string(updated_position, { ']' }, { });
		if (!number) throw std::runtime_error("Expected number.");
		auto n = std::stoi(number.value());
		
		rt = cur_value->get_array_element(n);
	}
	else
	{
		return nullptr;
	}
	ch = parse_character(']', updated_position);
	if (!ch)throw std::runtime_error("Expected ] in path.");
	return rt;

}

JSONValue* PathParser::parse_object_or_create()
{
	auto ch = parse_character('.', updated_position);
	Optional<String> key{};
	if (ch)
	{
		key = parse_string(updated_position, { '.', '[' }, { ']' });
		if (!key) throw std::runtime_error("Path parsing error.");
		auto el = cur_value->get_object_by_key(key.value());
		if (el != nullptr) return el;
		return cur_value->add_new_object(key.value());
	}
	return nullptr;
}
JSONValue* PathParser::parse_array_element_or_create()
{
	auto ch = parse_character('[', updated_position);
	int n;
	JSONValue* rt;

	if (ch)
	{
		auto number = parse_string(updated_position, { ']' }, { });
		if (!number) throw std::runtime_error("Expected number.");
		n = std::stoi(number.value());
		auto el = cur_value->add_array_element(n);
		rt = el;
		
	}
	else
	{
		return nullptr;
	}
	ch = parse_character(']', updated_position);
	if (!ch)throw std::runtime_error("Expected ] in path.");
	if (rt == nullptr)rt = cur_value->add_array_element(n);
	return rt;
}

bool PathParser::delete_element()
{
	parse_character('$', updated_position);
	cur_value = m_str->get_element();
	return get_or_delete_next_element(0, cur_value);
}

bool PathParser::get_or_delete_next_element(size_t position, JSONValue* parent)
{
	auto obj = parse_object();
	JSONValue* arr_el = nullptr;
	if (obj == nullptr) arr_el = parse_array_element();
	if (!has_next())
	{
		if (obj != nullptr)
		{
			return parent->delete_el (*obj);
		}
		if (arr_el != nullptr)
		{
			return parent->delete_el(*arr_el);
		}
		throw std::runtime_error("Nothing found on this path.");
	}
	else
	{
		cur_value = obj != nullptr ? obj : arr_el;
	}
	return get_or_delete_next_element(updated_position, cur_value);
}