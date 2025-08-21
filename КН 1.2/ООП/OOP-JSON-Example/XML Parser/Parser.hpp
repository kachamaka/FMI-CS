#pragma once
#include <string>
#include <optional>
#include <vector>

using String = std::string;

template <typename T>
using Vector = std::vector<T>;

class Parser
{
public:
	Parser() = default;
	Parser(const String&);

protected:
	String find_string(size_t) const;
	size_t find_next_pos(size_t) const;
	template <typename T>
	bool vector_contains(Vector<T> vector, const T& el);
	void parse_whitespace(size_t);
	std::optional<char> parse_character(char, size_t);
	std::optional<String> parse_string(size_t, const Vector<char>&, const Vector<char>&);
	void update_position(size_t);

protected:
	String content{};
	size_t updated_position{ 0 };
};