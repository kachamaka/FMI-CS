#pragma once
#include "XMLElement.hpp"

class XMLContent
{
public:
	XMLContent() = default;
	void concat_text(const String& text);
	void add_element(const XMLElement& m_elements);
	String get_text() const;
	Vector<XMLElement> get_elements() const;
private:
	String m_text{};
	Vector<XMLElement> m_elements{};
};