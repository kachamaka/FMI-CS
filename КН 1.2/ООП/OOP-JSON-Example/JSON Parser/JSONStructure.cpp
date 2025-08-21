#include "JSONStructure.hpp"
#include "JSONParser.hpp"
#include <iostream>

JSONStructure::JSONStructure(const JSONValue& value) : m_base{ value },
													   m_is_active{ true }
{
}

JSONStructure::JSONStructure(const JSONValue& value, bool is_active) : m_base{value},
																		m_is_active{is_active}
{
}

Pointer<JSONStructure> JSONStructure::clone() const
{
	return std::make_unique<JSONStructure>(m_base, m_is_active);
}

void JSONStructure::make_active()
{
	m_is_active = true;
}
void JSONStructure::make_unactive()
{
	m_is_active = false;
}

bool JSONStructure::is_active() const
{
	return m_is_active;
}

void JSONStructure::parse(const String& content)
{
	raw_content = content;
	JSONParser parser{ content };
	auto value = parser.parse();
	if (!value)
	{
		throw std::runtime_error("An error while reading has occurred.");
	}
	m_base = value.value();
	m_is_active = true;
}

void JSONStructure::set_content(const String& str)
{
	raw_content = str;
}

String JSONStructure::get_content() const
{
	return raw_content;
}

void JSONStructure::set_file_name(const String& str)
{
	m_file_name = str;
}

String JSONStructure::get_file_name() const
{
	return m_file_name;
}

void JSONStructure::clear()
{
	raw_content.clear();
	m_base = JSONValue();
	m_is_active = false;
}

std::ostream& operator<<(std::ostream& out, const JSONStructure& str)
{
	str.m_base.print(out, 0);
	return out;
}

Vector<JSONValue> JSONStructure::search(const String& key)
{
	return m_base.search(key);
}

JSONValue* JSONStructure::get_element()
{
	return &m_base;
}