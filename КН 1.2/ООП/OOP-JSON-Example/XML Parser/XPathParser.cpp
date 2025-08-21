#include "XPathParser.hpp"

XPathParser::XPathParser(const XMLElement& element,
						 const String& str) :	
												Parser(str),
												m_element{element}
												
{

}

std::variant<Vector<XMLElement>, Vector<String>> XPathParser::parse()
{
	Vector<XMLElement> initial = { m_element };
	return parse_from(initial,  0);
}

std::variant<Vector<XMLElement>, Vector<String>> XPathParser::parse_from(Vector<XMLElement>& el, size_t position)
{
	String name = parse_string(position, {'/', '(', '['}, {}).value();
	Vector<XMLElement> elements{};
	std::for_each(el.begin(), el.end(), [&elements, &name](const XMLElement& element) {
		Vector<XMLElement> children = element.get_children_by_name(name);
		elements.insert(elements.end(), children.rbegin(), children.rend());
	});
	
	std::optional<char> ch = parse_character('/', updated_position);
	if (ch)
	{
		return parse_from(elements, updated_position);
	}
	
	ch = parse_character('[', updated_position);
	if (ch)
	{
		return parse_square_bracket(elements);
	}

	ch = parse_character('(', updated_position);
	if (ch)
	{
		ch = parse_character('@', updated_position);
		if (ch)
		{
			return parse_at_operator(elements);
		}
		else
		{
			return parse_round_bracket(elements);
		}
	}
	else
	{
		return elements;
	}

}

std::variant<Vector<XMLElement>, Vector<String>> XPathParser::parse_square_bracket(Vector<XMLElement>& elements)
{
	String number = parse_string(updated_position, { ']' }, {}).value();
	int n = std::stoi(number);
	auto ch = parse_character(']', updated_position);
	ch = parse_character('/', updated_position);
	if (ch)
	{
		Vector<XMLElement> initial = { elements[n] };
		return parse_from(initial, updated_position);
	}
	else
	{
		return Vector<XMLElement>{ elements[n] };
	}
}

std::variant<Vector<XMLElement>, Vector<String>> XPathParser::parse_round_bracket(Vector<XMLElement>& elements)
{
	String name = parse_string(updated_position, { '=' }, {}).value();
	auto ch = parse_character('=', updated_position);
	ch = parse_character('"', updated_position);
	String text = parse_string(updated_position, { '"' }, {}).value();
	ch = parse_character('"', updated_position);
	ch = parse_character(')', updated_position);
	Vector<XMLElement> filtered{};
	std::for_each(elements.begin(), elements.end(), [&name, &text, &filtered](const XMLElement& el) {
		if (el.has_child_with_text(name, text))
		{
			filtered.push_back(el);
		}
	});
	ch = parse_character('/', updated_position);
	if (ch)
	{

		return parse_from(filtered, updated_position);
	}
	else
	{
		return filtered;
	}
}

std::variant<Vector<XMLElement>, Vector<String>> XPathParser::parse_at_operator(Vector<XMLElement>& elements)
{
	String key = parse_string(updated_position, { ')' }, {}).value();
	Vector<String> rt{};
	std::for_each(elements.begin(), elements.end(), [&rt, &key](const XMLElement& el) {
		if (key.compare("id") == 0)
		{
			String id = el.get_id();
			rt.push_back(id);
		}
		else
		{
			String value = el.get_attribute_by_key(key);
			if (!value.empty())rt.push_back(value);
		}
	});
	return rt;
}