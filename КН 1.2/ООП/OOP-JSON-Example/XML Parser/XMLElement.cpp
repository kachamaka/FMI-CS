#include "XMLElement.hpp"
#include<iostream>
#include<algorithm>

Vector<String> XMLElement::ids{};

//ctor
XMLElement::XMLElement(const String& name, 
					   const Vector<Pair>& attributes, 
					   const Vector<XMLElement>& elements, 
					   const String& text) : m_name{name},
											 m_attributes{attributes},
											 m_elements{elements},
											 m_text{text}
{

}

void XMLElement::print_tabs(size_t depth, std::ostream& out) const
{
	for (int i = 0; i < depth; i++)
	{
		out << "  ";
	}
}

XMLElement* XMLElement::get_by_id(const String& id)
{
	if (m_id.compare(id) == 0)
	{
		return this;
	}
	XMLElement* el{ nullptr };
	for (auto i{ 0 }; i<m_elements.size(); i++)
	{
		if(el==nullptr)el = m_elements[i].get_by_id(id);
	};
	return el;
}

void XMLElement::print(size_t depth, std::ostream& out) const
{
	print_tabs(depth, out);
	out << "Tag Name: " << get_name() << std::endl;
	print_tabs(depth, out);
	out << "ID: " << m_id << std::endl;
	if (!m_attributes.empty())
	{
		print_tabs(depth, out);
		out << "Attributes: ";
		std::for_each(m_attributes.rbegin(), m_attributes.rend(), [&out](const Pair& attr)
		{
			out << attr.first << "=" << attr.second << " ";
		});
		out << std::endl;
	}
	if (!m_text.empty())
	{
		print_tabs(depth, out);
		out << "Text: " << m_text << std::endl;
	}
	std::for_each(m_elements.rbegin(), m_elements.rend(), [&depth, &out](const XMLElement& el)
	{
		el.print(depth + 1, out);
	});
}

XMLElement& XMLElement::get_child_element_by_id(const String& id)
{
	return *(get_by_id(id));
}


//accessors
String XMLElement::get_name() const
{
	return m_name;
}
Vector<Pair> XMLElement::get_attributes() const
{
	return m_attributes;
}
Vector<XMLElement> XMLElement::get_children() const
{
	return m_elements;
}
String XMLElement::get_text() const
{
	return m_text;
}
String XMLElement::get_id() const
{
	return m_id;
}
String XMLElement::get_attribute_by_key(const String& key) const
{
	auto value_itr = std::find_if(m_attributes.begin(), m_attributes.end(), [&key](const Pair& attr) {
		return attr.first.compare(key) == 0;
	});
	if (value_itr == m_attributes.end()) return {};
	else return value_itr->second;
}
Vector<XMLElement> XMLElement::get_children_by_name(const String& name) const
{
	Vector<XMLElement> rt;
	std::for_each(m_elements.begin(), m_elements.end(), [&rt, &name](const XMLElement& el)
	{
		if (el.get_name().compare(name) == 0)rt.push_back(el);
	});
	return rt;
}
bool XMLElement::has_child_with_text(const String& name, const String& text) const
{
	auto itr = std::find_if(m_elements.begin(), m_elements.end(), [&text, &name](const XMLElement& el) {
		return el.get_text().compare(text) == 0 && el.get_name().compare(name) == 0;
	});
	return itr != m_elements.end();
}

//mutators
void XMLElement::set_name(const String& name)
{
	m_name = name;
}
void XMLElement::add_attribute(const Pair& attribute)
{
	m_attributes.push_back(attribute);
}
void XMLElement::set_id()
{
	auto id = std::find_if(m_attributes.begin(), m_attributes.end(), [](const Pair& p) {
		return p.first.compare("id") == 0;
	});
	if (id != m_attributes.end())
	{
		m_id = get_unique_id(id->second);
		m_attributes.erase(id);
	}
	else
	{
		m_id = get_unique_id("");
	}
	std::for_each(m_elements.rbegin(), m_elements.rend(), [](XMLElement& el) {
		el.set_id();
	});
}
void XMLElement::set_attribute_by_key(const String& key, const String& value)
{
	std::for_each(m_attributes.begin(), m_attributes.end(), [&key, &value](Pair& p) {
		if (p.first == key)
		{
			p.second = value;
		}
	});
}

void XMLElement::add_child()
{
	XMLElement el{};
	el.set_id();
	m_elements.push_back(el);
}

void XMLElement::remove_attribute(const String& key)
{
	auto itr = std::find_if(m_attributes.begin(), m_attributes.end(), [&key](const Pair& p) {
		return p.first == key;
	});
	if (itr != m_attributes.end())
	{
		m_attributes.erase(itr);
	}
}

String XMLElement::get_unique_id( String id)
{
	if (id.compare("") == 0)
	{
		for (int i{ 1 };; ++i)
		{
			if (std::find(ids.begin(),
						  ids.end(), 
						  "_"+std::to_string(i)) == ids.end())
			{
				ids.push_back("_" + std::to_string(i));
				return "_" + std::to_string(i);
			}
		}
	}
	else
	{
		if (std::find(ids.begin(), ids.end(), id) == ids.end())
		{
			ids.push_back(id);
			return id;
		}
		else
		{
			for (int i{ 1 };; ++i)
			{
				if (std::find(ids.begin(), 
							  ids.end(), 
							  id + '_' + std::to_string(i)) == ids.end())
				{
					ids.push_back(id + '_' + std::to_string(i));
					return id + '_' + std::to_string(i);
				}
			}
		}
	}
}


XMLElement* XMLElement::clone() const
{
	return new XMLElement{ *this };
}

std::ostream& operator<<(std::ostream& out, const XMLElement& el)
{
	el.print(0, out);
	return out;
}

void XMLElement::print_in_xml(size_t depth, std::ostream& out) const
{
	print_tabs(depth, out);
	out << "<" << m_name << " id=\""<<m_id<<"\"";
	std::for_each(m_attributes.begin(), m_attributes.end(), [&out](const Pair& p) {
		out << " " << p.first << "=" << p.second;
	});
	out << ">" << std::endl;
	if (!m_text.empty())
	{
		print_tabs(depth, out);
		out << m_text << std::endl;
	}
	std::for_each(m_elements.begin(), m_elements.end(), [&depth, &out](const XMLElement& el) {
		el.print_in_xml(depth + 1, out);
	});
	print_tabs(depth, out);
	out << "</" << m_name << ">" << std::endl;
}