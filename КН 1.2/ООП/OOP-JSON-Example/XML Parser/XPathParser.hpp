#pragma once
#include "Parser.hpp"
#include "XMLTree.hpp"
#include <variant>
#include <algorithm>

struct XPathParser : public Parser
{
public:
	XPathParser(const XMLElement&, const String& );
	std::variant<Vector<XMLElement>, Vector<String>>  parse();
private:
	std::variant<Vector<XMLElement>, Vector<String>>  parse_from(Vector<XMLElement>&, size_t);
	std::variant<Vector<XMLElement>, Vector<String>> parse_square_bracket(Vector<XMLElement>&);
	std::variant<Vector<XMLElement>, Vector<String>> parse_round_bracket(Vector<XMLElement>&);
	std::variant<Vector<XMLElement>, Vector<String>> parse_at_operator(Vector<XMLElement>&);
	XMLElement m_element{};
	String m_query{};
};