#include "Parser.hpp"
#include <string>
#include <cctype>
#include <iostream>
#include <optional>

using String = std::string;

Parser::Parser(const String& raw_string) : content{ raw_string }
{
}

String Parser::find_string(size_t from) const
{
	if (iswspace(content[from]) || from == content.length())
		return "";
	return content[from] + find_string(from + 1);
}

size_t Parser::find_next_pos(size_t from) const
{
	if (from == content.length())
	{
		return from;
	}
	if (content[from] == ' ')
	{
		return find_next_pos(from + 1);
	}
	else
	{
		return from;
	}
}

void Parser::parse_whitespace(size_t position)
{
	if (iswspace(content[position]))
	{
		parse_whitespace(position + 1);
	}
	else
	{
		update_position(position);
		return;
	}
}

Optional<char> Parser::parse_character(char c, size_t position)
{
	if (content[position] != c)
	{
		return {};
	}
	else
	{
		update_position(position + 1);
		return content[position];
	}
}


template <typename T>  
bool Parser::vector_contains(Vector<T> vector, const T& el)
{
	return std::find(vector.begin(), vector.end(), el) != vector.end();
}



Optional<String> Parser::parse_string(size_t position,
	const Vector<char>& endpoint_characters,
	const Vector<char>& invalid_characters)
{
	if (vector_contains(endpoint_characters, content[position]) )
	{
		update_position(position);
		return "";
	}
	if (position == content.length() - 1)
	{
		String rt{ content[position] };
		update_position(position + 1);
		return rt;
	}
	if (vector_contains(invalid_characters, content[position]) || position == content.length())
	{
		
		return {};
	}

	std::optional<String> str = parse_string(position + 1, endpoint_characters, invalid_characters);
	if (!str)
	{
		return {};
	}
	else
	{
		return content[position] + str.value();
	}
}

void Parser::update_position(size_t position)
{
	updated_position = position;
}