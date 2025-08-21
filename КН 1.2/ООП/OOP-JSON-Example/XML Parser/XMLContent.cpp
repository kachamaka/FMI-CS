#include "XMLContent.hpp"

void XMLContent::concat_text(const String& text)
{
	m_text = text + m_text;
}

void XMLContent::add_element(const XMLElement& element)
{
	m_elements.emplace_back(element);
}

String XMLContent::get_text() const
{
	return m_text;
}

Vector<XMLElement> XMLContent::get_elements() const
{
	return m_elements;
}